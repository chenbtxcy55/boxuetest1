//
//  ShopShop_OrderListTableViewCell.m
//  SSKJ
// 
//  Created by 张本超 on 2019/6/18.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "ShopShop_OrderListTableViewCell.h"
//Utils
#import "NSString+Conversion.h"
@interface ShopShop_OrderListTableViewCell(){
    ICC_Mall_BusinessOrderType _userOrderType;
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

@property (nonatomic, strong) UILabel *priceTypeLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *saledLabel;

@property (nonatomic, strong) UILabel *rasaveLabel;

@property (nonatomic, strong) UIView *downLine;

@property (nonatomic, strong) UIButton *onSaleBtn;

@property (nonatomic, strong) UIButton *edtingBtn;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIImageView *img;


@end

@implementation ShopShop_OrderListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self viewConfig];
    }
    return self;
}

-(UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, _downLine.bottom, ScreenWidth, ScaleW(40))];
        _bottomView.backgroundColor = kNavBGColor;
       
        //_bottomView.hidden = YES;
        [_bottomView addSubview:self.edtingBtn];
        [_bottomView addSubview:self.onSaleBtn];
        
    }
    return _bottomView;
}

-(void)viewConfig
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = self.contentView.backgroundColor = kNavBGColor;
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
        _contenBackView.backgroundColor = kNavBGColor;
        [_contenBackView addSubview:self.headView];
        [_contenBackView addSubview:self.numLabel];
        [_contenBackView addSubview:self.dateLabel];
        [_contenBackView addSubview:self.upLine];
        [_contenBackView addSubview:self.contenImg];
        [_contenBackView addSubview:self.titleLabel];
        [_contenBackView addSubview:self.typeMessage];
        [_contenBackView addSubview:self.priceLabel];
        [_contenBackView addSubview:self.priceTypeLabel];
        [_contenBackView addSubview:self.downLine];
        [_contenBackView addSubview:self.bottomView];
        
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
        _numLabel = [WLTools allocLabel:@"吃不吃奥利奥" font:systemFont(13) textColor:kMainWihteColor frame:CGRectMake(_headView.left, 0, ScreenWidth/2.f, ScaleW(40)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _numLabel;
}

-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [WLTools allocLabel:@"未支付" font:systemFont(13) textColor:UIColorFromRGB(0x5ba56f) frame:CGRectMake(ScreenWidth/2.f - ScaleW(15), 0, ScreenWidth/2.f, ScaleW(40)) textAlignment:(NSTextAlignmentRight)];
    }
    return _dateLabel;
}

-(UIView *)upLine
{
    if (!_upLine) {
        _upLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), _dateLabel.bottom, ScreenWidth - ScaleW(30), ScaleW(1))];
        _upLine.backgroundColor = kLineColor;
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
        _typeMessage = [WLTools allocLabel:@"-----" font:systemFont(ScaleW(12)) textColor:kSubSubTxtColor frame:CGRectMake(_titleLabel.left, _titleLabel.bottom, _titleLabel.width, ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _typeMessage;
}

-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [WLTools allocLabel:@"0.000000" font:systemBoldFont(ScaleW(17)) textColor:kMainRedColor frame:CGRectMake(ScaleW(11) + _contenImg.right, ScaleW(16) + _typeMessage.bottom, _titleLabel.width, ScaleW(17)) textAlignment:(NSTextAlignmentRight)];
        _priceLabel.right = _titleLabel.right;
    }
    return _priceLabel;
}
-(UILabel *)priceTypeLabel
{
    if (!_priceTypeLabel) {
        _priceTypeLabel = [WLTools allocLabel:SSKJLocalized(@"价格", nil) font:systemBoldFont(ScaleW(17)) textColor:kSubTxtColor frame:CGRectMake(_priceLabel.left- ScaleW(40), ScaleW(15) + _typeMessage.bottom, ScaleW(30), ScaleW(17)) textAlignment:(NSTextAlignmentRight)];
        _priceTypeLabel.right = _titleLabel.right;
    }
    return _priceTypeLabel;
}


