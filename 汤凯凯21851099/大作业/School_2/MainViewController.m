//
//  MainViewController.m
//  School_2
//
//  Created by 汤凯凯 on 15/12/5.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "MainViewController.h"
#import <AMapNaviKit/MAMapKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CustomAnnotationView.h"
#import "NearbyViewController.h"
#import "NaviTableViewController.h"
#import "AppDelegate.h"

struct buildings
{
    float longitude;
    float latitude;
    __unsafe_unretained NSString *titleForLocation;//建筑名并且图片名
    __unsafe_unretained NSString *subtitleForLocation;
}buildingsInSchool[58] = {
    {120.014262,30.288625, @"恕园1号楼" , @"杭州国际服务工程学院等" },
    {120.013533,30.289366,@"恕园2号楼",@"杭州国际服务工程学院等"},
    {120.012449,30.288087,@"恕园3号楼",@"行政人员办公的地方"},
    {120.011408,30.287763,@"恕园4号楼",@""},
    {120.010732,30.287596,@"恕园5号楼",@""},
    {120.010271,30.28742,@"恕园6号楼",@"继续教育学院（成人教育学院）"},
    {120.012546,30.289097,@"恕园7号楼",@"学生活动中心"},
    {120.011762,30.289005,@"恕园8号楼",@"食堂"},
    {120.014219,30.290524,@"恕园9号楼",@"教学区"},
    {120.013951,30.290756,@"恕园10号楼",@"教学区"},
    {120.013447,30.290126,@"恕园11号楼",@"教学区"},
    {120.013468,30.290468,@"恕园12号楼",@"教学区"},
    {120.012589,30.290153,@"恕园13号楼",@"教学区"},
    {120.0129,30.290413,@"恕园14号楼",@"教学区"},
    {120.014305,30.290885,@"恕园15号楼",@"信息化中心"},
    {120.014037,30.291302,@"恕园16号楼",@"公共实验楼"},
    {120.013382,30.290885,@"恕园17号楼",@"沈钧儒法学院"},
    {120.01187,30.290237,@"恕园18号楼",@"校园管理处"},
    {120.011516,30.290533,@"恕园19号楼",@"外国语学院"},
    {120.013629,30.291441,@"恕园20号楼",@"实验室与设备管理处"},
    {120.013286,30.291228,@"恕园21号楼",@"政治社会学院"},
    {120.012696,30.291256,@"恕园22号楼",@"教学楼"},
    {120.01188,30.291172,@"恕园23号楼",@"教学楼"},
    {120.011011,30.290561,@"恕园24号楼",@"教育学院"},
    {120.010872,30.290746,@"恕园25号楼",@"教育学院"},
    {120.011162,30.290839,@"恕园26号楼",@"教育学院"},
    {120.013812,30.291802,@"恕园27号楼",@"现代教育技术中心"},
    {120.013393,30.29183,@"恕园28号楼",@"现代教育技术中心"},
    {120.012921,30.291654,@"恕园29号楼",@"现代教育技术中心"},
    {120.012192,30.29171,@"恕园30号楼",@"有机硅材料重点实验室"},
    {120.011923,30.292043,@"恕园31号楼",@"教学楼"},
    {120.01158,30.291478,@"恕园32号楼",@"教学楼"},
    {120.011086,30.291237,@"恕园33号楼",@"教学楼"},
    {120.011505,30.291895,@"恕园34号楼",@"教学楼"},
    {120.011129,30.291756,@"恕园35号楼",@"教学楼"},
    {120.010346,30.291256,@"恕园36号楼",@"图书馆"},
    {120.010657,30.291469,@"恕园37号楼",@"图书馆"},
    {120.008404,30.291321,@"恕园38号楼",@"弘丰中心"},
    {120.010947,30.288356,@"博文苑1号楼",@"女生宿舍"},
    {120.0107,30.288884,@"博文苑2号楼",@"女生宿舍，超市"},
    {120.009681,30.288245,@"博文苑3号楼",@"女生宿舍"},
    {120.009338,30.288754,@"博文苑4号楼",@"女生宿舍，快递点"},
    {120.010207,30.289357,@"博文苑5号楼",@"女生宿舍，水果店等"},
    {120.010014,30.289857,@"博文苑6号楼",@"男生宿舍，菜鸟驿站"},
    {120.008447,30.289635,@"博文苑7号楼",@"男生宿舍，超市"},
    {120.008254,30.29019,@"博文苑8号楼",@"男生宿舍"},
    {120.009488,30.290255,@"博文苑9号楼",@"女生宿舍，学生事务中心"},
    {120.009134,30.290728,@"博文苑10号楼",@"女生宿舍"},
    {120.006194,30.290329,@"网球场",@""},
    {120.005261,30.290051,@"篮球场",@""},
    {120.006999,30.288801,@"操场",@""},
    {120.008973,30.289227,@"小足球场",@""},
    {120.013168,30.288301,@"校门",@""},
    {120.011237,30.28995,@"杨靖",@""},
    {120.00922,30.289699,@"陈枭磊",@""},
    {120.012331,30.291126,@"曹凯强",@""},
    {120.012524,30.288421,@"汤凯凯",@""},
    {120.009509,30.291339,@"林晓蕾",@""}};


