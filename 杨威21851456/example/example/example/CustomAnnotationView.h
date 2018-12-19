//
//  CustomAnnotationView.h
//  example
//
//  Created by 杨威 on 2018/12/18.
//  Copyright © 2018年 杨威. All rights reserved.
//

#import "CustomCalloutView.h"
#import <MAMapKit/MAMapKit.h>

@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, readonly) CustomCalloutView *calloutView;


@end
