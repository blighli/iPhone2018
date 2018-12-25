//
//  CZMessageCell.h
//  91VPN
//
//  Created by weichengzong on 2017/10/11.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZMessageCell : UITableViewCell

@property (nonatomic, strong)UILabel *headLabel;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)UILabel *timeLabel;


@property (nonatomic, strong)NSDictionary *dataDic;
@end
