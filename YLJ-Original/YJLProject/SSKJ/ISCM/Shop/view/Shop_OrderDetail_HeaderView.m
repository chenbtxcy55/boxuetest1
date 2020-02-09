//
//  Shop_OrderDetail_HeaderView.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/10.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Shop_OrderDetail_HeaderView.h"
#import "Tiltle_Value_View.h"
@interface Shop_OrderDetail_HeaderView()
{
    //当前状态
    NSString *_orderCurrentStatus;
    
    ICC_Mall_OrderDetail_HandleItemType _handleOrderType;
    
    
}
@property (nonatomic, strong) UIImageView *addressImg;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailAddresslabel;
@property (nonatomic, strong) UIView *septoeLine;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *staustLabel;
@property (nonatomic, strong) UIView *upLine;
@property (nonatomic, strong) UILabel *shopNameLabel;
@property (nonatomic, strong) UIImageView *contenImg;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *amountLabel;

@property (nonatomic, strong) UIView *downLine;
@property (nonatomic, strong) Tiltle_Value_View *shuofeeView;
@property (nonatomic, strong) Tiltle_Value_View *kuaidifeeView;
@property (nonatomic, strong) Tiltle_Value_View *wuliufeeView;
@property (nonatomic, strong) Tiltle_Value_View *createTime;
@property (nonatomic, strong) Tiltle_Value_View *fukuanTime;
@property (nonatomic, strong) Tiltle_Value_View *fahuoTime;
@property (nonatomic, strong) Tiltle_Value_View *shouhuoTime;
@property (nonatomic, strong) Tiltle_Value_View *momoView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UILabel *dingjinLabel;
@property (nonatomic, strong) UILabel *daozhangLabel;

@property (nonatomic, strong) UIButton *bottomBtn;

@property (nonatomic, strong) UIButton *twoBottmBtn;

@property (nonatomic, strong) UIButton *selectAddress;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UIImageView *noaddressimg;

@property (nonatomic, strong) UILabel *pleaseLabel;

@end

@implementation Shop_OrderDetail_HeaderView
-(instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = kMainWihteColor;
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(767));
        [self addSubview:self.addressImg];
        [self addSubview:self.nameLabel];
        [self addSubview:self.detailAddresslabel];
        [self addSubview:self.noaddressimg];
        [self addSubview:self.pleaseLabel];
        [self addSubview:self.septoeLine];
        [self addSubview:self.numLabel];
        [self addSubview:self.staustLabel];
        [self addSubview:self.upLine];
        [self addSubview:self.shopNameLabel];
        [self addSubview:self.contenImg];
        [self addSubview:self.titleLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.amountLabel];
        [self addSubview:self.downLine];
        [self addSubview:self.shuofeeView];
        [self addSubview:self.kuaidifeeView];
        [self addSubview:self.wuliufeeView];
        
        [self addSubview:self.createTime];
        [self addSubview:self.fukuanTime];
        [self addSubview:self.fahuoTime];
        [self addSubview:self.shouhuoTime];
        [self addSubview:self.momoView];
        
        [self addSubview:self.bottomView];
        [self addSubview:self.selectAddress];
        self.height = self.bottomView.bottom;
        
       
        
    }
    return self;
}

-(void)nameTap:(UITapGestureRecognizer *)tap
{
    if (self.nameLabel.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"获取失败", nil)];
        return;
    }
    
    [MBProgressHUD showSuccess:SSKJLocalized(@"复制成功", nil)];
    UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string=self.nameLabel.text;
}
-(void)addressTap:(UITapGestureRecognizer *)tap
{
    if (self.detailAddresslabel.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"获取失败", nil)];
        return;
    }
    
    [MBProgressHUD showSuccess:SSKJLocalized(@"复制成功", nil)];
    UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string=self.detailAddresslabel.text;
}

