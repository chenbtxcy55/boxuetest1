//
//  BCLineViews.m
//  SSKJ
//
//  Created by 张本超 on 2018/6/21.
//  Copyright © 2018年 James. All rights reserved.
//

#import "BCLineViews.h"
#import "JJHETFPositionModel.h"
#define TopMargin       5
#define SideMargin      5
#define BottomMargin    26
#define XAxis           4
#define YAxis           5
#define KSelectSpace    20

#define kAddValueX  40
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define KUIScreen_width  [UIScreen mainScreen].bounds.size.width
#define KUIScreen_height [UIScreen mainScreen].bounds.size.height
#define RedColor RGBCOLOR16(0xc0362f)

@interface BCLineViews()
{
    CGRect rect;
    float width;
    float height;
    NSArray *points;
    NSArray *xAxis;
    NSArray *yAxis;
    NSArray *allValue;
}
@property(nonatomic ,strong)UIView *selectLine;
@property(nonatomic ,strong)UIView *showBackground;
@property(nonatomic ,strong)UILabel *weightLabel;
@property(nonatomic ,strong)UILabel *stateLabel;
@property(nonatomic ,strong)UILabel *timeLabel;
@property (nonatomic, assign) NSInteger startDrawIndex;
@end
@implementation BCLineViews

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _dataArr = [NSMutableArray array];
        
    }
    return self;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _dataArr = [NSMutableArray array];
        
        self.backgroundColor = kMainWihteColor;
        
        
    }
    return self;
}

-(void)setDataArr:(NSMutableArray *)dataArr
{
    _dataArr = dataArr;
    
    [self initData];
    [self createSelectUI];
    [self setNeedsDisplay];
}

-(void)initData
{
    width = self.width-SideMargin*14;
    height = self.height-TopMargin-BottomMargin;
    rect = CGRectMake(SideMargin, TopMargin, width, height);
    
    float max = 0;
    float min = MAXFLOAT;
    
    for (JJHETFPositionModel *model in _dataArr)
    {
        NSLog(@"%@",model.closingPrice);
        max = [model.closingPrice floatValue]>max?[model.closingPrice floatValue]:max;
        min = [model.closingPrice floatValue]<min?[model.closingPrice floatValue]:min;
    }
    min = min - max;
    max = max - min;
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    if (_dataArr.count >= 7 && _dataArr.count <31) {
        [tmpArray addObject:[JJHETFPositionModel dateWithModel:(JJHETFPositionModel*)_dataArr[6] andFormatter:@"MM.dd"]];
        [tmpArray addObject:[JJHETFPositionModel dateWithModel:(JJHETFPositionModel*)_dataArr[5] andFormatter:@"MM.dd"]];
        [tmpArray addObject:[JJHETFPositionModel dateWithModel:(JJHETFPositionModel*)_dataArr[4] andFormatter:@"MM.dd"]];
        [tmpArray addObject:[JJHETFPositionModel dateWithModel:(JJHETFPositionModel*)_dataArr[3] andFormatter:@"MM.dd"]];
        [tmpArray addObject:[JJHETFPositionModel dateWithModel:(JJHETFPositionModel*)_dataArr[2] andFormatter:@"MM.dd"]];
        [tmpArray addObject:[JJHETFPositionModel dateWithModel:(JJHETFPositionModel*)_dataArr[1] andFormatter:@"MM.dd"]];
        [tmpArray addObject:[JJHETFPositionModel dateWithModel:(JJHETFPositionModel*)_dataArr[0] andFormatter:@"MM.dd"]];
    }
    if (_dataArr.count == 31)
    {
        [tmpArray addObject:[JJHETFPositionModel dateWithModel:(JJHETFPositionModel*)_dataArr[30] andFormatter:@"MM.dd"]];
        [tmpArray addObject:[JJHETFPositionModel dateWithModel:(JJHETFPositionModel*)_dataArr[25] andFormatter:@"MM.dd"]];
         [tmpArray addObject:[JJHETFPositionModel dateWithModel:(JJHETFPositionModel*)_dataArr[20] andFormatter:@"MM.dd"]];
        [tmpArray addObject:[JJHETFPositionModel dateWithModel:(JJHETFPositionModel*)_dataArr[15] andFormatter:@"MM.dd"]];
        [tmpArray addObject:[JJHETFPositionModel dateWithModel:(JJHETFPositionModel*)_dataArr[10] andFormatter:@"MM.dd"]];
        [tmpArray addObject:[JJHETFPositionModel dateWithModel:(JJHETFPositionModel*)_dataArr[5] andFormatter:@"MM.dd"]];
           [tmpArray addObject:[JJHETFPositionModel dateWithModel:(JJHETFPositionModel*)_dataArr[0] andFormatter:@"MM.dd"]];
    }
   
    xAxis = [NSArray arrayWithArray:tmpArray];
    
    [tmpArray removeAllObjects];
    float rangeMid = (max + min)/2;

    rangeMid = (float)rangeMid+0.001;
    
    float rangeLow = (rangeMid + min)/2;
 
    rangeLow = (float)rangeLow-0.001;
    
    float step = rangeMid - rangeLow;
    min = 0;
    max = rangeMid+step*2;
    
    for (int i = 0;i < YAxis;i ++)
    {
        [tmpArray addObject:[NSString stringWithFormat:@"%.2f",min+step*(YAxis-1-i)]];
    }
    yAxis = [NSArray arrayWithArray:tmpArray];
    
    [tmpArray removeAllObjects];
    for (int i = 0;i < _dataArr.count;i ++)
    {
        float value = [[(JJHETFPositionModel*)_dataArr[i] closingPrice] floatValue];
        CGPoint p = CGPointMake(width/(_dataArr.count-1)*(_dataArr.count-1-i) + SideMargin + kAddValueX, height-(value - min)/(max - min)*height + TopMargin);
        [tmpArray addObject:NSStringFromCGPoint(p)];
        //lastOne
       
    }
    points = [NSArray arrayWithArray:tmpArray];
    [tmpArray removeAllObjects];
    for (int i = 0;i < _dataArr.count;i ++)
    {
        float value = [[(JJHETFPositionModel*)_dataArr[0] closingPrice] floatValue];
        [tmpArray addObject:[NSString stringWithFormat:@"%.4f",value]];
        //lastOne
        
    }
    allValue = [NSArray arrayWithArray:tmpArray];
}

