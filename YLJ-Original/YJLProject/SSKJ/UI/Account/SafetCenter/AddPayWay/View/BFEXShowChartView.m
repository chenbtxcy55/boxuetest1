//
//  BFEXShowChartView.m
//  ZYW_MIT
//
//  Created by 张本超 on 2018/7/3.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "BFEXShowChartView.h"
#import "BFEXShowChartViewCell.h"
#import "alertSelectView.h"
#import "FRCameraViewController.h"
#import "ICC_SelectPhotoView.h"
#import "ManagerSocket.h"
#import <AFHTTPSessionManager.h>
@interface BFEXShowChartView()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITableView *showTableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *inputTextView ;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) alertSelectView *alertView;
@property (nonatomic, strong) ICC_SelectPhotoView *selectPhoto;
//1 支付宝 2 微信 3 银行卡 4paypal
@property (nonatomic, assign) NSInteger selectType;
//记录当前img
@property (nonatomic, strong) UIImageView *currentImg;
@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, copy) NSString *imageURL;

@property (nonatomic, strong) NSMutableDictionary *params;

@end

@implementation BFEXShowChartView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self viewConfig];
    }
    return self;
}

-(void)viewConfig
{
    
    self.selectType = 1;
    self.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
    self.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
   // [keyWindow addSubview:self];
    [self backView];
    [self nameLabel];
    [self inputTextView];
    [self showTableView];
    
    self.backView.centerY = ScreenHeight / 2;
}
-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[@{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},@{SSKJLocalized(@"支付宝", nil):SSKJLocalized(@"请输入支付宝账号", nil)},@{SSKJLocalized(@"二维码", nil):SSKJLocalized(@"请上传您的支付宝收款二维码图片", nil)},@{SSKJLocalized(@"安全密码", nil):SSKJLocalized(@"请输入安全密码", nil)}];
    }
    return _dataArr;
}


-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(16, 0, ScreenWidth - 16*2, 0)];
        _backView.backgroundColor = kSubBackgroundColor;
        _backView.layer.cornerRadius = 8.0f;
        [self addSubview:_backView];
    }
    return _backView;
}

-(UITableView *)showTableView{
    if (!_showTableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(25, self.headerView.maxY, Screen_Width - 50, Screen_Height - 160 - 90 -140) style:UITableViewStylePlain];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.backgroundColor=[UIColor clearColor];
           [self.backView addSubview:tableView];
        UIView *settingsview = [[UIView alloc]initWithFrame:CGRectMake(25, tableView.bottom, tableView.width, 90)];
        settingsview.backgroundColor = [UIColor clearColor];
        [self.backView addSubview:settingsview];
        UIButton *button = [[UIButton alloc] init];
//        button.backgroundColor = kMainTextColor;
//        button.layer.cornerRadius = 20;
        button.titleLabel.font = [UIFont systemFontOfSize:15.f];
//        button.layer.cornerRadius = 22.5;
//        button.layer.masksToBounds = YES;
        [button setTitle:SSKJLocalized(@"确定", nil) forState:UIControlStateNormal];
        button.tag = 100000;
        [button setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:)
         
         forControlEvents:UIControlEventTouchUpInside];
         [settingsview addSubview:button];
        button.frame = CGRectMake(settingsview.width/2, 20, ScaleW(125), 40);
        UIButton *buttoncancell = [[UIButton alloc] init];
        buttoncancell.backgroundColor = [UIColor clearColor];
        buttoncancell.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [buttoncancell setTitle:SSKJLocalized(@"取消", nil) forState:UIControlStateNormal];
     
        [buttoncancell setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        [buttoncancell addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        buttoncancell.frame = CGRectMake( 0, 20, ScaleW(125), 40);
//        buttoncancell.layer.masksToBounds = YES;
//        buttoncancell.layer.borderColor = kMainTextColor.CGColor;
//        buttoncancell.layer.borderWidth = 0.5;
//        buttoncancell.layer.cornerRadius = buttoncancell.height / 2;
        [settingsview addSubview:buttoncancell];
        settingsview.centerX = self.backView.width / 2;

        _showTableView = tableView;
        _showTableView.centerX = self.backView.width / 2;

        self.backView.height = settingsview.bottom;
    }
    return _showTableView;
    
}
-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 55, 200, 14)];
        [self label:_nameLabel font:14 textColor:kMainWihteColor text:SSKJLocalized(@"支付方式", nil)];
        [self.headerView addSubview:_nameLabel];
    }
    return _nameLabel;
}