-(UIImageView *)addressImg
{
    if (!_addressImg) {
        _addressImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(38), ScaleW(13), ScaleW(15))];
        _addressImg.image = [UIImage imageNamed:@"loction_icon"];
        //loction_icon
    }
    return _addressImg;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(37), ScaleW(18),ScreenWidth -  ScaleW(37), ScaleW(13))];
        [_nameLabel label:_nameLabel font:ScaleW(13) textColor:kMainTextColor text:@"xxx xxxxx"];
        
    }
    return _nameLabel;
}
-(UILabel *)detailAddresslabel
{
    if (!_detailAddresslabel) {
        _detailAddresslabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.left, ScaleW(11) + _nameLabel.bottom, ScaleW(300), ScaleW(35))];
        [_detailAddresslabel label:_detailAddresslabel font:ScaleW(13) textColor:kSubTxtColor text:@"河南省 郑州市 二七区 长江路街道 都市广场A座1单元1702室"];
        _detailAddresslabel.numberOfLines = 0;
        
        [_detailAddresslabel sizeToFit];
    }
    return _detailAddresslabel;
}

-(UIView *)septoeLine
{
    if (!_septoeLine) {
        _septoeLine = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(90), ScreenWidth, ScaleW(11))];
        _septoeLine.backgroundColor = kSubBackgroundColor;
    }
    return _septoeLine;
}

-(UILabel *)numLabel
{
    if (!_numLabel) {
        _numLabel = [WLTools allocLabel:@"编号：--" font:systemFont(13) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), _septoeLine.bottom, ScreenWidth/2.f, ScaleW(40)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _numLabel;
}

-(UILabel *)staustLabel
{
    if (!_staustLabel) {
        _staustLabel = [WLTools allocLabel:@"" font:systemFont(13) textColor:kMainRedColor frame:CGRectMake(ScreenWidth/2.f - ScaleW(15), 0, ScreenWidth/2.f, ScaleW(40)) textAlignment:(NSTextAlignmentRight)];
        _staustLabel.centerY = _numLabel.centerY;
    }
    return _staustLabel;
}

-(UIView *)upLine
{
    if (!_upLine) {
        _upLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), _numLabel.bottom, ScreenWidth - ScaleW(30), ScaleW(1))];
        _upLine.backgroundColor = kMainLineColor;
    }
    return _upLine;
}
-(UILabel *)shopNameLabel
{
    if (!_shopNameLabel) {
        _shopNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(14) + _upLine.bottom, ScreenWidth - ScaleW(30), ScaleW(15))];
        [_shopNameLabel label:_shopNameLabel font:ScaleW(15) textColor:kMainTextColor text:@"爱尚旗舰店"];
        _shopNameLabel.font = systemBoldFont(ScaleW(15));
    }
    return _shopNameLabel;
}
-(UIImageView *)contenImg
{
    if (!_contenImg) {
        _contenImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(15) + _shopNameLabel.bottom,ScaleW(90), ScaleW(90))];
        _contenImg.backgroundColor = [UIColor purpleColor];
        _contenImg.layer.cornerRadius = ScaleW(5);
        
    }
    return _contenImg;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"日本制作榨汁机榨汁 月销过万 麦可酷M9便携式家用水果小型电动榨汁机" font:systemFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(_contenImg.right + ScaleW(11), ScaleW(52) + _upLine.bottom, ScaleW(254), ScaleW(40)) textAlignment:(NSTextAlignmentLeft)];
        _titleLabel.numberOfLines = 0;
        
    }
    return _titleLabel;
}


-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [WLTools allocLabel:@"0.000000AB" font:systemFont(ScaleW(17)) textColor:kMainTextColor frame:CGRectMake(ScaleW(11) + _contenImg.right, ScaleW(112) + _upLine.bottom, ScaleW(120), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _priceLabel;
}
-(UILabel *)amountLabel
{
    if (!_amountLabel) {
        _amountLabel = [WLTools allocLabel:@"x0" font:systemFont(ScaleW(11)) textColor:kSubSubTxtColor frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(120), _priceLabel.top, ScaleW(120), ScaleW(15)) textAlignment:(NSTextAlignmentRight)];
    }
    return _amountLabel;
}

