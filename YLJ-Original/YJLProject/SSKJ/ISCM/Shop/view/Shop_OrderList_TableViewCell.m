//
//  Shop_GoodsList_TableViewCell.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/10.
//  Copyright © 2019 刘小雨. All rights reserved.
//
//Utils
#import "NSString+Conversion.h"
#import "Shop_OrderList_TableViewCell.h"
@interface Shop_OrderList_TableViewCell(){
    ICC_Mall_UserOrderType _userOrderType;
    NSString *_orderCurrentStatus;
}

@property (nonatomic, strong) UIView *headerLine;

@property (nonatomic, strong) UIView *contenBackView;

@property (nonatomic, strong) UILabel *headView;

@property (nonatomic, strong) UILabel *numLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIView *upLine;

@property (nonatomic, strong) UIImageView *contenImg;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *typeMessage;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *saledLabel;

@property (nonatomic, strong) UILabel *rasaveLabel;

@property (nonatomic, strong) UIView *downLine;

@property (nonatomic, strong) UIButton *onSaleBtn;

@property (nonatomic, strong) UIButton *edtingBtn;

@property (nonatomic, strong) UIImageView *img;


@end

@implementation Shop_OrderList_TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self viewConfig];
    }
    return self;
}

-(void)viewConfig
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.headerLine];
    [self.contentView addSubview:self.contenBackView];
}


-(UIView *)headerLine
{
    if (!_headerLine) {
        _headerLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(10))];
        _headerLine.backgroundColor = kMainColor;
    }
    return _headerLine;
}

-(UIView *)contenBackView
{
    if (!_contenBackView) {
        _contenBackView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(10), ScreenWidth, ScaleW(200))];
        _contenBackView.backgroundColor = kBgColor353750;
        [_contenBackView addSubview:self.headView];
        [_contenBackView addSubview:self.numLabel];
        [_contenBackView addSubview:self.dateLabel];
        [_contenBackView addSubview:self.upLine];
        [_contenBackView addSubview:self.contenImg];
        [_contenBackView addSubview:self.titleLabel];
        [_contenBackView addSubview:self.typeMessage];
        [_contenBackView addSubview:self.priceLabel];
    
        [_contenBackView addSubview:self.downLine];
        [_contenBackView addSubview:self.onSaleBtn];
        [_contenBackView addSubview:self.edtingBtn];
        
    }
    return _contenBackView;
}
-(UILabel *)headView
{
    if (!_headView) {
        
        _headView = [WLTools allocLabel:@"" font:systemFont(0) textColor:kSubTxtColor frame:CGRectMake(ScaleW(15), ScaleW(8), ScaleW(24), ScaleW(24)) textAlignment:(NSTextAlignmentCenter)];
        
        _headView.backgroundColor = [UIColor clearColor];

        [_headView setCornerRadius:ScaleW(12)];
        
//        _img = [[UIImageView alloc]init];
//        _img.frame = _headView.bounds;
//        [_headView addSubview:_img];
    }
    return _headView;
}
-(UILabel *)numLabel
{
    if (!_numLabel) {
        _numLabel = [WLTools allocLabel:@"吃不吃奥利奥" font:systemFont(13) textColor:kSubTxtColor frame:CGRectMake(_headView.left , 0, ScreenWidth/2.f, ScaleW(40)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _numLabel;
}

-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [WLTools allocLabel:@"未支付" font:systemFont(13) textColor:kMainRedColor frame:CGRectMake(ScreenWidth/2.f - ScaleW(15), 0, ScreenWidth/2.f, ScaleW(40)) textAlignment:(NSTextAlignmentRight)];
    }
    return _dateLabel;
}

-(UIView *)upLine
{
    if (!_upLine) {
        _upLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), _dateLabel.bottom, ScreenWidth - ScaleW(30), ScaleW(1))];
        _upLine.backgroundColor = kMainLineColor;
    }
    return _upLine;
}

