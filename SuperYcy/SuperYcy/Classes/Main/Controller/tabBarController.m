//
//  TabBarController.m
//  SuperYcy
//
//  Created by 叶晨宇 on 2018/11/10.
//  Copyright © 2018 叶晨宇. All rights reserved.
//

#import "TabBarController.h"
#import "TabBar.h"
#import "EssenceViewController.h"
#import "MeViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

+ (void)load {
    //对所有的item进行相同的设置
    UITabBarItem *item=[UITabBarItem appearance];
    //选中状态下的字体颜色
    NSMutableDictionary *attributes=[NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName]=[UIColor blackColor];
    [item setTitleTextAttributes:attributes forState:UIControlStateSelected];
    
    //正常状态下的字体大小
    NSMutableDictionary *attributes2=[NSMutableDictionary dictionary];
    attributes2[NSFontAttributeName]=[UIFont systemFontOfSize:11];
    [item setTitleTextAttributes:attributes2 forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAllChildViewController];
    
    [self setAllButtonTitle];
    
    [self setupTabBar];
}

- (void)setupTabBar
{
    TabBar *tabBar = [[TabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
}

//添加子控制器
- (void)setAllChildViewController {
    
    //1.Essence (精华)
    EssenceViewController *essenceVC=[[EssenceViewController alloc]init];
    UINavigationController *navigationVC1=[[UINavigationController alloc]initWithRootViewController:essenceVC];
    [self addChildViewController:navigationVC1];

    //2.Me（我的）
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:NSStringFromClass([MeViewController class]) bundle:nil];
    
    MeViewController *meVC=[storyBoard instantiateInitialViewController];
    UINavigationController *navigationVC2=[[UINavigationController alloc]initWithRootViewController:meVC];
    [self addChildViewController:navigationVC2];
}

//设置tabBar按钮
- (void)setAllButtonTitle {
    
    UINavigationController *navigationVC1=self.childViewControllers[0],
    *navigationVC2=self.childViewControllers[1];
    
    //1.Essence
    navigationVC1.tabBarItem.title=@"精华";
    navigationVC1.tabBarItem.image=[UIImage imageNamed:@"tabBar_essence_icon"];
    navigationVC1.tabBarItem.selectedImage=[UIImage imageNamed:@"tabBar_essence_click_icon"];
    
    
    //2.Me
    navigationVC2.tabBarItem.title=@"我";
    navigationVC2.tabBarItem.image=[UIImage imageNamed:@"tabBar_me_icon"];
    navigationVC2.tabBarItem.selectedImage=[UIImage imageNamed:@"tabBar_me_click_icon"];
}



@end