-(UIView *)downLine
{
    if (!_downLine) {
        _downLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), _contenImg.bottom + ScaleW(16), ScreenWidth - ScaleW(30), ScaleW(1))];
        _downLine.backgroundColor = kMainLineColor;
    }
    return _downLine;
}
-(Tiltle_Value_View *)shuofeeView
{
    if (!_shuofeeView) {
        _shuofeeView = [[Tiltle_Value_View alloc]initWithTile:@"手续费用:" valueString:@"1 AB" topMargin:_downLine.bottom];
    }
    return _shuofeeView;
}

-(Tiltle_Value_View *)kuaidifeeView
{
    if (!_kuaidifeeView) {
        _kuaidifeeView = [[Tiltle_Value_View alloc]initWithTile:@"快递费用:" valueString:@"---" topMargin:_shuofeeView.bottom];
        
    }
    return _kuaidifeeView;
}

-(Tiltle_Value_View *)wuliufeeView
{
    if (!_wuliufeeView) {
        _wuliufeeView = [[Tiltle_Value_View alloc]initWithTile:SSKJLocalized(@"物流信息:", nil) valueString:@"---" topMargin:_kuaidifeeView.bottom];
    }
    return _wuliufeeView;
}
/*@property (nonatomic, strong) Tiltle_Value_View *createTime;
 @property (nonatomic, strong) Tiltle_Value_View *fukuanTime;
 @property (nonatomic, strong) Tiltle_Value_View *fahuoTime;
 @property (nonatomic, strong) Tiltle_Value_View *shouhuoTime;*/

//-(Tiltle_Value_View *)



-(Tiltle_Value_View *)createTime
{
    if (!_createTime) {
        _createTime = [[Tiltle_Value_View alloc]initWithTile:SSKJLocalized(@"创建时间", nil) valueString:@"----" topMargin:_wuliufeeView.bottom];
        
    }
    return _createTime;
}
-(Tiltle_Value_View *)fukuanTime
{
    if (!_fukuanTime) {
        _fukuanTime = [[Tiltle_Value_View alloc]initWithTile:SSKJLocalized(@"付款时间", nil) valueString:@"----" topMargin:_createTime.bottom];
    }
    return _fukuanTime;
}
-(Tiltle_Value_View *)fahuoTime
{
    if (!_fahuoTime) {
        _fahuoTime = [[Tiltle_Value_View alloc]initWithTile:SSKJLocalized(@"发货时间", nil) valueString:@"----" topMargin:_wuliufeeView.bottom];
    }
    return _fahuoTime;
}
-(Tiltle_Value_View *)shouhuoTime
{
    if (!_shouhuoTime) {
        _shouhuoTime = [[Tiltle_Value_View alloc]initWithTile:SSKJLocalized(@"收货时间", nil) valueString:@"----" topMargin:_wuliufeeView.bottom];
    }
    return _shouhuoTime;
}
-(Tiltle_Value_View *)momoView
{
    if (!_momoView) {
        _momoView = [[Tiltle_Value_View alloc]initWithTile:SSKJLocalized(@"订单备注:", nil) valueString:@"" topMargin:_shouhuoTime.bottom];
    }
    return _momoView;
}
-(UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(21) + _momoView.bottom, ScreenWidth, ScaleW(155))];
        _bottomView.backgroundColor = kSubBackgroundColor;
        [_bottomView addSubview:self.dingjinLabel];
         [_bottomView addSubview:self.daozhangLabel];
         [_bottomView addSubview:self.bottomBtn];
        [_bottomView addSubview:self.twoBottmBtn];
    }
    return _bottomView;
}

