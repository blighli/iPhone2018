//
//  LocationViewController.m
//  example
//
//  Created by 杨威 on 2018/12/12.
//  Copyright © 2018年 杨威. All rights reserved.
//

#define defultZoomLevel 17.3

#import <Foundation/Foundation.h>
#import "NavigationViewController.h"

@interface NavigationViewController () <MAMapViewDelegate, AMapLocationManagerDelegate, AMapSearchDelegate,  AMapNaviDriveManagerDelegate, AMapNaviDriveViewDelegate>

@property (nonatomic, strong) MAPointAnnotation *pointAnnotaiton;
@property (nonatomic, assign) BOOL headingCalibration;
@property (nonatomic, strong) MAPinAnnotationView *annotationView;
@property (nonatomic, assign) CGFloat annotationViewAngle;
@property (nonatomic, strong) CLHeading *heading;
//大头针
@property (nonatomic, strong) MAPointAnnotation *annotation;
//逆地理编码
@property (nonatomic, strong) AMapReGeocodeSearchRequest *regeo;
//逆地理编码使用的
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) AMapNaviCompositeManager *compositeManager;
@property (nonatomic, strong) AMapNaviPoint *startPoint, *endPoint;
@property (nonatomic, strong) AMapNaviDriveView *driveView;

@end

@implementation NavigationViewController

#pragma mark - Action Handle

- (void)configLocationManager
{
    _headingCalibration = NO;
    
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
    //设置允许连续定位逆地理
    [self.locationManager setLocatingWithReGeocode:YES];
}


- (void)startHeadingLocation
{
    //开始进行连续定位
    [self.locationManager startUpdatingLocation];
    
    if ([AMapLocationManager headingAvailable] == YES)
    {
        [self.locationManager startUpdatingHeading];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        _headingCalibration = YES;
        [self startHeadingLocation];
    }
    else
    {
        _headingCalibration = NO;
        [self startHeadingLocation];
    }
}

#pragma mark - AMapLocationManager Delegate

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

int tag=0;
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    
    //获取到定位信息，更新annotation
    if (self.pointAnnotaiton == nil)
    {
        self.pointAnnotaiton = [[MAPointAnnotation alloc] init];
        [self.pointAnnotaiton setTitle:@"pointReuseIndetifier"];
        
        [self.pointAnnotaiton setCoordinate:location.coordinate];
        
        [self.mapView addAnnotation:self.pointAnnotaiton];
    }
    
    [self.pointAnnotaiton setCoordinate:location.coordinate];
  
    [self initLocation];
    
    if(tag==0){
        [self.mapView setCenterCoordinate:location.coordinate];
        
        tag=1;
    }
    if (_startPoint == nil) {
        _startPoint = [[AMapNaviPoint alloc] init];
    }
    _startPoint.longitude = location.coordinate.longitude;
    _startPoint.latitude = location.coordinate.latitude;
        
    //NSLog(@"location:{lat:%f; lon:%f; accuracy:%f, reGeocode:%@}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy, reGeocode.formattedAddress);
    //[self.mapView setZoomLevel:15.1 animated:NO];
    
}

- (BOOL)amapLocationManagerShouldDisplayHeadingCalibration:(AMapLocationManager *)manager
{
    return _headingCalibration;
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    if (_annotationView != nil)
    {
        CGFloat angle = newHeading.trueHeading*M_PI/180.0f + M_PI - _annotationViewAngle;
        _annotationViewAngle = newHeading.trueHeading*M_PI/180.0f + M_PI;
        _heading = newHeading;
        _annotationView.transform =  CGAffineTransformRotate(_annotationView.transform ,angle);
    }
}

#pragma mark - Initialization

- (void)initMapView
{
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        [self.mapView setDelegate:self];
        [self.mapView setZoomLevel:defultZoomLevel];

        
        [self.view addSubview:self.mapView];
    }
}

- (AMapReGeocodeSearchRequest *)regeo {
    if (!_regeo) {
        _regeo = [[AMapReGeocodeSearchRequest alloc]init];
        _regeo.requireExtension = YES;
    }
    return _regeo;
}

- (AMapSearchAPI *)search {
    if (!_search) {
        _search = [[AMapSearchAPI alloc]init];
        _search.delegate = self;
    }
    return _search;
}

-(void)initLocation{
    if (self.annotation == nil)
    {
        self.annotation = [[MAPointAnnotation alloc]init];
        [self.annotation setCoordinate:self.mapView.centerCoordinate];
        [self.annotation setTitle:@"annotationReuseIndetifier"];
        [self.mapView addAnnotation:self.annotation];
        
    }
}

