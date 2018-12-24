//
//  QXWebViewController.m
//  MovieBank
//
//  Created by 祈越 on 2018/12/18.
//  Copyright © 2018 QiyueX. All rights reserved.
//

#import "QXWebViewController.h"
#import "Masonry.h"

@interface QXWebViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIActivityIndicatorView *actIndicator;

@end

@implementation QXWebViewController

- (instancetype)initWithURL:(NSString *)urlStr {
    if (self = [super init]) {
        self.urlStr = urlStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *navBtnGoBack = [[UIBarButtonItem alloc] initWithTitle:@"后退" style:UIBarButtonItemStylePlain target:self action:@selector(pressNavBtnGoBack)];
    UIBarButtonItem *navBtnGoForward = [[UIBarButtonItem alloc] initWithTitle:@"前进" style:UIBarButtonItemStylePlain target:self action:@selector(pressNavBtnGoForward)];
    UIBarButtonItem *navBtnRefresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(pressNavBtnRefresh)];
    self.navigationItem.rightBarButtonItems = @[navBtnRefresh, navBtnGoForward, navBtnGoBack];
    
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.actIndicator];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
    }];
    [self.actIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.center.equalTo(self.view);
    }];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
    [self.webView loadRequest:urlRequest];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.actIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.actIndicator stopAnimating];
}

#pragma mark - EventHandlers

- (void)pressNavBtnGoBack {
    [self.webView goBack];
}

- (void)pressNavBtnGoForward {
    [self.webView goForward];
}

- (void)pressNavBtnRefresh {
    [self.webView reload];
}

#pragma mark - LazyLoad

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
    }
    return _webView;
}

- (UIActivityIndicatorView *)actIndicator {
    if (!_actIndicator) {
        _actIndicator = [[UIActivityIndicatorView alloc] init];
        _actIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [_actIndicator stopAnimating];
    }
    return _actIndicator;
}

@end
