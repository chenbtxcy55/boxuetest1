//
//  LA_Main_BlockVew.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/7/8.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "LA_Main_BlockVew.h"

@interface LA_Main_BlockVew ()
{
    NSString *_imageName;
}


@end

@implementation LA_Main_BlockVew

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = kMainColor;
        _imageName = imageName;
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.subTitleLabel];
        
        self.imageView.image = [UIImage imageNamed:imageName];
        self.titleLabel.text = title;
        self.subTitleLabel.text = subTitle;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickEvent)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


-(UIImageView *)imageView
{
    if (nil == _imageView) {
        UIImage *image = [UIImage imageNamed:_imageName];
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.image = image;
    }
    return _imageView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemBoldFont(ScaleW(15)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(11), ScaleW(27), self.width -self.imageView.left- ScaleW(10), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
        _titleLabel.numberOfLines = 0;
//        _titleLabel.adjustsFontSizeToFitWidth = YES;
        
    }
    return _titleLabel;
}

-(UILabel *)subTitleLabel
{
    if (nil == _subTitleLabel) {
        _subTitleLabel = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemFont(ScaleW(11)) textColor:kMainWihteColor frame:CGRectMake(self.titleLabel.x, self.titleLabel.bottom + ScaleW(21), self.titleLabel.width, ScaleW(11)) textAlignment:NSTextAlignmentLeft];
        _subTitleLabel.numberOfLines = 1;
        _subTitleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _subTitleLabel;
}


-(void)clickEvent
{
    if (self.clickBlock) {
        self.clickBlock();
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