-(UITextField *)inputTextView{
    if (!_inputTextView) {
        _inputTextView = [[UITextField alloc]initWithFrame:CGRectMake(25,_nameLabel.bottom + 12, Screen_Width - 50 - 32, 45.f)];
        [self textField:_inputTextView textFont:14 placeHolderFont:14 text:@"" placeText:SSKJLocalized(@"支付宝", nil) textColor:kMainTextColor placeHolderTextColor:kMainTextColor];
        [_inputTextView setCornerRadius:5.f];
        [_inputTextView setBorderWithWidth:1.f andColor:UIColorFromRGB(0x5b5e95)];
        _inputTextView.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _inputTextView.leftViewMode = UITextFieldViewModeAlways;
        _inputTextView.enabled = NO;
        [self.headerView addSubview:_inputTextView];
       _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.right = _inputTextView.right - ScaleW(47);
        _btn.centerY = _inputTextView.centerY - ScaleW(22);
        _btn.size = CGSizeMake(ScaleW(47), ScaleW(45));
        [self btn:_btn font:12 textColor:UIColorFromRGB(0xffffff) text:@"" image:[UIImage imageNamed:@"duihuan-xial"]];
        [_btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.headerView addSubview:_btn];
        
    }
    return _inputTextView;
}
-(alertSelectView *)alertView{
    if (!_alertView) {
        _alertView = [[alertSelectView alloc]initWithFrame:CGRectMake(_btn.x, _btn.maxY, 90 , 240)];
        _alertView.layer.borderColor = kLineGrayColor.CGColor;
        _alertView.layer.borderWidth = 0.5;
        _alertView.dataArray = @[SSKJLocalized(@"支付宝", nil),SSKJLocalized(@"微信", nil),SSKJLocalized(@"银行卡", nil)];
        
        _alertView.frame = CGRectMake(_btn.x, _btn.maxY + 60, 90 , 120);
        _alertView.hidden = YES;
        [self addSubview:_alertView];
    }
    return _alertView;
}
#pragma mark --- 选择支付类型 ---
-(void)btnAction:(UIButton *)sender
{
    WS(weakSelf);
    self.alertView.hidden = !self.alertView.hidden;
    self.alertView.selectIndexBlock = ^(NSInteger index) {
        weakSelf.selectType = index +1; weakSelf.inputTextView.text=weakSelf.alertView.dataArray[index];
        
        switch (weakSelf.selectType) {
            case 1:
            {
                 weakSelf.dataArr =  @[@{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},@{SSKJLocalized(@"支付宝", nil):SSKJLocalized(@"请输入支付宝账号", nil)},@{SSKJLocalized(@"二维码", nil):SSKJLocalized(@"请上传您的支付宝收款二维码图片", nil)},@{SSKJLocalized(@"安全密码", nil):SSKJLocalized(@"请输入安全密码", nil)}];
            }
                break;
            case 2:
               
            {
                 weakSelf.dataArr = @[@{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},@{SSKJLocalized(@"微信", nil):SSKJLocalized(@"请输入微信账号", nil)},@{SSKJLocalized(@"二维码", nil):SSKJLocalized(@"请上传您的微信收款二维码图片", nil)},@{SSKJLocalized(@"安全密码", nil):SSKJLocalized(@"请输入安全密码", nil)}];
            }
                break;
            case 3:
            {
                weakSelf.dataArr = @[
                                     @{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},
                                     @{SSKJLocalized(@"开户银行", nil):SSKJLocalized(@"请输入开户银行名", nil)},
                                     @{SSKJLocalized(@"开户支行", nil):SSKJLocalized(@"请输入支行名", nil)},
                                     @{SSKJLocalized(@"开户银行卡", nil):SSKJLocalized(@"请输入银行卡号", nil)},
                                     @{SSKJLocalized(@"安全密码", nil):SSKJLocalized(@"请输入安全密码", nil)}];
            }
                break;
            case 4:{
                NSString *str = [NSString stringWithFormat:@"Paypal%@",SSKJLocalized(@"账户", nil)];
                weakSelf.dataArr = @[
                                     @{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},
                                     @{str:SSKJLocalized(@"请输入您的", nil)},
                                     @{SSKJLocalized(@"安全密码", nil):SSKJLocalized(@"请输入安全密码", nil)}];
            }
               break;
            default:
                break;
        }
        [weakSelf.showTableView reloadData];
    };

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BFEXShowChartViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"BFEXShowChartViewCell%ld%ld",indexPath.row,self.selectType]];
    WS(weakSelf);
    if (cell == nil) {
        cell = [[BFEXShowChartViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[NSString stringWithFormat:@"BFEXShowChartViewCell%ld%ld",indexPath.row,self.selectType]];
        cell.backImg = ^(UIImageView *img) {
            weakSelf.currentImg = img;
            [weakSelf.selectPhoto showView];
        };
        
        if (indexPath.row == 2) {
            if (self.selectType == 1 || self.selectType == 2) {
                self.imageURL = self.dataData.img;
                [cell.selectImg sd_setImageWithURL:[NSURL URLWithString:self.dataData.img] placeholderImage:[UIImage imageNamed:@"sctp"]];
            }
        }
        
    }
    [cell setValueWith:self.dataArr[indexPath.row] type:self.addType];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)alertController {
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
    }];
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:SSKJLocalized(@"打开相机", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self presentPickerConroller:imagePickerController sourceType:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:SSKJLocalized(@"打开相册", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self presentPickerConroller:imagePickerController sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    [alertVc addAction:cancle];
    [alertVc addAction:camera];
    [alertVc addAction:photo];
    alertVc.modalPresentationStyle = UIModalPresentationFullScreen;

    [self.viewController presentViewController:alertVc animated:YES completion:nil];
}
-(ICC_SelectPhotoView *)selectPhoto
{
    if (!_selectPhoto) {
        _selectPhoto = [[ICC_SelectPhotoView alloc]init];
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        WS(weakSelf);
        _selectPhoto.selectLibryAction = ^
        {
            
            [weakSelf presentPickerConroller:imagePickerController sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
             [weakSelf removeCancelView];
        };
        _selectPhoto.takePhotoAction = ^
        {
            [weakSelf presentPickerConroller:imagePickerController sourceType:UIImagePickerControllerSourceTypeCamera];
            [weakSelf removeCancelView];
        };
    }
    return _selectPhoto;
}
-(void)removeCancelView
{
    [self.selectPhoto removeFromSuperview];
}
- (void)presentPickerConroller:(UIImagePickerController *)imagePickerController sourceType:(UIImagePickerControllerSourceType)sourceType {
    imagePickerController.sourceType = sourceType;
    WS(weakSelf);
    imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;

    [self.viewController presentViewController:imagePickerController animated:YES completion:^{
        
       // [weakSelf hiddenView];
    }];
}

#pragma mark - Camera Delegate

- (void)CameraAchieveToImageDelegate:(FRCameraViewController *)ViewController Withimage:(UIImage *)image {
    //
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showAlertView" object:nil];
    [self performSelector:@selector(saveImage:) withObject:image afterDelay:0.5];
}

- (void)saveImage:(UIImage *)image {
    self.currentImg.image = image;
    //[self judge];
}

#pragma mark - photo delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //获取返回的图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self performSelector:@selector(saveImage:) withObject:image afterDelay:0.5];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showAlertView" object:nil];
    [self.viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.viewController dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showAlertView" object:nil];
    }];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1f;
}
#pragma mark --- 头部试图 ---
-(UIView *)headerView{
    if (!_headerView) {
        //CGRectMake(25, 80, Screen_Width - 50, Screen_Height - 160 - 90)
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - ScaleW(30),140.f)];
//        _headerView.backgroundColor = MainTextColor;
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont boldSystemFontOfSize:17];
        label.text = SSKJLocalized(@"添加支付方式", nil);
        label.textColor = kMainTextColor;
        label.frame = CGRectMake(16, 20, 200, 17);
        [label sizeToFit];
        label.tag = 100002;
        label.backgroundColor = [UIColor clearColor];
        label.centerX = _headerView.centerX;
        label.textAlignment = NSTextAlignmentCenter;
        [_headerView addSubview:label];
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.maxX = Screen_Width- 50.f -30.f;
        button.size = [UIImage imageNamed:@"guan-bi"].size;
        button.centerY = label.centerY;
        [button setImage:[UIImage imageNamed:@"guan-bi"]  forState:UIControlStateNormal];
        [self btn:button font:12 textColor:UIColorFromRGB(0xffffff) text:@"" image:[UIImage imageNamed:@"guan-bi"]];