-(UIView *)downLine
{
    if (!_downLine) {
        _downLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), _contenImg.bottom + ScaleW(20), ScreenWidth - ScaleW(30), ScaleW(1))];
        _downLine.backgroundColor = kLineColor;
    }
    return _downLine;
}
-(UIButton *)onSaleBtn
{
    if (!_onSaleBtn) {
        _onSaleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_onSaleBtn btn:_onSaleBtn font:ScaleW(13) textColor:UIColorFromRGB(0x5ba56f) text:@"" image:nil sel:@selector(selectedFirstItemEvent) taget:self];
        
        [_onSaleBtn setCornerRadius:ScaleW(4)];
        [_onSaleBtn setBorderWithWidth:ScaleW(1) andColor:UIColorFromRGB(0x5ba56f)];
        
    }
    return _onSaleBtn;
}

-(UIButton *)edtingBtn
{
    if (!_edtingBtn) {
        _edtingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_edtingBtn btn:_edtingBtn font:ScaleW(13) textColor:UIColorFromRGB(0x5ba56f) text:@"" image:nil sel:@selector(selectedSecondItemEvent) taget:self];
        
        [_edtingBtn setCornerRadius:ScaleW(4)];
        
        [_edtingBtn setBorderWithWidth:ScaleW(1) andColor:UIColorFromRGB(0x5ba56f)];
        
        _edtingBtn.frame=CGRectMake(ScreenWidth-ScaleW(85), ScaleW(7), ScaleW(70), ScaleW(25));
        
        
    }
    return _edtingBtn;
}
//根据订单字符状态返回文字状态
- (NSString*)handleOrderStatus:(NSString*)orderStatus {
    if ([orderStatus isEqualToString:@"unpay"]) {//未付款
        return @"待付款";
    } else if ([orderStatus isEqualToString:@"payed"] || [orderStatus isEqualToString:@"wait_fahuo"]) {//待发货
        return @"待发货";
    } else if ([orderStatus isEqualToString:@"wait_shouhuo"]) {//待收货
        return @"待收货";
    } else if ([orderStatus isEqualToString:@"finish"]) {//已完成
        return @"已完成";
    } else if ([orderStatus isEqualToString:@"cancel"]) {//已取消
        return @"已取消";
    }  else if ([orderStatus isEqualToString:@"shop_delete"]) {//已删除
        return @"已删除";
    } else if ([orderStatus isEqualToString:@"pingtai_qx"]) {//后台取消
        return @"已撤销";
    }  else {
        return @"";
    }
}
#pragma mark -- 计算实际Cell高度
- (CGFloat)cellFactHight {
    
    if ([[_dataDict objectForKey:@"status"] isEqualToString:@"1"] ) {
        self.bottomView.hidden = NO;
        
//        self.contenBackView.backgroundColor = kMainRedColor;
        self.contenBackView.height = ScaleW(200);
        self.edtingBtn.hidden=NO;
        
        return ScaleW(210);
      
    } else {
        self.contenBackView.height = ScaleW(160);
        self.bottomView.hidden = YES;
        
        return  ScaleW(170);
        
    }
    
}