@interface MainViewController () <MAMapViewDelegate,AMapNaviManagerDelegate,AMapNaviViewControllerDelegate,UIAlertViewDelegate>
{
    MAMapView *_mapView;
   
    __weak IBOutlet UIToolbar *toolBar;
    //这个num为了坐标定位图标的不同
    int num;
}


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadMap];
    [self.view bringSubviewToFront:toolBar];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.isStartNavi = NO;
    
    //主页搜索栏，直接跳转
    [self.view bringSubviewToFront:_searchBar];
    _searchBar.placeholder = @"搜索";
    _searchBar.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)loadMap
{
    _mapView = [[MAMapView alloc] initWithFrame: CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    
    //定位
    _mapView.showsUserLocation = YES;
    
    CLLocation *targetLocation = [[CLLocation alloc]initWithLatitude:30.289292 longitude:120.012095];
    
    [_mapView setCenterCoordinate:targetLocation.coordinate];
    _mapView.mapType = MAMapTypeStandard;
    [_mapView setZoomLevel:17.7 animated:YES];
    [_mapView setRotationDegree:320.f animated:YES duration:0.5];
    [_mapView setCameraDegree:45.f animated:YES duration:0.5];
    
    //取消指南针和比例尺
    _mapView.showsCompass = NO;
    _mapView.showsScale = NO;
    [self initNaviManger];
    [self.view addSubview:_mapView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //设置大头针
    //    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc]init];
    //    pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.289153, 120.011678);
    //    pointAnnotation.title = @"恕园8号楼!!!";
    //    pointAnnotation.subtitle = @"食堂!";
    //
    //    [_mapView addAnnotation:pointAnnotation];
    for (int i = 0; i < 58; ++ i) {
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc]init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(buildingsInSchool[i].latitude, buildingsInSchool[i].longitude);
        pointAnnotation.title = buildingsInSchool[i].titleForLocation;
        pointAnnotation.subtitle = buildingsInSchool[i].subtitleForLocation;
        [_mapView addAnnotation:pointAnnotation];
        
        MAPointAnnotation *p = [[MAPointAnnotation alloc]init];
        p.coordinate = CLLocationCoordinate2DMake(buildingsInSchool[i].latitude, buildingsInSchool[i].longitude);
        p.title = buildingsInSchool[i].titleForLocation;
    }
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (app.isStartNavi == YES) {
        [self initNaviViewController];
        [self routeCal];
    }
    
    //这个num为了坐标定位图标的不同
    num = 0;    //大头针图片归0
}

-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil) {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        num++;
        if(num <= 53)
        {
            annotationView.image = [UIImage imageNamed:@"Marker"];//设置图片
        }
        else if(num >= 54 && num <= 58)
        {
            annotationView.image = [UIImage imageNamed:@"Marker2"];
        }
        else
        {
            num = num % 58;
        }
        //NSLog(@"%d\n",num);
        annotationView.centerOffset = CGPointMake(0, -18);//设置图片偏移量
        return annotationView;
    }
    return nil;
}