//        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:button];
        
        //透明 关闭按钮
        UIButton *alphaCloseButton=[UIButton buttonWithType:UIButtonTypeCustom];
  
        [alphaCloseButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [alphaCloseButton setBackgroundColor:[UIColor clearColor]];
        
        [_headerView addSubview:alphaCloseButton];
        
        [alphaCloseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(@0);
            
            make.right.equalTo(_headerView.mas_right);
            
            make.height.equalTo(@45);
            
            make.width.equalTo(@80);
        }];
        
        _headerView.centerX = self.backView.width / 2;
        [self.backView addSubview:_headerView];
    }
    return _headerView;
}
#pragma mark --- 添加支付方式 ---
-(void)buttonClicked:(UIButton *)sender
{
    
    
    if (sender.tag == 100000)
    {
        NSMutableDictionary *params =  [NSMutableDictionary dictionary];
        self.params = params;
        params[@"act"] = _addType?:@"add";

//
        switch (self.selectType) {
            case 1:
            {
                //支付宝
                params[@"type"] = @"alipay";

                if ([[ManagerSocket sharedManager].dataDic objectForKey:@"alipay"] != nil )
                {
                    params[@"alipay"] =   [[ManagerSocket sharedManager].dataDic objectForKey:@"alipay"];

                }else{
                    [MBProgressHUD showError:SSKJLocalized(@"请输入支付宝账号", nil)];
//                    [self removeSave];
                    return;
                }

            }
                break;
            case 2:

            {
                if (![WLTools judgeString:[[ManagerSocket sharedManager].dataDic objectForKey:@"wx"]] && [[[ManagerSocket sharedManager].dataDic objectForKey:@"wx"] length] == 0) {
                    [MBProgressHUD showError:SSKJLocalized(@"请输入微信账号", nil)];
//                    [self removeSave];
                    return;

                }
                //微信
                params[@"type"] = @"wx";
                params[@"wx"] = [[ManagerSocket sharedManager].dataDic objectForKey:@"wx"];;

            }
                break;
            case 3:
            {
                //银行卡
                if (![WLTools judgeString:[[ManagerSocket sharedManager].dataDic objectForKey:@"bank"]] && [[[ManagerSocket sharedManager].dataDic objectForKey:@"bank"] length] == 0) {
                    [MBProgressHUD showError:SSKJLocalized(@"请输入开户银行名", nil)];
//                    [self removeSave];
                    return;
                }else if (![WLTools judgeString:[[ManagerSocket sharedManager].dataDic objectForKey:@"branch"]] && [[[ManagerSocket sharedManager].dataDic objectForKey:@"branch"] length] == 0){
                    [MBProgressHUD showError:SSKJLocalized(@"请输入支行名", nil)];
//                    [self removeSave];
                    return;
                }else if (![WLTools judgeString:[[ManagerSocket sharedManager].dataDic objectForKey:@"bank_car"]]&& [[[ManagerSocket sharedManager].dataDic objectForKey:@"bank_car"] length] == 0){
                    [MBProgressHUD showError:SSKJLocalized(@"请输入银行卡号", nil)];
//                    [self removeSave];
                    return;
                }
                params[@"type"] = @"bankcard";
                params[@"bank"] = [[ManagerSocket sharedManager].dataDic objectForKey:@"bank"];
                params[@"branch"] = [[ManagerSocket sharedManager].dataDic objectForKey:@"branch"];
                params[@"bank_car"] = [[ManagerSocket sharedManager].dataDic objectForKey:@"bank_car"];
                self.currentImg.image = nil;
            }
                break;
            case 4:
            {
                if (![WLTools judgeString:[[ManagerSocket sharedManager].dataDic objectForKey:@"Paypal"]] && [[[ManagerSocket sharedManager].dataDic objectForKey:@"Paypal"] length] == 0) {
                    [MBProgressHUD showError:SSKJLocalized(@"请输入您的", nil)];
//                    [self removeSave];
                    return;
                }
                params[@"type"] = @"paypal";
                params[@"pal_account"]=[[ManagerSocket sharedManager].dataDic objectForKey:@"Paypal"];
            }
                 break;
            default:
                break;
        }

        if ([[ManagerSocket sharedManager].dataDic objectForKey:@"tpwd"]) {
            params[@"tpwd"] = [WLTools md5:[[ManagerSocket sharedManager].dataDic objectForKey:@"tpwd"]];
        }else{
            [MBProgressHUD showError:SSKJLocalized(@"请输入安全密码", nil)];
            return;
        }
        
        if (self.selectType == 1 || self.selectType == 2) {
            if (!self.currentImg) {
                [MBProgressHUD showError:SSKJLocalized(@"请上传图片", nil)];
                return;
            }
            [self uploadImage:self.currentImg.image];
        }else{
            [self uploadImage1:params];
        }
        
    }else{
        self.cancellBlock();
        [self removeFromSuperview];
    }
}

