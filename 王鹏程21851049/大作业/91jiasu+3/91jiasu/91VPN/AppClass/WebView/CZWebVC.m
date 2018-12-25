//
//  CZWebVC.m
//  91VPN
//
//  Created by weichengzong on 2017/8/21.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZWebVC.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WebKit.h>
#import "CZHomeModel.h"


#import "UIViewController+BackButtonHandler.h"
#import "WXApi.h"

static void *XFWkwebBrowserContext = &XFWkwebBrowserContext;

@interface CZWebVC ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *wkWebView;
//设置加载进度条
@property (nonatomic ,strong) UIProgressView *progressView;
@property (nonatomic ,strong) UIView *bgView;

@property (nonatomic ,assign) BOOL is_success;

@end

@implementation CZWebVC
- (void)viewDidAppear:(BOOL)animated{

}
- (void)viewWillDisappear:(BOOL)animated{
//    CZHomeModel *homeModel = [[CZHomeModel alloc] init];
//    NSString *token = [[MyUserInfo getUserInfo] objectForKey:@"token"];
//    [homeModel getUserinfo:token complete:^(NSDictionary *result) {
//        if ([result[@"status"] integerValue]==0000) {
//            NSDictionary *dic = [result objectForKey:@"data"];
//            NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]initWithDictionary:dic];
//            [dic1 setObject:[[MyUserInfo getUserInfo] objectForKey:@"user_name"] forKey:@"user_name"];
//            [dic1 setObject:[[MyUserInfo getUserInfo] objectForKey:@"user_pwd"] forKey:@"user_pwd"];
//            [dic1 setObject:[[MyUserInfo getUserInfo] objectForKey:@"token"] forKey:@"token"];
//            [MyUserInfo saveUserInfo:dic1];
//        }else{
//            [self showTopMessage:result[@"msg"] topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
//        }
//    }];

}
-(BOOL)navigationShouldPopOnBackButton{
    if (_is_success) {
        self.navigationController.tabBarController.selectedIndex=0;  //0
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    return YES;
}
- (void)goback1
{
    if (_is_success) {
        self.navigationController.tabBarController.selectedIndex=0;  //0
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"----------%@",self.URLString);
//    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
//
//    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    _bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_bgView];
    UILabel *topLabel = [[UILabel alloc] init];
    topLabel.text = @"正在转向中，请稍等......";
    topLabel.font = [UIFont systemFontOfSize:13];
    topLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgView).offset(20);
        make.right.equalTo(_bgView);
        make.left.equalTo(_bgView);
        make.height.mas_equalTo(30);
    }];
    UILabel *twoLabel = [[UILabel alloc] init];
    twoLabel.text = @"如果系统长时间无响应，请返回查看用户信息是否充值成功";
    twoLabel.numberOfLines = 0;
    twoLabel.font = [UIFont systemFontOfSize:13];
    twoLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:twoLabel];
    [twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabel.mas_bottom).offset(5);
        make.right.equalTo(_bgView);
        make.left.equalTo(_bgView);
        make.height.mas_equalTo(30);
    }];
    
    
    
    //添加到主控制器上
    [self.view addSubview:self.wkWebView];
    
    //添加进度条
    [self.view addSubview:self.progressView];
    
    //创建一个NSURLRequest 的对象
    NSMutableURLRequest * Request_zsj = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.URLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    [self.wkWebView loadRequest:Request_zsj];
    
//    if (self.URLString) {
//
//    }else{
//        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"text.rtf" withExtension:nil];
//        
//        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
//        // 服务器的响应对象,服务器接收到请求返回给客户端的
//        NSURLResponse *respnose = nil;
//        
//        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&respnose error:NULL];
//        
//        NSLog(@"%@", respnose.MIMEType);
//        
//        // 在iOS开发中,如果不是特殊要求,所有的文本编码都是用UTF8
//        // 先用UTF8解释接收到的二进制数据流
//        [self.wkWebView loadData:data MIMEType:respnose.MIMEType textEncodingName:@"UTF8" baseURL:nil];
//    }
}

//开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让加载进度条显示
    self.progressView.hidden = NO;
}

//KVO监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
//    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
//        [self.progressView setAlpha:1.0f];
//        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
//        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
//        
//        // Once complete, fade out UIProgressView
//        if(self.wkWebView.estimatedProgress >= 1.0f) {
//            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
//                [self.progressView setAlpha:0.0f];
//            } completion:^(BOOL finished) {
//                [self.progressView setProgress:0.0f animated:NO];
//            }];
//        }
//    }
//    else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
}

