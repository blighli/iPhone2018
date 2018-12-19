//
//  PointViewController.m
//  example
//
//  Created by 杨威 on 2018/12/18.
//  Copyright © 2018年 杨威. All rights reserved.
//
#define defultZoomLevel 17.3

#import <Foundation/Foundation.h>
#import "PointViewController.h"
#import "CustomAnnotationView.h"

@interface PointViewController () <MAMapViewDelegate, AMapLocationManagerDelegate,AMapSearchDelegate>

@property (nonatomic, strong) MAPointAnnotation *pointAnnotaiton;
@property (nonatomic, assign) BOOL headingCalibration;
@property (nonatomic, strong) CustomAnnotationView *annotationView;
@property (nonatomic, assign) CGFloat annotationViewAngle;
@property (nonatomic, strong) CLHeading *heading;


@property (nonatomic, strong) CLLocation *location;

//大头针
@property (nonatomic, strong) MAPointAnnotation *annotation;
//逆地理编码
@property (nonatomic, strong) AMapReGeocodeSearchRequest *regeo;
//逆地理编码使用的
@property (nonatomic, strong) AMapSearchAPI *search;


@end

@implementation PointViewController

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
bool firstLoad=false;
#pragma mark - AMapLocationManager Delegate

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}


- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{

    
    [self initLocation];
    
    if(firstLoad==false){
        [self.mapView setCenterCoordinate:location.coordinate];
        
        firstLoad=true;
    }
    _location=location;
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
        
        [self.mapView addAnnotation:self.annotation];
        
    }
}




#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self initMapView];
    
    [self configLocationManager];

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

}

#pragma mark - MAMapView Delegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"icon_location.png"];

        annotationView.canShowCallout = NO;

        annotationView.centerOffset = CGPointMake(0, -18);
        
        
        return annotationView;
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
//
//        NSString *province =response.regeocode.addressComponent.province;
//        NSString *township =response.regeocode.addressComponent.township;
//        NSString *district =response.regeocode.addressComponent.district;
//        NSString *city =response.regeocode.addressComponent.city;
        
        
        NSString *location=response.regeocode.formattedAddress;
        
//        location=[location stringByReplacingOccurrencesOfString:province withString:@""];
//        location=[location stringByReplacingOccurrencesOfString:township withString:@""];
//        location=[location stringByReplacingOccurrencesOfString:district withString:@""];
//        location=[location stringByReplacingOccurrencesOfString:city withString:@""];

        self.annotation.title=location;
        //[self.annotationView updateCallout];
    }
}


@end
