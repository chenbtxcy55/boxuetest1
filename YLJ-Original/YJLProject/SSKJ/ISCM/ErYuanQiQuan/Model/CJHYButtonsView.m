//
//  CJHYButtonsView.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "CJHYButtonsView.h"

@interface CJHYButtonsView()

@property (nonatomic, strong) NSMutableArray *codeBtnArray;

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, assign) BOOL firstInit;

@end

@implementation CJHYButtonsView

-(instancetype)init
{
    
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth-ScaleW(70), ScaleW(55));
        //self.codeArray  = @[@"USDT",@"ETH",@"BTC",@"EOS"];
//        [self addSubview:self.bottomLine];
    }
    return self;
    
}

-(void)setCodeArray:(NSArray *)codeArray
{
    _codeArray = codeArray;
    
    for (UIButton *btn  in self.codeBtnArray) {
        [btn removeFromSuperview];
        
    }
    [self.codeBtnArray removeAllObjects];
    
    for (int i = 0;i < _codeArray.count; i ++) {
        
        TradeListModel *model = _codeArray[i];
        
        SsLog(@"name:::%@",model.name);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake(ScaleW(10) + ScaleW(65) * i, ScaleW(14), ScaleW(55), ScaleW(26));
      
        [btn btn:btn font:ScaleW(14) textColor:[UIColor whiteColor] text:model.name image:nil sel:@selector(codeAction:) taget:self];
//        [btn setTitleColor:kMainBlueColor forState:(UIControlStateDisabled)];
//        [btn setTitleColor:kMainWihteColor forState:(UIControlStateSelected)];
//        [btn setTitleColor:kMainBlueColor forState:(UIControlStateNormal)];

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
//        if (model.yue.doubleValue == 0) {
//            btn.enabled = NO;
//        }else{
//            btn.enabled = YES;
//        }
//        if (btn.enabled == YES&&_firstInit == NO) {
//            btn.selected = YES;
//            self.currentText = btn.titleLabel.text;
//            _firstInit = YES;
//            btn.backgroundColor = kBtnBgColor;
//
//        }else
//        {
//            btn.backgroundColor = kMainWihteColor;
//
//        }
//        if (i == self.codeArray.count - 1) {
//            if (btn.enabled == NO&&_firstInit == NO) {
//                UIButton *firstBtn = self.codeBtnArray.firstObject;
//                firstBtn.backgroundColor = kBtnBgColor;
//                self.currentText = firstBtn.titleLabel.text;
//                _firstInit = YES;
//                firstBtn.enabled = YES;
//                firstBtn.selected = YES;
//            }
//        }
        
    }
    
}

-(UIView *)bottomLine
{
    
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(5), self.height - ScaleW(1),ScreenWidth - ScaleW(10), ScaleW(1))];
        UIColor *color = [WLTools day:kTextGrayColorF1f3f6 night:kLineColor];
        _bottomLine.backgroundColor = color;
    }
    return _bottomLine;
}

-(void)codeAction:(UIButton *)sender
{
    self.currentText = sender.titleLabel.text;
    for (UIButton *btn in self.codeBtnArray) {
        if (btn == sender) {
            btn.selected = YES;
            btn.backgroundColor = kBtnBgColor;
            [btn setTitleColor:kMainWihteColor forState:(UIControlStateNormal)];
        }else{
            btn.selected = NO;
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:kMainBlueColor forState:(UIControlStateNormal)];
            btn.layer.borderColor = [[UIColor colorWithRed:80.0f/255.0f green:113.0f/255.0f blue:210.0f/255.0f alpha:1.0f] CGColor];
            btn.layer.borderWidth = 1;
        }
    }
   
       

    !self.selectBtnBlock?:self.selectBtnBlock(self.currentText);
}
-(NSMutableArray *)codeBtnArray{
    if (!_codeBtnArray) {
        _codeBtnArray = [NSMutableArray array];
    }
    return _codeBtnArray;
}



@end