- (void)removeSave{
    NSArray *array=@[@"alipay",@"wx",@"tpwd",@"bank",@"branch",@"bank_car",@"Paypal"];
    [[ManagerSocket sharedManager].dataDic removeObjectsForKeys:array];
    return;
}

- (void)uploadImage1 :(NSDictionary *)params{
//    NSArray *array=@[@"alipay",@"wx",@"tpwd",@"bank",@"branch",@"bank_car",@"Paypal"];
//    [[ManagerSocket sharedManager].dataDic removeObjectsForKeys:array];
//    [[ManagerSocket sharedManager]removedataDic];
//    NSLog(@"%@",params);
    NSString *key = nil;
    if (_selectType == 1) {
        key = @"ali_img";
        
    }
    if (_selectType == 2) {
        key = @"wx_img";
    }
//    if (_selectType == 3 || _selectType == 4) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [MBProgressHUD showHUDAddedTo:window animated:YES];
        WS(weakSelf);
        [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_AddPaywaysApi RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
            [MBProgressHUD hideHUDForView:window animated:YES];
            WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
            if ([network_model.status integerValue] == SUCCESSED) {
                [MBProgressHUD showSuccess:network_model.msg];
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.sucessBlock();
                    [weakSelf removeSave];
                    [weakSelf removeFromSuperview];
                });
            }else{
                [MBProgressHUD showError:network_model.msg];
            }
        } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
            //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
            [MBProgressHUD hideHUDForView:window animated:YES];
        }];
