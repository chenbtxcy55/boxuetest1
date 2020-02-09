//
//  Mine_SeptorViewHeaderView.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/12.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Mine_SeptorViewHeaderView.h"
@interface Mine_SeptorViewHeaderView()


@property (nonatomic, strong) UIImageView *mainImgView;

@property (nonatomic, strong) UIImageView *leftImg;

@property (nonatomic, strong) UIImageView *rightImg;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *coopyBtn;

@property (nonatomic, strong) UILabel *codelabel;

@property (nonatomic, strong) UIImageView *septorImg;

@property (nonatomic, strong) UIImageView *teamImg;

@property (nonatomic, strong) UILabel *teamLabel;

@property (nonatomic, strong) UIView *twoCodeView;

@property (nonatomic, strong) UIImageView *twoCodeImg;

@property (nonatomic, strong) UILabel *desceplabel;

@property (nonatomic, strong) UILabel *rulsLabel;

@property (nonatomic, strong) UILabel *detailRules;

@property (nonatomic, strong) UIImageView *myInviteCode;



@end

@implementation Mine_SeptorViewHeaderView

-(instancetype)init
{
    if (self = [super init])
    {
        [self viewConfig];
    }
    return self;
}

-(void)viewConfig
{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar);
    self.backgroundColor = kWhiteBlueColor;
    self.height = ScreenHeight - Height_NavBar;
    
    
    [self addSubview:self.mainImgView];
    
    [self addSubview:self.rulsLabel];
    
    [self addSubview:self.detailRules];
    
}


-(UIImageView *)mainImgView
{
    if (!_mainImgView) {
        _mainImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
//
        if ([[[SSKJLocalized sharedInstance]currentLanguage] containsString:@"en"]) {
            _mainImgView.image = [UIImage imageNamed:@"Inver_BacImg_en"];

        }else{
            _mainImgView.image = [UIImage imageNamed:@"Inver_BacImg"];

        }
        _mainImgView.userInteractionEnabled = YES;
        [_mainImgView addSubview:self.leftImg];
        [_mainImgView addSubview:self.titleLabel];
        [_mainImgView addSubview:self.rightImg];
        [_mainImgView addSubview:self.myInviteCode];
        
        [_mainImgView addSubview:self.codelabel];
        [_mainImgView addSubview:self.coopyBtn];
        [_mainImgView addSubview:self.teamImg];
        [_mainImgView addSubview:self.teamLabel];
        [_mainImgView addSubview:self.septorImg];
        [_mainImgView addSubview:self.twoCodeView];
        
        [_mainImgView addSubview:self.desceplabel];
        

        
        
    }
    return _mainImgView;
}

-(UIImageView *)leftImg

{
    if (!_leftImg) {
        _leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(70), ScaleW(30), ScaleW(50), ScaleW(4))];
//        _leftImg.image = [UIImage imageNamed:@"septorLeft"];
        
    }
    return _leftImg;
}
-(UIImageView*)myInviteCode
{
    if (_myInviteCode == nil) {
        
        _myInviteCode = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(70), ScaleW(25), _mainImgView.width -ScaleW(70)*2, ScaleW(14))];
        
        _myInviteCode.image =[UIImage imageNamed:@"my_InviteCode"];
    }
    
    return _myInviteCode;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(_leftImg.right, 0, ScaleW(120), ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
        _titleLabel.centerY = _leftImg.centerY;
    }
    return _titleLabel;
}


-(UIImageView *)rightImg
{
    if (!_rightImg) {
        _rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.right, _leftImg.top, _leftImg.width, _leftImg.height)];
