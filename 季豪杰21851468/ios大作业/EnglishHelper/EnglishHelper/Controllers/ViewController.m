//
//  ViewController.m
//  EnglishHelper
//
//  Created by pc－jhj on 2018/12/13.
//  Copyright © 2018年 jhj. All rights reserved.
//

#import "ViewController.h"
#import "JHJQuestion.h"

@interface ViewController ()
@property (nonatomic,strong) NSArray *questions;
@property (nonatomic,assign) int index;
@property (nonatomic,assign) CGRect iconFrame;

@property (weak, nonatomic) IBOutlet UILabel *lblIndex;
@property (weak, nonatomic) IBOutlet UIButton *btnScore;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnIcon;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIButton *cover;
@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet UIView *optionsView;
- (IBAction)btnIconClick:(id)sender;
- (IBAction)btnTipClick;


- (IBAction)btnNextClick;
- (IBAction)bigImage:(id)sender;
@end

@implementation ViewController
-(NSArray *)questions
{
    if (_questions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"questions.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModel = [NSMutableArray array];
        
        for (NSDictionary *dict in arrayDict) {
            JHJQuestion *model = [JHJQuestion questionWithDict:dict];
            [arrayModel addObject:model];
        }
        _questions = arrayModel;
    }
    return _questions ;
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(BOOL) prefersStatusBarHidden
{
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = -1;
    [self nextQuestion];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnIconClick:(id)sender {
    if(self.cover == nil){
        [self bigImage:nil];
    }else{
        [self smallImage];
    }
}

- (IBAction)btnTipClick {
    [self addScore:-100];
    for (UIButton *btnAnswer in self.answerView.subviews ) {
        [self btnAnswerClick:btnAnswer];
    }
    JHJQuestion *model = self.questions[self.index];
    NSString *firstChar = [model.answer substringToIndex:1];
    for (UIButton *btnOpt in self.optionsView.subviews) {
        if ([btnOpt.currentTitle isEqualToString:firstChar]) {
            [self optionButtonClick:btnOpt];
            break;
        }
    }
    
}

- (IBAction)btnNextClick {
    [self nextQuestion];
}

- (IBAction)bigImage:(id)sender {
    self.iconFrame = self.btnIcon.frame;
    UIButton *btnCover = [[UIButton alloc] init];
    btnCover.frame = self.view.bounds;
    btnCover.backgroundColor = [UIColor blackColor];
    btnCover.alpha = 0.0;
    [self.view addSubview:btnCover];
    
    [btnCover addTarget:self action:@selector(smallImage) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view bringSubviewToFront:self.btnIcon];
    self.cover = btnCover;
    CGFloat iconW = self.view.frame.size.width;
    CGFloat iconH = iconW;
    CGFloat iconX = 0;
    CGFloat iconY = (self.view.frame.size.height - iconH) * 0.5;
    
    [UIView animateWithDuration:1 animations:^{
        btnCover.alpha = 0.6;
        self.btnIcon.frame = CGRectMake(iconX, iconY, iconW, iconH);
    }];
    
    
}
-(void)smallImage
{
    
    [UIView animateWithDuration:1 animations:^{
        self.btnIcon.frame = self.iconFrame;
        self.cover.alpha = 0.0;
        
    }completion:^(BOOL finished) {
        if (finished) {
            [self.cover removeFromSuperview];
            self.cover = nil;
        }

    }];
   

}


-(void)nextQuestion
{
    self.index++;
    if (self.index == self.questions.count) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"恭喜完成一轮学习" message:@"继续学习还是复习单词？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancelAc = [UIAlertAction actionWithTitle:@"继续学习" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            self.index = -1;
            [self nextQuestion];
        }];
        UIAlertAction *comfirmAc = [UIAlertAction actionWithTitle:@"复习单词" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击确定要执行的代码
        }];
        [alertVC addAction:cancelAc];
        [alertVC addAction:comfirmAc];
        [self presentViewController:alertVC animated:YES completion:nil];

        
        
        return;
    }
    JHJQuestion *model = self.questions[self.index];
    [self settingData:model];
    [self makeAnswerButton:model];
    [self makeOptionButtons:model];
}
-(void)settingData:(JHJQuestion *)model
{
    self.lblIndex.text = [NSString stringWithFormat:@"%d / %ld",(self.index+1),self.questions.count];
    self.lblTitle.text = model.title;
    [self.btnIcon setImage:[UIImage imageNamed:model.icon]forState:UIControlStateNormal];
    
    self.btnNext.enabled = (self.index != self.questions.count -1);
}