//导航
-(void)initNaviManger
{
    if (_naviManager == nil) {
        _naviManager = [[AMapNaviManager alloc] init];
        [_naviManager setDelegate:self];
    }
}

-(void)routeCal
{
    /*
     AMapNaviPoint *startPoint = [AMapNaviPoint locationWithLatitude:buildingsInSchool[0].latitude longitude:buildingsInSchool[0].longitude];
     AMapNaviPoint *endPoint = [AMapNaviPoint locationWithLatitude:buildingsInSchool[1].latitude longitude:buildingsInSchool[1].longitude];
     
     NSArray *startPoints = [[NSArray alloc]initWithObjects:startPoint, nil];
     NSArray *endPoints = [[NSArray alloc]initWithObjects:endPoint, nil];
     
     //步行规划
     [self.naviManager calculateWalkRouteWithStartPoints:startPoints endPoints:endPoints];*/
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    AMapNaviPoint *endPoint = [AMapNaviPoint locationWithLatitude:app.latitude longitude:app.longitude];
    NSArray *endPoints = [[NSArray alloc]initWithObjects:endPoint, nil];
    [self.naviManager calculateWalkRouteWithEndPoints:endPoints];
}

//导航视图初始化
-(void)initNaviViewController
{
    if (_naviViewController == nil) {
        _naviViewController = [[AMapNaviViewController alloc] initWithMapView:self->_mapView delegate:self];
    }
}

//路径规划成功的回调函数
-(void)naviManagerOnCalculateRouteSuccess:(AMapNaviManager *)naviManager
{
    //导航视图展示
    [_naviManager presentNaviViewController:_naviViewController animated:YES];
}

-(void)naviManager:(AMapNaviManager *)naviManager didPresentNaviViewController:(UIViewController *)naviViewController
{
    [_naviManager startGPSNavi];
}

//取消导航
- (void)naviViewControllerCloseButtonClicked:(AMapNaviViewController *)naviViewController
{
    [self.naviManager stopNavi];
    [self.naviManager dismissNaviViewControllerAnimated:YES];
    [self loadMap];
    [self viewDidAppear:YES];
    [self.view bringSubviewToFront:toolBar];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.isStartNavi = NO;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"已结束导航" message:@"是否需要志愿者" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        NearbyViewController *nextController = [mainStoryboard instantiateViewControllerWithIdentifier:@"VolunteerTableView"];
        [self.navigationController pushViewController:nextController animated:YES];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:action];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    [self.view bringSubviewToFront:_searchBar];
}

- (IBAction)next:(id)sender {
    [self.navigationController pushViewController:[[NaviTableViewController alloc]init] animated:YES];
}

//- (void)naviManager:(AMapNaviManager *)naviManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
//{
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        [_iFlySpeechSynthesizer startSpeaking:soundString];//soundString为导航引导语
//    });
//}
- (IBAction)nearbyLocation:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NearbyViewController *nextController = [mainStoryboard instantiateViewControllerWithIdentifier:@"NearbyView"];
    [self.navigationController pushViewController:nextController animated:YES];

}


//搜索栏直接跳转
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NaviTableViewController *nextController = [mainStoryboard instantiateViewControllerWithIdentifier:@"BuildingsForNaviView"];

    [self.navigationController pushViewController:nextController animated:YES];
    [textField resignFirstResponder];
    [nextController.searchDisplayController.searchBar becomeFirstResponder];
}



@end
