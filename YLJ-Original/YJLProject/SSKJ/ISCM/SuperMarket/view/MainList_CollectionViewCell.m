//
//  MainList_CollectionViewCell.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/13.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "MainList_CollectionViewCell.h"
@interface MainList_CollectionViewCell()
@property (nonatomic, strong) UIImageView *headerImg;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *priceLabel; //可售价格

@property (nonatomic, strong) UILabel *payCountLabel;

@property (nonatomic, strong) UILabel *daiPriceLabel; //待售价格

@property (nonatomic, strong) UILabel *moreLabel; //更多

@end

@implementation MainList_CollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.contentView.backgroundColor = kNavBGColor;
        
//        [self setCornerRadius:ScaleW(5)];
        
        [self addSubview:self.headerImg];
        
        [self addSubview:self.titleLabel];
        
        [self addSubview:self.payCountLabel];
        
        [self addSubview:self.priceLabel];

        [self addSubview:self.daiPriceLabel];
        
        [self addSubview:self.moreLabel];
        
    }
    return self;
}

-(void)viewConfig
{
    
}
-(UIImageView *)headerImg
{
    if (!_headerImg) {
        
        _headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(16), ScaleW(16), ScaleW(145), ScaleW(145))];
        _headerImg.backgroundColor = kSubBackgroundColor;
    
        _headerImg.layer.cornerRadius=5;
        
        _headerImg.clipsToBounds=YES;
        
    }
    return _headerImg;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" font:systemFont(ScaleW(ScaleW(14))) textColor:kMainTextColor frame:CGRectMake(_headerImg.right +ScaleW(15), ScaleW(5) + _headerImg.top, self.width - ScaleW(16)-(_headerImg.right +ScaleW(15)), ScaleW(34)) textAlignment:(NSTextAlignmentLeft)];
        _titleLabel.numberOfLines = 2;
        _titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
        
    }
    return _titleLabel;
}

-(UILabel *)payCountLabel{
    if (!_payCountLabel) {
       
        _payCountLabel = [WLTools allocLabel:[NSString stringWithFormat:@"0%@",SSKJLocalized(@"人付款", nil)] font:systemFont(ScaleW(ScaleW(12))) textColor:kSubTxtColor frame:CGRectMake(_titleLabel.left, _titleLabel.bottom+ScaleW(15), _titleLabel.width, ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _payCountLabel;
}
-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        UILabel *leftLabel=[WLTools allocLabel:SSKJLocalized(@"库存:", nil) font:systemFont(ScaleW(13)) textColor:kSubTxtColor frame:CGRectMake(_titleLabel.left, _payCountLabel.bottom+ScaleW(15), ScaleW(40), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
        
        [self addSubview:leftLabel];
        
        _priceLabel = [WLTools allocLabel:@"0.00 " font:systemFont(ScaleW(17)) textColor:kSubTxtColor frame:CGRectMake(leftLabel.right + ScaleW(10), leftLabel.top-1.5, ScreenWidth-(leftLabel.right + ScaleW(25)), ScaleW(18)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _priceLabel;
}

-(UILabel *)daiPriceLabel
{
    if (!_daiPriceLabel) {
        UILabel *leftLabel=[WLTools allocLabel:SSKJLocalized(@"价格:", nil) font:systemFont(ScaleW(13)) textColor:kSubSubTxtColor frame:CGRectMake(_titleLabel.left, _priceLabel.bottom+ScaleW(15), ScaleW(40), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
        
        [self addSubview:leftLabel];
        _daiPriceLabel = [WLTools allocLabel:@"0.0000  " font:systemFont(ScaleW(17)) textColor:UIColorFromRGB(0x5ba56f) frame:CGRectMake(leftLabel.right + ScaleW(10), leftLabel.top-1.5, ScreenWidth-(leftLabel.right + ScaleW(25)), ScaleW(18)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _daiPriceLabel;
}
-(UILabel *)moreLabel
{
    if (!_moreLabel) {
       
        _moreLabel = [WLTools allocLabel:@"..." font:systemBoldFont(ScaleW(15)) textColor:kMainBlueColor frame:CGRectMake(ScreenWidth - ScaleW(45+20), _daiPriceLabel.bottom-ScaleW(5), ScaleW(20), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _moreLabel;
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    NSLog(@"dataDic::%@",dataDic);
    
    _dataDic = dataDic;

    if ([dataDic.allKeys containsObject:@"name"]) {
        
        _titleLabel.text =[NSString stringWithFormat:@"%@", dataDic[@"name"]];

    }
    if ([dataDic.allKeys containsObject:@"goods_name"]) {
        
        _titleLabel.text =[NSString stringWithFormat:@"%@", dataDic[@"goods_name"]]; 
        
    }
    
    _priceLabel.text =[NSString stringWithFormat:@"%@%@",[NSString stringWithFormat:@"%@",[WLTools noroundingStringWith:[dataDic[@"skus"] doubleValue] afterPointNumber:2]],SSKJLocalized(@"个", nil)];

    _daiPriceLabel.text=[NSString stringWithFormat:@"%@",[WLTools noroundingStringWith:[dataDic[@"rmb_price"] doubleValue] afterPointNumber:2]];
    
    _payCountLabel.text = [NSString stringWithFormat:@"%@%@",dataDic[@"sale_num"],SSKJLocalized(@"人付款", nil)];
    
    NSString *str1=[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"goods_pic_path"]];
      NSString *str2=[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"pic_path"]];
      NSString *str3=[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"pic_urls"]];
     NSString *str4=[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"thumbnail_pic"]];
    if ([str4 length]>10) {
        SsLog(@"thumbnail_pic");
        
        [_headerImg sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:dataDic[@"thumbnail_pic"]]]];
    }
   else if ([str1 length]>10) {
        
          SsLog(@"goods_pic_path");
        
          [_headerImg sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:dataDic[@"goods_pic_path"]]]];
    }
   else if ([str2 length]>10) {
       SsLog(@"pic_path");
       
        [_headerImg sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:dataDic[@"pic_path"]]]];
    }
   else if ([str3 length]>10) {
       SsLog(@"pic_urls");

       [_headerImg sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:dataDic[@"pic_urls"]]]];
   }
  
    
    
   
    _headerImg.backgroundColor=[UIColor lightGrayColor];
    
//    goods_id": "2",
//    "goods_pic_path": "\/Uploads\/photo\/goods\/2019-09-10\/5d767d27c9187.jpg",
//    "goods_name": "店铺4商品",
//    "can_sell_price": "50.00",
//    "wait_sell_price": "60.00",
//    "sale_num": "23",
//    "store_id": "4"
}

@end