-(UILabel *)dingjinLabel{
    if (!_dingjinLabel) {
        _dingjinLabel = [WLTools allocLabel:@"订单金额：0.00" font:systemBoldFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), ScaleW(15) , ScreenWidth - ScaleW(30), ScaleW(14)) textAlignment:(NSTextAlignmentRight)];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self.dingjinLabel.text];
        [attributeString addAttribute:NSForegroundColorAttributeName value:kMainRedColor range:NSMakeRange(attributeString.length - SSKJLocalized(@"0.00", nil).length, SSKJLocalized(@"0.00", nil).length)];
        _dingjinLabel.attributedText = attributeString;
        
    }
    return _dingjinLabel;
}
-(UILabel *)daozhangLabel{
    if (!_daozhangLabel) {
        _daozhangLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(12)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), ScaleW(35) , ScreenWidth - ScaleW(35), ScaleW(12)) textAlignment:(NSTextAlignmentRight)];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self.daozhangLabel.text];
        [attributeString addAttribute:NSForegroundColorAttributeName value:kMainRedColor range:NSMakeRange(attributeString.length - SSKJLocalized(@"", nil).length, SSKJLocalized(@"", nil).length)];
        _daozhangLabel.attributedText = attributeString;
        
    }
    return _daozhangLabel;
}



-(UIButton *)bottomBtn
{
    if (!_bottomBtn) {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomBtn.frame = CGRectMake(0,_bottomView.height - ScaleW(49), ScreenWidth, ScaleW(49));
        [_bottomBtn btn:_bottomBtn font:ScaleW(16) textColor:kMainWihteColor text:SSKJLocalized(@"取消订单", nil) image:nil sel:@selector(selectedFirstItemEvent) taget:self];
        _bottomBtn.backgroundColor = kMainRedColor;
        
    }
                                      
    return _bottomBtn;
                            
}
-(UIButton *)twoBottmBtn

{
    if (!_twoBottmBtn) {
        _twoBottmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _twoBottmBtn.frame = CGRectMake(ScreenWidth/2.f,_bottomView.height - ScaleW(49), ScreenWidth/2, ScaleW(49));
        [_twoBottmBtn btn:_twoBottmBtn font:ScaleW(16) textColor:kMainTextColor text:SSKJLocalized(@"取消订单", nil) image:nil sel:@selector(selectedSecondItemEvent) taget:self];
      
        _twoBottmBtn.backgroundColor = kGrayWhiteColor;
    
    }
    return _twoBottmBtn;
}


