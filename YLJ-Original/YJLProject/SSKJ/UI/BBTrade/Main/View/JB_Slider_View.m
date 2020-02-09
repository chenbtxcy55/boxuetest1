//
//  JB_Slider_View.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/27.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Slider_View.h"
#import "JB_Progress_ButtonView.h"

@interface JB_Slider_View ()
@property (nonatomic, strong) UIView *progressLineView;
@property (nonatomic, strong) UIView *currentProgressLineView;
@property (nonatomic, strong) NSMutableArray *buttonsArray;

@property (nonatomic, strong) UIImageView *sliderView;   // 滑块

@property (nonatomic, strong) UIColor *btnColor;

@property (nonatomic, assign) BOOL isMove;

@property (nonatomic, strong) UISlider *slider;

@end

@implementation JB_Slider_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.btnColor = GREEN_HEX_COLOR;

        [self addSubview:self.progressLineView];
        [self addSubview:self.currentProgressLineView];
//        [self addSubview:self.sliderView];
        [self addButtons];
        
        [self addSubview:self.startLabel];
        [self addSubview:self.endLabel];
        
        [self addSubview:self.slider];
//        [self addSubview:self.sliderView];
    }
    return self;
}


-(NSMutableArray *)buttonsArray
{
    if (nil == _buttonsArray) {
        _buttonsArray = [NSMutableArray array];
    }
    return _buttonsArray;
}

-(UIView *)progressLineView
{
    if (_progressLineView == nil) {
        _progressLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width  - ScaleW(10), ScaleW(2))];
        _progressLineView.backgroundColor = kTextLightBlueColor;
        _progressLineView.centerY = self.height / 2 - ScaleW(5);
    }
    return _progressLineView;
}


-(UIView *)currentProgressLineView
{
    if (_currentProgressLineView == nil) {
        _currentProgressLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width - ScaleW(10), ScaleW(2))];
        _currentProgressLineView.backgroundColor = GREEN_HEX_COLOR;
        _currentProgressLineView.centerY = self.height / 2 - ScaleW(5);
    }
    
    return _currentProgressLineView;
}

//-(UIImageView *)sliderView
//{
//    if (nil == _sliderView) {
//        _sliderView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(15), ScaleW(21))];
//        _sliderView.backgroundColor = kSubBackgroundColor;
//        _sliderView.centerY = self.height / 2 - ScaleW(5);
//        _sliderView.image = [UIImage imageNamed:@"slider_green_btn"];
//    }
//    return _sliderView;
//}

-(void)addButtons
{
    NSInteger percent = self.progress * 100;
    
    int beishu = percent / 25;
    
    if (beishu > 4) {
        beishu = 4;
    }
    
    CGFloat width = (self.width - ScaleW(10)) / 4;
    
    for (JB_Progress_ButtonView *btn in self.buttonsArray) {
        [btn removeFromSuperview];
    }
    
    [self.buttonsArray removeAllObjects];
    
    for (int i = 0; i <= beishu; i++) {
        JB_Progress_ButtonView *btn = [[JB_Progress_ButtonView alloc]initWithFrame:CGRectMake(width * i, 0, ScaleW(8), ScaleW(10)) btnColor:self.btnColor];
        btn.selected = YES;
        btn.centerY = self.height / 2 - ScaleW(5);
        [self addSubview:btn];
        
        [self.buttonsArray addObject:btn];
    }
    
    for (int i = beishu + 1; i <= 4; i++) {
        JB_Progress_ButtonView *btn = [[JB_Progress_ButtonView alloc]initWithFrame:CGRectMake(width * i, 0, ScaleW(8), ScaleW(10)) btnColor:self.btnColor];
        btn.selected = NO;
        btn.centerY = self.height / 2 - ScaleW(5);

        [self addSubview:btn];
        
        [self.buttonsArray addObject:btn];
        
    }
    
    
    JB_Progress_ButtonView *btn = self.buttonsArray.lastObject;
    
    
    [self insertSubview:self.slider aboveSubview:btn];

    
}

-(UISlider *)slider
{
    if (nil == _slider) {
        _slider = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, self.width, ScaleW(15))];
        _slider.maximumTrackTintColor = [UIColor clearColor];
        _slider.minimumTrackTintColor = [UIColor clearColor];
        _slider.thumbTintColor = [UIColor clearColor];
        UIImage *thumbImage = [UIImage imageNamed:@"slider_green_btn"];
        [_slider setThumbImage:thumbImage forState:UIControlStateHighlighted];
        
        [_slider setThumbImage:thumbImage forState:UIControlStateNormal];
        
        [_slider addTarget:self action:@selector(progressChanged:) forControlEvents:UIControlEventValueChanged];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapGesture:)];
        tap.delegate = self;
        [_slider addGestureRecognizer:tap];
    }
    return _slider;
}

-(UILabel *)startLabel
{
    if (nil == _startLabel) {
        _startLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(10)) textColor:kTextGrayBlueColor frame:CGRectMake(0, self.slider.bottom + ScaleW(5), self.width / 2, ScaleW(10)) textAlignment:NSTextAlignmentLeft];
    }
    return _startLabel;
}

-(UILabel *)endLabel
{
    if (nil == _endLabel) {
        _endLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(10)) textColor:kTextGrayBlueColor frame:CGRectMake(self.width / 2, self.startLabel.y, self.width / 2, ScaleW(10)) textAlignment:NSTextAlignmentRight];
        _endLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _endLabel;
}

-(void)setProgress:(double)progress
{
    if (progress > 1) {
        progress = 1;
    }
    _progress = progress;
    
    self.slider.value = progress;
    self.sliderView.centerX = self.width * progress;
    self.currentProgressLineView.width = self.width * progress;
    [self addButtons];
}


-(void)progressChanged:(UISlider *)slider
{
    self.progress = slider.value;
    if (self.changeProgressBlock) {
        self.changeProgressBlock(self.progress);
    }
}

- (void)actionTapGesture:(UITapGestureRecognizer *)sender {
    CGPoint touchPoint = [sender locationInView:_slider];
    CGFloat value = (_slider.maximumValue - _slider.minimumValue) * (touchPoint.x / _slider.frame.size.width );
    [_slider setValue:value animated:YES];
    self.progress = value;
    if (self.changeProgressBlock) {
        self.changeProgressBlock(self.progress);
    }
}

-(void)setBuySellType:(BuySellType)buySellType
{
    _buySellType = buySellType;
    
    UIImage *image = [UIImage imageNamed:@"slider_green_btn"];
    if (buySellType == BuySellTypeBuy) {
        self.currentProgressLineView.backgroundColor = GREEN_HEX_COLOR;
        image = [UIImage imageNamed:@"slider_green_btn"];
        _btnColor = GREEN_HEX_COLOR;
    }else{
        self.currentProgressLineView.backgroundColor = RED_HEX_COLOR;
        image = [UIImage imageNamed:@"slider_red_btn"];
        _btnColor = RED_HEX_COLOR;
    }
    
    [_slider setThumbImage:image forState:UIControlStateHighlighted];
    
    [_slider setThumbImage:image forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
