//
//  FBCRecodTableViewCell.m
//  SSKJ
//
//  Created by 张本超 on 2019/5/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "FBCRecodTableViewCell.h"

@implementation FBCRecodTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contenView setCornerRadius:10.f];
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
