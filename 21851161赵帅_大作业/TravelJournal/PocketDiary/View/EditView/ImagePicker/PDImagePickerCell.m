//
//  PDImagePickerCell.m
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/18.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import "PDImagePickerCell.h"

@interface PDImagePickerCell ()

@property (nonatomic, weak) IBOutlet UIImageView *thumbnail;
@property (nonatomic, weak) IBOutlet UIImageView *selectedMark;

@end

@implementation PDImagePickerCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self.contentView bringSubviewToFront:self.selectedMark];
    self.selectedMark.hidden = YES;
}

- (void)setThumbnailWithImage:(UIImage *)image
{
    self.thumbnail.image = image;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    self.selectedMark.hidden = !selected;
}

@end
