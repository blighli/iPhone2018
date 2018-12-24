//
//  ViewController.m
//  MyPhoto
//
//  Created by 熊伟刚 on 2018/11/3.
//  Copyright © 2018 熊伟刚. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;
- (IBAction)photoBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *photoIndexLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *preBtn;

- (IBAction)btnClick:(UIButton *)sender;
- (IBAction)segmentValueChange:(UISegmentedControl *)sender;
- (IBAction)valueChange:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (nonatomic,assign)int photoIndex;
@property(nonatomic,assign)bool flag;
@property(nonatomic,assign)CGRect oldFrame;
@property(nonatomic,strong)UIView *coverView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor greenColor]];
    self.segmentControl.selectedSegmentIndex=1;
    self.photoIndex=1;
    [self changePhoto];
    self.flag=false;
    [[[[UIApplication sharedApplication] windows] firstObject] setBackgroundColor:[UIColor whiteColor]];
}


- (IBAction)btnClick:(UIButton *)sender {
    int tag = sender.tag;
    switch (tag) {
        case 1:
            //上一张
            self.photoIndex--;
            [self changePhoto];
            break;
        case 2:
            //下一张
            self.photoIndex++;
            [self changePhoto];
            break;
        case 3:
            //顺时针
            [self rotate:1];
            break;
        case 4:
            //逆时针
            [self rotate:-1];
            break;
    }
}

- (IBAction)segmentValueChange:(UISegmentedControl *)sender {
    
    int index=sender.selectedSegmentIndex;
    switch (index) {
        case 0:
            [self.view setBackgroundColor:[UIColor redColor]];
            break;
        case 1:
            [self.view setBackgroundColor:[UIColor greenColor]];
            break;
        case 2:
            [self.view setBackgroundColor:[UIColor yellowColor]];
            break;
    }
}

- (IBAction)valueChange:(UISlider *)sender {
    self.view.alpha=sender.value;
}


-(void)changePhoto
{
     if(self.photoIndex==1)
         self.preBtn.enabled=NO;
    else
        self.preBtn.enabled=YES;
    if(self.photoIndex==6)
        self.nextBtn.enabled=NO;
    else
        self.nextBtn.enabled=YES;
    [self.photoIndexLabel setText:[NSString stringWithFormat:@"%d/6",self.photoIndex]];
    
    [self.photoBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",self.photoIndex]] forState:UIControlStateNormal];
    [self.photoBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",self.photoIndex]] forState:UIControlStateHighlighted];
}

-(void)rotate:(int)direction
{
    [UIView animateWithDuration:1 animations:^{self.photoBtn.transform=CGAffineTransformRotate(self.photoBtn.transform, (direction)*M_PI_2);}];
}

- (IBAction)photoBtnClick:(UIButton *)sender {
    if(!self.flag)
        [self bigImage];
    else
        [self smallImage];
}

-(void)bigImage
{
    self.oldFrame=self.photoBtn.frame;
    float x = 0;
    float y = self.photoBtn.frame.origin.y;
    float w = [[UIScreen mainScreen]bounds].size.width;
    float h =w;
    
    self.coverView=[[UIView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [self.coverView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:self.coverView];
    self.coverView.alpha=0.1;
    [UIView animateWithDuration:1 animations:^{
        self.coverView.alpha=0.8;
        self.photoBtn.frame=CGRectMake(x, y, w, h);}];
    [self.view bringSubviewToFront:self.photoBtn];
    self.flag=!self.flag;
}

-(void)smallImage
{
    [UIView animateWithDuration:1 animations:^{
        self.photoBtn.frame=self.oldFrame;
    }completion:^(BOOL finished)
     {
         if(finished)
         [self.coverView removeFromSuperview];
     }];
    self.flag=!self.flag;
}

@end
