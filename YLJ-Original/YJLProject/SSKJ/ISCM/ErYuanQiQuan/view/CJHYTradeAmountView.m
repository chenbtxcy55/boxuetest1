

#import "CJHYTradeAmountView.h"

@interface CJHYTradeAmountView()



@property (nonatomic, strong) NSMutableArray *codeBtnArray;

@property (nonatomic, strong) UIView *bottomLine;


@end

@implementation CJHYTradeAmountView

-(instancetype)init
{
    
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(47));
        [self addSubview:self.titleLabel];
        //self.codeArray  = @[@"0.01",@"0.1",@"1"];
        [self addSubview:self.amountTf];
//        [self addSubview:self.bottomLine];
    }
    return self;
    
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"交易金额", nil) font:systemFont(15) textColor:kTitleColor frame:CGRectMake(ScaleW(5), ScaleW(14), ScaleW(65), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _titleLabel;
}


-(UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(5), self.height - ScaleW(1),ScreenWidth - ScaleW(10), ScaleW(1))];
        _bottomLine.backgroundColor = kLineColor;
    }
    return _bottomLine;
}
-(UILabel *)unitLabel
{
    if (!_unitLabel) {
        _unitLabel = [WLTools allocLabel:@"0" font:systemFont(ScaleW(15)) textColor:kMainBlueColor frame:CGRectMake(0, 0, ScaleW(46), ScaleW(45)) textAlignment:(NSTextAlignmentCenter)];
        
        _unitLabel.centerY=_titleLabel.centerY;
        
    }
    return _unitLabel;
}

-(UITextField *)amountTf
{
    if (!_amountTf) {
        _amountTf = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(80), 0, ScaleW(245), ScaleW(45))];
        NSString *string = [NSString stringWithFormat:@"%@",SSKJLocalized(@"金额大于500且是5的整数倍", nil)];
        [_amountTf textField:_amountTf textFont:ScaleW(14) placeHolderFont:ScaleW(14) text:nil placeText:string textColor:kTitleColor placeHolderTextColor:kSubTitleColor];
        _amountTf.rightViewMode = UITextFieldViewModeAlways;
        _amountTf.rightView = self.unitLabel;
        _amountTf.keyboardType = UIKeyboardTypeDecimalPad;
    }
    return _amountTf;
}
@end
