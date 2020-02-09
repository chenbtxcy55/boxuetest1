//
//  Money_getmoney_ViewController.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/5.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Money_getmoney_ViewController.h"


@interface Money_getmoney_ViewController ()
@property (nonatomic, strong) UIImageView  *twoCodeImg;
@property (nonatomic, strong) UILabel *decrpLabel;
@property (nonatomic, strong) NSDictionary *dataDic;
@end

@implementation Money_getmoney_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewConfig];
    self.title = _isHomepage?SSKJLocalized(@"提币地址", nil):SSKJLocalized(@"收币地址", nil);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self requstRequstiruet];
    [self creatCIQRCodeImage:_addressString];
}
-(void)viewConfig
{
    [self.view addSubview:self.twoCodeImg];
    [self.view addSubview:self.decrpLabel];
}

-(UIImageView *)twoCodeImg
{
    if (!_twoCodeImg) {
        _twoCodeImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(112), ScaleW(82), ScaleW(150), ScaleW(150))];
        _twoCodeImg.backgroundColor = [UIColor redColor];
        
        UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
        
        _twoCodeImg.userInteractionEnabled = YES;
        [_twoCodeImg addGestureRecognizer:longPress];
    }
    return _twoCodeImg;
    
}
-(UILabel *)decrpLabel
{
    if (!_decrpLabel) {
        _decrpLabel = [[UILabel alloc]initWithFrame:CGRectMake(_twoCodeImg.left, _twoCodeImg.bottom, _twoCodeImg.width, ScaleW(55))];
        
        _decrpLabel.textAlignment = NSTextAlignmentCenter;
        
        [_decrpLabel label:_decrpLabel font:ScaleW(15) textColor:kMainTextColor text:SSKJLocalized(@"长按保存二维码", nil)];
        
        UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
        
        _decrpLabel.userInteractionEnabled = YES;
        [_decrpLabel addGestureRecognizer:longPress];
    }
    return _decrpLabel;
}

-(void)longPressAction:(UILongPressGestureRecognizer *)longPr
{
    UIImage *img1 = _twoCodeImg.image;
    if (longPr.state == UIGestureRecognizerStateBegan) {
        
        UIImageWriteToSavedPhotosAlbum(img1, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
    }
    
    return;
}
//AB_Shop_balance_account_qrc
-(void)requstRequstiruet
{
    //资产信息
    // [MBProgressHUD showHUDAddedTo:self animated:YES];
    //    {
    //        "qrc": "icc://account=384111",
   // "upic": "http://127.0.0.1:8088/Uploads/photo/2018-08-23/5b7e50a666f8c43261.jpg"
    //    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_balance_account_qrc RequestType:RequestTypeGet Parameters:@{} Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            self.dataDic = netWorkModel.data;
        }
        else
        {
           [MBProgressHUD showError:netWorkModel.msg];
        }
        //
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    
    [self creatCIQRCodeImage:[NSString stringWithFormat:@"AB:%@",[SSKJ_User_Tool sharedUserTool].userInfoModel.mobile]];
}

- (void)creatCIQRCodeImage:(NSString *)dic
{
    // 1.创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认设置
    [filter setDefaults];
    // 3. 给过滤器添加数据
    
    NSString *dataString = dic;
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    // 注意，这里的value必须是NSData类型
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 4. 生成二维码
    CIImage *outputImage = [filter outputImage];
    // 5. 显示二维码
    // 该方法生成的图片较模糊
    //    self.codeImg.image = [UIImage imageWithCIImage:outputImage];
    // 使用该方法生成高清图
    self.twoCodeImg.image = [self creatNonInterpolatedUIImageFormCIImage:outputImage withSize:self.twoCodeImg.width];
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 *
 *  @return 生成高清的UIImage
 */
- (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1. 创建bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
// 需要实现下面的方法,或者传入三个参数即可
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [MBProgressHUD showError:@"保存失败"];
    } else {
        [MBProgressHUD showError:@"保存至相册"];
        return;
    }
}
@end

