
#import "Shop_WriteEmail_View.h"
@interface Shop_WriteEmail_View()

@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITextField *emailName;

@property (nonatomic, strong) UITextField *emailNum;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *sepLine;

@property (nonatomic, strong) UIButton *cancellBtn;

@property (nonatomic, strong) UIButton *commitBtn;


@end


@implementation Shop_WriteEmail_View

-(instancetype)init
{
    if (self = [super init])
    {
        self.frame = [UIApplication sharedApplication].keyWindow.bounds;
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        self.backgroundColor = kClearBackColor;
        
        [self addSubview:self.mainView];
        
        [self.mainView addSubview:self.titleLabel];
        
        [self.mainView addSubview:self.emailName];
        
        [self.mainView addSubview:self.emailNum];
        
        [self.mainView addSubview:self.lineView];
        
        [self.mainView addSubview:self.sepLine];
        
        [self.mainView addSubview:self.commitBtn];
        
        [self.mainView addSubview:self.cancellBtn];
        
        self.mainView.centerY = ScreenHeight/2.f-ScaleW(100);
    }
    return self;
}

-(UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth - ScaleW(30), ScaleW(260))];
        _mainView.backgroundColor = kBgColor353750;
        
        [_mainView setCornerRadius:ScaleW(10)];
        
        
    }
    return _mainView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"填写物流信息" font:systemBoldFont(ScaleW(17)) textColor:kMainTextColor frame:CGRectMake(0, 0, _mainView.width, ScaleW(67)) textAlignment:(NSTextAlignmentCenter)];
        
    }
    return _titleLabel;
}

-(UITextField *)emailName
{
    if (!_emailName) {
        _emailName = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(25), ScaleW(6) + _titleLabel.bottom, ScaleW(295), ScaleW(45))];
        [_emailName setCornerRadius:ScaleW(5)];
        
        [_emailName setBorderWithWidth:ScaleW(1) andColor:UIColorFromRGB(0xdcdcdc)];
        
        _emailName.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(15), ScaleW(45))];
        
        _emailName.leftView = leftView;
        
        [_emailName textField:_emailName textFont:ScaleW(14) placeHolderFont:ScaleW(14) text:nil placeText:SSKJLocalized(@"请填写物流名称", nil) textColor:kMainTextColor placeHolderTextColor:UIColorFromRGB(0xe7e7e7)];
    }
    return _emailName;
}
-(UITextField *)emailNum
{
    if (!_emailNum) {
        _emailNum = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(25), ScaleW(10) + _emailName.bottom, ScaleW(295), ScaleW(45))];
        [_emailNum setCornerRadius:ScaleW(5)];
        
        [_emailNum setBorderWithWidth:ScaleW(1) andColor:UIColorFromRGB(0xdcdcdc)];
        
        _emailNum.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(15), ScaleW(45))];
        
        _emailNum.leftView = leftView;
        
        [_emailNum textField:_emailNum textFont:ScaleW(14) placeHolderFont:ScaleW(14) text:nil placeText:SSKJLocalized(@"请填写物流编号", nil) textColor:kMainTextColor placeHolderTextColor:UIColorFromRGB(0xe7e7e7)];
        
        
    }
    return _emailNum;
}
-(UIView *)lineView
{
    if (!_lineView ) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _emailNum.bottom + ScaleW(35), _mainView.width, ScaleW(1))];
        _lineView.backgroundColor = kLineColor;
    }
    return _lineView;
}

-(UIView *)sepLine
{
    if (!_sepLine) {
        _sepLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(172),_lineView.bottom, ScaleW(1), ScaleW(53))];
        _sepLine.backgroundColor = kLineColor;
      
    }
    return _sepLine;
}

-(UIButton *)commitBtn
{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commitBtn btn:_commitBtn font:ScaleW(15) textColor:kMainRedColor text:@"提交" image:nil sel:@selector(commitBtnAction:) taget:self];
        _commitBtn.titleLabel.font = systemBoldFont(ScaleW(16));
        _commitBtn.frame = CGRectMake(_sepLine.right, _sepLine.top, ScaleW(172),ScaleW(53));
        
        
    }
    return _commitBtn;
}

-(UIButton *)cancellBtn
{
    if (!_cancellBtn) {
        _cancellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _cancellBtn.frame = CGRectMake(0, _sepLine.top, _sepLine.left, _commitBtn.height);
        
        [_cancellBtn btn:_cancellBtn font:ScaleW(16) textColor:UIColorFromRGB(0xdfdfdf) text:SSKJLocalized(@"取消", nil) image:nil sel:@selector(cancellAction:) taget:self];
    }
    return _cancellBtn;
}
-(void)commitBtnAction:(UIButton *)sender
{
    !self.commitBlock?:self.commitBlock(self.emailName.text,self.emailNum.text);
}
-(void)cancellAction:(UIButton *)sender
{
    !self.cancellBlock?:self.cancellBlock();
}
@end
