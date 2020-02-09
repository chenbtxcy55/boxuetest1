//
//  UIView+Extension.h
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>


//颜色取值宏
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBCOLOR16(rgbValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#define RGBACOLOR16(rgbValue, alphaValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]
#define BCOLOR   RGBCOLOR16(0x131f30)
#define ChartBColor RGBCOLOR16(0x131f30)
#define CharBlueColor [WLTools stringToColor:@"#8e94a3"]

//广播名称设定业务代码

#define KBtcListClickedNotifacation  @"KBtcListClickedNotifacation"
#define KSocketLongNofication     @"KSocketLongNofication"
#define KSocketLongDaBiNofication  @"KSocketLongDaBiNofication"
#define kQiangChouSelectedNotification @"QiangChouSelectedNotification"


//加btn的tag值
#define addTag        30001
//减Btn的tag值
#define reduceTag     30002

//买入卖出

#define buyTag 30003
#define sellTag 30004
//常用定义
#define myEdge   10.f
#define Screen_Width    [UIScreen mainScreen].bounds.size.width
#define Screen_Height   [UIScreen mainScreen].bounds.size.height

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;

@property (nonatomic, assign ,readonly) CGRect oneRightNextRect;
@property (nonatomic, assign ,readonly) CGRect oneBottomNextRect;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;


-(CGRect)rightNextRectWithWidth:(CGFloat)width andHeight:(CGFloat)height;
-(CGRect)bottomNextRectWithWidth:(CGFloat)width andHeight:(CGFloat)height;

@property (nonatomic, assign) CGFloat cornerRadius;
-(void)setBorderWithWidth:(CGFloat)width andColor:(UIColor *)color;
-(void)label:(UILabel *)lable font:(float)font textColor:(UIColor *)color text:(NSString *)text;
-(void)btn:(UIButton *)btn font:(float)font textColor:(UIColor *)color text:(NSString *)text image:(UIImage*)imge;
-(void)btn:(UIButton *)btn font:(float)font textColor:(UIColor *)color text:(NSString *)text image:(UIImage*)imge sel:(SEL)sel taget:(id)taget;
-(void)textField:(UITextField *)textField textFont:(CGFloat)textFont placeHolderFont:(CGFloat)placeHolderFont text:(NSString *)text placeText:(NSString *)placeText textColor:(UIColor *)textColor placeHolderTextColor:(UIColor *)placeHolderTextColor;
-(CGFloat)returnHeight:(NSString *)str font:(float)font width:(float)width;
-(void)widthToFit;
-(void)heightToFit;
-(CGFloat)returnWidth:(NSString *)str font:(float)font;

-(UILabel *)labelFrame:(CGRect)frame;

-(UILabel *)labelNew;
-(UIColor *)color:(NSString *)color;


-(void)localizedTextLabel:(UILabel *)textLabel;

-(void)localizedTextField:(UITextField *)textField;

-(void)localizedBtn:(UIButton *)btn;

-(void)locaLizedWithObjc:(id)Obj;
#pragma mark ------加阴影
-(void)setShadowView:(UIView *)view;

@end
