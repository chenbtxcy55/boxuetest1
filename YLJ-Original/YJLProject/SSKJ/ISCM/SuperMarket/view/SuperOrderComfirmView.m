
#import "SuperOrderComfirmView.h"
#import "Tiltle_Value_View.h"


@interface SuperOrderComfirmView()
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

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UILabel *dingjinLabel;
@property (nonatomic, strong) UILabel *daozhangLabel;

@property (nonatomic, strong) UIButton *bottomBtn;

@property (nonatomic, strong) UIButton *zhifuBtn;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *selectAddress;

@property (nonatomic, strong) UIImageView *noaddressimg;

@property (nonatomic, strong) UILabel *pleaseLabel;

@property (nonatomic, strong) UILabel *goodsNumLabel;







@end

@implementation SuperOrderComfirmView
-(instancetype)init
{
    if (self = [super init])
    {
//        self.backgroundColor = kBgColor353750;
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height_NavBar);
        [self addSubview:self.addressImg];
        [self addSubview:self.nameLabel];
        [self addSubview:self.detailAddresslabel];
        [self addSubview:self.noaddressimg];
        [self addSubview:self.pleaseLabel];
        [self addSubview:self.selectAddress];
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
//        [self addSubview:self.shuofeeView];
        
        [self addSubview:self.kuaidifeeView];
        [self addSubview:self.wuliufeeView];
        [self addSubview:self.momoView];
        [self addSubview:self.bottomView];
        
       
        
        self.height = self.bottomView.bottom;
        
    }
    return self;
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
        [_detailAddresslabel label:_detailAddresslabel font:ScaleW(14) textColor:kSubTxtColor text:@"----------------------"];
        _detailAddresslabel.numberOfLines = 2;
        
    }
    return _detailAddresslabel;
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
        _pleaseLabel = [WLTools allocLabel:SSKJLocalized(@"请选择收货地址", nil) font:systemFont(ScaleW(12)) textColor:kMainTextColor frame:CGRectMake(0, ScaleW(10), ScreenWidth, ScaleW(12)) textAlignment:(NSTextAlignmentCenter)];
        _pleaseLabel.top = _noaddressimg.bottom + ScaleW(10);
    }
    return _pleaseLabel;
}


-(UIView *)septoeLine
{
    if (!_septoeLine) {
        _septoeLine = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(90), ScreenWidth, ScaleW(11))];
        _septoeLine.backgroundColor = kMainColor;
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
        _staustLabel = [WLTools allocLabel:@"" font:systemFont(13) textColor:kGreenColor frame:CGRectMake(ScreenWidth/2.f - ScaleW(15), 0, ScreenWidth/2.f, ScaleW(40)) textAlignment:(NSTextAlignmentRight)];
        _staustLabel.centerY = _numLabel.centerY;
        _staustLabel.hidden = YES;
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
        _titleLabel = [WLTools allocLabel:@"--" font:systemFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(_contenImg.right + ScaleW(11), _contenImg.top, ScaleW(254), ScaleW(40)) textAlignment:(NSTextAlignmentLeft)];
        _titleLabel.numberOfLines = 0;
        
    }
    return _titleLabel;
}


-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [WLTools allocLabel:@"0.000000" font:systemFont(ScaleW(15)) textColor:kMainTextColor frame:CGRectMake(ScaleW(11) + _contenImg.right, ScaleW(20) + _titleLabel.bottom, ScaleW(200), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _priceLabel;
}
-(UILabel *)amountLabel
{
    if (!_amountLabel) {
        _amountLabel = [WLTools allocLabel:@"x0" font:systemFont(ScaleW(11)) textColor:kMainTextColor frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(120), _priceLabel.top, ScaleW(120), ScaleW(15)) textAlignment:(NSTextAlignmentRight)];
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
        _shuofeeView = [[Tiltle_Value_View alloc]initWithTile:SSKJLocalized(@"手续费用:", nil) valueString:@"1 " topMargin:_downLine.bottom];
    }
    return _shuofeeView;
}

