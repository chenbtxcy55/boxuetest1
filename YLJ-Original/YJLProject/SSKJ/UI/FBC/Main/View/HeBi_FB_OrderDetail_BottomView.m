//
//  HeBi_FB_OrderDetail_BottomView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_FB_OrderDetail_BottomView.h"

@interface HeBi_FB_OrderDetail_BottomView ()
@property (nonatomic, strong) UILabel *buyStatusLabel;  // 买家状态label

@property (nonatomic, strong) UIView *warningBackView;
@property (nonatomic, strong) UIImageView *warningImageView;    //提示图标
@property (nonatomic, strong) UILabel *warningLabel;

@property (nonatomic, strong) UIButton *confirmButton;      // 标记付款
@property (nonatomic, strong) UIButton *cancleButton;       // 取消

@property (nonatomic, strong) UIButton *fangbiButton;       // 放币
@property (nonatomic, strong) UIButton *appealButton;       // 申诉
//@property (nonatomic, strong) UIButton *nextStepButton;       // 下一步
@property (nonatomic, assign) long autoTime;       // 倒计时时间
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) HeBi_FB_OrderDetail_Model *orderDetailModel;
@end

@implementation HeBi_FB_OrderDetail_BottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kSubBackgroundColor;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    [self addSubview:self.buyStatusLabel];
    
    [self addSubview:self.warningBackView];
    [self.warningBackView addSubview:self.warningImageView];
    [self.warningBackView addSubview:self.warningLabel];
    
//    [self addSubview:self.nextStepButton];
    [self addSubview:self.confirmButton];
    [self addSubview:self.cancleButton];
    
    [self addSubview:self.fangbiButton];
    [self addSubview:self.appealButton];
    
    self.height = self.cancleButton.bottom + ScaleW(200);
}

-(UILabel *)buyStatusLabel
{
    if (nil == _buyStatusLabel) {
        _buyStatusLabel = [WLTools allocLabel:@"待付款请于”29:23:23“内向李*兵付款\n付款参考号2001" font:systemFont(ScaleW(13)) textColor:kTextOrgleColor frame:CGRectMake(ScaleW(15), ScaleW(20), ScreenWidth - ScaleW(30), ScaleW(34)) textAlignment:NSTextAlignmentLeft];
        _buyStatusLabel.numberOfLines = 0;
    }
    return _buyStatusLabel;
}

-(UIView *)warningBackView
{
    if (nil == _warningBackView) {
        _warningBackView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), self.buyStatusLabel.bottom + ScaleW(26), ScreenWidth - ScaleW(30), ScaleW(50))];
    }
    return _warningBackView;
}

-(UIImageView *)warningImageView
{
    if (nil == _warningImageView) {
        _warningImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(17), ScaleW(17))];
        _warningImageView.image = [UIImage imageNamed:@"gantanhao_icon"];
    }
    return _warningImageView;
}


-(UILabel *)warningLabel
{
    if (nil == _warningLabel) {
        _warningLabel = [WLTools allocLabel:@"付款成功，请点击”标记已付款“告知对方" font:systemFont(ScaleW(13)) textColor:kTextLightBlueColor frame:CGRectMake(self.warningImageView.right + ScaleW(7), 0, ScreenWidth - ScaleW(23) - self.warningImageView.right, ScaleW(13)) textAlignment:NSTextAlignmentLeft];
        _warningLabel.numberOfLines = 0;
        _warningLabel.centerY = self.warningImageView.centerY;
    }
    return _warningLabel;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {

        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.warningBackView.bottom + ScaleW(35), ScreenWidth - ScaleW(30), ScaleW(45))];
        [_confirmButton addGradientColor];
        [_confirmButton setTitle:SSKJLocalized(@"标记已付款", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(15));
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius = 4.0f;
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}



