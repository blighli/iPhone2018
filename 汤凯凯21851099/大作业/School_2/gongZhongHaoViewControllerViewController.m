//
//  gongZhongHaoViewController.m
//  School_2
//
//  Created by 汤凯凯 on 15/12/14.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "gongZhongHaoViewControllerViewController.h"

@interface gongZhongHaoViewControllerViewController ()
@property UIImage *image2;
@property UIView *background;
@end

@implementation gongZhongHaoViewControllerViewController

- (void)viewDidLoad {
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
    self.imageView.layer.masksToBounds = true;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(self.a == 0) {
        UIImage *image = [UIImage imageNamed:@"事物"];
        self.imageView.image = image;
        self.gongZhongHao.text = @"仓前事务服务中心";
        self.gongZhongHaoMingZi.text = @"微信号:hznusw";
        self.GongNengJieShao.text = @"功能介绍：嗨！我是仓前学生事务服务中心的小助手，我有很强大的能力去处理正装免费出借、校园宣传张贴申请、活动物资借取、火车优惠卡充磁、医药费报销、保险、贷款业务的受理、学生权益维护、汽车票销售等等事项。";
    }
    else if(self.a == 1 && self.b == 0) {
        UIImage *image = [UIImage imageNamed:@"微学工"];
        self.imageView.image = image;
        self.gongZhongHao.text = @"杭师大微学工";
        self.gongZhongHaoMingZi.text = @"微信号:hsdxsgz";
        self.GongNengJieShao.text = @"功能介绍:为学生提供校园资讯，打造服务学生平台。";
        
    }
    else if(self.a == 1 && self.b == 1){
        UIImage *image = [UIImage imageNamed:@"学生会"];
        self.imageView.image = image;
        self.gongZhongHao.text = @"杭州师范大学学生会";
        self.gongZhongHaoMingZi.text = @"微信号:hznustu";
        self.GongNengJieShao.text = @"功能介绍:我们是一个拳头，我们要奋发有为，若想了解更多动态，请关注我们！^_^";
    }
    else if(self.a == 1 && self.b == 2) {
        UIImage *image = [UIImage imageNamed:@"团委"];
        self.imageView.image = image;
        self.gongZhongHao.text = @"杭州师范大学团委";
        self.gongZhongHaoMingZi.text = @"微信号:hsdgqt";
        self.GongNengJieShao.text = @"功能介绍:师大青年，师大荣光！";
        
    }
    else if(self.a == 1 && self.b == 3) {
        UIImage *image = [UIImage imageNamed:@"小助理"];
        self.imageView.image = image;
        self.gongZhongHao.text = @"杭师大国服小助理";
        self.gongZhongHaoMingZi.text = @"微信号:guofuxiaozhuli";
        self.GongNengJieShao.text = @"功能介绍:国服最新资讯动态，国服人都在看。抒发你的心声吧，学长学姐带你玩转国服，做一个时尚的HISEer达人。";
        
    }
    else if(self.a == 1 && self.b == 4) {
        UIImage *image = [UIImage imageNamed:@"杭师大"];
        self.imageView.image = image;
        self.gongZhongHao.text = @"杭州师范大学";
        self.gongZhongHaoMingZi.text = @"微信号:hznuweixin";
        self.GongNengJieShao.text = @"功能介绍:发布校园资讯。";
        
    }
    else if(self.a == 1 && self.b == 5) {
        UIImage *image = [UIImage imageNamed:@"图书馆"];
        self.imageView.image = image;
        self.gongZhongHao.text = @"杭师大图书馆";
        self.gongZhongHaoMingZi.text = @"微信号:hznulib";
        self.GongNengJieShao.text = @"功能介绍:为全校师生提供图书馆的各种服务。";
    }
    else if(self.a == 2)
    {
        UIImage *image = [UIImage imageNamed:@"廉洁"];
        self.imageView.image = image;
        self.gongZhongHao.text = @"廉洁杭师大";
        self.gongZhongHaoMingZi.text = @"微信号:hsdjwb";
        self.GongNengJieShao.text = @"功能介绍:传播廉政资讯，弘扬廉政文化；扬清风正气，传递正能量，助推链接校园建设；实现廉政教育常态化、廉洁警示动态化、廉政信息生活化。";
    }
    else if(self.a == 3)
    {
        UIImage *image = [UIImage imageNamed:@"114"];
        self.imageView.image = image;
        self.gongZhongHao.text = @"校园114党员服务中心";
        self.gongZhongHaoMingZi.text = @"微信号:hznuxy114";
        self.GongNengJieShao.text = @"功能介绍:这是一款集权益维护、热线咨询、意见反馈、证件补办、舆情反馈等等服务于一身的服务平台。";
        
    }
    else if(self.a == 4){
        UIImage *image = [UIImage imageNamed:@"青"];
        self.imageView.image = image;
        self.gongZhongHao.text = @"青柠音乐生活馆";
        self.gongZhongHaoMingZi.text = @"微信号:lime-music";
        self.GongNengJieShao.text = @"功能介绍:感谢关注青柠音乐生活馆，青柠专业售卖、教授吉他、尤克里里。提供特色饮品。欢迎大家相聚在青柠。";
        
    }
   
    self.image2 = self.imageView.image;
    //为image添加手势
    self.imageView.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap)];
    [self.imageView addGestureRecognizer:tap];
}
-(void)singleTap{
    //创建灰色背景图，使后面内容不能操作
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.background = bgView;
    [bgView setBackgroundColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.7]];
    [self.view addSubview:bgView];
    //创建边框
    UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,200+16, 200+16)];
    //将图层的边框设置为圆脚
    borderView.layer.cornerRadius = 8;
    borderView.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    borderView.layer.borderWidth = 8;
    borderView.layer.borderColor = [[UIColor colorWithRed:0.9
                                                    green:0.9
                                                     blue:0.9
                                                    alpha:0.7]CGColor];
    
    [borderView setCenter:bgView.center];
    [bgView addSubview:borderView];
    //放大的图片
    UIImageView *scaleImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 200, 200)];
    scaleImage.image = self.image2;
    [borderView addSubview:scaleImage];
    UITapGestureRecognizer *suoxiao1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(suoxiao)];
    [borderView addGestureRecognizer:suoxiao1];
    //放大过程中的动画
    [self shakeToView:borderView];
}
-(void)suoxiao{
    [_background removeFromSuperview];
}
-(void)shakeToView:(UIView *)aView{
    //动画的效果
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
