//
//  ShopEdting_ViewController.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/16.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "ShopEdting_ViewController.h"
#import "Shop_Publish_View.h"
#import "StoreModel.h"

@interface ShopEdting_ViewController ()
@property (nonatomic, strong) UITextField *nameText;
@property (nonatomic, strong) UITextField *telText;
@property (nonatomic, strong) UITextField *QQText;

@property (nonatomic, strong) UITextField *addText;
@property (nonatomic, strong) Shop_Publish_View *shopView;
@property (nonatomic, strong) Shop_Publish_View *shopReduce;
@property (nonatomic, strong) UIButton *bottomBtn;
@property (nonatomic, strong) UIButton *submitButton;



@end

@implementation ShopEdting_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;

    self.title = SSKJLocalized(@"店铺信息", nil);
    
    
    [self.view addSubview:self.nameText];
    
    [self.view addSubview:self.telText];
    
    [self.view addSubview:self.QQText];
    
    [self.view addSubview:self.addText];
    
    
    [self.view addSubview:self.shopView];
    
    [self.view addSubview:self.submitButton];
    
    self.view.backgroundColor = kBgColor353750;
    
    NSLog(@"store_id:::%@",self.shopid);

    [self getStoreInfo];
    
}

-(void)getStoreInfo{
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if (! [SSKJ_User_Tool sharedUserTool].storeId ) {
        
        
        return;
        
    }
    
    NSDictionary *pamas = @{@"store_id": [SSKJ_User_Tool sharedUserTool].storeId };
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:KStoreInfo RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([netWorkModel.status integerValue] == SUCCESSED) {
            
//            NSArray *array=netWorkModel.data;
            
            StoreModel *model = [StoreModel mj_objectWithKeyValues:netWorkModel.data];
            
            self.nameText.text=model.name;
            self.telText.text=model.phone;
            self.QQText.text=model.qq;
            self.addText.text=model.address;
            self.shopView.textView.text=model.detail;
            self.shopView.placeHolder.hidden=YES;
            
            self.shopView.oldImgArray=model.pic_urls;

            
        }else{
            
            [MBProgressHUD showError:netWorkModel.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;

}
-(UITextField *)nameText{
    if (!_nameText) {
        _nameText = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(15), self.view.top, ScreenWidth, ScaleW(55))];
        _nameText.backgroundColor =[UIColor clearColor];
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(0), 0, ScaleW(80), ScaleW(40))];
        [nameLabel label:nameLabel font:ScaleW(15) textColor:kMainTextColor text:SSKJLocalized(@"店铺名称", nil)];
        _nameText.leftViewMode = UITextFieldViewModeAlways;
        _nameText.leftView = nameLabel;
        [_nameText textField:_nameText textFont:ScaleW(15) placeHolderFont:ScaleW(15) text:nil placeText:SSKJLocalized(@"请输入店铺名称", nil) textColor:kMainTextColor placeHolderTextColor:kSubSubTxtColor];
        _nameText.backgroundColor = [UIColor clearColor];
        
        UIView *style = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(15), _nameText.bottom, ScreenWidth -ScaleW(30) , 1)];
        style.backgroundColor=kLineColor;
        
        [self.view addSubview:style];
        
     
        
    }
    return _nameText;
}
-(UITextField *)telText{
    if (!_telText) {
        _telText = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(15), _nameText.bottom+1, ScreenWidth, ScaleW(55))];
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(0), 0, ScaleW(80), ScaleW(40))];
        [nameLabel label:nameLabel font:ScaleW(15) textColor:kMainTextColor text:SSKJLocalized(@"客服电话", nil)];
        _telText.leftViewMode = UITextFieldViewModeAlways;
        _telText.leftView = nameLabel;
        [_telText textField:_telText textFont:ScaleW(15) placeHolderFont:ScaleW(15) text:nil placeText:SSKJLocalized(@"请输入客服电话", nil) textColor:kMainTextColor placeHolderTextColor:kSubSubTxtColor];
         _telText.backgroundColor = [UIColor clearColor];
        
        UIView *style = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(15), _telText.bottom, ScreenWidth -ScaleW(30), 1)];
        style.backgroundColor=kLineColor;
        
        [self.view addSubview:style];
    }
    return _telText;
}
- (UITextField *)QQText{
    if (!_QQText) {
        _QQText = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(15), _telText.bottom+1, ScreenWidth, ScaleW(55))];
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(0), 0, ScaleW(80), ScaleW(40))];
        [nameLabel label:nameLabel font:ScaleW(15) textColor:kMainTextColor text:SSKJLocalized(@"客服QQ", nil)];
        _QQText.leftViewMode = UITextFieldViewModeAlways;
        _QQText.leftView = nameLabel;
        [_QQText textField:_QQText textFont:ScaleW(15) placeHolderFont:ScaleW(15) text:nil placeText:SSKJLocalized(@"请输入客服QQ", nil) textColor:kMainTextColor placeHolderTextColor:kSubSubTxtColor];
        _QQText.backgroundColor = [UIColor clearColor];
        
        UIView *style = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(15), _QQText.bottom, ScreenWidth - ScaleW(30) , 1)];
        style.backgroundColor=kLineColor;
        
        [self.view addSubview:style];
    }
    return _QQText;
    
}
-(UITextField *)addText{
    if (!_addText) {
        _addText = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(15), _QQText.bottom+1, ScreenWidth, ScaleW(55))];
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(0), 0, ScaleW(80), ScaleW(55))];
        [nameLabel label:nameLabel font:ScaleW(15) textColor:kMainTextColor text:SSKJLocalized(@"店铺地址", nil)];
        _addText.leftViewMode = UITextFieldViewModeAlways;
        _addText.leftView = nameLabel;
        [_addText textField:_addText textFont:ScaleW(15) placeHolderFont:ScaleW(15) text:nil placeText:SSKJLocalized(@"请输入您的店铺地址", nil) textColor:kMainTextColor placeHolderTextColor:kSubSubTxtColor];
         _addText.backgroundColor = [UIColor clearColor];
        
        UIView *style = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(15), _addText.bottom, ScreenWidth-ScaleW(30) , 1)];
        style.backgroundColor=kLineColor;
        
        [self.view addSubview:style];
    }
    return _addText;
}