-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.confirmButton.bottom, ScreenWidth - ScaleW(30), ScaleW(45))];
        [_cancleButton setTitle:SSKJLocalized(@"取消订单", nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = systemBoldFont(ScaleW(15));
        [_cancleButton addTarget:self action:@selector(cancleEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}


-(UIButton *)fangbiButton
{
    if (nil == _fangbiButton) {
        
        
        _fangbiButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.warningBackView.bottom + ScaleW(35), ScreenWidth - ScaleW(30), ScaleW(45))];
        [_fangbiButton addGradientColor];
        [_fangbiButton setTitle:SSKJLocalized(@"确认放币", nil) forState:UIControlStateNormal];
        [_fangbiButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _fangbiButton.titleLabel.font = systemBoldFont(ScaleW(15));
        _fangbiButton.layer.masksToBounds = YES;
        _fangbiButton.layer.cornerRadius = 4.0f;
        [_fangbiButton addTarget:self action:@selector(fangbiEvent) forControlEvents:UIControlEventTouchUpInside];
        _fangbiButton.hidden = YES;
    }
    return _fangbiButton;
}
//
//- (UIButton *)nextStepButton
//{
//    if (nil == _nextStepButton) {
//        _nextStepButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.warningBackView.bottom + ScaleW(35), ScreenWidth - ScaleW(30), ScaleW(45))];
//        [_nextStepButton addGradientColor];
//        [_nextStepButton setTitle:SSKJLocalized(@"下一步", nil) forState:UIControlStateNormal];
//        [_nextStepButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
//        _nextStepButton.titleLabel.font = systemBoldFont(ScaleW(15));
//        _nextStepButton.layer.masksToBounds = YES;
//        _nextStepButton.layer.cornerRadius = 4.0f;
//        [_nextStepButton addTarget:self action:@selector(nextStepEvent) forControlEvents:UIControlEventTouchUpInside];
//        _nextStepButton.hidden = YES;
//    }
//    return _nextStepButton;
//}

-(UIButton *)appealButton
{
    if (nil == _appealButton) {
        
        
        _appealButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.confirmButton.bottom, ScreenWidth - ScaleW(30), ScaleW(45))];
        [_appealButton setTitle:SSKJLocalized(@"提交申诉", nil) forState:UIControlStateNormal];
        [_appealButton setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        _appealButton.titleLabel.font = systemBoldFont(ScaleW(15));
        [_appealButton addTarget:self action:@selector(appealEvent) forControlEvents:UIControlEventTouchUpInside];
        _appealButton.hidden = YES;

    }
    return _appealButton;
}

-(void)setViewWithModel:(HeBi_FB_OrderDetail_Model *)model
{
    self.orderDetailModel = model;
    [self endTimer];
    NSInteger status = model.status.integerValue;
    if (model.type.integerValue == 1) {        // 出售者
        if (status == 1) {                      // 待付款
            self.autoTime = model.down_time.longLongValue;
            
            NSString *name = model.oop_name;
            if ([name isEqual:[NSNull null]] || name.length == 0) {
                name = model.oop_mobile;
            }
            
            NSString *time = [WLTools countDownTimeWithTime:self.autoTime];
            NSString *string = [NSString stringWithFormat:SSKJLocalized(@"等待对方付款，%@将于%@内完成支付\n付款参考号：%@", nil) ,name,time,model.refer];

            self.buyStatusLabel.text = string;
            
            self.buyStatusLabel.height = 50;
            
            self.warningBackView.hidden = YES;
            
            self.confirmButton.hidden = YES;
            self.cancleButton.hidden = YES;
            self.fangbiButton.hidden = YES;
            self.appealButton.hidden = YES;
            
            if (self.autoTime <= 0) {
                if (self.countDownBlock) {
                    self.countDownBlock();
                }
            }else{
                [self.timer fire];
            }
            
        }else if (status == 2){             // 对方已付款
            self.autoTime = model.qr_time.longLongValue;
            
            NSString *string = [NSString stringWithFormat:SSKJLocalized(@"对方已付款，付款参考号：%@",nil),model.refer];

//            NSString *string = [NSString stringWithFormat:@"您确认收款无误后，请点击按钮确认，否则系统将在%@后自动确认！",time];
//
            self.buyStatusLabel.text = string;
            self.warningBackView.hidden = NO;
            NSString *time = [WLTools countDownTimeWithTime:self.autoTime];

            string = [NSString stringWithFormat:SSKJLocalized(@"您确认收款无误后，请点击按钮确认，否则系统将在%@后自动确认！\n\n如收款有误，您可以提出申诉",nil),time];
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:string];
            [attributeString addAttribute:NSForegroundColorAttributeName value: kMainTextColor range:NSMakeRange(23, time.length)];
            self.warningLabel.attributedText = attributeString;
            self.warningLabel.height = 50;

            CGFloat height = [string boundingRectWithSize:CGSizeMake(self.warningLabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.warningLabel.font} context:nil].size.height;
            self.warningLabel.height = height;
            
            self.confirmButton.hidden = YES;
            self.cancleButton.hidden = YES;
            self.fangbiButton.hidden = NO;
            self.appealButton.hidden = NO;
            if (self.autoTime <= 0) {
                if (self.countDownBlock) {
                    self.countDownBlock();
                }
            }else{
                [self.timer fire];
            }
            
        }else if (status == 3){
            NSString *string = [NSString stringWithFormat:SSKJLocalized(@"已完成，付款参考号：%@", nil) ,model.refer];
            self.buyStatusLabel.text = string;
            self.warningBackView.hidden = YES;
            self.confirmButton.hidden = YES;
            self.cancleButton.hidden = YES;
            self.fangbiButton.hidden = YES;
            self.appealButton.hidden = YES;
        }else if (status == 4){                 // 申诉中
            self.buyStatusLabel.text = [NSString stringWithFormat:SSKJLocalized(@"申诉中，申诉参考号：%@",nil),model.command];
            self.confirmButton.hidden = YES;
            self.cancleButton.hidden = YES;
            self.fangbiButton.hidden = YES;
            self.appealButton.hidden = YES;
            self.warningBackView.hidden = YES;
            
        }else if (status == 5){
            self.buyStatusLabel.text = SSKJLocalized(@"已取消，您可重新下单",nil);
            self.buyStatusLabel.textColor = kTextOrangeColor;
            self.warningBackView.hidden = YES;
            self.confirmButton.hidden = YES;
            self.cancleButton.hidden = YES;
            self.fangbiButton.hidden = YES;
            self.appealButton.hidden = YES;
        }
    }else{                                  // 购买者
        if (status == 1) {                      // 待付款

            self.autoTime = model.down_time.longLongValue;
            
            NSString *name = model.oop_name;
            if ([name isEqual:[NSNull null]] || name.length == 0) {
                name = model.oop_mobile;
            }
            
            NSString *time = [WLTools countDownTimeWithTime:self.autoTime];
            NSString *string = [NSString stringWithFormat:SSKJLocalized(@"待付款，请于%@内向%@付款\n付款参考号：%@", nil),time,name,model.refer];
//            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:string];
//            [attributeString addAttribute:NSForegroundColorAttributeName value:kTextLightBlueColor range:NSMakeRange(6, time.length)];
            self.buyStatusLabel.text = string;
            self.buyStatusLabel.height = 50;

            self.warningImageView.image = [UIImage imageNamed:@"gantanhao_icon"];
            
            NSString *warningText = [NSString stringWithFormat:SSKJLocalized(@"付款成功后，请点击“标记已付款”告知对方",nil)];
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:warningText];
            [attributeString addAttribute:NSForegroundColorAttributeName value: kMainTextColor range:NSMakeRange(9, 7)];
            self.warningLabel.attributedText = attributeString;
            
//            if (isHavSelectedPayMethod) {
//                self.confirmButton.hidden = NO;
//                self.cancleButton.hidden = NO;
//                self.nextStepButton.hidden = YES;
//            }else{
                self.confirmButton.hidden = NO;
                self.cancleButton.hidden = NO;
//                self.nextStepButton.hidden = NO;
//            }
            
            self.warningBackView.hidden = NO;
        
            self.fangbiButton.hidden = YES;
            self.appealButton.hidden = YES;
            
            
            if (self.autoTime <= 0) {
                if (self.countDownBlock) {
                    self.countDownBlock();
                }
            }else{
                [self.timer fire];
            }

        }else if (status == 2){
            self.autoTime = model.qr_time.longLongValue;
            NSString *string = [NSString stringWithFormat:SSKJLocalized(@"已付款，付款参考号：%@",nil),model.refer];
            self.buyStatusLabel.textColor = GREEN_HEX_COLOR;
            self.buyStatusLabel.text = string;
            self.warningBackView.hidden = NO;
            self.warningImageView.image = [UIImage imageNamed:@"gantanhao_icon"];
            NSString *time = [NSString stringWithFormat:@"“%@”",[WLTools countDownTimeWithTime:self.autoTime]];
            NSString *warningText = [NSString stringWithFormat:SSKJLocalized(@"系统将在%@后，自动确认!",nil),time];
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:warningText];
            [attributeString addAttribute:NSForegroundColorAttributeName value: kMainTextColor range:NSMakeRange(4, time.length)];
            self.warningLabel.attributedText = attributeString;
            self.confirmButton.hidden = YES;
            self.cancleButton.hidden = YES;
            self.fangbiButton.hidden = YES;
            self.appealButton.hidden = YES;
//            self.nextStepButton.hidden = YES;

            if (self.autoTime <= 0) {
                if (self.countDownBlock) {
                    self.countDownBlock();
                }
            }else{
                [self.timer fire];
            }
            
        }else if (status == 3){
            NSString *string = [NSString stringWithFormat:SSKJLocalized(@"已完成，付款参考号：%@",nil),model.refer];
            self.buyStatusLabel.text = string;
            self.warningBackView.hidden = YES;
            self.confirmButton.hidden = YES;
            self.cancleButton.hidden = YES;
            self.fangbiButton.hidden = YES;
            self.appealButton.hidden = YES;
//            self.nextStepButton.hidden = YES;

        }else if (status == 4){                 // 申诉中
            self.buyStatusLabel.text = [NSString stringWithFormat:SSKJLocalized(@"申诉中，申诉参考号：%@",nil),model.command];
            self.warningBackView.hidden = YES;
            self.confirmButton.hidden = YES;
            self.cancleButton.hidden = YES;
            self.fangbiButton.hidden = YES;
            self.appealButton.hidden = YES;
//            self.nextStepButton.hidden = YES;

            
        }else if (status == 5){
            self.buyStatusLabel.text = SSKJLocalized(@"已取消，您可重新下单",nil);
            self.buyStatusLabel.textColor = kTextOrangeColor;
            self.warningBackView.hidden = YES;
            self.confirmButton.hidden = YES;
            self.cancleButton.hidden = YES;
            self.fangbiButton.hidden = YES;
            self.appealButton.hidden = YES;
//            self.nextStepButton.hidden = YES;

        }
    }
}