-(void)createSelectUI{
    if (_selectLine == nil) {
        _selectLine = [[UIView alloc]initWithFrame:CGRectMake(0, TopMargin, 1, self.height-TopMargin-BottomMargin)];
        _selectLine.backgroundColor = RGBCOLOR(0x33, 0x33, 0x33);
        [self addSubview:_selectLine];
        _selectLine.hidden = YES;
        
        _showBackground = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
        _showBackground.centerY = self.height/2;
        _showBackground.backgroundColor = [UIColor clearColor];
        [self addSubview:_showBackground];
        _showBackground.hidden = YES;
        
        UIView *back = [[UIView alloc]initWithFrame:_showBackground.bounds];

        back.backgroundColor = RGBACOLOR(0x00, 0x00, 0x00, 0.7);
        back.layer.cornerRadius = 4;
        back.layer.masksToBounds = YES;
        [_showBackground addSubview:back];
        
        _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(7, 10, _showBackground.width - 14, 20)];
        _stateLabel.font = [UIFont systemFontOfSize:18];
        _stateLabel.textColor = [UIColor whiteColor];
        [_showBackground addSubview:_stateLabel];
        
        _weightLabel = [[UILabel alloc]initWithFrame:CGRectMake(_stateLabel.x, _stateLabel.maxY+5, _showBackground.width/2, 11)];
        _weightLabel.font = [UIFont systemFontOfSize:9];
        _weightLabel.textColor = [UIColor whiteColor];
        [_showBackground addSubview:_weightLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_showBackground.width - 9 - 40, _weightLabel.y, 40, _weightLabel.height)];
        _timeLabel.font = [UIFont systemFontOfSize:9];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = RGBCOLOR(0xcc, 0xcc, 0xcc);
        [_showBackground addSubview:_timeLabel];
        
    }
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,kMainWihteColor.CGColor);
    CGContextFillRect(context, rect);
    [self drawScale];
    [self drawFrame];
    [self drawLine];
   
   // [self drawLineLines];
    //[self fillColors];
    [self drawBrokenFillColor];
}

