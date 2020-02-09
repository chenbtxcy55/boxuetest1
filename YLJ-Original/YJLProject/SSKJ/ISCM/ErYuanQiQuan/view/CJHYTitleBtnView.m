
#import "CJHYTitleBtnView.h"

#define kBtnTag(a) 100000000 + a

@interface CJHYTitleBtnView()


@property (nonatomic, strong) NSMutableArray *codeBtnArray;

@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIView *topLine;


@end

@implementation CJHYTitleBtnView

-(instancetype)init
{
    
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(60));
        [self addSubview:self.topLine];

        
        [self addSubview:self.titleLabel];
        //self.codeArray  = @[@"0.01",@"0.1",@"1"];
        
        [self addSubview:self.bottomLine];
    }
    return self;
    
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"目标点位", nil) font:systemFont(15) textColor:kTitleColor frame:CGRectMake(ScaleW(5), ScaleW(25), ScaleW(65), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _titleLabel;
}
-(void)setCodeArray:(NSArray *)codeArray
{
    [self.codeBtnArray removeAllObjects];
    _codeArray = codeArray;
    
    for (int i = 0;i < _codeArray.count; i ++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake(ScaleW(80) + ScaleW(65) * i, ScaleW(19), ScaleW(55), ScaleW(26));
        
         UIColor *color = [WLTools day:kTextGrayColor333333 night:kMainWihteColor];
        
        [btn btn:btn font:ScaleW(12) textColor:color text:[NSString stringWithFormat:@"%@min",_codeArray[i]] image:nil sel:@selector(codeAction:) taget:self];
        
        btn.tag = kBtnTag(i);
        
        [self addSubview:btn];
        
        [self.codeBtnArray addObject:btn];
       
        if (i==0) {
            
            btn.selected=YES;
            btn.backgroundColor = kBtnBgColor;
            [btn setTitleColor:kMainWihteColor forState:(UIControlStateNormal)];
            
        }
        else{
            
            btn.selected=NO;
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:kMainBlueColor forState:(UIControlStateNormal)];
            btn.layer.borderColor = [[UIColor colorWithRed:80.0f/255.0f green:113.0f/255.0f blue:210.0f/255.0f alpha:1.0f] CGColor];
            btn.layer.borderWidth = 1;
            
          }
        }
    
    
}
-(UIView *)topLine
{
    if (!_topLine) {
        _topLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(5), 0,ScreenWidth - ScaleW(10), ScaleW(1))];
        _topLine.backgroundColor = kLineColor;
    }
    return _topLine;
}
-(UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(5), self.height - ScaleW(1),ScreenWidth - ScaleW(10), ScaleW(1))];
        _bottomLine.backgroundColor = kLineColor;
    }
    return _bottomLine;
}

-(void)codeAction:(UIButton *)sender
{
    self.currentText = sender.titleLabel.text;
    self.currenIndex = sender.tag - kBtnTag(0);
    !self.buttonClickedBlock?:self.buttonClickedBlock(self.currentText);
    for (UIButton *btn in self.codeBtnArray) {
        if (btn == sender) {
            btn.backgroundColor = kBtnBgColor;
            [btn setTitleColor:kMainWihteColor forState:(UIControlStateNormal)];
        }else{
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:kMainBlueColor forState:(UIControlStateNormal)];
            btn.layer.borderColor = [[UIColor colorWithRed:80.0f/255.0f green:113.0f/255.0f blue:210.0f/255.0f alpha:1.0f] CGColor];
            btn.layer.borderWidth = 1;
        }
    }
    
}


-(NSMutableArray *)codeBtnArray{
    if (!_codeBtnArray) {
        _codeBtnArray = [NSMutableArray array];
    }
    return _codeBtnArray;
}

@end
