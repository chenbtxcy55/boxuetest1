//
//  LA_MainShopCollectionCell.m
//  SSKJ
//
//  Created by GT on 2019/7/25.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "LA_MainShopCollectionCell.h"
@interface LA_MainShopCollectionCell()
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UILabel *priceLabel;
/**
 购物券
 */
@property (nonatomic, strong) UILabel *coupLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIImageView *picImgView;

@end
@implementation LA_MainShopCollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.contentView.backgroundColor = kSubBackgroundColor;
        [self viewConfig];
    }
    return self;
}

- (void)viewConfig {
    
//    self.contentView.layer.cornerRadius =ScaleW(5);
//    self.contentView.layer.borderWidth =1.0f;
//    self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
//    self.contentView.layer.masksToBounds =YES;
    
    [self.contentView addSubview:self.picImgView];
    [self.contentView addSubview:self.desLabel];
//    [self.contentView addSubview:self.stateLabel];
    [self.contentView addSubview:self.coupLabel];
    [self.contentView addSubview:self.priceLabel];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ScaleW(8));
        make.right.mas_equalTo(ScaleW(-5));
        make.top.equalTo(self.picImgView.mas_bottom).offset(ScaleW(10));
    }];
//    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(ScaleW(-10));
////        make.top.equalTo(self.desLabel.mas_bottom).offset(ScaleW(16));
//        make.bottom.equalTo(self.priceLabel.mas_bottom);
////        make.width.mas_greaterThanOrEqualTo(ScaleW(50));   // 这是最小宽度
//    }];

    
    [self.coupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ScaleW(-10));
        make.left.mas_equalTo(ScaleW(8));
        make.top.equalTo(self.desLabel.mas_bottom).offset(ScaleW(12));
        make.width.mas_greaterThanOrEqualTo(ScaleW(120));   // 这是最小宽度
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ScaleW(-10));
        make.left.mas_equalTo(ScaleW(8));
        make.top.equalTo(self.coupLabel.mas_bottom).offset(ScaleW(12));
        make.width.mas_greaterThanOrEqualTo(ScaleW(120));   // 这是最小宽度
    }];
    
    self.backBtn = [UIButton new];
    [self.contentView addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    // 设置抗压缩优先级
//    [self.stateLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
//    [self.priceLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];

}

- (void)changeUI {
    [self.priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ScaleW(-10));
        make.left.mas_equalTo(ScaleW(8));
        make.top.equalTo(self.desLabel.mas_bottom).offset(ScaleW(12));
        make.width.mas_greaterThanOrEqualTo(ScaleW(120));   // 这是最小宽度
    }];
}

- (void)reStoreUI {
//    self.coupLabel.hidden = YES;
    [self.coupLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ScaleW(-10));
        make.left.mas_equalTo(ScaleW(8));
        make.top.equalTo(self.desLabel.mas_bottom).offset(ScaleW(12));
        make.width.mas_greaterThanOrEqualTo(ScaleW(120));   // 这是最小宽度
    }];
    
    [self.priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ScaleW(-10));
        make.left.mas_equalTo(ScaleW(8));
        make.top.equalTo(self.coupLabel.mas_bottom).offset(ScaleW(12));
        make.width.mas_greaterThanOrEqualTo(ScaleW(120));   // 这是最小宽度
    }];
    
}
- (void)setLModel:(LA_MainShopHotListModel *)lModel {
    _lModel = lModel;
    self.desLabel.text = lModel.goods_name;
//    if (jifen.length > 0 && rmb.length > 0) {
//        return [NSString stringWithFormat:@"%@购物券+%@余额",[WLTools noroundingStringWith:[jifen doubleValue] afterPointNumber:2],[WLTools noroundingStringWith:[rmb doubleValue] afterPointNumber:2]];
//    } else if (jifen.length > 0 &&rmb.length == 0){
//        return [NSString stringWithFormat:@"%@购物券",[WLTools noroundingStringWith:[jifen doubleValue] afterPointNumber:2]];
//    } else {
//        return [NSString stringWithFormat:@"%@余额",[WLTools noroundingStringWith:[rmb doubleValue] afterPointNumber:2]];
//    }

//    [WLTools noroundingStringWith:[jifen doubleValue] afterPointNumber:2]
    if (lModel.can_sell_price.length > 0 &&lModel.rmb_price.length > 0) {
        self.priceLabel.text = [NSString stringWithFormat:@"%@余额",[WLTools noroundingStringWith:[lModel.rmb_price doubleValue] afterPointNumber:2]];
        self.coupLabel.text = [NSString stringWithFormat:@"%@购物券",[WLTools noroundingStringWith:[lModel.can_sell_price doubleValue] afterPointNumber:2]];
        [self reStoreUI];
        self.priceLabel.hidden = NO;
        self.coupLabel.hidden = NO;


    } else if (lModel.can_sell_price.length > 0 && lModel.rmb_price.length == 0) {
        self.coupLabel.text = [NSString stringWithFormat:@"%@购物券",[WLTools noroundingStringWith:[lModel.can_sell_price doubleValue] afterPointNumber:2]];
        [self reStoreUI];
        self.priceLabel.hidden = YES;
        self.coupLabel.hidden = NO;

    } else {
        [self changeUI];
        self.coupLabel.hidden = YES;
        self.priceLabel.hidden = NO;
        self.priceLabel.text = [NSString stringWithFormat:@"%@余额",[WLTools noroundingStringWith:[lModel.rmb_price doubleValue] afterPointNumber:2]];
    }
    
    NSString *urlStr = lModel.thumbnail_pic;
    NSString *nUrlStr = [WLTools imageURLWithURL:urlStr];

    [self.picImgView sd_setImageWithURL:[NSURL URLWithString:nUrlStr] placeholderImage:[UIImage imageNamed:@"suolueTu"]];
}


- (UIImageView *)picImgView {
    if (!_picImgView) {
        _picImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScaleW(106), ScaleW(106))];
        _picImgView.image = [UIImage imageNamed:@"suolueTu"];
        _picImgView.contentMode = UIViewContentModeScaleAspectFill;
        _picImgView.layer.masksToBounds = YES;
    }
    return _picImgView;
}

- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [UILabel new];
        [self label:_desLabel font:(ScaleW(12)) textColor:kMainTextColor text:@"92#汽油0.92/L"];
    }
    return _desLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        [self label:_priceLabel font:(ScaleW(16)) textColor:kTheMeColor text:@"126.05 余额"];
        _priceLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _priceLabel;
}

//- (UILabel *)stateLabel {
//    if (!_stateLabel) {
//        _stateLabel = [UILabel new];
//        [self label:_stateLabel font:(ScaleW(12)) textColor:kTextGrayColor text:@""];
//    }
//    return _stateLabel;
//}
- (UILabel *)coupLabel {
    if (!_coupLabel) {
        _coupLabel = [UILabel new];
        [self label:_coupLabel font:(ScaleW(16)) textColor:kTheMeColor text:@"126.05 购物券"];
        _coupLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _coupLabel;
}
@end