//        return;
    
//    if (!self.currentImg.image) {
//        [MBProgressHUD showSuccess:SSKJLocalized(@"请上传图片", nil)];
////        [self removeSave];
//        return;
//    }
   
}

- (void)uploadImage:(UIImage *)image1 {
    NSArray *imageAry = @[image1];
    // 基于AFN3.0+ 封装的HTPPSession句柄
    
    NSString *Token=[[SSKJ_User_Tool sharedUserTool] getToken];
    NSString *Account=[[SSKJ_User_Tool sharedUserTool] getAccount];
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.f;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:Account forHTTPHeaderField:@"account"];
    [manager.requestSerializer setValue:Token forHTTPHeaderField:@"token"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    WS(weakSelf);
    [manager POST:JB_Upload_pic_URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < imageAry.count; i++) {
            id file = imageAry[i];
            NSString * imgname = [NSString stringWithFormat:@"jiangxian_img_%d.jpg",i];
            if ([file isKindOfClass:[UIImage class]]) {
                [formData appendPartWithFileData:UIImageJPEGRepresentation(file,0.3) name:@"file" fileName:imgname mimeType:@"image/jpg/png/jpeg"];
            }
        }
    } progress:^(NSProgress * xx){
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (network_Model.status.integerValue == 200) {
           
            weakSelf.imageURL = network_Model.data[@"url"];
            
            if (weakSelf.selectType == 1) {
                [weakSelf.params setObject:weakSelf.imageURL forKey:@"ali_img"];
            }else if (weakSelf.selectType == 2){
                [weakSelf.params setObject:weakSelf.imageURL forKey:@"wx_img"];
            }
            
            [weakSelf uploadImage1:weakSelf.params];
            
        }else{
            [MBProgressHUD showError:network_Model.msg];

        }
        
        [MBProgressHUD hideHUDForView:weakSelf animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:weakSelf animated:YES];
    }];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataArr[indexPath.row];
    if ([dic.allKeys.firstObject isEqualToString:@"二维码"])
    {
        return 120;
    }
    return 85;
}