-(UIImageView *)contenImg
{
    if (!_contenImg) {
        _contenImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(20) + _upLine.bottom,ScaleW(80), ScaleW(80))];
        _contenImg.backgroundColor = [UIColor purpleColor];
        
    }
    return _contenImg;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"日本制作榨汁机榨汁 月销过万 麦可酷M9便携式家用水果小型电动榨汁机" font:systemFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(_contenImg.right + ScaleW(11), ScaleW(19) + _upLine.bottom, ScaleW(254), ScaleW(40)) textAlignment:(NSTextAlignmentLeft)];
        _titleLabel.numberOfLines = 0;
        
    }
    return _titleLabel;
}
-(UILabel *)typeMessage
{
    if (!_typeMessage) {
        _typeMessage = [WLTools allocLabel:@"备注：x1; 粉色包装，500g" font:systemFont(ScaleW(12)) textColor:kSubSubTxtColor frame:CGRectMake(_titleLabel.left, _titleLabel.bottom, _titleLabel.width, ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _typeMessage;
}

-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [WLTools allocLabel:@"实收 ：0.000000AB" font:systemBoldFont(ScaleW(17)) textColor:kMainRedColor frame:CGRectMake(ScaleW(11) + _contenImg.right, ScaleW(15) + _typeMessage.bottom, _titleLabel.width, ScaleW(17)) textAlignment:(NSTextAlignmentRight)];
        _priceLabel.right = _titleLabel.right;
    }
    return _priceLabel;
}


-(UIView *)downLine
{
    if (!_downLine) {
        _downLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), _contenImg.bottom + ScaleW(20), ScreenWidth - ScaleW(30), ScaleW(1))];
        _downLine.backgroundColor = kMainLineColor;
    }
    return _downLine;
}
-(UIButton *)onSaleBtn
{
    if (!_onSaleBtn) {
        _onSaleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_onSaleBtn btn:_onSaleBtn font:ScaleW(13) textColor:kMainRedColor text:SSKJLocalized(@"上架", nil) image:nil sel:@selector(selectedSecondItemEvent) taget:self];
        _onSaleBtn.frame = CGRectMake(ScreenWidth-ScaleW(165), ScaleW(8) + _downLine.bottom, ScaleW(70), ScaleW(25));
        [_onSaleBtn setCornerRadius:ScaleW(4)];
        [_onSaleBtn setBorderWithWidth:ScaleW(1) andColor:kMainRedColor];
        _onSaleBtn.hidden = YES;
        
    }
    return _onSaleBtn;
}

-(UIButton *)edtingBtn
{
    if (!_edtingBtn) {
        _edtingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_edtingBtn btn:_edtingBtn font:ScaleW(13) textColor:kMainRedColor text:SSKJLocalized(@"编辑", nil) image:nil sel:@selector(selectedFirstItemEvent) taget:self];
        _edtingBtn.frame = CGRectMake(_onSaleBtn.right + ScaleW(10), ScaleW(8) + _downLine.bottom, ScaleW(70), ScaleW(25));
        [_edtingBtn setCornerRadius:ScaleW(4)];
        [_edtingBtn setBorderWithWidth:ScaleW(1) andColor:kMainRedColor];
        
    }
    return _edtingBtn;
}


#pragma mark -- action event
- (void)selectedFirstItemEvent {
    if ([_orderCurrentStatus isEqualToString:@"0"]) {
        _userOrderType = kgoPayOrderEvent;
    } else if ([_orderCurrentStatus isEqualToString:@"3"]) {
        _userOrderType = kcontactShopEvent;
    }else if ([_orderCurrentStatus isEqualToString:@"2"]) {
        _userOrderType = ksureOrderEvent;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(selectedOrderAtIndexPath:userHandleType:)]) {
        [_delegate selectedOrderAtIndexPath:self.indexPath userHandleType:_userOrderType];
    }
}

