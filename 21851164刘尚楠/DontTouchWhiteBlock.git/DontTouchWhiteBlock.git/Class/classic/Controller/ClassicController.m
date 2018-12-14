//
//  ClassicController.m
//  DontTouchWhiteBlock
//
//  Created by Marveliu on 18/11/20.
//  Copyright © 2018年 Marveliu. All rights reserved.
//

#import "ClassicController.h"
#import "Block.h"
#import "SuccessViewController.h"
#import "FailViewController.h"

@interface ClassicController ()

/** 存放所有的块 */
@property (strong, nonatomic) NSMutableArray *blocks;
/** 加载多少行 */
@property (nonatomic, assign) NSInteger totalLines;
/** 是否加载了结束行 */
@property (nonatomic, assign, getter=isShowEnd) BOOL showEnd;
/** 开始游戏的时间 */
@property (copy, nonatomic) NSString *startTime;
/** 是否开始游戏 */
@property (nonatomic, assign) BOOL timerRunning;
/** 定时器 */
@property (strong, nonatomic) CADisplayLink *displayLink;
/** 时间显示器 */
@property (strong, nonatomic) UILabel *timerLabel;
/** 点击的总次数 */
@property (nonatomic, assign) NSInteger blockClickSum;

@end

@implementation ClassicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self creatGame];
}

#pragma mark - 创建游戏界面
/**
 *  创建游戏
 */
- (void)creatGame{
    
    [self.blocks removeAllObjects];
    for(UIView *view in self.view.subviews){
        [view removeFromSuperview];
    }
    // 重置属性
    self.timerLabel.text = @"0.000";
    self.showEnd = NO;
    self.timerRunning = NO;
    self.totalLines = 0;
    self.blockClickSum = 0;
    [self addStartLine];
    [self addNormalLine:1 isFirstLine:YES];
    [self addNormalLine:2 isFirstLine:NO];
    [self addNormalLine:3 isFirstLine:NO];
    [self setupTimerLabel];
}

/**
 *  创建开始行
 */
- (void)addStartLine{
    
    CGFloat blockW = ScreenW / 4;
    CGFloat blockH = ScreenH / 4;
    CGFloat blockX;
    CGFloat blockY;
    
    for(NSInteger i = 0; i < 4; ++i){
        Block *block = [[Block alloc] init];
        block.type = BlockTypeStart;
        block.line = 0;
        [block setBackgroundColor:[UIColor yellowColor]];
        blockX = i * blockW;
        blockY = ScreenH - blockH;
        block.frame = CGRectMake(blockX, blockY, blockW, blockH);
        [self.blocks addObject:block];
        [self.view addSubview:block];
    }
    self.totalLines++;
}
/**
 *  创建结束行
 */