-(Tiltle_Value_View *)kuaidifeeView
{
    if (!_kuaidifeeView) {
        _kuaidifeeView = [[Tiltle_Value_View alloc]initWithTile:SSKJLocalized(@"快递费用:", nil) valueString:@"---" topMargin:_downLine.bottom];
        
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

-(UITextField *)momoView
{
    if (!_momoView) {
//        _momoView = [[AB_TitleTextInputView alloc]initWithTile:@"订单备注:" valueString:@"选填，请填写您的备注信息" topMargin:_wuliufeeView.bottom];
//
        _momoView = [[UITextField alloc]initWithFrame:CGRectMake(_wuliufeeView.left+ScaleW(90), _wuliufeeView.bottom, _wuliufeeView.width-(_wuliufeeView.left+ScaleW(105)), _wuliufeeView.height) ];
        _momoView.textColor=kSubTxtColor;
//        leftGap:10 placeHolder:@"注意快递包装哦！" font:systemFont(14) keyBoardType:UIKeyboardTypeDefault titleText:@"订单备注:"];
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: SSKJLocalized(@"选填，请填写您的备注信息", nil) attributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xb5b5b5)}];
        
        _momoView.attributedPlaceholder = placeholderString1;

        
        _momoView.font=systemFont(14);
        
  
        UILabel *leftLabel=[WLTools allocLabel:SSKJLocalized(@"订单备注:", nil) font:systemFont(14) textColor:kMainTextColor frame:CGRectMake(_wuliufeeView.left+ScaleW(16), _wuliufeeView.bottom, ScaleW(75), ScaleW(42)) textAlignment:NSTextAlignmentLeft];
        
        [self addSubview:leftLabel];
        
    }
    return _momoView;
}

-(UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(21) + _momoView.bottom, ScreenWidth, self.height-(ScaleW(21) + _momoView.bottom) )];
        _bottomView.backgroundColor = kMainColor;
        [_bottomView addSubview:self.dingjinLabel];
        [_bottomView addSubview:self.daozhangLabel];
        [_bottomView addSubview:self.goodsNumLabel];
        
        [_bottomView addSubview:self.bottomBtn];
        
        [_bottomView addSubview:self.cancelBtn];
        
        [_bottomView addSubview:self.zhifuBtn];
        
    }
    return _bottomView;
}

-(UILabel *)dingjinLabel{
    
    if (!_dingjinLabel) {
        
        _dingjinLabel = [WLTools allocLabel:[NSString stringWithFormat:@"%@0.00",SSKJLocalized(@"订单金额：", nil)] font:systemBoldFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(ScreenWidth - ScaleW(165), ScaleW(15) ,  ScaleW(130), ScaleW(14)) textAlignment:(NSTextAlignmentRight)];
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self.dingjinLabel.text];
        
        [attributeString addAttribute:NSForegroundColorAttributeName value:kMainRedColor range:NSMakeRange(attributeString.length - SSKJLocalized(@"0.00", nil).length, SSKJLocalized(@"0.00", nil).length)];
        
        _dingjinLabel.adjustsFontSizeToFitWidth=YES;
        
        _dingjinLabel.attributedText = attributeString;
        
        
        
    }
    return _dingjinLabel;
}
-(UILabel *)goodsNumLabel{
    
    if (!_goodsNumLabel) {
        
        _goodsNumLabel = [WLTools allocLabel:SSKJLocalized(@"共0件商品", nil) font:systemBoldFont(ScaleW(12)) textColor:RGBCOLOR(150,150,150) frame:CGRectMake(_dingjinLabel.left-ScaleW(110), _dingjinLabel.top ,  ScaleW(100), ScaleW(13)) textAlignment:(NSTextAlignmentRight)];
        
    }
    
    return _goodsNumLabel;
    
}
-(UILabel *)daozhangLabel{
    if (!_daozhangLabel) {
        _daozhangLabel = [WLTools allocLabel:[NSString stringWithFormat:@"%@%@%@",SSKJLocalized(@"预计到账：", nil),@"30  20",SSKJLocalized(@"爱点", nil)] font:systemFont(ScaleW(12)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), ScaleW(35) , ScreenWidth - ScaleW(35), ScaleW(12)) textAlignment:(NSTextAlignmentRight)];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self.daozhangLabel.text];
        [attributeString addAttribute:NSForegroundColorAttributeName value:kMainRedColor range:NSMakeRange(attributeString.length - SSKJLocalized(@"30  20爱点", nil).length, SSKJLocalized(@"30  20爱点", nil).length)];
        _daozhangLabel.attributedText = attributeString;
        _daozhangLabel.text = @"";
        
    }
    return _daozhangLabel;
}



