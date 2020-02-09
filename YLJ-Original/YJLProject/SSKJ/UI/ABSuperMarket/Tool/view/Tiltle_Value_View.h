//
//  Tiltle_Value_View.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/10.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tiltle_Value_View : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;


-(instancetype)initWithTile:(NSString *)title valueString:(NSString *)valueString topMargin:(CGFloat)topMargin;
@end

NS_ASSUME_NONNULL_END