- (void)selectedSecondItemEvent {
//    -1：取消 0:待付款,1:已付款未发货,2:已付款已发货,3:已完成
    if ([_orderCurrentStatus isEqualToString:@"0"]) {
        _userOrderType = kcancelOrderEvent;
    } else if ([_orderCurrentStatus isEqualToString:@"2"]) {
        _userOrderType = kcontactShopEvent;
    } else if ([_orderCurrentStatus isEqualToString:@"3"]) {
        _userOrderType = kdeleteOrderEvent;
    } else if ([_orderCurrentStatus isEqualToString:@"-1"]) {
        _userOrderType = kdeleteOrderEvent;
    } else if ([_orderCurrentStatus isEqualToString:@"1"] ) {
        _userOrderType = kcontactShopEvent;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(selectedOrderAtIndexPath:userHandleType:)]) {
        [_delegate selectedOrderAtIndexPath:self.indexPath userHandleType:_userOrderType];
    }
}
#pragma mark -- 更新数据
- (void)updateViewWithOrderDatas:(NSDictionary*)orderDatas {

    
    _dataDic=orderDatas;
    
    NSInteger orderStatus = [[orderDatas objectForKey:@"status"] integerValue];
//    -1：取消 0:待付款,1:已付款未发货,2:已付款已发货,3:已完成
    
    _orderCurrentStatus=[NSString stringWithFormat:@"%@",[orderDatas objectForKey:@"status"]];
    
    NSString *typeStr=@"";
    
    switch (orderStatus) {
        case -1:
            
            typeStr =SSKJLocalized(@"已取消", nil);
            
            break;
        case 0:
            
            typeStr =SSKJLocalized(@"待付款", nil);
            
            break;
        case 1:
            
            typeStr =SSKJLocalized(@"已付款待发货", nil);
            
            break;
        case 2:
            
            typeStr =SSKJLocalized(@"待收货", nil);
            
            break;
        case 3:
            
            typeStr =SSKJLocalized(@"已完成", nil);
            
            break;
      
            
        default:
            break;
    }
   
    NSString *goodsImageUrlStr = [NSString stringTransformObject:[orderDatas objectForKey:@"pic_path"]];
    
    NSString *goodsTitle = [NSString stringTransformObject:[orderDatas objectForKey:@"goods_name"]];
    

    NSString *totalPrice = [NSString stringTransformObject:[orderDatas objectForKey:@"total_price"]];
  
   
    
    self.numLabel.text = [NSString stringWithFormat:@"%@",orderDatas[@"shop_name"]];
    
    self.dateLabel.text = typeStr;
    
    //[‘order_ext’][‘shop_info’][‘upic’]
   NSString *url = [orderDatas objectForKey:@"pic_path"];
    
    [_img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage: [UIImage imageNamed:@"Header"]];
    
    //设置商品图片
    if ([goodsImageUrlStr rangeOfString:@"http"].length == 0) {
        goodsImageUrlStr = [NSString stringWithFormat:@"%@%@",ProductBaseServer,goodsImageUrlStr];
    }
    [self.contenImg sd_setImageWithURL:[NSURL URLWithString:goodsImageUrlStr] placeholderImage:[UIImage imageNamed:@"VPay_user"]];
    //商品标题
    self.titleLabel.text = goodsTitle;
    
    NSString *remark = [NSString stringTransformObject:[orderDatas objectForKey:@"note"]];
    
    if (remark.length) {
        self.typeMessage.text=[NSString stringWithFormat:@"%@X%@; %@",SSKJLocalized(@"备注：", nil),[orderDatas objectForKey:@"num"],remark];
    }
    else
    {
        self.typeMessage.text=[NSString stringWithFormat:@"%@X%@;",SSKJLocalized(@"备注：", nil),[orderDatas objectForKey:@"num"]];
    }
    
    NSString *typeStr2;
    
    NSInteger type=[[orderDatas objectForKey:@"payment_method"] integerValue];
    typeStr2 =SSKJLocalized(@"价格", nil);

//    if (type ==1) {
//        
//        typeStr2 =SSKJLocalized(@"价格", nil);
//    }
//    else{
//        
//        typeStr2 =SSKJLocalized(@"待售", nil);
//        
//    }
    

    self.priceLabel.text =[NSString stringWithFormat:@"%@:%@",typeStr2,[WLTools noroundingStringWith:[totalPrice doubleValue] afterPointNumber:4]];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self.priceLabel.text];
    
    [attributeString addAttribute:NSForegroundColorAttributeName value: kSubSubTxtColor range:NSMakeRange(0, 3)];
    
    [attributeString addAttribute:NSFontAttributeName value: [UIFont systemFontOfSize:14] range:NSMakeRange(0, 3)];
    
    self.priceLabel.attributedText = attributeString;

    if (orderStatus ==-2) {//平台取消
     
    }
    else {
      
        [self changeHandleViewWithOrderStatus:[NSString stringWithFormat:@"%@",[orderDatas objectForKey:@"status"]]];
    }
    [self cellFactHight];

}