-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    //收货人名字
//    self.nameLabel.text = _dataDic[@"name"];
//    
//    self.detailAddresslabel.text = _dataDic[@"address"];
    
    
    self.numLabel.text = [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"订单编号：", nil),_dataDic[@"ordername"]];
    
    NSString *message = nil;
    
    NSString *string = _dataDic[@"order_status"];
    
    _orderCurrentStatus = string;
    
    
    if ([string isEqualToString:@"unpay"]) {
        message = SSKJLocalized(@"未付款", nil);
    }
    if ([string isEqualToString:@"cancel"]) {
        message = SSKJLocalized(@"已取消", nil);
    }
    if ([string isEqualToString:@"wait_fahuo"]) {
        message =SSKJLocalized(@"待发货", nil) ;
    }
    if ([string isEqualToString:@"wait_shouhuo"]) {
        message =SSKJLocalized(@"待收货", nil) ;
    }
    if ([string isEqualToString:@"finish"]) {
        message =SSKJLocalized(@"已完成", nil) ;
    }
    //设置button状态
    [self changeHandleViewWithOrderStatus:string];
    
    self.staustLabel.text = message;
    
    self.shopNameLabel.text = _dataDic[@"order_ext"][@"shop_info"][@"shop_name"];
    //[‘order_ext’][‘goods_history’][‘title’]
    self.titleLabel.text = _dataDic[@"order_ext"][@"goods_history"][@"title"];
    
    //[‘order_ext’][‘goods_history’][‘price’]
    self.priceLabel.text = [NSString stringWithFormat:@"%@",_dataDic[@"order_ext"][@"goods_history"][@"price"]];;
    
    //[‘order_ext’][‘num’]
    self.amountLabel.text = [NSString stringWithFormat:@"x%@",_dataDic[@"order_ext"][@"num"]];
    
    //[‘order_ext’][‘sx_money’]
    self.shuofeeView.valueLabel.text =  [NSString stringWithFormat:@"%@",_dataDic[@"order_ext"][@"sx_money"]];
    
    self.kuaidifeeView.valueLabel.text = [NSString stringWithFormat:@"%@",_dataDic[@"order_ext"][@"freight"]];
    
    self.wuliufeeView.valueLabel.text = [NSString stringWithFormat:@"%@",_dataDic[@"order_ext"][@"order_add_post"]?:@""];
    NSString *headerImg = [[[_dataDic objectForKey:@"order_ext"]objectForKey:@"goods_history"]objectForKey:@"thumb"];
   
    //[‘order_ext’][‘goods_history’][‘thumb’]
    [self.contenImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headerImg]]];
    self.momoView.valueLabel.text = [_dataDic objectForKey:@"wuliudan"];
    _dingjinLabel.text =  [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"订单金额：", nil),dataDic[@"order_ext"][@"total_money"]];
    
    _dingjinLabel.text = [NSString stringWithFormat:@"%@%@%@%@",SSKJLocalized(@"共计", nil),dataDic[@"order_ext"][@"num"],SSKJLocalized(@"件商品合计：", nil),dataDic[@"order_ext"][@"total_money"]];
    // "create_time": "2018-08-10 09:04:34",
    //"create_time": "2018-05-30 10:35:08",
    //"update_time": "2018-05-30 10:44:22",