-(Shop_Publish_View *)shopView

{
    if (!_shopView) {
        
        _shopView = [[Shop_Publish_View alloc]initWithTop:_addText.bottom+1 Title:SSKJLocalized(@"店铺介绍", nil) subTiles:SSKJLocalized(@"请填写店铺简介", nil) limit:60 andDecripTitle:SSKJLocalized(@"店铺背景图片", nil) subTitle:SSKJLocalized(@"(最多上传3张图片)", nil) andHeight:ScaleW(330) andImgLimit:3 andImgType:1];
        
        _shopView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _shopView;
}


-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), ScreenHeight - ScaleW(55)-Height_TabBar, ScreenWidth - ScaleW(30), ScaleW(45))];
//        _submitButton.backgroundColor = kMainTextColor;
        [_submitButton setTitle:SSKJLocalized(@"确定", nil) forState:UIControlStateNormal];
        [_submitButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemBoldFont(ScaleW(15));
        _submitButton.layer.cornerRadius = _submitButton.height / 2;
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
        [_submitButton addGradientColor];
//        _submitButton.layer.masksToBounds = YES;
//        _submitButton.layer.cornerRadius = ScaleW(5);
//        [_submitButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
        _submitButton.backgroundColor = kTheMeColor;
    }
    return _submitButton;
}
-(void)submitEvent
{

//    ":self.nameText.text,
//    @"address":self.addText.text,
//    @"phone":self.telText.text,
//    @"qq":self.QQText.text,
//    @"detail":self.shopView.textView.text,
    
    if (self.
        nameText.text.length == 0) {
        
        showAlert(@"请输入店铺名");
        
        return;
        
    }
    if (self.
        nameText.text.length == 0) {
        
        showAlert(@"请输入店铺名");
        
        return;
        
    }
    if (self.
        telText.text.length == 0) {
        
        showAlert(@"请输入客服电话");
        
        return;
        
    }
    if (self.
        QQText.text.length == 0) {
        
        showAlert(@"请输入客服QQ");
        
        return;
        
    }
    if (self.
        shopView.textView.text.length == 0) {
        
        showAlert(@"请输入店铺介绍");
        
        return;
        
    }
    if (self.
        addText.text.length == 0) {
        
        showAlert(@"请输入店铺地址");
        
        return;
        
    }
    NSMutableArray *imgUrlArray=[NSMutableArray new];
    
    if (self.shopView.contenUrlString.length) {
        
        [self comit:self.shopView.contenUrlString];
  
    }
    else{
        
        showAlert(@"请选择背景图片");
    }

}
-(void)comit:(NSString*)imgsUrl{
    
    
        NSDictionary *params = @{@"name":self.nameText.text,
                                 @"address":self.addText.text,
                                 @"phone":self.telText.text,
                                 @"qq":self.QQText.text,
                                 @"detail":self.shopView.textView.text,
                                 @"store_pics":imgsUrl
    
                                 };
        WS(weakSelf);
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[WLHttpManager shareManager]requestWithURL_HTTPCode:kowner_shop_edit_post_url RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
            if ([network_model.status integerValue] == SUCCESSED) {
                [MBProgressHUD showError:network_model.msg];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [MBProgressHUD showError:network_model.msg];
            }
        } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        }];
}

@end
