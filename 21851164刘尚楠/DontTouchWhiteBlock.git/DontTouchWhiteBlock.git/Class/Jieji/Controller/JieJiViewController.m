//
//  JieJiViewController.m
//  DontTouchWhiteBlock.git
//
//  Created by Marveliu on 16/4/11.
//  Copyright © 2018年 Marveliu. All rights reserved.
//

#import "JieJiViewController.h"
#import "Block.h"
#import "SuccessViewController.h"

// 初始下落速度
#define FallSpeed ScreenH / 120

@interface JieJiViewController ()
/** 存放所有的块 */
@property (strong, nonatomic) NSMutableArray *blocks;
/** 是否开始游戏 */
@property (nonatomic, assign) BOOL timerRunning;
/** 定时器 */
@property (strong, nonatomic) CADisplayLink *displayLink;
/** 点击的总次数 */
@property (nonatomic, assign) NSInteger BlackblockSum;
/** 得分显示器 */
@property (strong, nonatomic) UILabel *scoreLabel;
/** 存放所有的黑块 */
@property (strong, nonatomic) NSMutableArray *blackBlocks;
/** 下落的速度 */
@property (nonatomic, assign) CGFloat fallSpeed;


@end

@implementation JieJiViewController

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
    [self.blackBlocks removeAllObjects];
    
    for(UIView *view in self.view.subviews){
        [view removeFromSuperview];
    }
    // 重置属性
    self.timerRunning = NO;
    self.BlackblockSum = 0;
    self.scoreLabel.text = @"0";
    self.fallSpeed = FallSpeed;
    [self addStartLine];
    [self addNormalLine:1 isFirstLine:YES];
    for(int i = 2 ; i <= JieJiTotalLines; ++i){
        [self addNormalLine:i isFirstLine:NO];
    }
    Block *block = [self.blackBlocks firstObject];
    block.enabled = YES;
    [self setupScoreLabel];
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
}

/**
 *  添加黑白块
 */
- (void)addNormalLine:(NSInteger)line isFirstLine:(BOOL)firstLine{
    if(self.blocks.count >= (JieJiTotalLines + 2) * 4) return;
    CGFloat blockW = ScreenW / 4;
    CGFloat blockH = ScreenH / 4;
    CGFloat blockX;
    CGFloat blockY;
    
    int blackIndex = arc4random() % 4;
    
    for(NSInteger i = 0; i < 4; ++i){
        
        Block *block = [[Block alloc] init];
        if(blackIndex == i){
            block.enabled = NO;
            block.index = self.blackBlocks.count + 1;
            [self.blackBlocks addObject:block];
        }
        block.type = (blackIndex == i ? BlockTypeBlack : BlockTypeWhite);
        block.line = line;
        block.user = NO;
        block.backgroundColor = (blackIndex == i ? [UIColor blackColor] : [UIColor whiteColor]);
        if(blackIndex == i && firstLine){
            [block setTitle:@"开始" forState:UIControlStateNormal];
        }
        blockX = i * blockW;
        blockY = ScreenH - (line + 1) * blockH;
        block.frame = CGRectMake(blockX, blockY, blockW - 1, blockH - 1);
        [block addTarget:self action:@selector(blockClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.blocks addObject:block];
        [self.view addSubview:block];
    }
}

static UIWindow *window_;
- (void)setupScoreLabel{
    CGFloat scoreLabelW = 120;
    CGFloat scoreLabelH = 50;
    CGFloat scoreLabelX = ScreenW / 2 - scoreLabelW / 2;
    CGFloat scoreLabelY = 0;
    
    // 创建窗口
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(scoreLabelX, scoreLabelY, scoreLabelW, scoreLabelH);
    window_.backgroundColor = [UIColor clearColor];
    
    self.scoreLabel.frame = window_.bounds;
    self.scoreLabel.backgroundColor = [UIColor clearColor];
    self.scoreLabel.textColor = [UIColor redColor];
    self.scoreLabel.textAlignment = NSTextAlignmentCenter;
    self.scoreLabel.font = [UIFont systemFontOfSize:25];
    [window_ addSubview:self.scoreLabel];
}

- (void)blockClick:(Block *)block{
    if(block.type == BlockTypeBlack){
        if(!self.timerRunning){
            // 开始游戏
            [self startGame];
        }
        block.backgroundColor = [UIColor lightGrayColor];
        block.enabled = NO;
        
        // 下一行的黑块允许被点
        Block *nextBlock  = self.blackBlocks[block.index];
        nextBlock.enabled = YES;
        
        // 一共点击的多少黑块
        self.BlackblockSum++;
        self.scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)self.BlackblockSum];
        self.fallSpeed = FallSpeed * 1.0 + self.BlackblockSum / 10.0;
        
    }else if(block.type == BlockTypeWhite){
        // 停止交互
        self.view.userInteractionEnabled = NO;
        [self whiteBlockColorChange:block];
    }
}

- (void)whiteBlockColorChange:(Block *)block{
    [UIView animateWithDuration:0.2 animations:^{
        block.backgroundColor = [UIColor redColor];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            block.backgroundColor = [UIColor blackColor];
        } completion:^(BOOL finished) {
            block.backgroundColor = [UIColor redColor];
            [self endGame];
        }];
    }];
}

- (void)endGame{
    // 停止定时器，停止刷新时间
    [self stopDisplayLink];
    self.view.userInteractionEnabled = NO;
    SuccessViewController *vc = [[SuccessViewController alloc] init];
    vc.titleName = @"街机";
    vc.score = self.scoreLabel.text;
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

- (void)startGame{
    self.timerRunning = YES;
    [self startDisplayLink];
    window_.hidden = NO;
}

- (void)startDisplayLink{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self  selector:@selector(updateTimer:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)updateTimer:(CADisplayLink *)displayLink{
    
    [self addNormalLine:JieJiTotalLines + 1 isFirstLine:NO];
    for(NSInteger i = 0; i < self.blocks.count; ++i){
        Block *block = self.blocks[i];
        block.y += self.fallSpeed;
        if(block.y > ScreenH && block.user == NO){
            block.user = YES;
            if(block.backgroundColor == [UIColor blackColor]){
                [self endGame];
            }
            [self.blocks removeObject:block];
            [block removeFromSuperview];
        }
    }
}

- (void)stopDisplayLink{
    [self.displayLink invalidate];
    self.displayLink = nil;
}

#pragma mark - 懒加载
- (UILabel *)scoreLabel{
    if(!_scoreLabel){
        _scoreLabel = [[UILabel alloc] init];
    }
    return _scoreLabel;
}

- (NSMutableArray *)blocks{
    if(!_blocks){
        _blocks = [[NSMutableArray alloc] init];
    }
    return _blocks;
}

- (NSMutableArray *)blackBlocks{
    if(!_blackBlocks){
        _blackBlocks = [[NSMutableArray alloc] init];
    }
    return _blackBlocks;
}

@end