//    "pay_time": "0000-00-00 00:00:00",
//    "fahuo_time": "0000-00-00 00:00:00",
//    "shouhuo_time": "0000-00-00 00:00:00",
    self.createTime.valueLabel.text = [NSString stringWithFormat:@"%@",_dataDic[@"create_time"]?:@"--"];
    self.createTime.hidden =  self.fahuoTime.hidden = self.fahuoTime.hidden = self.fukuanTime.hidden = YES;
    self.fahuoTime.valueLabel.text = [NSString stringWithFormat:@"%@",_dataDic[@"fahuo_time"]];
    self.shouhuoTime.valueLabel.text = [NSString stringWithFormat:@"%@",_dataDic[@"shouhuo_time"]];
     self.fukuanTime.valueLabel.text = [NSString stringWithFormat:@"%@",_dataDic[@"pay_time"]];
    
}
-(UIButton *)selectAddress{
    if (!_selectAddress) {
        _selectAddress = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectAddress.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(90));
        UIImageView *gotoimg = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"wd_icon_right"]];
        
        gotoimg.centerY = _addressImg.centerY;
        
        gotoimg.right = ScreenWidth - ScaleW(15);
        [_selectAddress addSubview:gotoimg];
        [_selectAddress addTarget:self action:@selector(addressGotoActin:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _selectAddress;
}
-(void)addressGotoActin:(UIButton *)sender
{
    !self.gotoAddressBlock?:self.gotoAddressBlock();
}

-(void)setOrder_id:(NSString *)order_id
{
    _order_id = order_id;
    
    [self loadOrderDetailDatas];
}

-(void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    if (_titleArray.count == 0) {
        self.twoBottmBtn.hidden = YES;
        self.bottomView.hidden = YES;
    }
    
    if (_titleArray.count == 1) {
        
        self.twoBottmBtn.hidden = YES;
        
        self.bottomBtn.hidden = NO;
        
        self.bottomBtn.width = ScreenWidth;
        
    }else{
        self.twoBottmBtn.hidden = NO;
        self.bottomBtn.hidden = NO;
        self.bottomBtn.width = ScreenWidth/2.f;
        
        self.twoBottmBtn.top = self.bottomBtn.top;
        
    }
    
    for (int i = 0; i <_titleArray.count; i ++) {
        if (i == 0) {
            [_bottomBtn setTitle:_titleArray[0] forState:(UIControlStateNormal)];
        }
        if (i == 1) {
            [_twoBottmBtn setTitle:_titleArray[1] forState:(UIControlStateNormal)];
        }
    }
    
    
}
/* kuserCancelOrderEvent = 100,//取消订单
 kuserGoPayOrderEvent = 101,//去支付
 kuserSureOrderEvent = 102, //确认订单
 kuserDeleteOrderEvent = 103,//删除订单
 kuserContactShopEvent = 104, //联系商家
 kbusnessSendGoodsOrederEvent = 105, //商家发货
 kbusnessDeleteOrderEvent = 106 //商家删除订单
 */


- (void)changeHandleViewWithOrderStatus:(NSString*)orderStatus {
    
    if (!_isShop) {
        if ([orderStatus isEqualToString:@"unpay"]) {//未付款
            
            self.titleArray = @[SSKJLocalized(@"立即支付", nil),SSKJLocalized(@"取消订单", nil)];
            
        } else if ([orderStatus isEqualToString:@"wait_shouhuo"]) {//待收货
            
            self.titleArray = @[SSKJLocalized(@"确认收货", nil),SSKJLocalized(@"联系商家", nil)];
            
        } else if ([orderStatus isEqualToString:@"wait_fahuo"] || [orderStatus isEqualToString:@"payed"]) {//待收货
            self.titleArray = @[SSKJLocalized(@"联系商家", nil)];
            
        }  else if ([orderStatus isEqualToString:@"finish"]) {//已完成
            
            self.titleArray = @[SSKJLocalized(@"联系商家", nil),SSKJLocalized(@"删除订单", nil)];
        } else if ([orderStatus isEqualToString:@"cancel"]) {//取消状态
            
            self.titleArray = @[SSKJLocalized(@"删除订单", nil)];
        }
        else  if ([orderStatus isEqualToString:@"payed"] || [_orderCurrentStatus isEqualToString:@"wait_fahuo"]) {
            _handleOrderType = kbusnessSendGoodsOrederEvent;
            
            self.titleArray = @[SSKJLocalized(@"确认收货", nil)];
            
        }else{
            
        }
    }else{
        if ([orderStatus isEqualToString:@"wait_fahuo"] || [orderStatus isEqualToString:@"payed"]) {//待收货
            self.titleArray = @[SSKJLocalized(@"确认收货", nil)];
            
        } else{
            self.titleArray = @[];
        }
    }
    
   
    
}
- (void)selectedFirstItemEvent {
    //不是商家
    if (self.isShop == NO) {
        if ([_orderCurrentStatus isEqualToString:@"unpay"]) {
            _handleOrderType = kuserGoPayOrderEvent;
        } else if ([_orderCurrentStatus isEqualToString:@"wait_shouhuo"]) {
            _handleOrderType = kuserSureOrderEvent;
        } else if ([_orderCurrentStatus isEqualToString:@"finish"]) {
            _handleOrderType = kuserContactShopEvent;
        } else if ([_orderCurrentStatus isEqualToString:@"cancel"]) {
            _handleOrderType = kuserDeleteOrderEvent;
        }else if ([_orderCurrentStatus isEqualToString:@"wait_fahuo"] || [_orderCurrentStatus isEqualToString:@"payed"]) {
            _handleOrderType = kuserContactShopEvent;
        }
    }
    
    if (self.isShop == YES) {
        if ([_orderCurrentStatus isEqualToString:@"payed"] || [_orderCurrentStatus isEqualToString:@"wait_fahuo"]) {
            _handleOrderType = kbusnessSendGoodsOrederEvent;
            
             self.titleArray = @[SSKJLocalized(@"确认收货", nil)];
        }else{
             self.titleArray = @[];
        }
    }else{
       
    }
    
    !self.bottomClickedFist?:self.bottomClickedFist(_handleOrderType);
    
}
- (void)selectedSecondItemEvent {
    if (_isShop == NO) {
        if ([_orderCurrentStatus isEqualToString:@"unpay"]) {
            _handleOrderType = kuserCancelOrderEvent;
        } else if ([_orderCurrentStatus isEqualToString:@"finish"]) {
            _handleOrderType = kuserDeleteOrderEvent;
        }else if ([_orderCurrentStatus isEqualToString:@"wait_shouhuo"]) {
            _handleOrderType = kuserContactShopEvent;
        }
    }
     !self.bottomClickedSecend?:self.bottomClickedFist(_handleOrderType);
   
}

-(void)loadOrderDetailDatas
{
    NSString *url = nil;
    if (_isShop) {
        url = VPay_Shop_ShopOrderDetail_URL;
    }else{
        url = AB_Shop_order_order_detail;
    }
    
    WS(weakSelf);
    
    
    NSDictionary *params = @{@"order_id":_order_id};
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:url RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        self.dataDic = net_model.data;
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:weakSelf animated:YES];
        
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
};

