


#import "super_AddAddressViewController.h"
#import "UIInput_Title_TFView.h"
#import "RegularExpression.h"
#import "GFAddressPicker.h"




@interface super_AddAddressViewController ()<GFAddressPickerDelegate>

@property (nonatomic, strong) UIInput_Title_TFView *resaveMen;
@property (nonatomic, strong) UIInput_Title_TFView *telNumView;
@property (nonatomic, strong) UIInput_Title_TFView *saveGoodsAddress;
@property (nonatomic, strong) UIInput_Title_TFView *detailAddress;

@property (nonatomic,strong) UILabel *descLabel;
@property (nonatomic, strong) UIView *tobeDefultView;
@property (nonatomic, strong) UIButton *selecetAddresBtn;
@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong) GFAddressPicker *pickerView;
@property (nonatomic, strong) NSString *sheng;
@property (nonatomic, strong) NSString *shi;
@property (nonatomic, strong) NSString *qu;
@property (nonatomic, assign) BOOL isDefault;
@property (nonatomic,copy) UISwitch *sw;


@end

@implementation super_AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.resaveMen];
    [self.view addSubview:self.telNumView];
    [self.view addSubview:self.saveGoodsAddress];
    [self.view addSubview:self.detailAddress];
    [self.view addSubview:self.tobeDefultView];
    [self.view addSubview:self.descLabel];
    [self.view addSubview:self.commitBtn];
    self.title = self.edtingType == 2? SSKJLocalized(@"修改地址", nil):SSKJLocalized(@"添加地址", nil);
//    self.edgesForExtendedLayout = UIRectEdgeNone;

}
-(UIInput_Title_TFView *)resaveMen
{
    if (!_resaveMen) {
        _resaveMen = [[UIInput_Title_TFView alloc]initWithTop:_type == 1?0:ScaleW(15) title:SSKJLocalized(@"收货人：", nil) subTitle:SSKJLocalized(@"请输入您的姓名", nil)];
        
    }
    return _resaveMen;
}