//        _rightImg.image = [UIImage imageNamed:@"septorRight"];
        
    }
    return _rightImg;
}
-(UILabel *)codelabel
{
    if (!_codelabel) {
        _codelabel = [WLTools allocLabel:@"xxxxx" font:systemBoldFont(ScaleW(20)) textColor:kMainTextColor frame:CGRectMake(0, _titleLabel.bottom + ScaleW(20), _mainImgView.width, ScaleW(20)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _codelabel;
}

-(UIButton *)coopyBtn
{
    if (!_coopyBtn) {
        _coopyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _coopyBtn.frame = CGRectMake(ScaleW(143), ScaleW(20) + _codelabel.bottom, ScaleW(70), ScaleW(24));
        _coopyBtn.layer.cornerRadius = ScaleW(12);
        [_coopyBtn setBorderWithWidth:1 andColor:kMainBlueColor];
        [_coopyBtn btn:_coopyBtn font:ScaleW(12) textColor:kMainBlueColor text:@"一键复制" image:nil sel:@selector(coopyBtnAction:) taget:self];
        
    }
    return _coopyBtn;
}

-(UIImageView *)teamImg
{
    if (!_teamImg) {
        _teamImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(89), ScaleW(42) +_coopyBtn.bottom, ScaleW(17), ScaleW(14))];
        _teamImg.image = [UIImage imageNamed:@"copretionicon"];
        
    }
    return _teamImg;
}

-(UILabel *)teamLabel
{
    if (!_teamLabel) {
        
        _teamLabel = [WLTools allocLabel:@"我的团队人数 ：0" font:systemFont(ScaleW(15)) textColor:kMainTextColor frame:CGRectMake(ScaleW(10) + _teamImg.right, 0, ScaleW(200), ScaleW(20)) textAlignment:(NSTextAlignmentLeft)];
        _teamLabel.centerY = _teamImg.centerY;
        UIImageView * teamImageView =[[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(10) + _teamImg.right-ScaleW(27), 0, ScaleW(17), ScaleW(14))];
        teamImageView.centerY = _teamImg.centerY ;

        teamImageView.image = [UIImage imageNamed:@"my_teamImageView"];
//        teamImageView.contentMode =
        [_mainImgView addSubview:teamImageView];
        
        
        
    }
    return _teamLabel;
}
-(UIImageView *)septorImg
{
    if (!_septorImg) {
        _septorImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScaleW(40) + _teamLabel.bottom, ScaleW(295), ScaleW(1))];
        _septorImg.centerX = _mainImgView.width/2.f;
        _septorImg.image = [UIImage imageNamed:@"septor_img"];
    }
    return _septorImg;
}
-(UIView *)twoCodeView
{
    if (!_twoCodeView) {
        _twoCodeView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(119), ScaleW(86) + _teamLabel.bottom, ScaleW(137), ScaleW(138))];
        _twoCodeView.layer.cornerRadius = ScaleW(5);
        [_twoCodeView setShadowView:_twoCodeView];
        [_twoCodeView addSubview:self.twoCodeImg];
        _twoCodeView.centerX = _mainImgView.width/2.f;
        _twoCodeView.backgroundColor = kMainWihteColor;
        
    }
    return _twoCodeView;
}

-(UILabel *)rulsLabel{
    if (!_rulsLabel) {
        _rulsLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(20), ScaleW(29) + _mainImgView.bottom, ScaleW(70), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
        
       UIImageView * rulsImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth -ScaleW(149))/2, ScaleW(29) + _mainImgView.bottom, ScaleW(149), ScaleW(15))];
        
        rulsImageView.image =[UIImage imageNamed:@"rulsImageView_my"];
        
        [self addSubview:rulsImageView];
    }
    return _rulsLabel;
}

-(UILabel *)detailRules{
    if (!_detailRules) {
        _detailRules = [WLTools allocLabel:@"--" font:systemFont(ScaleW(14)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(20), ScaleW(15) + _rulsLabel.bottom,ScreenWidth - ScaleW(40), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
       
    }
    return _detailRules;
}
-(void)logAction:(UILongPressGestureRecognizer *)log
{
    UIImage *img1 = _twoCodeImg.image;
    if (log.state == UIGestureRecognizerStateBegan) {

         UIImageWriteToSavedPhotosAlbum(img1, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
    }
   
}
-(UIImageView *)twoCodeImg
{
    if (!_twoCodeImg) {
        _twoCodeImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(10), ScaleW(10), ScaleW(117), ScaleW(117))];
        _twoCodeImg.backgroundColor = [UIColor purpleColor];
        _twoCodeImg.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *log = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(logAction:)];
        [_twoCodeImg addGestureRecognizer:log];
    }
    return _twoCodeImg;
}
-(UILabel *)desceplabel
{
    if (!_desceplabel) {
        _desceplabel = [WLTools allocLabel:@"长按保存二维码" font:systemFont(ScaleW(15)) textColor:kMainTextColor frame:CGRectMake(0, ScaleW(14) + _twoCodeView.bottom, ScaleW(120), ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
        _desceplabel.centerX = _twoCodeView.centerX;
    }
    return _desceplabel;
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    _codelabel.text = _dataDic[@"tgno"];
    
    _teamLabel.text = [NSString stringWithFormat:@"我的团队人数：%@",_dataDic[@"count"]];
    
    
    _detailRules.text = [WLTools filterHTML: _dataDic[@"role"]];
    _detailRules.numberOfLines = 0;
    [_detailRules sizeToFit ];
    self.height = _detailRules.bottom + ScaleW(25);
    
    [self.twoCodeImg sd_setImageWithURL:[NSURL URLWithString:_dataDic[@"qrc"]]];
//    [self creatCIQRCodeImage:_dataDic];
}
-(void)coopyBtnAction:(UIButton *)sender
{
    if (self.codelabel.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"获取失败", nil)];
        return;
    }
    
    [MBProgressHUD showSuccess:SSKJLocalized(@"复制成功", nil)];
    UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string=self.codelabel.text;
}
- (void)creatCIQRCodeImage:(NSDictionary *)dic
{
    // 1.创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认设置
    [filter setDefaults];
    // 3. 给过滤器添加数据
    
    NSString *dataString = dic[@"url"];
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
