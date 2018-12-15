//
//  DetailNewsViewController.m
//  School_2
//
//  Created by 汤凯凯 on 15/12/15.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "DetailNewsViewController.h"

@interface DetailNewsViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DetailNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.list = @[@"http://www.hznu.edu.cn/sdyw/739762.shtml",@"http://www.hznu.edu.cn/sdyw/739152.shtml",@"http://www.hznu.edu.cn/sdyw/737670.shtml",@"http://www.hznu.edu.cn/sdyw/733058.shtml",@"http://www.hznu.edu.cn/sdyw/736492.shtml",@"http://www.hznu.edu.cn/sdyw/732920.shtml"];
    self.string = [self.list objectAtIndex:self.index];
    self.url = [NSURL URLWithString:_string];
    self.req = [NSURLRequest requestWithURL:_url];
    [self.webView loadRequest:_req];
    self.webView.scalesPageToFit = true;
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
