//
//  HKButtonView.h
//  SSKJ
//
//  Created by apple on 2019/9/6.
//  Copyright © 2019 HKK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HKButtonViewBLcok)(void);
@interface HKButtonView : UIView

@property (nonatomic,strong) UIImageView *fbcImageView;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *subTitle;
@property (nonatomic,strong) NSString *imgName;
@property (nonatomic,assign) CGRect myFrame;
@property (nonatomic,assign) BOOL isLleft;

@property (nonatomic,copy) HKButtonViewBLcok block;

-(HKButtonView *)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle andImg:(NSString *)imgName andFrame:(CGRect)frame isLeft:(BOOL)isLeft;

@end

NS_ASSUME_NONNULL_END
