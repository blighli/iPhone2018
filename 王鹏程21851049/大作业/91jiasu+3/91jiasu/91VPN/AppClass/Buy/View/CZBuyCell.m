//
//  CZBuyCell.m
//  91加速
//
//  Created by weichengzong on 2017/8/17.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZBuyCell.h"

@implementation CZBuyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
    {
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            [self uiConfig];
//            self.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return self;
    }
- (void)uiConfig{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.text = @"套餐";
    _titleLabel.highlightedTextColor = [UIColor whiteColor];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(25);
        make.centerY.equalTo(self).offset(-10);
    }];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont systemFontOfSize:13];
    _priceLabel.text = @"￥0.00/月";
    _priceLabel.highlightedTextColor = [UIColor whiteColor];
    [self.contentView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom);
    }];
    
    _rightLabel = [[UILabel alloc] init];
    _rightLabel.font = [UIFont systemFontOfSize:15];
    _rightLabel.text = @"￥0.00";
    _rightLabel.highlightedTextColor = [UIColor whiteColor];
    [self.contentView addSubview:_rightLabel];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-25);
        make.centerY.equalTo(self);
       
    }];
}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    _titleLabel.text = [dic objectForKey:@"name"];
    _priceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"desc"]];

    if ([[MyUserInfo getInfoForkey:@"isOpenAPPle"] isEqualToString:@"true"]){
    _rightLabel.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"cost"]];
    }else{
    _rightLabel.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"ios_cost"]];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