-(void)drawFrame
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context, YES);
    CGContextSetLineWidth(context, 1.f);
    CGContextSetStrokeColorWithColor(context, RGBCOLOR(0x99, 0x99, 0x99).CGColor);
    rect = CGRectMake(SideMargin + kAddValueX , TopMargin, self.width-14*SideMargin, self.height-TopMargin-BottomMargin);
    CGContextAddRect(context,rect);
    CGContextStrokePath(context);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    
    UIView *v = [self viewWithTag:10000000];
    UIView *v1 = [self viewWithTag:10000001];
    [v removeFromSuperview];
    [v1 removeFromSuperview];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(SideMargin + kAddValueX, TopMargin - 0.5, self.width-14*SideMargin, 2)];
    lineView.backgroundColor = kMainWihteColor;
    
    lineView.tag = 10000000;
    [self addSubview:lineView];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(kAddValueX +self.width-13*SideMargin - 0.5, TopMargin - 0.5, 2,self.height-TopMargin-BottomMargin)];
    lineView2.backgroundColor = kMainWihteColor;
    
    lineView2.tag = 10000000;
    [self addSubview:lineView2];
    
}

-(void)drawScale
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context, YES);
    CGContextSetLineWidth(context, 1.f);
    
    CGContextSetStrokeColorWithColor(context, RGBCOLOR(0x23, 0x23, 0x23).CGColor);
    for (int i = 0; i < xAxis.count; i ++)
    {
//        CGContextMoveToPoint(context, SideMargin+width/(xAxis.count-1)*i, TopMargin);
//        CGContextAddLineToPoint(context, SideMargin+width/(xAxis.count-1)*i, self.height-BottomMargin);
    }
    
    for (int i = 0; i < yAxis.count + 1 ; i ++)
    {
//        CGContextMoveToPoint(context, SideMargin, TopMargin+height/(yAxis.count-1)*i);
//        CGContextAddLineToPoint(context, self.width-SideMargin, TopMargin+height/(yAxis.count-1)*i);
    }
    CGContextStrokePath(context);
    CGColorRef color = RGBCOLOR(0x66, 0x66, 0x66).CGColor;
    CGContextSetFillColorWithColor(context, color);
    for (int i = 0; i < xAxis.count; i ++)
    {
        float x = SideMargin + kAddValueX/2.f+width/(xAxis.count-1)*i;
       
        [xAxis[i] drawAtPoint:CGPointMake(x, self.height-BottomMargin+5) withFont:[UIFont systemFontOfSize:ScaleW(12)]];
        float w = [BCLineViews sizeForString:xAxis[i] withWidth:self.width-SideMargin*2 inFont:[UIFont systemFontOfSize:12.f]].width;
        if (i > 0)
        {
            x -= (i == xAxis.count-1)?w:w/2;
        }
       
    }
    
    CGContextSetFillColorWithColor(context, RGBCOLOR(0x99, 0x99, 0x99).CGColor);
    for (int i = 0; i < yAxis.count; i ++)
    {
        [yAxis[i] drawAtPoint:CGPointMake(/*KUIScreen_width - 12*SideMargin*/ SideMargin + SideMargin, TopMargin+height/(yAxis.count-1)*i-(i==yAxis.count-1?[BCLineViews sizeForString:nil withWidth:self.width-SideMargin*2 inFont:[UIFont systemFontOfSize:12]].height:0)) withFont:[UIFont systemFontOfSize:12]];
    }
    //last
   
//    CGContextSetStrokeColorWithColor(context, RGBCOLOR(0x00, 0x00, 0x00).CGColor);
//    CGContextMoveToPoint(context, SideMargin, self.height-BottomMargin);
//    CGContextAddLineToPoint(context, self.width-SideMargin, self.height-BottomMargin);
//    for (int i = 0; i < xAxis.count; i ++)
//    {
//        CGContextMoveToPoint(context, SideMargin+width/(xAxis.count-1)*i, self.height-BottomMargin);
//        CGContextAddLineToPoint(context, SideMargin+width/(xAxis.count)*i, self.height-BottomMargin+4);
//    }
    CGContextStrokePath(context);
}

