//
//  CustomAnnotationView.h
//  游园
//
//  Created by Ray on 15/12/1.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import <AMapNaviKit/MAMapKit.h>
#import "CustomCalloutView.h"
@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, readonly) CustomCalloutView *calloutView;

@end
