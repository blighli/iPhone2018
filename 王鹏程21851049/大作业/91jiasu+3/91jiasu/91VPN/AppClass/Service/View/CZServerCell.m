//
//  CZServerCell.m
//  91加速
//
//  Created by weichengzong on 2017/8/17.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZServerCell.h"

@implementation CZServerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self uiConfig];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)uiConfig{
    _leftImageView = [[UIImageView alloc] init];
    _leftImageView.image = [UIImage imageNamed:@""];
    [self.contentView addSubview:_leftImageView];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.contentView).offset(20);
       make.centerY.equalTo(self.contentView);
        make.height.and.width.mas_equalTo(60);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.text = @"客服电话";
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(_leftImageView.mas_right).offset(40);
       make.centerY.equalTo(self.contentView).offset(-20);
    }];
    

    
    _rightImageView = [[UIImageView alloc] init];
    _rightImageView.image = [UIImage imageNamed:@""];
    [self.contentView addSubview:_rightImageView];
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-20);
        make.centerY.equalTo(self.contentView);
        make.width.and.height.mas_equalTo(30);
    }];
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.right.equalTo(_rightImageView.mas_left).offset(-10);
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
