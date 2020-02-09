//
//  YLJ_AddressListTableViewCell.m
//  SSKJ
//
//  Created by cy5566 on 2019/11/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "YLJ_AddressListTableViewCell.h"

@implementation YLJ_AddressListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.defaultBtn setImage:[UIImage imageNamed:@"sc_icon_un"] forState:UIControlStateNormal];
    [self.defaultBtn setImage:[UIImage imageNamed:@"sc_icon_se"] forState:UIControlStateSelected];

    [self.selectBtn setImage:[UIImage imageNamed:@"sc_icon_un"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"sc_icon_se"] forState:UIControlStateSelected];
    self.selectBtn.hidden = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectEvent:(id)sender {
    !self.selectBlock?:self.selectBlock();

}

- (IBAction)defaultEvent:(id)sender {
    if (self.defultBlock) {
        self.defultBlock();
    }
}

- (IBAction)editEvent:(id)sender {
    if (self.edtingBlock) {
        self.edtingBlock();
    }
}

- (void)setModel:(AddressMessageModel *)model {
    self.defaultBtn.selected =model.default_status.integerValue;
    self.nameLabel.text =[NSString stringWithFormat:@"%@",model.name];
    self.phoneLabel.text = model.mobile;
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@-%@",model.sheng,model.shi,model.qu,model.address];
}
@end
