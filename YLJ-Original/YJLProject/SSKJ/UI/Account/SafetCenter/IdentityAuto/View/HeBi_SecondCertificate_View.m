//
//  HeBi_SecondCertificate_View.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_SecondCertificate_View.h"

@interface HeBi_SecondCertificate_View ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@end

@implementation HeBi_SecondCertificate_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kSubBackgroundColor;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.messageLabel];
    
    self.height = self.messageLabel.bottom + ScaleW(25);
    
}


-(UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScaleW(30), ScaleW(200), ScaleW(127))];
        _imageView.centerX = self.width / 2;
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectPhotoEvent)];
        [_imageView addGestureRecognizer:tap];
    }
    return _imageView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        
        _titleLabel = [WLTools allocLabel:@"" font:systemThinFont(ScaleW(14)) textColor:[UIColor colorWithHexStringToColor:@"b2b9e7"] frame:CGRectMake(ScaleW(15), self.imageView.bottom + ScaleW(20), ScreenWidth - ScaleW(30), ScaleW(14)) textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(UILabel *)messageLabel
{
    if (nil == _messageLabel) {
        
        _messageLabel = [WLTools allocLabel:@"" font:systemThinFont(ScaleW(14)) textColor:[UIColor colorWithHexStringToColor:@"6b6fb9"] frame:CGRectMake(ScaleW(15), self.titleLabel.bottom + ScaleW(15), ScreenWidth - ScaleW(30), ScaleW(52)) textAlignment:NSTextAlignmentLeft];
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

-(void)setPhotoType:(PhotoType)photoType
{
    _photoType = photoType;
    
    NSString *imageName;
    NSString *title;
    NSString *message;
    
    if (photoType == PhotoTypeFront) {
        imageName = @"idcard_front_img";
        title = SSKJLocalized(@"请上传身份证正面", nil);
        message = SSKJLocalized(@"身份证正面确保无水印无污渍，身份信息清晰，非文字反向照片，请勿进行PS处理。", nil);
    }else if (photoType == PhotoTypeBack){
        imageName = @"idcard_back_img";
        title = SSKJLocalized(@"请上传身份证背面", nil);
        message = SSKJLocalized(@"身份证背面确保无水印无污渍，身份信息清晰，非文字反向照片，请勿进行PS处理。", nil);
    }else{
        imageName = @"idcard_hand_img";
        title = SSKJLocalized(@"请上传手持身份证照片", nil);
        message = SSKJLocalized(@"需要您本人单手手持您的身份证，另一只手持有一种有您写的OTC和当天日期的白纸，确保身份证和白纸在您胸前，不遮挡您的脸部，并且身份证和白纸上的信息清晰可见。", nil);
    }
    
    self.imageView.image = [UIImage imageNamed:imageName];
    self.titleLabel.text = title;
    self.messageLabel.text = message;
    
    CGFloat height = [message boundingRectWithSize:CGSizeMake(self.messageLabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.messageLabel.font} context:nil].size.height;
    
    self.messageLabel.height = height;
    
    if (photoType == PhotoTypeBack) {
        self.height = self.messageLabel.bottom + ScaleW(25);
    }else{
        self.height = self.messageLabel.bottom + ScaleW(5);
    }
}

-(void)selectPhotoEvent
{
    if (self.selectPhotoBlock) {
        self.selectPhotoBlock(self.photoType);
    }
}


-(void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

-(void)setImgURL:(NSString *)imgURL
{
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgURL]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
