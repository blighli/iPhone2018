//
//  PDTopBarView.m
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/25.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import "PDTopBarView.h"

@interface PDTopBarView ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIButton *returnBtn;

@end

@implementation PDTopBarView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        UIView *containerView = [[[UINib nibWithNibName:@"PDTopBarView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.titleLabel.textColor = TitleTextBlackColor;
    
    [self.returnBtn setTitleColor:MainBlueColor forState:UIControlStateNormal];
}

- (void)setTitleWithText:(NSString *)text
{
    self.titleLabel.text = text;
}

- (IBAction)touchedReturn:(id)sender
{
    [self.delegate infoTableViewReturn];
}

@end
