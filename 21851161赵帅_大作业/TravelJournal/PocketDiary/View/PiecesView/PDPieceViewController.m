//
//  PDPieceViewController.m
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/30.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import "PDPieceViewController.h"
#import "PDPocketDiaryView.h"
#import "PDRecordViewController.h"
#import "PDPieceEditViewController.h"
#import "PDScaleAnimation.h"
#import "PDSwipeDrivenInteractiveTransition.h"
//#import "PDNormalDismissAnimation.h"
#import "PDInfoViewController.h"
#import "PDDataManager.h"
#import "PDPieceCell.h"
#import "PDReadViewController.h"

#define kOriginY    20

@interface PDPieceViewController ()<PDPocketDiaryViewDelegate, UIViewControllerTransitioningDelegate, PDScaleAnimationDelegate, PDRecordViewControllerDelegate, PDInfoViewControllerDelegate>

@property (nonatomic, retain) PDPocketDiaryView *PocketDiaryView;
@property (nonatomic, assign) CGRect currentItemFrame;
@property (nonatomic, retain) UICollectionViewCell *selecteItemCell;
@property (nonatomic, retain) PDScaleAnimation *scaleAnimation;

//@property (nonatomic, retain) PDSwipeDrivenInteractiveTransition *swipeDrivenInteractive;
//@property (nonatomic, strong) PDNormalDismissAnimation *dismissAnimation;

@end

@implementation PDPieceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = BackgroudGrayColor;
    
//    PDDataManager *dataManager = [PDDataManager defaultManager];
//    NSDate *date = [NSDate date];
//    NSArray *dataArray = [dataManager getPieceViewCellDatasWithDate:date];
    
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"PDPocketDiaryView" owner:self options:nil];
    self.PocketDiaryView = [nibViews objectAtIndex:0];
    self.PocketDiaryView.frame = [self getPocketDiaryFrame];
    self.PocketDiaryView.delegate = self;
    
    [self.PocketDiaryView resetPocketDiaryViewWithDate:[NSDate date]];
    
//    self.PocketDiaryView.cellDataArray = dataArray;
//    [self.PocketDiaryView setCurrentDateWithDate:date];
    
    [self.view addSubview:self.PocketDiaryView];
    self.PocketDiaryView.backgroundColor = [UIColor grayColor];
    
    self.scaleAnimation = [PDScaleAnimation new];
    self.scaleAnimation.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadData];
}

- (void)reloadData
{
    [self.PocketDiaryView reloadAllCell];
}

- (CGRect)getPocketDiaryFrame
{
    CGRect frame = CGRectMake(0, kOriginY, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - kOriginY);
    return frame;
}

- (void)enterPieceEditViewWithIndex:(NSInteger)index
{
    // 进入编辑界面
    PDPieceEditViewController *pieceEditViewController = [[PDPieceEditViewController alloc] initWithDataArray:self.PocketDiaryView.cellDataArray currentIndex:index];
    pieceEditViewController.transitioningDelegate = self;
    
//    self.swipeDrivenInteractive = [PDSwipeDrivenInteractiveTransition new];
//     [self.swipeDrivenInteractive wireToViewController:pieceEditViewController];
    
    [self presentViewController:pieceEditViewController animated:YES completion:nil];
}

- (void)showRecordView
{
    // 显示心情天气记录视图
    PDRecordViewController *recordViewController = [[PDRecordViewController alloc] initWithDate:[self.PocketDiaryView getCurrentDate]];
    recordViewController.delegate = self;
    
    recordViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:recordViewController animated:YES completion:nil];
}

- (void)showInfoView
{
    PDInfoViewController *infoViewController = [[PDInfoViewController alloc] initWithDate:[self.PocketDiaryView getCurrentDate]];
    infoViewController.delegate = self;
    [self presentViewController:infoViewController animated:YES completion:nil];
}

- (void)showReadView
{
    PDReadViewController *readViewController = [[PDReadViewController alloc] initWithDataArray:self.PocketDiaryView.cellDataArray];
    [self presentViewController:readViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)skipToDate:(NSDate *)date
{
    // 跳转到指定日期
    [self.PocketDiaryView resetPocketDiaryViewWithDate:date];
}

#pragma mark - PDRecordViewControllerDelegate

- (void)recordViewControllerDismiss:(PDRecordViewController *)recordViewController
{
    [self reloadData];
    [recordViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.scaleAnimation.animationType = AnimationTypePresent;
    return self.scaleAnimation;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.scaleAnimation.animationType = AnimationTypeDismiss;
    return self.scaleAnimation;
}


//- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
//{
//    return self.swipeDrivenInteractive.interacting ? self.swipeDrivenInteractive : nil;
//}

#pragma mark - PDPocketDiaryViewDelegate

- (void)PocketDiaryView:(PDPocketDiaryView *)PocketDiaryView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    [self showInfoView];
}

- (void)enterEditFromCell:(UICollectionViewCell *)cell dataArrayIndex:(NSInteger)index
{
    self.currentItemFrame = [self.view convertRect:cell.frame fromView:self.PocketDiaryView.pieceCollectionView];
    self.selecteItemCell = cell;
    
    [self enterPieceEditViewWithIndex:index];
}

- (void)enterRecordViewWithDate:(NSDate *)date
{
    [self showRecordView];
}

- (void)enterInfoViewWithDate:(NSDate *)date
{
    [self showInfoView];
}

- (void)enterReadViewWithDate:(NSDate *)date
{
    [self showReadView];
}

#pragma mark - ScaleAnimationDelegate

- (CGRect)getCurrentItemRect
{
    return self.currentItemFrame;
}

//- (UIImage *)getChangeViewImage
//{
//    UIGraphicsBeginImageContext(self.selecteItemCell.bounds.size);
//    [self.selecteItemCell.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return viewImage;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - PDInfoViewControllerDelegate

- (void)infoViewController:(PDInfoViewController *)infoViewController dismissAndEnterPieceViewWithDate:(NSDate *)date
{
    [self skipToDate:date];
    [infoViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
