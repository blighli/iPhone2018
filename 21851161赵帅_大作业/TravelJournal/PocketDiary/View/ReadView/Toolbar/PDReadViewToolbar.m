//
//  PDReadViewToolbar.m
//  PocketDiary
//
//  Created by 赵帅 on 2018/12/1.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import "PDReadViewToolbar.h"

@implementation PDReadViewToolbar

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        UIView *containerView = [[[UINib nibWithNibName:@"PDReadViewToolbar" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
    }
    return self;
}

- (IBAction)touchedReturn:(id)sender
{
    [self.delegate readViewReturn];
}

@end
