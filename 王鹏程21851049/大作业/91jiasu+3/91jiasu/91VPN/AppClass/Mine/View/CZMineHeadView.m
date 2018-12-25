//
//  CZMineHeadView.m
//  91加速
//
//  Created by weichengzong on 2017/8/17.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZMineHeadView.h"

@implementation CZMineHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self uiConfig];
    }
    return self;
}

- (void)uiConfig{
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = [UIImage imageNamed:@"user bg"];
    bgImageView.userInteractionEnabled = YES;
    [self addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.equalTo(self);
    }];
    
    
    
    UIImageView *headImageView = [[UIImageView alloc] init];
    headImageView.image = [UIImage imageNamed:@"headimg"];
    [self addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self);
        make.width.and.height.mas_equalTo(80);
    }];
    
//    UIView *lineView = [[UIView alloc] init];
//    lineView.backgroundColor = [UIColor whiteColor];
//    [self addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//       make.left.equalTo(headImageView.mas_right).offset(10);
//       make.height.mas_equalTo(0.5);
//       make.right.equalTo(self).offset(-150);
//       make.centerY.equalTo(self);
//    }];
    
//    UIImageView *headView = [[UIImageView alloc] init];
//    headView.image = [UIImage imageNamed:@"mine_head"];
//    [self addSubview:headView];
//    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
//       make.left.equalTo(lineView);
//       make.bottom.equalTo(lineView).offset(-5);
//       make.height.mas_equalTo(20);
//       make.width.mas_equalTo(16);
//    }];
    
//    _nameLabel = [[UILabel alloc] init];
//    _nameLabel.font = [UIFont systemFontOfSize:16];
//    _nameLabel.text = @"91加速";
//    _nameLabel.textColor = [UIColor whiteColor];
//    [self addSubview:_nameLabel];
//    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//       make.top.equalTo(headImageView.mas_bottom).offset(5);
//       make.centerX.equalTo(headImageView);
//    }];
    
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.font = [UIFont systemFontOfSize:14];
    _numberLabel.text = @"账　　号:";
    _numberLabel.textColor = [UIColor whiteColor];
    _numberLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headImageView.mas_centerY).offset(-15);
        make.left.equalTo(headImageView.mas_right).offset(20);
        make.right.equalTo(self).offset(-10);
    }];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.text = @"有效期至:";
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headImageView.mas_centerY).offset(15);
        make.left.equalTo(headImageView.mas_right).offset(20);
        make.right.equalTo(self).offset(-10);
    }];
    
}

-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
//    _nameLabel.text = [dataDic objectForKey:@"nickname"];
//    _numberLabel.text = [NSString stringWithFormat:@"账       号：%@",[dataDic objectForKey:@"mobile"]];

    if ([[MyUserInfo getInfoForkey:@"youke"] isEqualToString:@"yes"]) {
    _numberLabel.text =@"游客账号";
    _timeLabel.text =@"随时可能被其他用户登录";
    }else{
//        [self conversionCharacterInterval:12 current:[NSString stringWithFormat:@"账       号：%@",[dataDic objectForKey:@"mobile"]] withLabel:_numberLabel];
//        [self conversionCharacterInterval:14 current:[NSString stringWithFormat:@"有效期至：%@",[dataDic objectForKey:@"exdate"]] withLabel:_timeLabel];
        _numberLabel.text = [NSString stringWithFormat:@"账　　号：%@",[dataDic objectForKey:@"mobile"]];
        _timeLabel.text = [NSString stringWithFormat:@"有效期至：%@",[dataDic objectForKey:@"exdate"]];
    }

}

- (void)conversionCharacterInterval:(NSInteger)maxInteger current:(NSString *)currentString withLabel:(UILabel *)label
{
    CGRect rect = [[currentString substringToIndex:1] boundingRectWithSize:CGSizeMake(200,label.frame.size.height)
                                                                   options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                                attributes:@{NSFontAttributeName: label.font}
                                                                   context:nil];
    
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:currentString];
    float strLength = [self getLengthOfString:currentString];
    [attrString addAttribute:NSKernAttributeName value:@(((maxInteger - strLength) * rect.size.width)/(strLength - 1)) range:NSMakeRange(0, strLength)];
    label.attributedText = attrString;
}

-  (float)getLengthOfString:(NSString*)str {
    
    float strLength = 0;
    char *p = (char *)[str cStringUsingEncoding:NSUnicodeStringEncoding];
    for (NSInteger i = 0 ; i < [str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            strLength++;
        }
        p++;
    }
    return strLength/2;
}

@end
