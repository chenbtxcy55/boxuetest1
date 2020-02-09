//
//  HeBi_FB_OrderDetail_PayView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_FB_OrderDetail_PayView.h"

@interface HeBi_FB_OrderDetail_PayView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSMutableArray *payMehodViewArray;

@property (nonatomic, strong) HeBi_FB_OrderDetail_Model *model;

@end

@implementation HeBi_FB_OrderDetail_PayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kSubBackgroundColor;
        [self setUI];
    }
    return self;
}

-(NSMutableArray *)payMehodViewArray
{
    if (nil == _payMehodViewArray) {
        _payMehodViewArray = [NSMutableArray array];
    }
    return _payMehodViewArray;
}

#pragma mark - UI

-(void)setUI
{
    [self addSubview:self.titleLabel];
    
    
    [self addSubview:self.lineView];
    
    self.height = self.lineView.bottom;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"收款方式", nil) font:systemBoldFont(ScaleW(15)) textColor: kMainTextColor frame:CGRectMake(ScaleW(15), ScaleW(23), ScaleW(300), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}


-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15),ScaleW(25), ScreenWidth - ScaleW(30), 0.5)];
        _lineView.backgroundColor = kLineGrayColor;
    }
    return _lineView;
}


-(void)setViewWithModel:(HeBi_FB_OrderDetail_Model *)model
{

    if ([model.status isEqualToString:self.model.status] && model.status.integerValue == 1 && model.type.integerValue == 2) {
        return;
    }
    
    self.model = model;
    NSMutableArray *payMethodArray = [NSMutableArray array];
    
    
    BOOL canSelectPay = NO;

//    if (model.status.integerValue == 1 && model.type.integerValue == 2 && model.pay_list.count != 1) {
//        self.titleLabel.text = SSKJLocalized(@"选择付款方式", nil);
//        canSelectPay = YES;
//    }else{
        self.titleLabel.text = SSKJLocalized(@"支付方式", nil);
        canSelectPay = NO;
//    }

    for (HeBi_PayMethod_Index_Model *payModel1 in model.pay_list) {
        [payMethodArray addObject:payModel1];
    }
        
    
        
    
    CGFloat startY = self.titleLabel.bottom + ScaleW(12);
    for (UIView *view in self.payMehodViewArray) {
        [view removeFromSuperview];
    }
    
    [self.payMehodViewArray removeAllObjects];
    
    
//    if (model.status.integerValue == 1 || model.status.integerValue == 5) {
        for (int i = 0; i < payMethodArray.count; i++) {
            HeBi_PayMethod_Index_Model *payModel1 = payMethodArray[i];
            JB_FBC_OrderDetail_PayIndexView *payView = [[JB_FBC_OrderDetail_PayIndexView alloc]initWithFrame:CGRectMake(0, startY, ScreenWidth, ScaleW(38)) canSelect:canSelectPay];
            payView.payModel = payModel1;
            
            [self addSubview:payView];
            [self.payMehodViewArray addObject:payView];
            WS(weakSelf);
            payView.showQRcodeBlock = ^(HeBi_PayMethod_Index_Model * _Nonnull payModel) {
                [weakSelf showQRCodeWithModel:payModel];
            };
            __block typeof(payView) blockPayView = payView;
            payView.selectBlock = ^(BOOL selected) {
                if (selected == YES) {
                    [blockPayView setSelected:NO];
                    weakSelf.selectPayModel = nil;
                }else{
                    for (JB_FBC_OrderDetail_PayIndexView *view in weakSelf.payMehodViewArray) {
                        [view setSelected:NO];
                    }
                    
                    [blockPayView setSelected:YES];
                    weakSelf.selectPayModel = blockPayView.payModel;
                }
            };
            startY += payView.height;
        }
        
        
        if (payMethodArray.count == 1) {
            self.selectPayModel = payMethodArray.firstObject;
        }
//    }else{
//        HeBi_PayMethod_Index_Model *payModel1 = self.model.pay_type;
//        JB_FBC_OrderDetail_PayIndexView *payView = [[JB_FBC_OrderDetail_PayIndexView alloc]initWithFrame:CGRectMake(0, self.titleLabel.bottom + ScaleW(12), ScreenWidth, ScaleW(38)) canSelect:canSelectPay];
//        WS(weakSelf);
//        payView.showQRcodeBlock = ^(HeBi_PayMethod_Index_Model * _Nonnull payModel) {
//            [weakSelf showQRCodeWithModel:payModel];
//        };
//        payView.payModel = payModel1;
//        startY += ScaleW(38);
//        [self addSubview:payView];
//        [self.payMehodViewArray addObject:payView];
//    }
    
    self.lineView.y = startY + ScaleW(10);
    
    self.height = self.lineView.bottom;

}

#pragma mark - 展示二维码
-(void)showQRCodeWithModel:(HeBi_PayMethod_Index_Model *)payModel
{
    if (self.showQRCodeBlock) {
        self.showQRCodeBlock([WLTools imageURLWithURL:payModel.img]);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
