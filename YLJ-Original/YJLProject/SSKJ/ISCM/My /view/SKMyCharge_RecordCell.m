//
//  SKMyCharge_RecordCell.m
//  SSKJ
//
//  Created by 孙 on 2019/7/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SKMyCharge_RecordCell.h"

@implementation SKMyCharge_RecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.getMoneyAddress];
        [self.contentView addSubview:self.getMoneyAmount];
        [self.contentView addSubview:self.getMoneyAddressContent];
        [self.contentView addSubview:self.getMoneyAmountContent];
        [self.contentView addSubview:self.lineView];

        
    }
    return self;
}

-(UILabel *)getMoneyAddress{
    
    if (!_getMoneyAddress) {
        _getMoneyAddress = [[UILabel alloc]init];
        _getMoneyAddress.frame = CGRectMake(ScaleW(15), 18, ScaleW(60), 16);
        [self label:_getMoneyAddress font:14 textColor:WLColor(50, 50, 50, 1) text:@"充值地址"];
     
    }
    
    return _getMoneyAddress;
}
-(UILabel *)getMoneyAddressContent{
    
    if (!_getMoneyAddressContent) {
        _getMoneyAddressContent = [[UILabel alloc]init];
        _getMoneyAddressContent.frame = CGRectMake(self.getMoneyAddress.right +20, 18, ScreenWidth- self.getMoneyAddress.right - 20 -ScaleW(15), 16);
        
        [self label:_getMoneyAddressContent font:14 textColor:[UIColor colorWithRed:142.0f/255.0f green:148.0f/255.0f blue:163.0f/255.0f alpha:1.0f] text:@"充值地址 hfjdskfjkdshkjhjfsdhfksh"];
        
    }
    
    return _getMoneyAddressContent;
}

-(UILabel *)getMoneyAmount{
    
    if (!_getMoneyAmount) {
        _getMoneyAmount = [[UILabel alloc]init];
        [self label:_getMoneyAmount font:14 textColor:WLColor(50, 50, 50, 1) text:@"充值数量"];
        _getMoneyAmount.frame = CGRectMake(ScaleW(15), self.getMoneyAddress.bottom + 14, ScaleW(60), 16);

    }
    
    return _getMoneyAmount;
}
-(UILabel *)getMoneyAmountContent{
    
    if (!_getMoneyAmountContent) {
        _getMoneyAmountContent = [[UILabel alloc]init];
        _getMoneyAmountContent.frame = CGRectMake(self.getMoneyAmount.right +20, self.getMoneyAddress.bottom + 14, ScreenWidth- self.getMoneyAmountContent.right - 20 -ScaleW(15), 16);
        
        [self label:_getMoneyAmountContent font:14 textColor:[UIColor colorWithRed:142.0f/255.0f green:148.0f/255.0f blue:163.0f/255.0f alpha:1.0f] text:@"1111 hfjdskfjkdshkjhjfsdhfksh"];
        
        
    }
    
    return _getMoneyAmountContent;
}
- (UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.frame = CGRectMake(0, 18*2 + 16*2 +14-1, ScreenWidth, 1);
        _lineView.backgroundColor = WLColor(246, 247, 251, 1);
        [self.contentView addSubview:_lineView];
       
    }
    return _lineView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
