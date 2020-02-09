//
//  FBCToBuyTableViewCell.m
//  SSKJ
//
//  Created by 张本超 on 2019/5/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "FBCToBuyTableViewCell.h"
@interface FBCToBuyTableViewCell()
@property (nonatomic, strong) NSMutableArray *imagPayWaysArray;
@property (nonatomic, strong) JB_FBC_DealHall_OrderModel *model;
@end

@implementation FBCToBuyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.backView setCornerRadius:10.f];
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)gotoBuyAction:(id)sender {
  
    !self.gotoBuyBlock?:self.gotoBuyBlock();
}

-(void)setPayWaysArray:(NSArray *)payWaysArray
{
    for (UIImageView *v in self.imagPayWaysArray) {
        [v removeFromSuperview];
    }
    _payWaysArray = payWaysArray;
    
    for (int i = 0; i < _payWaysArray.count; i ++) {
        UIImageView * imagView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(281) + i *27, 28, 15, 15)];
        imagView.image = [UIImage imageNamed:_payWaysArray[i]];
        imagView.right = ScreenWidth - 31 - i *27;
        [self.imagPayWaysArray addObject:imagView];
        [self.contentView addSubview:imagView];
    }
}

-(void)setCellWithModel:(JB_FBC_DealHall_OrderModel *)model
{
    _model = model;
    self.realNameLabel.text = [NSString stringWithFormat:@"%@",model.realname];
    self.messageLabel.text = [NSString stringWithFormat:@"%@|%@",model.cd_num,model.rate];
    self.limitLabel.text = [NSString stringWithFormat:@"限额  %@CNY",model.quota];
    self.priceLabel.text = [NSString stringWithFormat:@" %@CNY",model.price];
    self.amountlabel.text = [NSString stringWithFormat:@"数量  %@AB",model.trans_num];
    NSMutableArray *array = [NSMutableArray array];
    
    if ([model.pay_alipay integerValue] == 1) {
        [array addObject:@"FBCalpay"];
    }
    if ([model.pay_wx integerValue] == 1) {
        [array addObject:@"weChat"];
    }
    if ([model.pay_backcard integerValue] == 1) {
        [array addObject:@"bankCard"];
    }
    self.payWaysArray = array;
}

@end
