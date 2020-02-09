//
//  Homlist_CollectionViewCell.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/13.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Homlist_CollectionViewCell.h"
@interface Homlist_CollectionViewCell()



@end

@implementation Homlist_CollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig
{
    [self.contentView addSubview:self.headerImg];
    [self.contentView addSubview:self.bottomLabel];
    self.backgroundColor = kNavBGColor;
}

-(UIImageView *)headerImg
{
    if (!_headerImg) {
        _headerImg= [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(10), ScaleW(8.5), ScaleW(43), ScaleW(43))];
        _headerImg.centerX = self.width/2.f;
//        _headerImg.image = [UIImage imageNamed:@"图层11"];
        [_headerImg setCornerRadius:ScaleW(43/2.f)];
        
        
    }
    return _headerImg;
}
-(UILabel *)bottomLabel
{
    if (!_bottomLabel) {
        _bottomLabel = [WLTools allocLabel:@"海外" font:systemFont(ScaleW(12)) textColor:kMainTextColor frame:CGRectMake(0, ScaleW(7) + _headerImg.bottom, self.width, ScaleW(12)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _bottomLabel;
}


@end
