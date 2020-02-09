//
//  Shop_Publish_View.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/11.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Shop_Publish_View : UIView

-(instancetype)initWithTop:(CGFloat)top Title:(NSString *)title subTiles:(NSString *)subTiles limit:(NSInteger)limit andDecripTitle:(NSString*)dtitle subTitle:(NSString*)dsubTitle andHeight:(CGFloat)height andImgLimit:(NSInteger)imgLimit andImgType:(NSInteger)type;

@property (nonatomic, strong) NSArray *oldImgArray;

@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) UIButton *addImgeBtn;

@property (nonatomic, copy) void(^saveImgBlock)(void);

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) NSString *contenUrlString;

@property (nonatomic, strong) NSString *shotCutString;

@property (nonatomic, strong) UILabel *placeHolder;

@property (nonatomic, strong) NSMutableArray *dataSoureArray;

@property (nonatomic, strong) NSMutableArray *contenUrlArray;

@property (nonatomic, strong) NSMutableArray *imgUrlArray;

-(void)clearDatas;

-(void)showData;

-(void)limitHidden;

@end

NS_ASSUME_NONNULL_END
