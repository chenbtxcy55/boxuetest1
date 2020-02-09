//
//  SKMyChargeVC.m
//  SSKJ
//
//  Created by 孙 on 2019/7/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SKMyChargeVC.h"
#import "SKMyCharge_RecordVC.h"
#import "ETF_Default_ActionsheetView.h"

@interface SKMyChargeVC ()

@property(nonatomic,strong)UIScrollView * myScrollView;

@property(nonatomic,strong)NSDictionary * myDataDic;

@property(nonatomic,strong)UIImageView * qrCodeImageView;


@property(nonatomic,strong)UILabel * showTile;

@property(nonatomic,strong)UILabel * adressLab;

@property(nonatomic,strong)UILabel * tipLab;


@end

@implementation SKMyChargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"充币", nil);
//     [self addRightNavgationItemWithImage:[UIImage imageNamed:@"cbjl_icon"]];
    
    [self initView];
    
}

//-(void)rigthBtnAction:(id)sender
//{
//    SKMyCharge_RecordVC * myCharge_RecordVC = [SKMyCharge_RecordVC new];
//
//    [self.navigationController pushViewController:myCharge_RecordVC animated:YES];
//
//
//}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    
    [self requestList];
    
//    [self requestData];
    
}
-(void)initView
{
    
    [self.view addSubview:self.myScrollView];

    UIView *style = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, ScreenWidth, 50)];
    style.backgroundColor = kBgColor353750;
    [self.view addSubview:style];
    
    
    UILabel * showTile = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 100, 50)];
    showTile.textColor = kMainTextColor;
    showTile.font = systemMediumFont(15);
    showTile.adjustsFontSizeToFitWidth = YES;
    showTile.textAlignment = NSTextAlignmentLeft;
    showTile.text = SSKJLocalized(@"选择币种", nil);
    
    [style addSubview:showTile];
    
    {
        UILabel * showTile = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth- ScaleW(16)-ScaleW(80)-ScaleW(6)-ScaleW(10), 0, ScaleW(80), ScaleW(50))];
        showTile.textColor = kMainWihteColor;
        showTile.font = systemMediumFont(15);
        //        showTile.adjustsFontSizeToFitWidth = YES;
        showTile.textAlignment = NSTextAlignmentRight;
        showTile.text = self.coinStr;
        self.showTile = showTile;
        
        //        showTile.userInteractionEnabled = YES;
        [style addSubview:showTile];
        UITapGestureRecognizer * tapGesture =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBiTypeEvent:)];
        [style addGestureRecognizer:tapGesture];
        
        
    }
    
    UIImageView * jiaoImageView =[[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - ScaleW(6) -ScaleW(16), (ScaleW(50)-ScaleW(10))/2, ScaleW(6), ScaleW(10))];
    jiaoImageView.image = [UIImage imageNamed:@"more_icon"];
    
    [style addSubview:jiaoImageView];
    
    {
        UIView *style = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(51), 54, ScreenWidth-ScaleW(51)*2, 0)];
        style.layer.cornerRadius = 10;
        style.backgroundColor = kBgColor353750;
        style.alpha = 1;
        
        [self.myScrollView addSubview:style];
        
        UIImageView * qrCodeImageView =[[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(80), 45,style.width- ScaleW(80)*2, style.width- ScaleW(80)*2)];
        

        [qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ProductBaseServer,self.myDataDic[@"qrc"]]]];
        qrCodeImageView.userInteractionEnabled = YES;
        
        [style addSubview:qrCodeImageView];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        
        [qrCodeImageView addGestureRecognizer:longPress];
        
        self.qrCodeImageView = qrCodeImageView;
        
        
        
        UILabel * showTile = [[UILabel alloc]initWithFrame:CGRectMake(0, qrCodeImageView.bottom +18, style.width, 15)];
        showTile.textColor = kMainTextColor;
        showTile.font = systemMediumFont(14);
        showTile.adjustsFontSizeToFitWidth = YES;
        showTile.textAlignment = NSTextAlignmentCenter;
        showTile.text = SSKJLocalized(@"长按保存二维码", nil);
        
        [style addSubview:showTile];
        
        //Base style for 分割线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(12), showTile.bottom +14, style.width - ScaleW(12)*2, 1)];
        lineView.backgroundColor = kLineGrayColor;
        
        [style addSubview:lineView];
        
        
   
        
        UILabel * adressLab = [[UILabel alloc]initWithFrame:CGRectMake(10, lineView.bottom +24, style.width -20, 15)];
        adressLab.textColor = [UIColor colorWithRed:142.0f/255.0f green:148.0f/255.0f blue:163.0f/255.0f alpha:1.0f];
        adressLab.font = systemMediumFont(14);
        adressLab.adjustsFontSizeToFitWidth = YES;
        adressLab.textAlignment = NSTextAlignmentCenter;
        adressLab.text = self.myDataDic[@"url"];
        
        [style addSubview:adressLab];
        
        self.adressLab = adressLab;
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(ScaleW(60), adressLab.bottom +22 , style.width - ScaleW(64)*2, 40);
        
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        
        [button addTarget:self action:@selector(copyEvent:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:SSKJLocalized(@"复制地址", nil) forState:UIControlStateNormal];
        button.titleLabel.font = systemMediumFont(14);
        [button setTitleColor:kMainTextColor forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
        button.backgroundColor = kTheMeColor;

        [style addSubview:button];
        
        style.height = button.bottom +41;
        
        {
            UILabel * showTile = [[UILabel alloc]initWithFrame:CGRectMake(style.left, style.bottom +27, style.width, 50)];
            showTile.textColor = UIColorFromRGB(0x888d9d);
            showTile.font = systemFont(ScaleW(14));
            showTile.adjustsFontSizeToFitWidth = YES;
            showTile.textAlignment = NSTextAlignmentLeft;
//            showTile.text = [NSString stringWithFormat:@"%@%@%@",SSKJLocalized(@"请勿向上述地址充值任何", nil),[self.coinStr uppercaseString],SSKJLocalized(@"非资产，否则资产将不可找回。", nil)];
            self.tipLab = showTile;
            
            [self.myScrollView addSubview:showTile];
            
            self.myScrollView.contentSize = CGSizeMake(ScreenWidth, showTile.bottom +100);
        }
        
    }
    
   
    
}

