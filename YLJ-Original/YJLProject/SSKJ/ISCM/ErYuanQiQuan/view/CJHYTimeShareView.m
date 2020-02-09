


#import "CJHYTimeShareView.h"
#import "UIImageView+WebCache.h"
@interface CJHYTimeShareView()

@property (nonatomic, strong) UIImageView *contenImg;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *derectionLabel;

@property (nonatomic, strong) UILabel *amountLabel;

@property (nonatomic, strong) UILabel *mbhyNameLabel;

@property (nonatomic, strong) UILabel *mbhyLabel;

@property (nonatomic, strong) UILabel *kcNameLabel;

@property (nonatomic, strong) UILabel *kcLabel;

@property (nonatomic, strong) UILabel *pcNameLabel;

@property (nonatomic, strong) UILabel *pcLabel;

@property (nonatomic, assign) CGFloat mbhyWidth;

@property (nonatomic, strong) UILabel *appName;

@property (nonatomic, strong) UILabel *appRight;

@property (nonatomic, strong) UIView *twoCodeView;

@property (nonatomic, strong) UIImageView *twoCodeImg;
//项目图标
@property (nonatomic, strong) UIImageView *appImg;


@end

@implementation CJHYTimeShareView

-(instancetype)init
{
    if (self = [super init])
    {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(500));
        self.mbhyWidth = (ScreenWidth - ScaleW(34))/3.f;
        [self addSubview:self.contenImg];
        [self addSubview:self.titleLabel];
        [self addSubview:self.derectionLabel];
        [self addSubview:self.amountLabel];
        [self addSubview:self.mbhyNameLabel];
        [self addSubview:self.mbhyLabel];
        [self addSubview:self.kcNameLabel];
        [self addSubview:self.kcLabel];
        [self addSubview:self.pcNameLabel];
        [self addSubview:self.pcLabel];
        [self addSubview:self.appName];
        [self addSubview:self.appRight];
        [self addSubview:self.twoCodeView];
        [self addSubview:self.appImg];
        self.height = self.contenImg.bottom + ScaleW(10);
    }
    return self;
}

-(UIImageView *)contenImg
{
    if (!_contenImg) {
        _contenImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(667))];
        
        //fenxiang-yingwen
        //fenxiang-hanwen
        //fenxiang-fanti
        
        NSString *Imgstring = @"pc_hb";
        if ([[[SSKJLocalized sharedInstance] currentLanguage] isEqualToString:@"zh-Hans"]) {
            Imgstring = @"pc_hb";
        }
        if ([[[SSKJLocalized sharedInstance] currentLanguage] isEqualToString:@"zh-Hant"]) {
            Imgstring = @"fenxiang-fanti";
        }
        if ([[[SSKJLocalized sharedInstance] currentLanguage] isEqualToString:@"en"]) {
            Imgstring = @"fenxiang-yingwen";
        }
        if ([[[SSKJLocalized sharedInstance] currentLanguage] isEqualToString:@"ko"]) {
            Imgstring = @"fenxiang-hanwen";
        }
        _contenImg.image = [UIImage imageNamed:Imgstring];
        
    }
    return _contenImg;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"盈利金额", nil) font:systemFont(ScaleW(20)) textColor:kTextBlackColor frame:CGRectMake(ScaleW(128), ScaleW(375), ScaleW(90), ScaleW(20)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _titleLabel;
}

-(UILabel *)derectionLabel

{
    if (!_derectionLabel) {
        _derectionLabel = [WLTools allocLabel:SSKJLocalized(@"买涨", nil) font:systemFont(ScaleW(12)) textColor:kMainWihteColor frame:CGRectMake(_titleLabel.right, _titleLabel.top, ScaleW(38), ScaleW(20)) textAlignment:(NSTextAlignmentCenter)];
        [_derectionLabel setCornerRadius:ScaleW(5)];
        
        
    }
    return _derectionLabel;
}