- (void)addEndLine{
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(0, 0, ScreenW, ScreenH - ScreenH / 2);
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"加油胜利就在眼前" forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.font = [UIFont systemFontOfSize:25];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.numberOfLines = 3;
    [button addTarget:self action:@selector(endGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:button atIndex:0];
}

/**
 *  添加黑白块
 */
- (void)addNormalLine:(NSInteger)line isFirstLine:(BOOL)firstLine{
    CGFloat blockW = ScreenW / 4;
    CGFloat blockH = ScreenH / 4;
    CGFloat blockX;
    CGFloat blockY;
    
    int blackIndex = arc4random() % 4;
    
    
    for(NSInteger i = 0; i < 4; ++i){
        Block *block = [[Block alloc] init];
        block.type = (blackIndex == i ? BlockTypeBlack : BlockTypeWhite);
        block.line = line;
        // block.layer.borderWidth = 0.3;
        // block.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        block.backgroundColor = (blackIndex == i ? [UIColor blackColor] : [UIColor whiteColor]);
        if(blackIndex == i && firstLine){
            [block setTitle:@"开始" forState:UIControlStateNormal];
        }
        blockX = i * blockW;
        blockY = ScreenH - (line + 1) * blockH;
        block.frame = CGRectMake(blockX, blockY, blockW - 1, blockH - 1);
        [block addTarget:self action:@selector(blockClick:) forControlEvents:UIControlEventTouchDown];
        [self.blocks addObject:block];
        [self.view addSubview:block];
        
    }
    self.totalLines++;
}

static UIWindow *window_;
- (void)setupTimerLabel{
    CGFloat timerLabelW = 140;
    CGFloat timerLabelH = 60;
    CGFloat timerLabelX = ScreenW / 2 - timerLabelW / 2;
    CGFloat timerLabelY = 0;
    
    // 创建窗口
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(timerLabelX, timerLabelY, timerLabelW, timerLabelH);
    window_.backgroundColor = [UIColor clearColor];
    
    self.timerLabel.frame = window_.bounds;
    self.timerLabel.backgroundColor = [UIColor clearColor];
    self.timerLabel.textColor = [UIColor redColor];
    self.timerLabel.textAlignment = NSTextAlignmentCenter;
    self.timerLabel.font = [UIFont systemFontOfSize:30];
    [window_ addSubview:self.timerLabel];
}
#pragma mark - 内部事件处理
- (void)endGame{
    // 停止定时器，停止刷新时间
    [self stopDisplayLink];
    SuccessViewController *vc = [[SuccessViewController alloc] init];
    vc.titleName = @"经典";
    vc.score = self.timerLabel.text;
    
    [self presentViewController:vc animated:NO completion:nil];
    window_.hidden = YES;
    vc.buttonClick = ^(BOOL isAgain){
        if(isAgain) {
            [self creatGame];
        } else {
            window_.hidden = YES;
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    };
}


- (void)blockClick:(Block *)block{

    if(block.line == 1 || block.type == BlockTypeWhite){
        if(block.type == BlockTypeBlack){
            
            if(!self.timerRunning){
                // 开始游戏
                [self startGame];
            }
            self.blockClickSum++;
            // 已经完成游戏
            if(self.blockClickSum == TotalLines){
                [self endGame];
                return;
            }
            block.backgroundColor = [UIColor lightGrayColor];
            block.enabled = NO;
            [self moveDown];
        }else if(block.type == BlockTypeWhite){
            // 停止交互
            self.view.userInteractionEnabled = NO;
            [UIView animateWithDuration:0.2 animations:^{
                block.backgroundColor = [UIColor redColor];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    block.backgroundColor = [UIColor blackColor];
                } completion:^(BOOL finished) {
                    block.backgroundColor = [UIColor redColor];
                    [self gameFailed];
                }];
            }];
        }
    }
}

- (void)gameFailed{

    // 停止定时器，停止刷新时间
    [self stopDisplayLink];
    self.view.userInteractionEnabled = NO;
    FailViewController *vc = [[FailViewController alloc] init];
    [self presentViewController:vc animated:NO completion:nil];
    window_.hidden = YES;
    vc.buttonClick = ^(BOOL isAgain){
        if(isAgain) {
            self.view.userInteractionEnabled = YES;
            [self creatGame];
        } else {
            window_.hidden = YES;
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    };
}

- (void)moveDown{
    // 一共有40行
    if (self.totalLines <= TotalLines) {
        [self addNormalLine:4 isFirstLine:NO];
    }else if(!self.showEnd){
        [self addEndLine];
        self.showEnd = YES;
    }
    NSMutableArray *newBlocks = [NSMutableArray arrayWithArray:self.blocks];
    for(Block *block in newBlocks){
        block.line--;
        [UIView animateWithDuration:0.18 animations:^{
            block.y += ScreenH / 4;
        }completion:^(BOOL finished) {
            if(block.line < 0){
                [block removeFromSuperview];
                [self.blocks removeObject:block];
            }
        }];
    }
}

- (void)startGame{
    self.startTime = [self GetCurTime];
    self.timerRunning = YES;
    self.timerLabel.hidden = NO;
    [self startDisplayLink];
    window_.hidden = NO;
    
}

#pragma mark - 时间处理 && 定时器
- (NSString*)GetCurTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    
    NSString *timeString = [formatter stringFromDate: [NSDate date]];
    
    return timeString;
}

- (void)startDisplayLink{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self  selector:@selector(updateTimer:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)updateTimer:(CADisplayLink *)displayLink{
    
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    
    NSDate *StartDate = [formatter dateFromString:self.startTime];
    
    NSDate *EndDate = [NSDate date];
    
    NSTimeInterval time = [EndDate timeIntervalSinceDate:StartDate];
    
    int hour =(int)(time / 3600);
    
    int minute = (int)(time - hour * 3600) / 60;
    
    float second = time - hour * 3600 - minute * 60;
    
    self.timerLabel.text = [NSString stringWithFormat:@"%.3lfs", second];
}

- (void)stopDisplayLink{
    [self.displayLink invalidate];
    self.displayLink = nil;
}

#pragma mark - 懒加载
- (UILabel *)timerLabel{
    if(!_timerLabel){
        _timerLabel = [[UILabel alloc] init];
    }
    return _timerLabel;
}

- (NSArray *)blocks{
    if(!_blocks){
        _blocks = [[NSMutableArray alloc] init];
    }
    return _blocks;
}
@end