-(UIButton *)bottomBtn
{
    if (!_bottomBtn) {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomBtn.frame = CGRectMake(0,_bottomView.height-ScaleW(49),ScreenWidth , ScaleW(49));
        
        [_bottomBtn btn:_bottomBtn font:ScaleW(16) textColor:kMainWihteColor text:SSKJLocalized(@"确认订单", nil) image:nil sel:@selector(bottomAction:) taget:self];
//        _bottomBtn.backgroundColor = kMainBlueColor;
        
//        [_bottomBtn setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
        _bottomBtn.backgroundColor = kTheMeColor;

    }
    
    return _bottomBtn;
    
}

-(UIButton *)cancelBtn{
    
    if (!_cancelBtn) {
        
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _cancelBtn.frame = CGRectMake(0 , _bottomView.height-ScaleW(49) , ScreenWidth/2.0 , ScaleW(49));
        
        [_cancelBtn btn:_cancelBtn font:ScaleW(16) textColor:kSubSubTxtColor text:SSKJLocalized(@"取消", nil) image:nil sel:@selector(cancelAction:) taget:self];
        
        _cancelBtn.backgroundColor =kNavBGColor;
        
        _cancelBtn.hidden=YES;
        
        
        
        
    }
    
    return _cancelBtn;
    
}
-(UIButton *)zhifuBtn{
    if (!_zhifuBtn) {
        _zhifuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _zhifuBtn.frame = CGRectMake(_cancelBtn.right,_bottomView.height-ScaleW(49),ScreenWidth/2.0 , ScaleW(49));
        
        [_zhifuBtn btn:_zhifuBtn font:ScaleW(16) textColor:kMainWihteColor text:SSKJLocalized(@"立即支付", nil) image:nil sel:@selector(payAction:) taget:self];
//        _zhifuBtn.backgroundColor = kMainBlueColor;
//        [_zhifuBtn setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
        _zhifuBtn.backgroundColor = kTheMeColor;

        _zhifuBtn.hidden=YES;
        
    }
    
    return _zhifuBtn;
    
}
-(void)payAction:(UIButton*)sender{
    
    if (self.payBlock) {
        
        self.payBlock();
        
    }
}
-(void)cancelAction:(UIButton*)sender{
    
    if (self.cancelBlock) {
        
        self.cancelBlock();
        
    }
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

-(void)bottomAction:(UIButton *)sender
{
    if ([self.bottomBtn.currentTitle isEqualToString:SSKJLocalized(@"删除", nil)]) {
        
        
        !self.deleteBlock?:self.deleteBlock();

    }
   else if ([self.bottomBtn.currentTitle isEqualToString:SSKJLocalized(@"取消订单", nil)]) {
        
        
        !self.shopCancelBlock?:self.shopCancelBlock();
        
    }
   else if ([self.bottomBtn.currentTitle isEqualToString:SSKJLocalized(@"立即发货", nil)]) {
       
       
       !self.shopSureBlock?:self.shopSureBlock();
       
   }
   else if ([self.bottomBtn.currentTitle isEqualToString:SSKJLocalized(@"确认收货", nil)]) {
       
       
       !self.userSureBlock?:self.userSureBlock();
       
   }
    else{
        !self.commitBlock?:self.commitBlock();

    }
}
-(void)setDataDic2:(NSDictionary *)dataDic2{
    _dataDic2=dataDic2;
    
    _numLabel.hidden=YES;
    
    _staustLabel.hidden=YES;
    
    _upLine.hidden=YES;
    
    NSString *string  = [NSString stringWithFormat:@"%@",_dataDic2[@"store_name"]];
    
    
    
    _shopNameLabel.text = string;
    
    NSString *typeStr=_dataDic2[@"payment_method"];
    
    NSInteger type = [typeStr integerValue];
    
    CGFloat money;
    
    if (type ==1) {
        _priceLabel.text = [NSString stringWithFormat:@"%@ %@ ",SSKJLocalized(@"价格", nil),[WLTools noroundingStringWith:[_dataDic2[@"can_sell_price"] doubleValue] afterPointNumber:2]];
        
        money = [_dataDic2[@"can_sell_price"] floatValue]*[_dataDic2[@"num"] floatValue]+[_dataDic2[@"freight"] floatValue];
        
    }
    else{
        _priceLabel.text = [NSString stringWithFormat:@"%@ %@ ",SSKJLocalized(@"待售", nil),_dataDic2[@"wait_sell_price"]];
         money = [_dataDic2[@"wait_sell_price"] floatValue]*[_dataDic2[@"num"] floatValue]+[_dataDic2[@"freight"] floatValue];
    }
    
   
   
    
    _dingjinLabel.text = [NSString stringWithFormat:@"%@%@ ",SSKJLocalized(@"合计：", nil),[WLTools noroundingStringWith:money afterPointNumber:2]];
    
    _amountLabel.text = [NSString stringWithFormat:@"x%@",_dataDic2[@"num"]];
    
    
    _wuliufeeView.valueLabel.text =@"----"; //[NSString stringWithFormat:@"%@",_dataDic[@"address"]];@"
    
    
    _kuaidifeeView.valueLabel.text = [NSString stringWithFormat:@"%@ ",_dataDic2[@"freight"]];
    
    [_contenImg sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:_dataDic2[@"thumbnail_pic"]]]];
    
    //[‘order_ext’][‘total_money’]
    
   
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@",_dataDic2[@"goods_name"]];
    
    self.goodsNumLabel.text=[NSString stringWithFormat:@"%@%@%@",SSKJLocalized(@"共", nil),_dataDic2[@"num"],SSKJLocalized(@"件商品", nil)];
    