- (UIWebView *)wkWebView{
    if (!_wkWebView) {
        //设置网页的配置文件
        WKWebViewConfiguration * Configuration = [[WKWebViewConfiguration alloc]init];
        //允许视频播放
        Configuration.allowsAirPlayForMediaPlayback = YES;
        // 允许在线播放
        Configuration.allowsInlineMediaPlayback = YES;
        // 允许可以与网页交互，选择视图
        Configuration.selectionGranularity = YES;
        // web内容处理池
        Configuration.processPool = [[WKProcessPool alloc] init];
        //自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作)
        WKUserContentController * UserContentController = [[WKUserContentController alloc]init];
        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
//        [UserContentController addScriptMessageHandler:self name:@"WXPay"];
        // 是否支持记忆读取
        Configuration.suppressesIncrementalRendering = YES;
        // 允许用户更改网页的设置
        Configuration.userContentController = UserContentController;
        _wkWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) ];
        _wkWebView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
        _wkWebView.delegate = self;
        // 设置代理
//        _wkWebView.navigationDelegate = self;
//        _wkWebView.UIDelegate = self;
        //kvo 添加进度监控
        [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:XFWkwebBrowserContext];
        //开启手势触摸
//        _wkWebView.allowsBackForwardNavigationGestures = YES;
        // 设置 可以前进 和 后退
        //适应你设定的尺寸
        [_wkWebView sizeToFit];
        
    }
    return _wkWebView;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    NSString* reqUrl = request.URL.absoluteString;
    NSLog(@"------------------------------------%@",reqUrl);
    
    NSArray *arrtop = [reqUrl componentsSeparatedByString:@"?"];

    if ([[arrtop firstObject] rangeOfString:@"requestToken"].location !=NSNotFound) {
        if ([MyUserInfo isLogined]) {
            NSString *str =[[MyUserInfo getUserInfo] objectForKey:SHInvokerUserInforuser_token];
            NSString *str1 = [NSString stringWithFormat:@"%@'%@'",@"backToken",str];
            [_wkWebView stringByEvaluatingJavaScriptFromString:str1];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    //微信
    if ([[arrtop firstObject] rangeOfString:@"loading.html"].location !=NSNotFound) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"重要提示" message:@"是否已完成支付？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *clAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            NSURLRequest * Request_zsj = [NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
            //加载网页
            [self.wkWebView loadRequest:Request_zsj];
        }];
        
        [alert addAction:clAction];
        UIAlertAction *photography = [UIAlertAction actionWithTitle:@"已支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *lastStr = [arrtop lastObject];
            NSString *strl = [[lastStr componentsSeparatedByString:@"="] lastObject];
            NSString *orderStr = [[strl componentsSeparatedByString:@"-"] objectAtIndex:1];
            [self payStatus:orderStr withWX:YES];
        }];
        [alert addAction:photography];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    //支付宝
    if ([reqUrl rangeOfString:@"out_trade_no"].location !=NSNotFound) {
        NSArray *arr1 = [[arrtop lastObject] componentsSeparatedByString:@"="];
        NSString *lastStr = [arr1 objectAtIndex:arr1.count-2];
        NSArray *orderarr = [lastStr componentsSeparatedByString:@"&"];
        NSString *orderStr = [orderarr firstObject];
        [self payStatus:orderStr withWX:NO];
        return NO;
    }

    if ([reqUrl hasPrefix:@"alipays://"] || [reqUrl hasPrefix:@"alipay://"]) {
        self.wkWebView.hidden = YES;
        // NOTE: 跳转支付宝App
        BOOL bSucc = [[UIApplication sharedApplication]openURL:request.URL];
        
        // NOTE: 如果跳转失败，则跳转itune下载支付宝App
        if (!bSucc) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"未检测到支付宝客户端，请安装后重试。"
                                                          delegate:self
                                                 cancelButtonTitle:@"立即安装"
                                                 otherButtonTitles:nil];
            [alert show];
        }
        return NO;
    }
//    //新版本的H5拦截支付对老版本的获取订单串和订单支付接口进行合并，推荐使用该接口
//    __weak CZWebVC* wself = self;
//    BOOL isIntercepted = [[AlipaySDK defaultService] payInterceptorWithUrl:[request.URL absoluteString] fromScheme:@"jiuyaojiasu" callback:^(NSDictionary *result) {
//        // 处理支付结果
//        NSLog(@"%@", result);
//        // isProcessUrlPay 代表 支付宝已经处理该URL
//        if ([result[@"isProcessUrlPay"] boolValue]) {
//            // returnUrl 代表 第三方App需要跳转的成功页URL
////            NSString* urlStr = result[@"returnUrl"];
//            NSString *codeStr = [NSString stringWithFormat:@"%@",[result objectForKey:@"resultCode"]];
//            if (codeStr.integerValue==9000) {
//                    [wself loadWithUrlStr:@"http://www.i1y8.com/home/index/isok.html"];
//            }
//        }
//    }];
    
//    if (isIntercepted) {
//        return NO;
//    }

    NSURL *URL = webView.request.URL;