-(void)setModel:(AddressMessageModel *)model
{
    _model = model;
    if (_model) {
        self.hasAddress = YES;
    }
    
     _nameLabel.text = [NSString stringWithFormat:@"%@%@",_model.name,_model.mobile];
    
    _detailAddresslabel.text = [NSString stringWithFormat:@"%@  %@  %@  %@",_model.sheng,_model.shi,_model.qu,_model.address];
    
}
-(void)setHasAddress:(BOOL)hasAddress
{
    _hasAddress = hasAddress;
    
    if (_hasAddress) {
        _addressImg.hidden = NO;
        _detailAddresslabel.hidden = NO;
        _nameLabel.hidden = NO;
        _noaddressimg.hidden = YES;
        _pleaseLabel.hidden = YES;
        
    }else{
        _noaddressimg.hidden = NO;
        _pleaseLabel.hidden = NO;
        _addressImg.hidden = YES;
        _detailAddresslabel.hidden = YES;
        _nameLabel.hidden = YES;
    }
}
-(UIImageView *)noaddressimg
{
    if (!_noaddressimg) {
        _noaddressimg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"saveLocantin"]];
        _noaddressimg.centerX = ScreenWidth/2.f;
        _noaddressimg.top = ScaleW(20);
    }
    return _noaddressimg;
}

-(UILabel *)pleaseLabel
{
    if (!_pleaseLabel) {
        _pleaseLabel = [WLTools allocLabel:SSKJLocalized(@"请选择收货地址", nil) font:systemFont(ScaleW(12)) textColor:kSubSubTxtColor frame:CGRectMake(0, ScaleW(10), ScreenWidth, ScaleW(12)) textAlignment:(NSTextAlignmentCenter)];
        _pleaseLabel.top = _noaddressimg.bottom + ScaleW(10);
    }
    return _pleaseLabel;
}

-(void)setIsShop:(BOOL)isShop
{
    _isShop = isShop;
    
    _canCoopy = _isShop;
    if (_canCoopy) {
        self.selectAddress.hidden = YES;
        UITapGestureRecognizer *nameTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nameTap:)];
        self.nameLabel.userInteractionEnabled = YES;
        
        [self.nameLabel addGestureRecognizer:nameTap];
        UITapGestureRecognizer *address = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addressTap:)];
        self.detailAddresslabel.userInteractionEnabled = YES;
        [self.detailAddresslabel addGestureRecognizer:address];
    }
}

@end