-(void) makeAnswerButton:(JHJQuestion *) model
{
    while (self.answerView.subviews.firstObject) {
        [self.answerView.subviews.firstObject removeFromSuperview];
    }
    
    NSUInteger len = model.answer.length;
    CGFloat margin = 10;
    CGFloat answerW = 35;
    CGFloat answerH = 35;
    CGFloat answerY = 0;
    CGFloat marginLeft = (self.answerView.frame.size.width - (len * answerW) - (len -1)*margin) / 2;
    
    
    
    
    for (int i =0; i<len; i++) {
        UIButton *btnAnswer = [[UIButton alloc] init];
        [btnAnswer setBackgroundImage:[UIImage imageNamed:@"btn_answer"]forState:UIControlStateNormal];
        [btnAnswer setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"]forState:UIControlStateHighlighted];
        CGFloat answerX = marginLeft + i*(answerW + margin);
        btnAnswer.frame = CGRectMake(answerX, answerY, answerW, answerH);
        [btnAnswer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.answerView addSubview:btnAnswer];
        [btnAnswer addTarget:self action:@selector(btnAnswerClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}

-(void)btnAnswerClick:(UIButton *)sender
{
    self.optionsView.userInteractionEnabled = YES;
    for (UIButton *optBtn in self.optionsView.subviews) {
        if (sender.tag == optBtn.tag) {
            optBtn.hidden = NO;
            break;
        }
    }
    [sender setTitle:nil forState:UIControlStateNormal];
    [self setanswerButtonTitleColor:[UIColor blackColor]];
}



    


-(void) makeOptionButtons:(JHJQuestion *) model
{
    self.optionsView.userInteractionEnabled = YES;
    [self.optionsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSArray *words = model.options;
    CGFloat optionW = 35;
    CGFloat optionH = 35;
    CGFloat margin = 10;

    int columns = 7;
    CGFloat marginLeft = (self.optionsView.frame.size.width - columns * optionW - (columns-1)*margin)/2;
    for (int i = 0; i<words.count; i++) {
        UIButton *btnOpt = [[UIButton alloc] init];
        btnOpt.tag = i;
        [btnOpt setBackgroundImage:[UIImage imageNamed:@"btn_option"] forState:UIControlStateNormal];
        [btnOpt setBackgroundImage:[UIImage imageNamed:@"btn_option_highlighted"] forState:UIControlStateHighlighted];
        
        [btnOpt setTitle:words[i] forState:UIControlStateNormal];
        [btnOpt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        int colIdx = i % columns;
        int rowIdx = i/columns;
        CGFloat optionX = marginLeft + colIdx*(optionW+margin);
        CGFloat optionY = 0 + rowIdx*(optionH + margin);
        
        btnOpt.frame = CGRectMake(optionX, optionY, optionW, optionH);
        [self.optionsView addSubview:btnOpt];
        
        [btnOpt addTarget:self action:@selector(optionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)optionButtonClick:(UIButton *)sender
{
    sender.hidden = YES;
    NSString *text = [sender titleForState:UIControlStateNormal];
    
    
    for (UIButton *answerBtn in self.answerView.subviews) {
        if (answerBtn.currentTitle == nil) {
            [answerBtn setTitle:text forState:UIControlStateNormal];
            answerBtn.tag = sender.tag;
            break;
        }
    }
    BOOL isFull = YES;
    NSMutableString *userInput = [NSMutableString string];
    for (UIButton *btnAnswer in self.answerView.subviews) {
        if (btnAnswer.currentTitle == nil) {
            isFull = NO;
            break;
        }else {
            [userInput appendString:btnAnswer.currentTitle];
        }
    }
    if (isFull) {
        self.optionsView.userInteractionEnabled = NO;
        JHJQuestion *model = self.questions[self.index];
        if ([model.answer isEqualToString:userInput]) {
            [self addScore:100];
            [self setanswerButtonTitleColor:[UIColor blueColor]];
            [self performSelector:@selector(nextQuestion) withObject:nil afterDelay:0.5];
        }else{

            [self setanswerButtonTitleColor:[UIColor redColor]];

        }
        
    }
    
    
    
}
-(void)addScore:(int)score
{
    NSString *str = self.btnScore.currentTitle;
    int currentScore = str.intValue;
    currentScore = currentScore + score;
    [self.btnScore setTitle:[NSString stringWithFormat:@"%d",currentScore] forState:UIControlStateNormal];
}





-(void)setanswerButtonTitleColor:(UIColor *)color
{
    for (UIButton *btnAnswer in self.answerView.subviews) {
        [btnAnswer setTitleColor:color forState:UIControlStateNormal];
    }
}








@end
    