//    NSLog(@"%@",URL);
    NSString *scheme = [URL scheme];
    
    if ([reqUrl rangeOfString:@"isok.html"].location !=NSNotFound) {
        _is_success = YES;
    }
    return YES;
}
- (void)sleep
{
    self.navigationController.tabBarController.selectedIndex=0;  //0
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)loadWithUrlStr:(NSString*)urlStr
{
    if (urlStr.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURLRequest *webRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]
                                                        cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                    timeoutInterval:30];
            [self.wkWebView loadRequest:webRequest];
        });
    }
}

- (void)payStatus:(NSString *)orderStr withWX:(BOOL)iswx{
    NSString *token = [[MyUserInfo getUserInfo] objectForKey:@"token"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:token forKey:@"token"];
    [param setObject:orderStr forKey:@"out_trade_no"];

    [AFNetInterFaceManager Post:GETPayStatus parameters:param success:^(NSDictionary *response, NSURLSessionDataTask *task) {
        NSDictionary *dict = (NSDictionary*)response;
        NSLog(@"%@",dict);
        if (iswx) {
            NSString *statusStr = [NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
            if (statusStr.integerValue==0000) {
                NSDictionary *dataDic = [dict objectForKey:@"data"];
                if ([[dataDic objectForKey:@"trade_status"] isEqualToString:@"WX_SUCCESS"]) {
                    NSString *urlStr = nil;
                    if ([[MyUserInfo getInfoForkey:[[MyUserInfo getUserInfo] objectForKey:SHInvokerUserInfouser_name]] isEqualToString:@"guowai"]) {
                        urlStr = [NSString stringWithFormat:@"%@%@",@"http://www.i1y8.com",@"/home/index/isok.html"];
                    }else{
                        urlStr = [NSString stringWithFormat:@"%@%@",@"http://91jiasu.adclick.com.cn",@"/home/index/isok.html"];
                    }
                    NSURLRequest * Request_zsj = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
                    //加载网页
                    [self.wkWebView loadRequest:Request_zsj];
                    self.wkWebView.hidden = NO;
                }else{
                    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                        
                    }else{
                        [self showTopMessage:@"请安装微信进行支付" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
                    }
                    self.wkWebView.hidden = NO;
                    NSString *urlStr = nil;
                    if ([[MyUserInfo getInfoForkey:[[MyUserInfo getUserInfo] objectForKey:SHInvokerUserInfouser_name]] isEqualToString:@"guowai"]) {
                        urlStr = [NSString stringWithFormat:@"%@%@",@"http://www.i1y8.com",@"/home/index/isno.html"];
                    }else{
                        urlStr = [NSString stringWithFormat:@"%@%@",@"http://91jiasu.adclick.com.cn",@"/home/index/isno.html"];
                    }
                    NSURLRequest * Request_zsj = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
                    //加载网页
                    [self.wkWebView loadRequest:Request_zsj];
                    
                    
                }
                
            }
        }else{
            //支付宝
            NSString *statusStr = [NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
            if (statusStr.integerValue==0000) {
                NSDictionary *dataDic = [dict objectForKey:@"data"];
                if ([[dataDic objectForKey:@"trade_status"] isEqualToString:@"TRADE_SUCCESS"]) {
                    self.wkWebView.hidden = NO;
                    NSString *urlStr = nil;
                    if ([[MyUserInfo getInfoForkey:[[MyUserInfo getUserInfo] objectForKey:SHInvokerUserInfouser_name]] isEqualToString:@"guowai"]) {
                        urlStr = [NSString stringWithFormat:@"%@%@",@"http://www.i1y8.com",@"/home/index/isok.html"];
                    }else{
                        urlStr = [NSString stringWithFormat:@"%@%@",@"http://91jiasu.adclick.com.cn",@"/home/index/isok.html"];
                    }
                    NSURLRequest * Request_zsj = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
                    //加载网页
                    [self.wkWebView loadRequest:Request_zsj];
                    
                }
                
            }

        }
        
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
        NSLog(@"%@",error);
    }];

    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // NOTE: 跳转itune下载支付宝App
    NSString* urlStr = @"https://itunes.apple.com/cn/app/zhi-fu-bao-qian-bao-yu-e-bao/id333206289?mt=8";
    NSURL *downloadUrl = [NSURL URLWithString:urlStr];
    [[UIApplication sharedApplication]openURL:downloadUrl];
}
- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 2);
        // 设置进度条的色彩
        [_progressView setTrackTintColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0]];
        _progressView.progressTintColor = [UIColor greenColor];
    }
    return _progressView;
}
//-(void)viewWillDisappear:(BOOL)animated{
//    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"WXPay"];
//    [self.wkWebView setNavigationDelegate:nil];
//    [self.wkWebView setUIDelegate:nil];
//}
//注意，观察的移除
-(void)dealloc{
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
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
