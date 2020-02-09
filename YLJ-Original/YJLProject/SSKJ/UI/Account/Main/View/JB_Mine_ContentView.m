//
//  JB_Mine_ContentView.m
//  SSKJ
//
//  Created by James on 2019/5/14.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Mine_ContentView.h"

@interface JB_Mine_ContentItemView : UIView
@property (nonatomic, strong) UIButton *bgButton;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UIImageView *iconIM;
@property (nonatomic, strong) UIImageView *arrowIM;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation JB_Mine_ContentItemView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title icon:(NSString *)icon
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgButton];
        [self.bgButton addSubview:self.iconIM];
        [self.bgButton addSubview:self.titleLB];
        [self.bgButton addSubview:self.arrowIM];
        [self.bgButton addSubview:self.lineView];
        
        self.titleLB.text = title;
        self.iconIM.image = [UIImage imageNamed:icon];
        
        [self.bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(ScaleW(50));
        }];
        [self.iconIM mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.bgButton);
            make.left.equalTo(self.bgButton).offset(ScaleW(18));
        }];
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.bgButton);
            make.left.equalTo(self.iconIM.mas_right).offset(ScaleW(17));
        }];
        [self.arrowIM mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.bgButton);
            make.right.equalTo(self.bgButton).offset(-ScaleW(17));
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgButton);
            make.bottom.equalTo(self.bgButton);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

- (UIImageView *)iconIM {
    if (!_iconIM) {
        _iconIM = [[UIImageView alloc]init];
    }
    return _iconIM;
}

- (UIImageView *)arrowIM {
    if (!_arrowIM) {
        _arrowIM = [[UIImageView alloc]init];
        _arrowIM.image = [UIImage imageNamed:@"arrow_right_icon"];
    }
    return _arrowIM;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc]init];
        _titleLB.textColor = kMainTextColor;
        _titleLB.font = [UIFont systemFontOfSize:ScaleW(15)];
        _titleLB.text = SSKJLocalized(@"", nil);
        _titleLB.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLB;
}

- (UIView *)bgButton {
    if (!_bgButton) {
        _bgButton = [[UIButton alloc]init];
//        _bgButton.backgroundColor = kSubBackgroundColor;
    }
    return _bgButton;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kLineGrayColor;
    }
    return _lineView;
}

@end


@interface JB_Mine_ContentView()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *icons;
@end

@implementation JB_Mine_ContentView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles icons:(NSArray *)icons
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        self.icons = icons;
        [self addSubview:self.bgView];
        [self setupMasnory];
    }
    return self;
}

#pragma mark -- Private Method

- (void)itemViewClick:(UIButton *)sender {
    self.selectedIndexBlock(sender.tag-100);
}

- (void)setupMasnory {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.left.equalTo(self);
        make.height.mas_equalTo(ScaleW(50)*self.titles.count);
    }];
    [self setupButtons];
}

- (void)setupButtons {
    for (NSInteger i = 0; i<self.titles.count; i++) {
        JB_Mine_ContentItemView *itemView = [[JB_Mine_ContentItemView alloc]initWithFrame:CGRectZero
                                                                                    title:self.titles[i]
                                                                                     icon:self.icons[i]];
        itemView.bgButton.tag = 100+i;
        [itemView.bgButton addTarget:self action:@selector(itemViewClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:itemView];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgView);
            make.top.equalTo(self.bgView).offset(ScaleW(50)*i);
            make.height.mas_equalTo(ScaleW(50));
        }];
  
        if (self.titles.count-1 == i) {
            itemView.lineView.hidden = YES;
        }else{
            itemView.lineView.hidden = NO;
        }
    }
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = kSubBackgroundColor;
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = ScaleW(10);
    }
    return _bgView;
}

@end
