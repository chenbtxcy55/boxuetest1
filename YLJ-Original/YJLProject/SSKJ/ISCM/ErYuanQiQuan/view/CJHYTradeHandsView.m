//
//  CJHYTradeHandsView.m
#import "CJHYTradeHandsView.h"
#import"ETF_Default_ActionsheetView.h"

@interface CJHYTradeHandsView()

@property (nonatomic, strong) UIButton *handesView;

@property (nonatomic, strong) UILabel *handeLabel;

@property (nonatomic, strong) UIImageView *handImgView;

@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation CJHYTradeHandsView

-(instancetype)init
{
    
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(55));
        [self addSubview:self.titleLabel];
        [self addSubview:self.handesView];
        [self addSubview:self.handImgView];
        [self addSubview:self.handeLabel];
        [self addSubview:self.bottomLine];
    }
    return self;
    
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"交易手数", nil) font:systemFont(15) textColor:kTitleColor frame:CGRectMake(ScaleW(28), ScaleW(20), ScaleW(170), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _titleLabel;
}
-(UIButton *)handesView
{
    if (!_handesView) {
        _handesView = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _handesView.frame = CGRectMake(_titleLabel.right, 0, ScreenWidth - _titleLabel.right, self.height);
        
        [_handesView btn:_handesView font:ScaleW(0) textColor:kMainColor text:@"" image:nil sel:@selector(selectBtnAction:) taget:self];
        
        
    }
    return _handesView;
}
-(UIImageView *)handImgView
{
    if (!_handImgView) {
        _handImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(37), ScaleW(24),ScaleW(16) , ScaleW(8))];
       _handImgView.image = [UIImage imageNamed:@"xiala"];
    }
    
    return _handImgView;
}
-(UILabel *)handeLabel
{
    if (!_handeLabel) {
        _handeLabel = [WLTools allocLabel:SSKJLocalized(@"1手", nil) font:systemFont(15) textColor:kTitleColor frame:CGRectMake(_handImgView.left - ScaleW(15), ScaleW(20), ScaleW(70), ScaleW(15)) textAlignment:(NSTextAlignmentRight)];
        _handeLabel.right = _handImgView.left - ScaleW(15);
    }
    return _handeLabel;
}


-(UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(28), self.height - ScaleW(1),ScreenWidth - ScaleW(56), ScaleW(1))];
        _bottomLine.backgroundColor = kLineColor;
    }
    return _bottomLine;
}


-(void)selectBtnAction:(UIButton *)sender
{
    
    sender.selected = !sender.selected;
    
    NSArray *array = @[SSKJLocalized(@"1手", nil),SSKJLocalized(@"2手", nil),SSKJLocalized(@"3手", nil),SSKJLocalized(@"4手", nil),SSKJLocalized(@"5手", nil),SSKJLocalized(@"6手", nil),SSKJLocalized(@"7手", nil),SSKJLocalized(@"8手", nil),SSKJLocalized(@"9手", nil),SSKJLocalized(@"10手", nil)];
    WS(weakSelf);
    [ETF_Default_ActionsheetView showWithItems:array title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
        NSString *title = array[selectIndex];
        weakSelf.handeLabel.text = title;
        !weakSelf.handBackBlock?:self.handBackBlock(selectIndex);
        
    } cancleBlock:^{
       weakSelf.handImgView.image = [UIImage imageNamed:@"xiala"];
    }];
}



@end
