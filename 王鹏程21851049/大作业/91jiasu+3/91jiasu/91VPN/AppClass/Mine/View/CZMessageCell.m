//
//  CZMessageCell.m
//  91VPN
//
//  Created by weichengzong on 2017/10/11.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZMessageCell.h"

@implementation CZMessageCell

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

    _headLabel = [[UILabel alloc] init];
    _headLabel.font = [UIFont fontWithName:@"ArialMT"size:17];
    _headLabel.layer.cornerRadius = 37.5;
    _headLabel.layer.masksToBounds = YES;
    _headLabel.textAlignment = NSTextAlignmentCenter;
    _headLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_headLabel];
    [_headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.contentView);
        make.height.and.width.mas_equalTo(75);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headLabel.mas_right).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-20);
    }];
    

    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headLabel.mas_right).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:13];
    _contentLabel.numberOfLines = 0;
    _contentLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headLabel.mas_right).offset(10);
        make.top.equalTo(_titleLabel.mas_bottom);
        make.right.equalTo(self.contentView).offset(-20);
        make.bottom.equalTo(_timeLabel.mas_top);
    }];

}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    NSString *str = [[dataDic objectForKey:@"title"] substringToIndex:2];
    _headLabel.text = str;
    
    _titleLabel.text = [dataDic objectForKey:@"title"];
    
    _contentLabel.text = [dataDic objectForKey:@"body"];
    
    _timeLabel.text = [dataDic objectForKey:@"time"];
    if (!kStringIsEmpty([dataDic objectForKey:@"url"])) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
