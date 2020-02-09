//
//  HeBi_Publish_PayMethodView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_Publish_PayMethodView.h"

#import "HeBi_PayMethodView.h"


@interface HeBi_Publish_PayMethodView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSMutableArray *payMethodViewArray;

@end

@implementation HeBi_Publish_PayMethodView

@synthesize selectedPayMethodArray = _selectedPayMethodArray;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kSubBackgroundColor;
        [self addSubview:self.titleLabel];
    }
    return self;
}

-(NSMutableArray *)payMethodViewArray
{
    if (nil == _payMethodViewArray) {
        _payMethodViewArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _payMethodViewArray;
}

-(NSMutableArray *)selectedPayMethodArray
{
    if (nil == _selectedPayMethodArray) {
        _selectedPayMethodArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _selectedPayMethodArray;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"收款方式", nil) font:systemThinFont(ScaleW(14)) textColor: kMainTextColor frame:CGRectMake(ScaleW(15), ScaleW(22), ScaleW(200), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

- (void)setPayMethodArray:(NSMutableArray *)payMethodArray
{
    [self.selectedPayMethodArray removeAllObjects];
    
    _payMethodArray = payMethodArray;
    
    for (HeBi_PayMethodView *view in self.payMethodViewArray) {
        [view removeFromSuperview];
    }
    
    [self.payMethodViewArray removeAllObjects];
    
    CGFloat startY = self.titleLabel.bottom + ScaleW(22);
    
    for (int i= 0; i < payMethodArray.count; i++) {
        JB_PayWayModel *model = payMethodArray[i];
        __block HeBi_PayMethodView *payMethodView = [[HeBi_PayMethodView alloc]initWithFrame:CGRectMake(0, startY, ScreenWidth, ScaleW(50))];
        [payMethodView setViewWithModel:model];
        [self addSubview:payMethodView];
        [self.payMethodViewArray addObject:payMethodView];
        
        startY += payMethodView.height;
        
        WS(weakSelf);
        
        __block typeof(payMethodView) blockPayView = payMethodView;
        payMethodView.selectBlock = ^(BOOL isSelected) {
            if (isSelected) {
                
                blockPayView.isSelect = YES;
                [weakSelf.selectedPayMethodArray addObject:blockPayView.model];
                
            }else{
                [weakSelf.selectedPayMethodArray removeObject:blockPayView.model];
                blockPayView.isSelect = NO;
            }
        };
    }
    
    self.height = startY;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
