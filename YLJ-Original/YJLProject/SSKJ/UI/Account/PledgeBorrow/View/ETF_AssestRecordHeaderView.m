//
//  ETF_AssestRecordHeaderView.m
//  SSKJ
//
//  Created by James on 2019/5/8.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "ETF_AssestRecordHeaderView.h"

@interface ETF_AssestRecordItemView()
@property (nonatomic, strong) UIButton *bgButton;


@property (nonatomic, strong) UIImageView *iconIM;
@end

@implementation ETF_AssestRecordItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgButton];
        [self.bgButton addSubview:self.titleLB];
        [self.bgButton addSubview:self.contentLB];
        [self.bgButton addSubview:self.iconIM];
        
        
        [self.bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self);
        }];
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgButton);
            make.centerY.equalTo(self.bgButton);
        }];
        [self.contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLB.mas_right).offset(ScaleW(10));
            make.centerY.equalTo(self.bgButton);
        }];
        [self.iconIM mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentLB.mas_right).offset(ScaleW(10));
            make.bottom.equalTo(self.contentLB.mas_bottom);
            make.right.equalTo(self.bgButton);
        }];
    }
    return self;
}

- (UIButton *)bgButton {
    if (!_bgButton) {
        _bgButton = [[UIButton alloc]init];
    
    }
    return _bgButton;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc]init];
        _titleLB.textColor = [UIColor colorWithHexStringToColor:@"b4b2c5"];
        _titleLB.font = [UIFont systemFontOfSize:ScaleW(13)];
        _titleLB.text = SSKJLocalized(@"", nil);
        _titleLB.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLB;
}
- (UILabel *)contentLB {
    if (!_contentLB) {
        _contentLB = [[UILabel alloc]init];
        _contentLB.textColor = kMainWihteColor;
        _contentLB.font = [UIFont systemFontOfSize:ScaleW(13)];
        _contentLB.text = SSKJLocalized(@"", nil);
        _contentLB.adjustsFontSizeToFitWidth = YES;
    }
    return _contentLB;
}

- (UIImageView *)iconIM {
    if (!_iconIM) {
        _iconIM = [[UIImageView alloc]init];
        _iconIM.image = [UIImage imageNamed:@"right_downarrow"];
    }
    return _iconIM;
}


@end


@interface ETF_AssestRecordHeaderView()
@property (nonatomic, strong) UIView *bgView;

@end

@implementation ETF_AssestRecordHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.coinItem];
        [self.bgView addSubview:self.typeItem];
        [self setupMasnory];
    }
    return self;
}

- (void)setupItemOneTitle:(NSString *)left itemTwoTitle:(NSString *)right {
    self.coinItem.titleLB.text = left;
    self.typeItem.titleLB.text = right;
}

- (void)coinItemClick {
    if (self.coinBlock) {
        self.coinBlock();
    }
}

- (void)typeItemClick {
    if (self.typeBlock) {
        self.typeBlock();
    }
}

#pragma mark -- Private Method

- (void)setupMasnory {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(ScaleW(50));
    }];
    [self.coinItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.centerY.equalTo(self.bgView);
    }];
    [self.typeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coinItem.mas_right).offset(ScaleW(30));
        make.centerY.equalTo(self.bgView);
    }];
}

- (void)configureView {
    
}

#pragma mark -- Public Method

#pragma mark -- Getter Method
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = kMainBackgroundColor;
    }
    return _bgView;
}

- (ETF_AssestRecordItemView *)coinItem {
    if (!_coinItem) {
        _coinItem = [[ETF_AssestRecordItemView alloc]init];
        _coinItem.titleLB.text = SSKJLocalized(@"币种", nil);
        [_coinItem.bgButton addTarget:self action:@selector(coinItemClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _coinItem;
}

- (ETF_AssestRecordItemView *)typeItem {
    if (!_typeItem) {
        _typeItem = [[ETF_AssestRecordItemView alloc]init];
        _typeItem.titleLB.text = SSKJLocalized(@"类型", nil);
        [_typeItem.bgButton addTarget:self action:@selector(typeItemClick) forControlEvents:UIControlEventTouchUpInside];
        _typeItem.contentLB.text = SSKJLocalized(@"充币", nil);
    }
    return _typeItem;
}

#pragma mark -- Setter Method

@end
