//
//  HeBi_ShowQRCode_AlertView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/19.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_ShowQRCode_AlertView.h"

@interface HeBi_ShowQRCode_AlertView ()
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation HeBi_ShowQRCode_AlertView

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self addSubview:self.alertView];
        [self.alertView addSubview:self.imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


-(UIView *)alertView
{
    if (nil == _alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(268), ScaleW(268))];
        _alertView.center = CGPointMake(self.width / 2, self.height / 2);
        _alertView.backgroundColor = kMainWihteColor;
        _alertView.layer.cornerRadius = 4.0f;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressEvent:)];
        [_alertView addGestureRecognizer:longPress];
    }
    return _alertView;
}

- (UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(204), ScaleW(204))];
        _imageView.center = CGPointMake(self.alertView.width / 2, self.alertView.height / 2);
    }
    return _imageView;
    
}

+(void)showWithImageURL:(NSString *)url
{
    HeBi_ShowQRCode_AlertView *alertView = [[HeBi_ShowQRCode_AlertView alloc]init];
    
    [alertView.imageView sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:url]]];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:alertView];
}

-(void)hide
{
    [self removeFromSuperview];
}


-(void)longPressEvent:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
    }
   

}


// 需要实现下面的方法,或者传入三个参数即可
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [MBProgressHUD showError:SSKJLocalized(@"保存失败", nil) ];
    } else {
        [MBProgressHUD showSuccess:SSKJLocalized(@"保存成功",nil)];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