//处理操作按钮展示状态
- (void)changeHandleViewWithOrderStatus:(NSString*)orderStatus {

    if ([orderStatus isEqualToString:@"0"]) {//未付款
        self.onSaleBtn.hidden = NO;
        self.edtingBtn.hidden = NO;
        [self.edtingBtn setTitle:SSKJLocalized(@"立即付款", nil)  forState:UIControlStateNormal];
        [self.edtingBtn setTitleColor:kMainRedColor forState:UIControlStateNormal];
        [self.edtingBtn.layer setBorderColor:kMainRedColor.CGColor];
        
        [self.onSaleBtn setTitle:SSKJLocalized(@"取消订单", nil) forState:UIControlStateNormal];
        [self.onSaleBtn setTitleColor:[WLTools stringToColor:@"#969696"] forState:UIControlStateNormal];
        [self.onSaleBtn.layer setBorderColor:[WLTools stringToColor:@"#969696"].CGColor];
    }
    else if ([orderStatus isEqualToString:@"-1"]) {//待收货
        
        self.onSaleBtn.hidden = NO;
        [self.onSaleBtn setTitle:SSKJLocalized(@"删除订单", nil) forState:UIControlStateNormal];
        [self.onSaleBtn setTitleColor:kMainRedColor forState:UIControlStateNormal];
        [self.onSaleBtn.layer setBorderColor:kMainRedColor.CGColor];
    }
    else if ([orderStatus isEqualToString:@"1"]) {//待收货
        
        self.onSaleBtn.hidden = YES;
        
        self.edtingBtn.hidden = YES;
      
    }
    else if ([orderStatus isEqualToString:@"2"]) {//待收货
        
      
        self.onSaleBtn.hidden = YES;

        self.edtingBtn.hidden = NO;
        [self.edtingBtn setTitle:SSKJLocalized(@"确认收货", nil) forState:UIControlStateNormal];
        [self.edtingBtn setTitleColor:kMainRedColor forState:UIControlStateNormal];
        [self.edtingBtn.layer setBorderColor:kMainRedColor.CGColor];

        
    }

    else if ([orderStatus isEqualToString:@"3"]) {//已完成
        self.onSaleBtn.hidden = YES;
        self.edtingBtn.hidden = YES;
//        [self.onSaleBtn setTitle:(@"联系商家") forState:UIControlStateNormal];
//        [self.onSaleBtn setTitleColor:kMainRedColor forState:UIControlStateNormal];
//        [self.onSaleBtn.layer setBorderColor:kMainRedColor.CGColor];
//        
//        [self.edtingBtn setTitle:(@"删除订单") forState:UIControlStateNormal];
//        [self.edtingBtn setTitleColor:[WLTools stringToColor:@"#666666"] forState:UIControlStateNormal];
//        [self.edtingBtn.layer setBorderColor:[WLTools stringToColor:@"#666666"].CGColor];
    } else if ([orderStatus isEqualToString:@"-1"]) {//取消状态
        self.onSaleBtn.hidden = YES;
        self.edtingBtn.hidden = NO;
        
        [self.edtingBtn setTitle:SSKJLocalized(@"删除订单", nil) forState:UIControlStateNormal];
        [self.edtingBtn setTitleColor:[WLTools stringToColor:@"#666666"] forState:UIControlStateNormal];
        [self.edtingBtn.layer setBorderColor:[WLTools stringToColor:@"#666666"].CGColor];
    }
}
//根据订单字符状态返回文字状态
- (NSString*)handleOrderStatus:(NSString*)orderStatus {
    if ([orderStatus isEqualToString:@"unpay"]) {//未付款
        return SSKJLocalized(@"待付款", nil);
    } else if ([orderStatus isEqualToString:@"payed"] || [orderStatus isEqualToString:@"wait_fahuo"]) {//待发货
        return SSKJLocalized(@"待发货", nil) ;
    } else if ([orderStatus isEqualToString:@"wait_shouhuo"]) {//待收货
        return SSKJLocalized(@"待收货", nil);
    } else if ([orderStatus isEqualToString:@"finish"]) {//已完成
        return SSKJLocalized(@"已完成", nil);
    } else if ([orderStatus isEqualToString:@"cancel"]) {//已取消
        return SSKJLocalized(@"已取消", nil);
    }  else if ([orderStatus isEqualToString:@"user_delete"]) {//已删除
        return SSKJLocalized(@"已删除", nil);
    }else if ([orderStatus isEqualToString:@"pingtai_qx"]) {//平台撤销
        return SSKJLocalized(@"已撤销", nil);
    }  else {
        return @"";
    }
}
#pragma mark -- 计算实际Cell高度
- (CGFloat)cellFactHight {
    if ([[_dataDic objectForKey:@"status"] isEqualToString:@"0"] ||[[_dataDic objectForKey:@"status"] isEqualToString:@"2"] ||[[_dataDic objectForKey:@"status"] isEqualToString:@"-1"]) {
//        self.contenBackView.height = ScaleW(200);
        self.contenBackView.height = ScaleW(142);

//        return ScaleW(210);
        return   ScaleW(152);
        
    } else {
//        self.contenBackView.height = ScaleW(160);
        self.contenBackView.height = ScaleW(142);

//        return   ScaleW(170);
        return   ScaleW(152);

    }
}
@end

