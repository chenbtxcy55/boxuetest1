//
//  JB_BBTrade_SocketDealOrder_HeaderView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_BBTrade_SocketDealOrder_HeaderView.h"

@interface JB_BBTrade_SocketDealOrder_HeaderView ()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UIImageView *leftImg;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *lineView;


@end

@implementation JB_BBTrade_SocketDealOrder_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addTopLabel];

        [self addLabels];
        
    }
    return self;
}
-(void)addTopLabel{
 
    self.leftImg=[UIImageView new];
    [self addSubview:_leftImg];
    
    [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(ScaleW(15));
        make.width.mas_equalTo(2);
        make.top.equalTo(self).offset(ScaleW(10));
        
        make.height.mas_equalTo(ScaleW(16));
        
    }];
    
    _leftImg.backgroundColor=kMainBlueColor;
    
    self.titleLabel=[WLTools allocLabel:@"盈利订单" font:systemBoldFont(ScaleW(14)) textColor:[UIColor blackColor] frame:CGRectMake(ScaleW(25),ScaleW(10), ScaleW(100),ScaleW(16)) textAlignment:NSTextAlignmentLeft];
    
    [self addSubview: self.titleLabel];
    
    self.lineView=[[UILabel alloc]initWithFrame:CGRectMake(0, self.titleLabel.bottom+ScaleW(10), ScreenWidth, 1)];
    
    [self addSubview:_lineView];
 
    _lineView.backgroundColor=kMainLineColor;
    
    
   
}
-(void)addLabels
{
    NSArray *array = @[SSKJLocalized(@"时间", nil),SSKJLocalized(@"方向", nil),SSKJLocalized(@"获利", nil),SSKJLocalized(@"开仓价", nil)];
    
    CGFloat width = (self.width - ScaleW(30)) / 4;
    
    for (int i = 0; i < array.count; i++) {
        NSString *title = array[i];
        UILabel *label = [WLTools allocLabel:title font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15) + i * width, self.lineView.bottom+ScaleW(5), width, ScaleW(30)) textAlignment:NSTextAlignmentLeft];
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

-(void)setCoinModel:(JB_Market_Index_Model *)coinModel
{
    NSArray *array = [coinModel.code componentsSeparatedByString:@"/"];
    
//    self.priceLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"价格", nil),array.lastObject];
//
//    self.amountLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"数量", nil),array.firstObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
