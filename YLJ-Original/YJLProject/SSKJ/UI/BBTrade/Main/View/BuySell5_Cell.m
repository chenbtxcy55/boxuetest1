//
//  BuySell5_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/15.
//  Copyright © 2019年 James. All rights reserved.
//

#import "BuySell5_Cell.h"

@interface BuySell5_Cell ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@end

@implementation BuySell5_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(160), ScaleW(21))];
    }
    return _backView;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.width  / 3;

    self.indexLabel.width = width - ScaleW(20);
    self.priceLabel.x = self.indexLabel.right;
    self.priceLabel.width = width + ScaleW(10);
    
    self.numberLabel.x = self.priceLabel.right;
    self.numberLabel.width = width + ScaleW(7);

}

-(void)setUI
{
    
    [self addSubview:self.backView];
    
    CGFloat width = ScaleW(160)  / 3;
    
    for (int i = 0; i < 3; i++) {
        
        CGFloat newWidth;
        if (i == 0) {
            newWidth = width - ScaleW(30);
        }else{
            newWidth = width + ScaleW(15);
        }
        
        UILabel *label = [WLTools allocLabel:@"" font:systemFont(ScaleW(12)) textColor:kTextDarkBlueColor frame:CGRectMake(width * i, 0, newWidth, ScaleW(21)) textAlignment:NSTextAlignmentLeft];
        label.adjustsFontSizeToFitWidth = YES;
        if (i == 0) {
            label.textAlignment = NSTextAlignmentLeft;
            self.indexLabel = label;
        }else if (i == 1){
            label.textAlignment = NSTextAlignmentCenter;
            self.priceLabel = label;
            label.numberOfLines = 1;
            self.priceLabel.adjustsFontSizeToFitWidth = YES;
        }else{
            label.textAlignment = NSTextAlignmentRight;
            self.numberLabel = label;
            label.adjustsFontSizeToFitWidth = YES;
        }
        
        
        [self addSubview:label];
    }
}
-(void)setCellWithIndexPath:(NSIndexPath *)indexPath price:(NSString *)price number:(NSString *)number dotNumber:(NSInteger)dotNumber totalDotNumber:(NSInteger)totalDotNumber maxVolume:(NSString *)maxVolume coinAmountDotNumber:(NSInteger)coinNameDotNumber model:(ETF_Contract_Depth_Index_Model *)model
{
    if (indexPath.section == 0) {
        self.indexLabel.text = [NSString stringWithFormat:@"%ld",8 - indexPath.row];
        self.priceLabel.textColor = RED_HEX_COLOR;
        self.backView.backgroundColor = UIColorFromARGB(0xe96d42, 0.3);
    }else{
        self.indexLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
        self.priceLabel.textColor = GREEN_HEX_COLOR;
        self.backView.backgroundColor = UIColorFromARGB(0x08be88, 0.3);;
    }
    
    if ([price isEqualToString:@"--"]) {
        self.priceLabel.text = price;
    }else{
        
        NSString *formate = [NSString stringWithFormat:@"%%.%ldf",dotNumber];
        
        NSString *priceString = [NSString stringWithFormat:formate,[WLTools noroundingStringWith:price.doubleValue afterPointNumber:dotNumber].doubleValue];
        formate = [NSString stringWithFormat:@"%%.%ldf",totalDotNumber];
        self.priceLabel.text = [NSString stringWithFormat:formate,priceString.doubleValue];
    }
    
    if ([number isEqualToString:@"--"]) {
        self.numberLabel.text = number;
    }else{
    
        self.numberLabel.text = [WLTools noroundingStringWith:number.doubleValue afterPointNumber:coinNameDotNumber];
    }
    
    CGFloat width = 0;
    if (maxVolume.doubleValue == 0) {
        width = 0;
    }else{
//        if (model.isMax) {
//            width = self.width;
//        }else{
            width = number.doubleValue / maxVolume.doubleValue * self.width;
//        }
        
        
    }
    self.backView.width = width;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSString *)price
{
    return self.priceLabel.text;
}

@end