-(void)drawLine
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetShouldAntialias(context, YES);
    CGContextSetLineWidth(context, 1.f);
    CGContextSetStrokeColorWithColor(context, kMainRedColor.CGColor);
    UIBezierPath *path = [UIBezierPath bezierPath];
    bool bFirstPoint = YES;
    CGMutablePathRef fillPath = CGPathCreateMutable();
    for(int i = 0; i < points.count; i++){
        CGPoint p = CGPointFromString([points objectAtIndex:i]);
        if (bFirstPoint)
        {
            [path moveToPoint:CGPointMake(p.x, p.y)];
            bFirstPoint = NO;
        }
        [path addLineToPoint:p];
        
        NSString *string = allValue.lastObject;
        CGPoint plast = CGPointFromString([points objectAtIndex:0]);
          CGPoint pstart = CGPointFromString([points objectAtIndex:points.count - 1]);
        if (1 == i) {
            CGPathMoveToPoint(fillPath, NULL, SideMargin, self.height);
            CGPathAddLineToPoint(fillPath, NULL, SideMargin,plast.y);
            CGPathAddLineToPoint(fillPath, NULL, plast.x, plast.y);
        }else{
            CGPathAddLineToPoint(fillPath, NULL, pstart.x, p.y);
        }
        if ((points.count - 1) == i) {
            CGPathAddLineToPoint(fillPath, NULL, pstart.x, p.y);
            CGPathAddLineToPoint(fillPath, NULL, pstart.x, self.height);
            CGPathCloseSubpath(fillPath);
        }
    }
    [path stroke];
    UIColor *beginC = RGBCOLOR16(0x3d361f);
    UIColor *endC = [UIColor clearColor];
    if (points.count > 0) {
        //[self drawLinearGradient:context path:fillPath alpha:1 startColor:beginC.CGColor endColor:endC.CGColor];
    }
    CGPathRelease(fillPath);

    

}


-(void)tapAction:(UITapGestureRecognizer *)tap{
    CGPoint p =[tap locationInView:self];
    [self selectLine:p];
    [self selectHidden:YES];
}

-(void)longAction:(UILongPressGestureRecognizer *)lon{
    CGPoint p =[lon locationInView:self];
    [self selectLine:p];
    [self selectHidden:NO];
}

-(void)panAction:(UIPanGestureRecognizer *)pan{
    CGPoint p =[pan locationInView:self];
    [self selectLine:p];
    [self selectHidden:NO];
}

-(void)selectLine:(CGPoint)p{
    return;
    float scale = p.x/(KUIScreen_width-10);
    int a = _dataArr.count*scale - 1;
    a = (a >= 0 )?a :0;
    float b = 999;
    int j = 0;
    for (int i = a; i < ((a+2)<_dataArr.count?a+2:_dataArr.count); i++) {
        CGPoint point = CGPointFromString(points[i]);
        if (b > (fabsf((float)p.x - (float)point.x))) {
            b = (fabsf((float)p.x - (float)point.x));
            j = i;
        }
    }
    j = (int)_dataArr.count - 1 - j;
    CGPoint point = CGPointFromString(points[j]);
    _selectLine.x = point.x;
    if (point.x + KSelectSpace< self.width - 10 - _showBackground.width) {
        _showBackground.x = point.x + KSelectSpace;
    }else{
        _showBackground.x = point.x - KSelectSpace - _showBackground.width;
    }
    [self saveDataWithData:_dataArr[j]];
}

-(void)saveDataWithData:(JJHETFPositionModel *)data{
    _weightLabel.text = [NSString stringWithFormat:@"%@吨",data.positionTon];
    
    _timeLabel.text = [JJHETFPositionModel dateWithModel:data andFormatter:@"MM.dd"];
    
    
    if ([data.changeEtf floatValue]>0) {
        _stateLabel.text = [NSString stringWithFormat:@"%@吨",data.changeEtf];
        //        _stateLabel.backgroundColor = KUpDateColorRed;
    }else if([data.changeEtf floatValue] == 0){
        _stateLabel.text = @"持平";
        //        _stateLabel.backgroundColor = KUpDateColorGray;
    }else if([data.changeEtf floatValue] < 0){
        _stateLabel.text = [NSString stringWithFormat:@"%@吨",data.changeEtf];
        //        _stateLabel.backgroundColor = KUpDateColorGreen;
    }
}

