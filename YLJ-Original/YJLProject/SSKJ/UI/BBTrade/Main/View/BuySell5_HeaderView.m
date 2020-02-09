//
//  BuySell5_HeaderView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/15.
//  Copyright © 2019年 James. All rights reserved.
//

#import "BuySell5_HeaderView.h"
#import "ETF_Default_ActionsheetView.h"
@interface BuySell5_HeaderView ()

@property (nonatomic, strong) UIView *dotSelectBackView;
@property (nonatomic, strong) UILabel *dotLabel;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, assign) NSInteger maxDotNumber;

@end

@implementation BuySell5_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    [self addSubview:self.dotSelectBackView];
    [self.dotSelectBackView addSubview:self.dotLabel];
    [self.dotSelectBackView addSubview:self.selectButton];
    
    NSArray *array = @[SSKJLocalized(@"盘口",nil),SSKJLocalized(@"价格",nil),SSKJLocalized(@"数量",nil)];
    CGFloat width = self.width  / array.count;
    
    CGFloat startX = 0;
    
    
    for (int i = 0; i < array.count; i++) {
        CGFloat newWidth;

        if (i == 0) {
            newWidth = width - ScaleW(20);
        }else if (i == 1) {
            newWidth = width + ScaleW(10);
        }else{
            newWidth = width + ScaleW(7);
        }
        
        UILabel *label = [WLTools allocLabel:array[i] font:systemFont(ScaleW(12)) textColor:kTextDarkBlueColor frame:CGRectMake(startX, self.dotSelectBackView.bottom, newWidth, ScaleW(40)) textAlignment:NSTextAlignmentLeft];
        if (i == 0) {
            label.textAlignment = NSTextAlignmentLeft;
        }else if (i == 1){
            label.textAlignment = NSTextAlignmentCenter;
        }else{
            label.textAlignment = NSTextAlignmentRight;
        }
        [self addSubview:label];
        self.height = label.bottom;
        startX += newWidth;
    }
    
}

-(UIView *)dotSelectBackView
{
    if (nil == _dotSelectBackView) {
        _dotSelectBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, ScaleW(23))];
        _dotSelectBackView.layer.masksToBounds = YES;
        _dotSelectBackView.layer.borderColor = kTextDarkBlueColor.CGColor;
        _dotSelectBackView.layer.borderWidth = 0.5;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectDotEvent)];
        [_dotSelectBackView addGestureRecognizer:tap];
    }
    return _dotSelectBackView;
}

-(UILabel *)dotLabel
{
    if (nil == _dotLabel) {
        _dotLabel = [WLTools allocLabel:SSKJLocalized(@"1位小数", nil) font:systemFont(ScaleW(10.5)) textColor:kTextLightBlueColor frame:CGRectMake(ScaleW(5), 0, ScaleW(100), self.dotSelectBackView.height) textAlignment:NSTextAlignmentLeft];
    }
    return _dotLabel;
}

-(UIButton *)selectButton
{
    if (nil == _selectButton) {
        _selectButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - ScaleW(25), 0, ScaleW(25), self.dotSelectBackView.height)];
        [_selectButton setImage:[UIImage imageNamed:@"bc_bb_down"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"bc_bb_up"] forState:UIControlStateSelected];
    }
    return _selectButton;
}

-(void)selectDotEvent
{
    
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 1; i <= self.maxDotNumber; i++) {
        [array addObject:[NSString stringWithFormat:@"%d%@",i,SSKJLocalized(@"位小数", nil)]];
    }
    
    WS(weakSelf);
    [ETF_Default_ActionsheetView showWithItems:array title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
        NSString *title = array[selectIndex];
        weakSelf.dotLabel.text = title;
        if (weakSelf.changeDotBlock) {
            weakSelf.changeDotBlock(selectIndex + 1);
        }
    } cancleBlock:^{
        
    }];
}

-(void)setMaxDotNumber:(NSInteger)maxDotNumber showDotNumber:(BOOL)isShowDot
{
    self.dotLabel.text = [NSString stringWithFormat:@"%ld%@",maxDotNumber,SSKJLocalized(@"位小数", nil)];
    
    self.maxDotNumber = maxDotNumber;
    
    self.dotSelectBackView.hidden = !isShowDot;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