-(void)changeBiTypeEvent:(UIGestureRecognizer *)gesture
{
    
    if (self.coinArray.count>0) {
        NSMutableArray *arr =[NSMutableArray array];
        for (int i = 0; i<self.coinArray.count; i++) {
            
            [arr addObject:[self.coinArray[i] uppercaseString]];
            
        }
        
        WS(weakSelf);
        [ETF_Default_ActionsheetView showWithItems:arr title:SSKJLocalized(@"请选择充币的币种", nil) selectedIndexBlock:^(NSInteger selectIndex) {
            weakSelf.showTile.text = arr[selectIndex];
            weakSelf.coinStr = weakSelf.coinArray[selectIndex];
            weakSelf.tipLab.text = [NSString stringWithFormat:@"%@%@%@",SSKJLocalized(@"请勿向上述地址充值任何", nil),[weakSelf.coinStr uppercaseString],SSKJLocalized(@"非资产，否则资产将不可找回。", nil)];
            [weakSelf requestData:weakSelf.coinStr];
            
        } cancleBlock:^{
            
        }];
    }
   
    
}

-(void)copyEvent:(UIButton*)sender
{
    
    if ([self.myDataDic[@"address"]length] == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"获取失败", nil)];
        return;
    }
    
    [MBProgressHUD showError:SSKJLocalized(@"复制成功", nil)];
    UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string=self.myDataDic[@"address"];
}
// 长按图片的时候就会触发长按手势
- (void)longPress:(UILongPressGestureRecognizer *)longPress
{
    // 一般开发中,长按操作只会做一次
    // 假设在一开始长按的时候就做一次操作
    UIImage *img1 = self.qrCodeImageView.image;
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        UIImageWriteToSavedPhotosAlbum(img1, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
    }
   
}
// 需要实现下面的方法,或者传入三个参数即可
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [MBProgressHUD showError:SSKJLocalized(@"保存失败", nil)];
    } else {
        [MBProgressHUD showError:SSKJLocalized(@"保存至相册", nil)];
        return;
    }
}
-(UIScrollView *)myScrollView
{
    if (nil == _myScrollView) {
        _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, ScaleW(50), ScreenWidth, ScreenHeight - Height_NavBar- ScaleW(50))];
        _myScrollView.backgroundColor = kMainColor;
        
    }
    return _myScrollView;
}

-(void)requestList
{
    
    WS(weakSelf);
    
    //    NSString *language = [[SSKJLocalized sharedInstance]currentLanguage];
    //    NSString *type;
    //    if ([language isEqualToString:@"en"]) {
    //        type = @"2";
    //    }else{
    //        type = @"1";
    //    }
    NSDictionary *params = @{@"type":@"1"};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:JB_get_recharge_coin_list_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         
         if (network_Model.status.integerValue == SUCCESSED)
         {
             
             for (int i = 0; i<[network_Model.data count]; i++) {
                 
                 NSDictionary *dic = network_Model.data[i];
                 
                 [weakSelf.coinArray addObject: [dic[@"code"] componentsSeparatedByString:@"_"].firstObject] ;
             }
             
//             if (!weakSelf.coinStr) {
//
//
//             }
             weakSelf.coinStr = weakSelf.coinArray.firstObject;
             weakSelf.showTile.text = [weakSelf.coinStr uppercaseString];
             [weakSelf requestData:weakSelf.coinStr];
             
              weakSelf.tipLab.text = [NSString stringWithFormat:@"%@%@%@",SSKJLocalized(@"请勿向上述地址充值任何", nil),[weakSelf.coinStr uppercaseString],SSKJLocalized(@"非资产，否则资产将不可找回。", nil)];
             
         }else{
             [MBProgressHUD showError:network_Model.msg];
         }
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         
         [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
     }];
}

-(void)requestData:(NSString *)codeType
{
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_conin_recharge_Api RequestType:RequestTypeGet Parameters:@{@"wall_type":codeType} Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        
        if (net_model.status.integerValue == 200) {
            
    
            weakSelf.myDataDic = net_model.data;
            
            [weakSelf.qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:net_model.data[@"qrc"]]];
            
            weakSelf.adressLab.text = net_model.data[@"address"];
            
          
        }else{
            
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
    
}

-(NSMutableArray *)coinArray
{
    if (_coinArray == nil) {
        
        _coinArray = [NSMutableArray array];
    }
    
    return _coinArray;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