-(UIInput_Title_TFView *)telNumView{
    if (!_telNumView) {
        _telNumView = [[UIInput_Title_TFView  alloc]initWithTop:_resaveMen.bottom title:SSKJLocalized(@"联系电话：", nil) subTitle:SSKJLocalized(@"请输入您的手机号", nil)];
        _telNumView.textFild.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _telNumView;
}
-(UIInput_Title_TFView *)saveGoodsAddress
{
    if (!_saveGoodsAddress) {
        _saveGoodsAddress = [[UIInput_Title_TFView alloc]initWithTop:_telNumView.bottom title:SSKJLocalized(@"所在地区：", nil) subTitle:SSKJLocalized(@"请输入您的所在地区", nil)];
        _selecetAddresBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selecetAddresBtn.frame = _saveGoodsAddress.bounds;
        UIImageView *goImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wd_icon_right"]];
        goImg.right = ScreenWidth - ScaleW(15);
        goImg.centerY = _selecetAddresBtn.centerY;
        [_selecetAddresBtn addSubview:goImg];
        [_saveGoodsAddress addSubview:self.selecetAddresBtn];
        [_selecetAddresBtn addTarget:self action:@selector(selctAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _saveGoodsAddress;
}

-(UIInput_Title_TFView *)detailAddress
{
    if (!_detailAddress) {
        _detailAddress = [[UIInput_Title_TFView alloc]initWithTop:_saveGoodsAddress.bottom title:SSKJLocalized(@"详细地址：", nil) subTitle:SSKJLocalized(@"请输入您的详细地址", nil)];
       
    }
    return _detailAddress;
}

-(UIView *)tobeDefultView
{
    if (!_tobeDefultView) {
        _tobeDefultView = [[UIView alloc]initWithFrame:CGRectMake(0, _detailAddress.bottom, ScreenWidth, ScaleW(45))];
//        _tobeDefultView.backgroundColor = kBgColor353750;
        UILabel *titleLabel = [WLTools allocLabel:SSKJLocalized(@"设为默认：", nil) font:systemFont(ScaleW(15)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), 0, ScaleW(100), ScaleW(45)) textAlignment:(NSTextAlignmentLeft)];
        [_tobeDefultView addSubview:titleLabel];
        
        UISwitch *sw = [[UISwitch alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(65), ScaleW(9), ScaleW(50),ScaleW(30))];
        [sw setOn:self.isDefault];
//        sw.tintColor = kGrayWhiteColor;
//        sw.onTintColor = kGrayWhiteColor;
        sw.thumbTintColor = kSubBackgroundColor;
        [sw addTarget:self action:@selector(onOrOffAction:) forControlEvents:(UIControlEventValueChanged)];
        [_tobeDefultView addSubview:sw];
    }
    return _tobeDefultView;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [FactoryUI createLabelWithFrame:CGRectMake(ScaleW(15), self.tobeDefultView.bottom + ScaleW(5), ScaleW(180), ScaleW(12)) text:@"注：将此地址设置为默认收货地址" textColor:kGrayTitleColor font:systemFont(ScaleW(12))];
    }
    return _descLabel;
}

-(UIButton *)commitBtn{
    
    if (!_commitBtn) {
        
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
//        _commitBtn.frame = CGRectMake(0,ScreenHeight - ScaleW(49),ScreenWidth, ScaleW(49));
        
        [_commitBtn btn:_commitBtn font:ScaleW(15) textColor:kMainWihteColor text:SSKJLocalized(@"保存", nil) image:nil sel:@selector(commitAction:) taget:self];
        
        _commitBtn.layer.cornerRadius = ScaleW(5);
        
//        _commitBtn.backgroundColor = kMainBlueColor;
//        [_commitBtn setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
//        [_commitBtn setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateHighlighted];
        _commitBtn.backgroundColor = kTheMeColor;
//        if (_type == 1) {
        
            _commitBtn.frame = CGRectMake(0,ScreenHeight - ScaleW(49)-Height_NavBar,ScreenWidth, ScaleW(49));
            
//        }
        
    }
    
    return _commitBtn;
    
}

-(void)commitAction:(UIButton *)sender
{
    if (![self defutltPams:self.resaveMen]) {
        return;
    }
    if (![self defutltPams:self.telNumView]) {
        return;
    }
   
    if (![self defutltPams:self.saveGoodsAddress]) {
        return;
    }
    if (![self defutltPams:self.detailAddress]) {
        return;
    }
    if (![RegularExpression validateMobile:self.telNumView.textFild.text]) {
        
        [MBProgressHUD showError:@"请输入正确的手机号"];
        return;
    }
    //AB_Shop_shop_address_add_post
    
    //添加
    if (self.edtingType == 1) {
//        name    是    string    姓名
//        phone    是    string    电话
//        province    是    string    省
//        city    是    string    市
//        country    是    string    区
//        detail    是    string    详细地址
//        is_default
    
        NSDictionary *pamas = @{@"name":self.resaveMen.textFild.text,@"phone":self.telNumView.textFild.text,@"province":self.sheng,@"city":self.shi,@"country":self.qu,@"detail":self.detailAddress.textFild.text,@"is_default":@(self.isDefault)};
        
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_shop_address_add_post RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
           
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        else
        {
            
        }
        
         [MBProgressHUD showError:netWorkModel.msg];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    }else{
        //AB_Shop_address_edit_post
        
        //编辑
        NSDictionary *pamas = @{ @"address_id":self
                                 .model.ID,@"name":self.resaveMen.textFild.text,@"phone":self.telNumView.textFild.text,@"province":self.sheng,@"city":self.shi,@"country":self.qu,@"detail":self.detailAddress.textFild.text,@"is_default":@(self.isDefault)};
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_address_edit_post RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
            WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([netWorkModel.status isEqualToString:@"200"]) {
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            else
            {
                
            }
            // [MBProgressHUD showError:netWorkModel.msg];
        } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];

    }
}



-(BOOL)defutltPams:(UIInput_Title_TFView *)text
{
    if(text.textFild.text.length == 0)
    {
        [MBProgressHUD showError:text.textFild.placeholder];
        return NO;
    }
    
    return YES;

}

-(void)onOrOffAction:(UISwitch *)sender
{
   
    self.isDefault=sender.isOn;
    
}

-(void)selctAction:(UIButton *)sender
{
//    *resaveMen;
//    @property (nonatomic, strong) UIInput_Title_TFView *telNumView;
//    @property (nonatomic, strong) UIInput_Title_TFView *saveGoodsAddress;
//    @property (nonatomic, strong) UIInput_Title_TFView *detailAddress;
    
    [self.telNumView.textFild resignFirstResponder ];
    
    [self.saveGoodsAddress.textFild resignFirstResponder ];

    [self.detailAddress.textFild resignFirstResponder ];

    
    self.pickerView = [[GFAddressPicker alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if (_type == 1) {
        self.pickerView.frame = CGRectMake(0, -Height_NavBar, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    [self.pickerView updateAddressAtProvince:@"河南省" city:@"郑州市" town:@"金水区"];
    self.pickerView.delegate = self;
    self.pickerView.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:self.pickerView];
}
- (void)GFAddressPickerWithProvince:(NSString *)province
                               city:(NSString *)city area:(NSString *)area
{
    [self.pickerView removeFromSuperview];
    
    self.saveGoodsAddress.textFild.text = [NSString stringWithFormat:@"%@  %@  %@",province,city,area];
    
    self.sheng = province;
    
    self.shi = city;
    
    self.qu = area;
    
}
-(void)GFAddressPickerCancleAction
{
    [self.pickerView removeFromSuperview];
    
}
-(NSInteger)edtingType
{
    if (!_edtingType) {
        _edtingType = 1;
    }
    return _edtingType;
}

-(void)setModel:(AddressMessageModel *)model
{
    _model = model;
    
    self.resaveMen.textFild.text = _model.name;
    
    self.telNumView.textFild.text = _model.mobile;
    
    self.saveGoodsAddress.textFild.text = [NSString stringWithFormat:@"%@  %@  %@",model.sheng,model.shi,model.qu];
    
    self.detailAddress.textFild.text = model.address;
    
    self.sheng = model.sheng;
    self.shi = model.shi;
    self.qu = model.qu;
    self.isDefault=[model.default_status boolValue];

    
    
}



@end
