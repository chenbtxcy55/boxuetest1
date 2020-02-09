//
//  CJHYTitleBtnView.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJHYTitleBtnView : UIView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) NSArray *codeArray;

@property (nonatomic, strong) NSString *currentText;

@property (nonatomic, assign) NSInteger currenIndex;

@property (nonatomic, copy) void(^buttonClickedBlock)(NSString *string);

@end

NS_ASSUME_NONNULL_END