#pragma mark - 倒计时逻辑

-(void)endTimer
{
    [_timer invalidate];
    _timer = nil;
}

-(NSTimer *)timer
{
    if (nil == _timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _timer;
}

-(void)countDown
{
    
    if (self.autoTime <= 0) {
        [self endTimer];
        if (self.countDownBlock) {
            self.countDownBlock();
        }
        return;
    }
    
    NSInteger status = self.orderDetailModel.status.integerValue;

    if (self.orderDetailModel.type.integerValue == 1) {     // 出售者
        if (status == 1) {                                      // 待付款
            NSString *name = self.orderDetailModel.oop_name;
            if ([name isEqual:[NSNull null]] || name.length == 0) {
                name = self.orderDetailModel.oop_mobile;
            }
            NSString *time = [WLTools countDownTimeWithTime:self.autoTime];
            NSString *string = [NSString stringWithFormat:SSKJLocalized(@"等待对方付款，%@将于%@内完成支付\n付款参考号：%@",nil),name,time,self.orderDetailModel.refer];
//            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:string];
//            [attributeString addAttribute:NSForegroundColorAttributeName value:kTextLightBlueColor range:NSMakeRange(name.length + 2, time.length)];
            self.buyStatusLabel.text = string;
            self.buyStatusLabel.textColor = kTextOrangeColor;
            
        }else if (status == 2){
            NSString *time = [WLTools countDownTimeWithTime:self.autoTime];
            
            NSString *string = [NSString stringWithFormat:SSKJLocalized(@"您确认收款无误后，请点击按钮确认，否则系统将在%@后自动确认！\n\n如收款有误，您可以提出申诉",nil),time];
            
            CGFloat height = [string boundingRectWithSize:CGSizeMake(self.warningLabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.warningLabel.font} context:nil].size.height;
            self.warningLabel.height = height;
            
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:string];
            [attributeString addAttribute:NSForegroundColorAttributeName value: kMainTextColor range:NSMakeRange(23, time.length)];
            self.warningLabel.attributedText = attributeString;
        }
    }else{                                                  // 购买者
        if (status == 1) {
            NSString *name = self.orderDetailModel.oop_name;
            if ([name isEqual:[NSNull null]] || name.length == 0) {
                name = self.orderDetailModel.oop_mobile;
            }
            NSString *time = [WLTools countDownTimeWithTime:self.autoTime];
            NSString *string = [NSString stringWithFormat:SSKJLocalized(@"待付款，请于%@内向%@付款\n付款参考号：%@",nil),time,name,self.orderDetailModel.refer];
//            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:string];
//            [attributeString addAttribute:NSForegroundColorAttributeName value:kTextLightBlueColor range:NSMakeRange(6, time.length)];
            self.buyStatusLabel.text = string;
        }else if (status == 2){
            NSString *time = [WLTools countDownTimeWithTime:self.autoTime];
            NSString *warningText = [NSString stringWithFormat:SSKJLocalized(@"系统将在%@后，自动确认",nil),time];
//            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:warningText];
//            [attributeString addAttribute:NSForegroundColorAttributeName value:kTextLightBlueColor range:NSMakeRange(4, time.length)];
            self.warningLabel.text = warningText;
        }
    }
    
    
    self.autoTime--;
    
}


#pragma mark - 用户操作
// 确认放币
-(void)confirmEvent
{
    if (self.actionBlock) {
        self.actionBlock(ActionTypePay);
    }
}

// 买家取消
-(void)cancleEvent
{
    if (self.actionBlock) {
        self.actionBlock(ActionTypeCancle);
    }
}


// 卖家放币
-(void)fangbiEvent
{
    if (self.actionBlock) {
        self.actionBlock(ActionTypeFangbi);
    }
}

// 卖家申诉
-(void)appealEvent
{
    if (self.actionBlock) {
        self.actionBlock(ActionTypeAppeal);
    }
}



//-(void)nextStepEvent
//{
//    if (self.actionBlock) {
//        self.actionBlock(ActionTypeNextStep);
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

