//
//  FB_Action_TitleView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/21.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "FB_Action_TitleView.h"
#import "ETF_Default_ActionsheetView.h"

@interface FB_Action_TitleView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSArray *titlesArray;


@end

@implementation FB_Action_TitleView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        _titlesArray = titles;
        if (titles.count == 0) {
            return self;
        }
        [self setUI];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEvent)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - UI
-(void)setUI
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.imageView];
}


-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:self.titlesArray.firstObject font:systemFont(17) textColor:[UIColor whiteColor] frame:CGRectMake(0, 0, self.width, 17) textAlignment:NSTextAlignmentCenter];
        _titleLabel.centerY = self.height / 2;
    }
    return _titleLabel;
}

- (UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width - ScaleW(5), _titleLabel.bottom - ScaleW(5), ScaleW(5), ScaleW(5))];
        _imageView.image = [UIImage imageNamed:@"icon_jiaobiao"];
    }
    return _imageView;
}




#pragma mark - 切换购买、出售
-(void)tapEvent
{
    
    WS(weakSelf);
    [ETF_Default_ActionsheetView showWithItems:self.titlesArray title:@"" selectedIndexBlock:^(NSInteger selectIndex) {

        NSString *title = weakSelf.titlesArray[selectIndex];

        weakSelf.titleLabel.text = title;
        if (weakSelf.titleChangeBlock) {
            weakSelf.titleChangeBlock(selectIndex);
        }
    } cancleBlock:^{

    }];
    
    
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
