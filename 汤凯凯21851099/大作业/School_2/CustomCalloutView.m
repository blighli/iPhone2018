//
//  CustomCalloutView.m
//  游园
//
//  Created by Ray on 15/12/1.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import "CustomCalloutView.h"

#define kArrorHeight 10

#define kPortraitMargin 5
#define kPortraitWidth 70
#define kPortraitHeight 60

#define kTitleWidth 120
#define kTitleHeight 20

@implementation CustomCalloutView

- (void)drawRect:(CGRect)rect
{
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 0.4;     //不透明度
    self.layer.shadowOffset = CGSizeMake(0.1f, 0.1f);
    
}

- (void)drawInContext:(CGContextRef)context
{
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.7].CGColor);
    [self getDrawPath: context];
    CGContextFillPath(context);
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect);
    CGFloat midx = CGRectGetMidX(rrect);
    CGFloat maxx = CGRectGetMaxX(rrect);
    
    CGFloat miny = CGRectGetMinY(rrect);
    CGFloat maxy = CGRectGetMaxY(rrect);
    
    CGContextMoveToPoint(context, midx + kArrorHeight, maxy);
    CGContextAddLineToPoint(context, midx, maxy + kArrorHeight);
    CGContextAddLineToPoint(context, midx - kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    
    CGContextClosePath(context);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    //添加图片
    self.portraitView = [[UIImageView alloc]initWithFrame:CGRectMake(kPortraitMargin, kPortraitMargin, kPortraitWidth, kPortraitHeight)];
    self.portraitView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.portraitView];
    
    //添加标题
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kPortraitMargin * 2 + kPortraitWidth, kPortraitMargin, kTitleWidth, kTitleHeight)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.textColor = [UIColor whiteColor];
    //self.titleLabel.text = @"恕园8号楼";
    [self addSubview:self.titleLabel];
    
    //添加副标题
    self.subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kPortraitMargin * 2 + kPortraitWidth, kPortraitMargin * 2 + kTitleHeight, kTitleWidth, kTitleHeight)];
    self.subtitleLabel.font = [UIFont systemFontOfSize:12];
    self.subtitleLabel.textColor = [UIColor lightGrayColor];
    //self.subtitleLabel.text = @"食堂";
    [self addSubview:self.subtitleLabel];
    
}

-(void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

-(void)setSubtitle:(NSString *)subtitle
{
    self.subtitleLabel.text = subtitle;
}

-(void)setImage:(UIImage *)image
{
    self.portraitView.image = image;
}



@end






