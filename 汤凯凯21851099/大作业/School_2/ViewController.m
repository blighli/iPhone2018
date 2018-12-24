//
//  ViewController.m
//  School_2
//
//  Created by 汤凯凯 on 15/12/5.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;

@property (weak, nonatomic) IBOutlet UIView *view_1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.loginButton.layer.cornerRadius = 10.0;
    self.signInButton.layer.cornerRadius = 10.0;
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"222" ofType:@"gif"];
    NSData *gif = [NSData dataWithContentsOfFile:filePath];
    
    UIWebView *webViewBG = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    [webViewBG loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    
    webViewBG.userInteractionEnabled = NO;
    
    [self.view_1 addSubview:webViewBG];
}

@end