- (void)changeHandleViewWithOrderStatus:(NSString*)orderStatus {
    [self.onSaleBtn.layer setMasksToBounds:YES];
    [self.onSaleBtn.layer setCornerRadius:ScaleW(3)];
    [self.onSaleBtn.layer setBorderWidth:ScaleW(1)];
    
    [self.edtingBtn.layer setMasksToBounds:YES];
    [self.edtingBtn.layer setCornerRadius:ScaleW(3)];
    [self.edtingBtn.layer setBorderWidth:ScaleW(1)];
    if ([orderStatus isEqualToString:@"1"]) {//待发货
        SsLog(@"确认发货");
        self.bottomView.hidden=NO;
        
        self.onSaleBtn.hidden = YES;
        self.edtingBtn.hidden = NO;
        [self.edtingBtn setTitle:@"立即发货" forState:UIControlStateNormal];
        [self.edtingBtn setTitleColor:UIColorFromRGB(0x5ba56f) forState:UIControlStateNormal];
        [self.edtingBtn.layer setBorderColor:kMainRedColor.CGColor];
    }
//    else if ([orderStatus isEqualToString:@"0"]) {//待发货
//        SsLog(@"确认发货");
//        self.bottomView.hidden=NO;
//        
//        self.onSaleBtn.hidden = YES;
//        self.edtingBtn.hidden = NO;
//        [self.edtingBtn setTitle:@"取消订单" forState:UIControlStateNormal];
//        [self.edtingBtn setTitleColor:kMainRedColor forState:UIControlStateNormal];
//        [self.edtingBtn.layer setBorderColor:kMainRedColor.CGColor];
//    }
    else{
        self.edtingBtn.hidden = YES;
        self.onSaleBtn.hidden = YES;
    }
    [self cellFactHight];
    
}
#pragma mark -- 更新数据
- (void)updateViewWithOrderDatas:(NSDictionary*)orderDatas {
   
    
    _dataDict=orderDatas;
    
    NSInteger orderStatus = [[orderDatas objectForKey:@"status"] integerValue];
    //    -1：取消 0:待付款,1:已付款未发货,2:已付款已发货,3:已完成
    
    
    switch (orderStatus) {
        case -1:
            
            _orderCurrentStatus =SSKJLocalized(@"已取消", nil);
            
            break;
        case 0:
            
            _orderCurrentStatus =SSKJLocalized(@"未支付", nil);
            
            break;
        case 1:
            
            _orderCurrentStatus =SSKJLocalized(@"已付款,等待发货", nil);
            
            break;
        case 2:
            
            _orderCurrentStatus =SSKJLocalized(@"已发货", nil);
            
            break;
        case 3:
            
            _orderCurrentStatus =SSKJLocalized(@"已完成", nil);
            
            break;
            
            
        default:
            break;
    }
    
    NSString *goodsImageUrlStr = [NSString stringTransformObject:[orderDatas objectForKey:@"pic_path"]];
    
    NSString *goodsTitle = [NSString stringTransformObject:[orderDatas objectForKey:@"goods_name"]];
    
    
    NSString *totalPrice = [NSString stringTransformObject:[orderDatas objectForKey:@"total_price"]];
    
    
    
    self.numLabel.text = [NSString stringWithFormat:@"%@",orderDatas[@"shop_name"]];
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@",_orderCurrentStatus];
    
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
        self.typeMessage.text=[NSString stringWithFormat:@"备注：X%@; %@",[orderDatas objectForKey:@"num"],remark];
    }
    else
    {
        self.typeMessage.text=[NSString stringWithFormat:@"备注：X%@;",[orderDatas objectForKey:@"num"]];
    }
    
    NSString *typeStr;
    
    NSInteger type=[[orderDatas objectForKey:@"payment_method"] integerValue];
    
    if (type ==1) {
        
        typeStr =SSKJLocalized(@"价格", nil);
    }
    else{
        
        typeStr =SSKJLocalized(@"待售", nil);
        
    }
//    typeStr =@"共计:";
    
    self.priceLabel.text =[NSString stringWithFormat:@"%@:%@",typeStr,[WLTools noroundingStringWith:[totalPrice doubleValue] afterPointNumber:4]];
    
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
#pragma mark -- action event
- (void)selectedFirstItemEvent {
}

- (void)selectedSecondItemEvent {
    
    if ([ [_dataDict objectForKey:@"status"] isEqualToString:@"1" ]) {
        _userOrderType = ksureSendSendGoodOrderEvent;
    }
    if ([ [_dataDict objectForKey:@"status"] isEqualToString:@"0" ]) {
        _userOrderType = kcancelHadFinishedOrderEvent;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(selectedOrderAtIndexPath:userHandleType:)]) {
        [_delegate selectedOrderAtIndexPath:self.indexPath userHandleType:_userOrderType];
    }
}

@end