-(UILabel *)amountLabel
{
    if (!_amountLabel) {
        _amountLabel = [WLTools allocLabel:@"0.0USDT" font:systemFont(ScaleW(35)) textColor:kTextGreenColor frame:CGRectMake(0, ScaleW(25) + _titleLabel.bottom, ScreenWidth, ScaleW(35)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _amountLabel;
}

-(UILabel *)mbhyNameLabel
{
    if (!_mbhyNameLabel) {
        _mbhyNameLabel = [WLTools allocLabel:SSKJLocalized(@"周期合约", nil) font:systemFont(ScaleW(12)) textColor:kTextGreenColor frame:CGRectMake(ScaleW(17), ScaleW(51) + _amountLabel.bottom, self.mbhyWidth, ScaleW(12)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _mbhyNameLabel;
}
-(UILabel *)mbhyLabel
{
    if (!_mbhyLabel) {
        _mbhyLabel = [WLTools allocLabel:SSKJLocalized(@"EOS/USDT", nil) font:systemFont(ScaleW(12)) textColor:kTextBlackColor frame:CGRectMake(ScaleW(17), ScaleW(8) + _mbhyNameLabel.bottom, self.mbhyWidth, ScaleW(18)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _mbhyLabel;
}
-(UILabel *)kcNameLabel
{
    if (!_kcNameLabel) {
        _kcNameLabel = [WLTools allocLabel:SSKJLocalized(@"周期", nil) font:systemFont(ScaleW(12)) textColor:kTextGreenColor frame:CGRectMake(_mbhyNameLabel.right, ScaleW(51) + _amountLabel.bottom, self.mbhyWidth, ScaleW(12)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _kcNameLabel;
}
-(UILabel *)kcLabel
{
    if (!_kcLabel) {
        _kcLabel = [WLTools allocLabel:SSKJLocalized(@"$0.000", nil) font:systemFont(ScaleW(12)) textColor:kTextBlackColor frame:CGRectMake(_kcNameLabel.left, ScaleW(8) + _mbhyNameLabel.bottom, self.mbhyWidth, ScaleW(18)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _kcLabel;
}
-(UILabel *)pcNameLabel
{
    if (!_pcNameLabel) {
        _pcNameLabel = [WLTools allocLabel:SSKJLocalized(@"平仓价格", nil) font:systemFont(ScaleW(12)) textColor:kTextGreenColor frame:CGRectMake(_kcNameLabel.right, ScaleW(51) + _amountLabel.bottom, self.mbhyWidth, ScaleW(12)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _pcNameLabel;
}
-(UILabel *)pcLabel
{
    if (!_pcLabel) {
        _pcLabel = [WLTools allocLabel:SSKJLocalized(@"$0.000", nil) font:systemFont(ScaleW(12)) textColor:kTextBlackColor frame:CGRectMake(_pcNameLabel.left, ScaleW(8) + _mbhyNameLabel.bottom, self.mbhyWidth, ScaleW(18)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _pcLabel;
}

-(UILabel *)appName
{
    if (!_appName) {
        _appName = [WLTools allocLabel:SSKJLocalized(@"|超级合约", nil) font:systemFont(ScaleW(13)) textColor:kTextBlueColor frame:CGRectMake(ScaleW(87), ScaleW(611),ScaleW(300), ScaleW(18)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _appName;
}

-(UILabel *)appRight
{
    if (!_appRight) {
        _appRight = [WLTools allocLabel:SSKJLocalized(@"· 最终解释权归平台所有", nil) font:systemFont(ScaleW(13)) textColor:kTextBlackColor frame:CGRectMake(ScaleW(17), _appName.bottom + ScaleW(10),ScaleW(300), ScaleW(18)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _appRight;
}
-(UIView *)twoCodeView
{
    if (!_twoCodeView) {
        _twoCodeView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(290), ScaleW(590), ScaleW(65), ScaleW(65))];
        _twoCodeView.backgroundColor = kMainWihteColor;
        
        [_twoCodeView addSubview:self.twoCodeImg];
        
    }
    return _twoCodeView;
}
-(UIImageView *)twoCodeImg
{
    if (!_twoCodeImg) {
        _twoCodeImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(5), ScaleW(5), ScaleW(55), ScaleW(55))];
        _twoCodeImg.backgroundColor = [UIColor blueColor];
    }
    return _twoCodeImg;
}
-(UIImageView *)appImg
{
    if (!_appImg) {
        _appImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(17), ScaleW(18) + _twoCodeView.top, ScaleW(66), ScaleW(27))];
        _appImg.image = [UIImage imageNamed:@"LOGO_bule"];
    }
    return _appImg;
}
-(void)setModel:(CJHYShareModel *)model
{
    _model = model;
    
    self.mbhyLabel.text = _model.pname;
    
    self.kcLabel.text = [NSString stringWithFormat:@"%@S",_model.aim_point];
    
//    NSString *price = [WLTools noroundingStringWith:_model.sellprice.doubleValue withPriceCode:model.ptype];
//    self.pcLabel.text = price;
    NSString *string = [WLTools noroundingStringWith:model.income.doubleValue afterPointNumber:6];
    self.amountLabel.text = [NSString stringWithFormat:@"%@%@",string,_model.ptype];
    // [self creatCIQRCodeImage:_model.url];
    
    [self.twoCodeImg sd_setImageWithURL:[NSURL URLWithString:_model.qrc]];
    UIColor *color =  GREEN_HEX_COLOR;
    NSString *title =  SSKJLocalized(@"买涨", nil);
    if (_model.type.integerValue == 1) {
        color =  GREEN_HEX_COLOR;
        title = SSKJLocalized(@"买涨", nil);
    }
    if (_model.type.integerValue == 2) {
        color =  RED_HEX_COLOR;
        title = SSKJLocalized(@"买跌", nil);
    }
    self.derectionLabel.backgroundColor = color;
    
    self.derectionLabel.text = title;
}

- (void)creatCIQRCodeImage:(NSString *)url
{
    // 1.创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认设置
    [filter setDefaults];
    // 3. 给过滤器添加数据
    
    NSString *dataString = url;
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

@end
