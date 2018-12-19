//
//  SquareViewCell.m
//  SuperYcy
//
//  Created by 叶晨宇 on 2018/11/22.
//  Copyright © 2018 叶晨宇. All rights reserved.
//

#import "SquareViewCell.h"
#import <UIImageView+WebCache.h>
#import "SquareItem.h"
@interface SquareViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;

@end

@implementation SquareViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void) setItem:(SquareItem *)item{
    
    _item=item;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _nameView.text=item.name;
    
}

@end
