//
//  BSafeCenterCell.m
//  ZYW_MIT
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "BLSafeCenterCell.h"

@implementation BLSafeCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = kSubBackgroundColor;
    self.cellTitle.textColor = kMainTextColor;
    self.status.textColor = kTextLightBlueColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}



-(void)setZhiwenSelected:(BOOL)zhiwenSelected
{
    if (zhiwenSelected) {
        self.swithImageView.image = [UIImage imageNamed:@"switch_on"];
    }else{
        self.swithImageView.image = [UIImage imageNamed:@"switch_off"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