-(void)selectHidden:(BOOL)state{
    state = YES;
    _showBackground.hidden = state;
    _selectLine.hidden = state;
}
+(CGSize)sizeForString:(NSString*)str withWidth:(CGFloat)width inFont:(UIFont*)font
{
    NSString *theStr = str;
    if (theStr == nil)
    {
        theStr = @"";
    }
    
    CGSize size = [theStr sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)];
    return size;
}


-(void)drawLineLines
{
    NSString *string = allValue.lastObject;
    CGPoint plast = CGPointZero;
    if (points.count)
    {
       // plast =  CGPointFromString([points objectAtIndex:points.count - 1]);
        plast = CGPointFromString([points objectAtIndex:0]);
    }
   
    plast = CGPointMake(plast.x, plast.y - 6);
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, RGBCOLOR16(0xffffff), NSForegroundColorAttributeName,RedColor,NSBackgroundColorAttributeName,nil];
    [string drawAtPoint:plast withAttributes:attrs];
    plast = CGPointMake(plast.x, plast.y + 6 );
    [self drawLineFrom:CGPointMake(SideMargin, plast.y ) toPoint:plast color:RGBCOLOR16(0xff0000)];
}
-(void)drawLineFrom:(CGPoint)point toPoint:(CGPoint)toPiont color:(UIColor *)color
{
    // Drawing code
    CGContextRef context=UIGraphicsGetCurrentContext();//获取绘图用的图形上下文
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);//填充色设置成
    CGFloat lengths[] = {4};
    CGContextSetLineDash(context, 4, lengths,1);
    
    CGContextFillRect(context,self.bounds);//把整个空间用刚设置的颜色填充
    //上面是准备工作，下面开始画线了
    CGContextSetStrokeColorWithColor(context, color.CGColor);//设置线的颜色
    CGContextMoveToPoint(context,point.x,point.y);//画线的起始点位置
    CGContextAddLineToPoint(context,toPiont.x,toPiont.y);//画第一条线的终点位置
    
    CGContextStrokePath(context);//把线在界面上绘制出来
    
}
-(void)fillColors
{

}
- (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                     alpha:(CGFloat)alpha
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextSetAlpha(context, alpha);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
}
- (void)drawBrokenFillColor
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGMutablePathRef fillPath = CGPathCreateMutable();
    
    if (points.count > 0) {
        
        // 即时成交价线
        for (NSInteger i = 0; i < points.count; i ++) {
          CGPoint p =CGPointFromString(points[i]);
            CGFloat x = p.x;
            CGFloat y = p.y;
            if (i == 0) {
                CGPathMoveToPoint(fillPath, NULL,x, TopMargin + height);
                CGPathAddLineToPoint(fillPath, NULL, x, y);
            } else if (i == points.count - 1) {
                
                CGPathAddLineToPoint(fillPath, NULL,x, y);
                 CGPathAddLineToPoint(fillPath, NULL, x,TopMargin + height);
                CGPathCloseSubpath(fillPath);
            }  else{
                CGPathAddLineToPoint(fillPath, NULL, p.x, p.y);
            }
        }
    }
    
    //    CGPathMoveToPoint(fillPath, NULL, 0, 0);
    //    CGPathAddLineToPoint(fillPath,NULL, self.width / 2, self.height / 2);
    //
    //    CGPathAddLineToPoint(fillPath,NULL, self.width, 0);
    //    CGPathAddLineToPoint(fillPath,NULL, self.width, self.height);
    //    CGPathAddLineToPoint(fillPath,NULL, 0, self.height);
    //    CGPathCloseSubpath(fillPath);
    
    
    [self drawLinearGradient:context path:fillPath alpha:0.5 startColor:kMainRedColor.CGColor endColor:kMainWihteColor.CGColor];
    
    
    CGPathRelease(fillPath);
    
    CGContextRestoreGState(context);
}




@end
