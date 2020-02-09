//
//  CJHYButtonsView.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TradeListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJHYButtonsView : UIView

@property (nonatomic, copy) void(^selectBtnBlock)(NSString *codeString);

@property (nonatomic, strong) NSArray *codeArray;

@property (nonatomic, strong) NSString *currentText;

@property (nonatomic, strong) NSArray *disAbleArray;

@end

NS_ASSUME_NONNULL_END