#pragma mark --- 获取数据 ---
-(void)setAddType:(NSString *)addType
{
    _addType = addType;
    UILabel *ways = [self.headerView viewWithTag:100002];
   
    if ([_addType isEqualToString:@"edit"]) {
        ways.text = SSKJLocalized(@"修改支付方式", nil);
        _btn.enabled = NO;
    }else{
        ways.text = SSKJLocalized(@"添加支付方式", nil);
    }
    [ways sizeToFit];
}
-(void)setDataData:(JB_PayWayModel *)dataData{
//    NSLog(@"+++++++++++%@+++++++++++",dataData);
    _dataData = dataData;
    self.inputTextView.text=_dataData.tip?:self.inputTextView.text;
    NSArray *array = @[SSKJLocalized(@"支付宝", nil) ,SSKJLocalized(@"微信",nil),SSKJLocalized(@"银行卡",nil),@"Paypal"];
    NSInteger index = 0;
    for (int i = 0; i<array.count; i++) {
        if ([_dataData.tip isEqualToString:array[i]]) {
            index = i;
        }
    }
    //self.alertView.selectIndexBlock(index);
    _selectType = index + 1;
    switch (self.selectType) {
        case 1:
        {
             self.dataArr =  @[@{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},@{SSKJLocalized(@"支付宝", nil):SSKJLocalized(@"请输入支付宝账号", nil)},@{SSKJLocalized(@"二维码", nil):SSKJLocalized(@"请上传您的支付宝收款二维码图片", nil)},@{SSKJLocalized(@"安全密码", nil):SSKJLocalized(@"请输入安全密码", nil)}];
            if ([_addType isEqualToString:@"edit"]) {
                self.dataArr =  @[@{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},@{SSKJLocalized(@"支付宝", nil):dataData.number},@{SSKJLocalized(@"二维码", nil):SSKJLocalized(@"请上传您的支付宝收款二维码图片", nil)},@{SSKJLocalized(@"安全密码", nil):SSKJLocalized(@"请输入安全密码", nil)}];
                [[ManagerSocket sharedManager].dataDic setObject:dataData.number forKey:@"alipay"];

            }
        }
            break;
        case 2:
            
        {
             self.dataArr = @[@{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},@{SSKJLocalized(@"微信", nil):SSKJLocalized(@"请输入微信账号", nil)},@{SSKJLocalized(@"二维码", nil):SSKJLocalized(@"请上传您的微信收款二维码图片", nil)},@{SSKJLocalized(@"安全密码", nil):SSKJLocalized(@"请输入安全密码", nil)}];
            
            if ([_addType isEqualToString:@"edit"]) {
                
                self.dataArr = @[@{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},
                                 @{SSKJLocalized(@"微信", nil):dataData.number},
                                 @{SSKJLocalized(@"二维码", nil):SSKJLocalized(@"请上传您的微信收款二维码图片", nil)},
                                 @{SSKJLocalized(@"安全密码", nil):SSKJLocalized(@"请输入安全密码", nil)}];
                [[ManagerSocket sharedManager].dataDic setObject:dataData.number forKey:@"wx"];

            }
        }
            break;
        case 3:
        {
            self.dataArr = @[
                                 @{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},
                                 @{SSKJLocalized(@"开户银行", nil):SSKJLocalized(@"请输入开户银行名", nil)},
                                 @{SSKJLocalized(@"开户支行", nil):SSKJLocalized(@"请输入支行名", nil)},
                                 @{SSKJLocalized(@"开户银行卡", nil):SSKJLocalized(@"请输入银行卡号", nil)},
                                 @{SSKJLocalized(@"安全密码", nil):SSKJLocalized(@"请输入安全密码", nil)}];
            if ([_addType isEqualToString:@"edit"]) {
                
                self.dataArr = @[
                                 @{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},
                                 @{SSKJLocalized(@"开户银行", nil):dataData.bank},
                                 @{SSKJLocalized(@"开户支行", nil):dataData.branch},
                                 @{SSKJLocalized(@"开户银行卡", nil):dataData.number},
                                 @{SSKJLocalized(@"安全密码", nil):SSKJLocalized(@"请输入安全密码", nil)}];
                [[ManagerSocket sharedManager].dataDic setObject:dataData.bank?:@"" forKey:@"bank"];
                [[ManagerSocket sharedManager].dataDic setObject:dataData.branch?:@"" forKey:@"branch"];
                [[ManagerSocket sharedManager].dataDic setObject:dataData.number?:@"" forKey:@"bank_car"];

            }
            
        }
            break;
        case 4:{
            NSString *str = [NSString stringWithFormat:@"Paypal%@",SSKJLocalized(@"账户", nil)];

            self.dataArr = @[
                                 @{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},
                                 @{str:SSKJLocalized(@"请输入您的", nil)},
                                 @{SSKJLocalized(@"安全密码", nil):SSKJLocalized(@"请输入安全密码", nil)}];
            if ([_addType isEqualToString:@"edit"]) {
                self.dataArr = @[
                                 @{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},
                                 @{str:dataData.number?:@""},
                                 @{SSKJLocalized(@"安全密码", nil):SSKJLocalized(@"请输入安全密码", nil)}];
                [[ManagerSocket sharedManager].dataDic setObject:dataData.number?:@"" forKey:@"Paypal"];

            }
        }
            break;
        default:
            break;
    }
    [self.showTableView reloadData];
}
@end