-(void)initLabel{
    CGRect backFrame = CGRectMake(20, 40, 300, 31);
    
    textField = [[UITextField alloc]initWithFrame:backFrame];
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    [textField setPlaceholder:@"Type a task,tap Insert"];
    
    //[self.view addSubview:bg];
    [self.view addSubview:textField];
    
    CGRect buttonFrame = CGRectMake(330, 40, 72, 31);
    naviButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [naviButton setFrame:buttonFrame];
    [naviButton setBackgroundColor:[UIColor blueColor]];
    [naviButton setTitle:@"GOTO" forState:UIControlStateNormal];
    
    [self.view addSubview:naviButton];
    [naviButton addTarget:self
                   action:@selector(startNavi:)
         forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self initMapView];
    
    [self configLocationManager];

    [self initLabel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self startHeadingLocation];
    
    if ([AMapLocationManager headingAvailable] == NO)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备不支持方向功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    
    //[self performSelector:@selector(initLocation) withObject:nil afterDelay:5.0];
    
}

#pragma mark - MAMapView Delegate
int tag2=0;
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        static NSString *reuseIdetifier = @"annotationReuseIndetifier";
        
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        
        MAAnnotationView *annotationView2 = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            annotationView.canShowCallout   = NO;
            annotationView.animatesDrop     = NO;
            annotationView.draggable        = NO;
            annotationView.image            = [UIImage imageNamed:@"icon_location.png"];
            _annotationView = annotationView;
            _annotationViewAngle = 0;
        }
        
        if (annotationView2 == nil) {
            annotationView2 = [[MAAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:reuseIdetifier];
            annotationView2.image = [UIImage imageNamed:@"icon_location.png"];
            annotationView2.centerOffset = CGPointMake(0, -18);
        }
        
        if([annotation.title isEqualToString:@"pointReuseIndetifier"]){
            return annotationView;
        }else if([annotation.title isEqualToString:@"annotationReuseIndetifier"]){
            return annotationView2;
        }
        
    }
    
    return nil;
}

#pragma mark - 让大头针不跟着地图滑动，时时显示在地图最中间
- (void)mapViewRegionChanged:(MAMapView *)mapView {
    _annotation.coordinate = mapView.centerCoordinate;
}

#pragma mark - 滑动地图结束修改当前位置
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    self.regeo.location = [AMapGeoPoint locationWithLatitude:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude];
    self.regeo.requireExtension= YES;
    [self.search AMapReGoecodeSearch:self.regeo];
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
    if (response.regeocode != nil) {


        NSString *province =response.regeocode.addressComponent.province;
        NSString *township =response.regeocode.addressComponent.township;
        NSString *district =response.regeocode.addressComponent.district;
        NSString *city =response.regeocode.addressComponent.city;
        
        if (_endPoint == nil) {
            _endPoint = [[AMapNaviPoint alloc] init];
        }
        _endPoint.longitude = request.location.longitude;
        _endPoint.latitude = request.location.latitude;
        
        NSString *location=response.regeocode.formattedAddress;
        
        location=[location stringByReplacingOccurrencesOfString:province withString:@""];
        location=[location stringByReplacingOccurrencesOfString:township withString:@""];
        location=[location stringByReplacingOccurrencesOfString:district withString:@""];
        location=[location stringByReplacingOccurrencesOfString:city withString:@""];
        [textField setText:location];
    }
}

- (void) startNavi:(id)sender {
    [self initDriveView];
    [self initDriveManager];
    [[AMapNaviDriveManager sharedInstance] calculateDriveRouteWithStartPoints:@[self.startPoint]
                                                                    endPoints:@[self.endPoint]
                                                                    wayPoints:nil
                                                              drivingStrategy:17];
}

- (void)initDriveManager
{
    //请在 dealloc 函数中执行 [AMapNaviDriveManager destroyInstance] 来销毁单例
    [[AMapNaviDriveManager sharedInstance] setDelegate:self];
    [[AMapNaviDriveManager sharedInstance] addDataRepresentative:self.driveView];
}

- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"导航成功");
    
//实时导航
//    [[AMapNaviDriveManager sharedInstance] startGPSNavi];
//模拟导航
    [[AMapNaviDriveManager sharedInstance] startEmulatorNavi];
    
}

- (void)initDriveView
{
    if (self.driveView == nil)
    {
        self.driveView = [[AMapNaviDriveView alloc] initWithFrame:self.view.bounds];
        self.driveView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.driveView setDelegate:self];
        
        [self.view addSubview:self.driveView];
    }
}

- (void)dealloc
{
    [[AMapNaviDriveManager sharedInstance] stopNavi];
    [[AMapNaviDriveManager sharedInstance] removeDataRepresentative:self.driveView];
    [[AMapNaviDriveManager sharedInstance] setDelegate:nil];
    
    BOOL success = [AMapNaviDriveManager destroyInstance];
    NSLog(@"单例是否销毁成功 : %d",success);
}

- (BOOL)driveManagerIsNaviSoundPlaying:(AMapNaviDriveManager *)driveManager
{
    return [[SpeechSynthesizer sharedSpeechSynthesizer] isSpeaking];
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    NSLog(@"playNaviSoundString:{%ld:%@}", (long)soundStringType, soundString);
    
    [[SpeechSynthesizer sharedSpeechSynthesizer] speakString:soundString];
}

@end
