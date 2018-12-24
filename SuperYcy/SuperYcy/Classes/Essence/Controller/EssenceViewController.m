//
//  EssenceViewController.m
//  SuperYcy
//
//  Created by 叶晨宇 on 2018/12/03.
//  Copyright © 2018 叶晨宇. All rights reserved.
//

#import "EssenceViewController.h"
#import "TitleButton.h"
#import "AllTableViewController.h"
#import "PictureTableViewController.h"
#import "VideoTableViewController.h"
#import "VoiceTableViewController.h"
#import "WordsTableViewController.h"

@interface EssenceViewController () <UIScrollViewDelegate>
@property(weak,nonatomic)UIView *titleView;
@property (weak, nonatomic) TitleButton *previousClickedTitleButton;
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化5个子TableView控制器
    [self setAllChildVC];
    
    //设置NavigationBar
    [self setupNavigationBar];
    
    //ScrollView
    [self setScrollView];
    
    //标题栏
    [self setTitleView];
    
    //ALL页面子控制器
    [self addChildVcViewIntoScrollView:0];
}

-(void)setAllChildVC{
    [self addChildViewController:[[AllTableViewController alloc]init]];
    [self addChildViewController:[[PictureTableViewController alloc]init]];
    [self addChildViewController:[[VideoTableViewController alloc]init]];
    [self addChildViewController:[[VoiceTableViewController alloc]init]];
    [self addChildViewController:[[WordsTableViewController alloc]init]];
}

-(void)setScrollView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView=[[UIScrollView alloc]init];
    scrollView.backgroundColor=[UIColor grayColor];
    scrollView.frame=self.view.bounds;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.scrollsToTop = NO;
    [self.view addSubview: scrollView];
    self.scrollView = scrollView;

    CGFloat scrollViewW = scrollView.bounds.size.width;

    scrollView.contentSize = CGSizeMake(5 * scrollViewW, 0);

}

-(void)setTitleView{
    UIView *titleView=[[UIView alloc]init];
    titleView.backgroundColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    titleView.frame = CGRectMake(0, 64, self.view.bounds.size.width, 35);
    [self.view addSubview: titleView];
    self.titleView=titleView;
    
    [self setTitleButton];
    
}

-(void)setTitleButton{
    
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    
    // 标题按钮的尺寸
    CGFloat titleButtonW = self.view.bounds.size.width / count;
    CGFloat titleButtonH = self.titleView.bounds.size.height;
    
    // 创建5个标题按钮
    for (NSUInteger i = 0; i < count; i++) {
        TitleButton *titleButton = [[TitleButton alloc] init];
        titleButton.tag = i;
        //点击事件：切换到相应的TableView
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:titleButton];
        // frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        // 文字
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];

    }
}


- (void) setupNavigationBar{
    //设置button，Bar左右两边各一个
    UIButton *btnGame=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnGame setImage:[UIImage imageNamed:@"nav_item_game_icon"]
         forState:UIControlStateNormal];
    [btnGame setImage:[UIImage imageNamed:@"nav_item_game_click_icon"]          forState:UIControlStateHighlighted];
    [btnGame addTarget:self action:@selector(game) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btnRandom=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnRandom setImage:[UIImage imageNamed:@"navigationButtonRandom"]
         forState:UIControlStateNormal];
    [btnRandom setImage:[UIImage imageNamed:@"navigationButtonRandomClick"]          forState:UIControlStateHighlighted];
    [btnRandom addTarget:self action:@selector(random) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btnGame];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btnRandom];
    self.navigationItem.title=@"精华";
    
}

- (void)game {
    NSLog(@"game button clicked...");
}

-(void)random{
    NSLog(@"game random clicked...");
}

- (void)titleButtonClick:(TitleButton *)titleButton{
    //重复点击标题
    if (self.previousClickedTitleButton == titleButton) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TitleButtonDidRepeatClickNotification" object:nil];
    }
    
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    NSUInteger index = titleButton.tag;

    [UIView animateWithDuration:0.25 animations:^{
        CGFloat offsetX = self.scrollView.bounds.size.width*index;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    }completion:^(BOOL finished) {
        [self addChildVcViewIntoScrollView:titleButton.tag];
    }];
    
    for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVc = self.childViewControllers[i];
        if (!childVc.isViewLoaded) continue;
        UIScrollView *scrollView = (UIScrollView *)childVc.view;
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        scrollView.scrollsToTop = (i == index);
    }
        
}


#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;

    TitleButton *titleButton = self.titleView.subviews[index];
    [self titleButtonClick:titleButton];
}

- (void)addChildVcViewIntoScrollView:(NSUInteger)index
{
    UIViewController *childVc = self.childViewControllers[index];
    
    // 如果view已经被加载过，就直接返回
    if (childVc.isViewLoaded) return;
    
    // 取出index位置对应的子控制器view
    UIView *childVcView = childVc.view;
    
    // 设置子控制器view的frame
    CGFloat scrollViewW = self.scrollView.bounds.size.width;
    childVcView.frame = CGRectMake(index * scrollViewW, 0, scrollViewW, self.scrollView.bounds.size.height);
    // 添加子控制器的view到scrollView中
    [self.scrollView addSubview:childVcView];
}

@end
