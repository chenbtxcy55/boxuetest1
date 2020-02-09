//
//  JB_SocketDealOrder_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_SocketDealOrder_Cell.h"

@interface JB_SocketDealOrder_Cell ()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@end

@implementation JB_SocketDealOrder_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addLabels];
    }
    return self;
}


-(void)addLabels
{
    NSArray *array = @[SSKJLocalized(@"时间", nil),SSKJLocalized(@"方向", nil),SSKJLocalized(@"价格", nil),SSKJLocalized(@"数量", nil)];
    
    CGFloat width = (ScreenWidth - ScaleW(30)) / 4;
    
    for (int i = 0; i < array.count; i++) {
        NSString *title = array[i];
        UILabel *label = [WLTools allocLabel:title font:systemFont(ScaleW(13)) textColor:UIColorFromRGB(0X646464) frame:CGRectMake(ScaleW(15) + i * width, 0, width, self.height) textAlignment:NSTextAlignmentLeft];
        NSTextAlignment aligment;
        if (i == 0) {
            aligment = NSTextAlignmentLeft;
            self.timeLabel = label;
        }else if (i == 1){
            aligment = NSTextAlignmentLeft;
            self.typeLabel = label;
        }else if (i == 2){
            aligment = NSTextAlignmentCenter;
            self.priceLabel = label;
        }else{
            self.amountLabel = label;
            aligment = NSTextAlignmentRight;
        }
        
        label.textAlignment = aligment;
        
        [self addSubview:label];
        
        
    }
    
}


-(void)setCellWithModel:(JB_BBTrade_SocketDealOrder_Model *)model
{
    self.timeLabel.text = [WLTools convertTimestamp:model.addtime.doubleValue andFormat:@"HH:mm:ss"];
    if (model.order_type.integerValue ==1 ) {
        self.typeLabel.text = SSKJLocalized(@"买涨", nil);
        self.typeLabel.textColor = GREEN_HEX_COLOR;
    }else{
        self.typeLabel.text = SSKJLocalized(@"买跌", nil);
        self.typeLabel.textColor = RED_HEX_COLOR;
    }
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@ ISCM",[WLTools noroundingStringWith:model.deposit.doubleValue afterPointNumber:4]];
    self.amountLabel.text = [WLTools noroundingStringWith:model.sellprice.doubleValue afterPointNumber:2];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