//    self.staustLabel.text = @"待付款";
    
    self.staustLabel.hidden = NO;
    
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    self.selectAddress.userInteractionEnabled=NO;
    self.selectAddress.hidden=YES;

    _numLabel.text = [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"订单编号：", nil),_dataDic[@"order_sn"]];
    
    NSString *string  = _dataDic[@"shop_name"];
  
    _shopNameLabel.text = [NSString stringWithFormat:@"%@",string];
    
    NSString *typeStr=_dataDic[@"payment_method"];
                      
    NSInteger type = [typeStr integerValue];
               
    if (type ==1) {
        
        _priceLabel.text = [NSString stringWithFormat:@"%@ %@ ",SSKJLocalized(@"价格", nil),[WLTools noroundingStringWith:[_dataDic[@"can_sell_price"] doubleValue] afterPointNumber:2]];
        
    }
    else{
        _priceLabel.text = [NSString stringWithFormat:@"%@ %@ ",SSKJLocalized(@"价格", nil),[WLTools noroundingStringWith:[_dataDic[@"wait_sell_price"] doubleValue] afterPointNumber:2]];
    }
    
    
  
    
    _amountLabel.text = [NSString stringWithFormat:@"x%@",_dataDic[@"num"]];
    
    
    _wuliufeeView.valueLabel.text =@"----";
    
   
    _kuaidifeeView.valueLabel.text = [NSString stringWithFormat:@"%@ ",_dataDic[@"freight"]];
    
    if (![_dataDic[@"pic_path"] isKindOfClass:[NSNull class]]) {
           [_contenImg sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:_dataDic[@"pic_path"]]]];
    }
    
    else if (![_dataDic[@"thumbnail_pic"] isKindOfClass:[NSNull class]]){
        
           [_contenImg sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:_dataDic[@"thumbnail_pic"]]]];
        
    }
 
    
    _dingjinLabel.text = [NSString stringWithFormat:@"%@%@ ",SSKJLocalized(@"合计：", nil),dataDic[@"price"]];
    
    self.goodsNumLabel.text=[NSString stringWithFormat:@"%@%@%@",SSKJLocalized(@"共", nil),_dataDic[@"num"],SSKJLocalized(@"件商品", nil)];
  
    if ([_dataDic[@"note"] length]>0 ) {
        
          _momoView.text =  [NSString stringWithFormat:@"%@",_dataDic[@"note"]];
    }
    else{
        
        _momoView.text =  @"----";
        
    }
    _momoView.userInteractionEnabled=NO;
    
    self.titleLabel.text = _dataDic[@"goods_name"];
    
    self.staustLabel.text = SSKJLocalized(@"待付款", nil);
    
    self.staustLabel.hidden = NO;
    
    NSInteger status=[_dataDic[@"status"] integerValue];
    
    self.bottomBtn.hidden=NO;
    
    NSInteger isShop=[[dataDic objectForKey:@"isShop"] integerValue];
    

    
    if (![[_dataDic objectForKey:@"shipping_comp_name"] isKindOfClass:[NSNull class]]) {
        
        _wuliufeeView.valueLabel.text =[NSString stringWithFormat:@"%@ , %@",[_dataDic objectForKey:@"shipping_comp_name"],[_dataDic objectForKey:@"shipping_sn"]];
    }
    switch (status) {
            
        case -1:
            self.staustLabel.text = SSKJLocalized(@"已取消", nil);
            
            self.bottomBtn.hidden=NO;
            
            [self.bottomBtn setTitle:SSKJLocalized(@"删除", nil) forState:UIControlStateNormal];
           

            break;
        case 0:
            
            self.staustLabel.text = SSKJLocalized(@"待付款", nil);
            
            if (isShop) {
                
                self.bottomBtn.hidden=NO;

                [self.bottomBtn setTitle:SSKJLocalized(@"取消订单", nil) forState:UIControlStateNormal];
                
                self.cancelBtn.hidden=YES;
                
                self.zhifuBtn.hidden=YES;
            }
            else{
                self.bottomBtn.hidden=YES;
                self.cancelBtn.hidden=NO;
                
                self.zhifuBtn.hidden=NO;
            }
//
            
           
          
            break;
        case 1:
            self.staustLabel.text = SSKJLocalized(@"已付款待发货", nil);
            
            if (isShop) {
                
                self.bottomBtn.hidden=NO;
                
                [self.bottomBtn setTitle:SSKJLocalized(@"立即发货", nil) forState:UIControlStateNormal];
                
            }
            else{
                
                self.bottomBtn.hidden=YES;
            }

            break;
                
        case 2:
                
            self.staustLabel.text = SSKJLocalized(@"待收货", nil);
            
            if (isShop) {
                    
                self.bottomBtn.hidden=YES;
                
            }
            else{
                [self.bottomBtn setTitle:SSKJLocalized(@"确认收货", nil) forState:UIControlStateNormal];
            }
            
            
            break;
                
        case 3:
            self.staustLabel.text = SSKJLocalized(@"已完成", nil);
            self.bottomBtn.hidden=YES;
            
            break;
            
        default:
            break;
            
    }
    
    
//    status    string    订单状态 -1：取消 0:待付款,1:已付款未发货,2:已付款已发货,3:已完成
    
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
-(void)setModel:(AddressMessageModel *)model
{
    _model = model;
    
    SsLog(@"model::%@",model);
    
    self.hasAddress = YES;
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@    %@",model.name,model.mobile];
    
    self.detailAddresslabel.text = [NSString  stringWithFormat:@"%@  %@  %@  %@",model.sheng,model.shi,model.qu,model.address];
    
    
}
-(void)setAdressDict:(NSDictionary *)adressDict{
    
    self.hasAddress = YES;
//    "address_id": "47",
//    "user_name": "Fdsafssa",
//    "phone": "4234234",
//    "province": "河南省",
//    "city": "郑州市",
//    "country": "金水区",
//    "detail": "Ewrtewtew"
    self.nameLabel.text = [NSString stringWithFormat:@"%@     %@",adressDict[@"user_name"],adressDict[@"phone"]];
    
    self.detailAddresslabel.text = [NSString  stringWithFormat:@"%@  %@  %@  %@",adressDict[@"province"],adressDict[@"city"],adressDict[@"country"],adressDict[@"detail"]];
    
}

@end
