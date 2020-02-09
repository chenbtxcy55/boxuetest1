//
//  JB_LendChoiceTableViewCell.h
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JB_LendCoinModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    JB_LendChoiceCellType_Normal = 0,//只有subTitle
    JB_LendChoiceCellType_Arrow = 1,//副标题带箭头
    JB_LendChoiceCellType_Input = 2,//带输入框副标题
    JB_LendChoiceCellType_InputUnEble = 3,//带不可输入的输入框副标题
} JB_LendChoiceCellType;

@protocol JB_LendChoiceTableViewCellDelegate <NSObject>

- (void)inputTFInfoWithModel:(JB_LendCoinModel *)model inputString:(NSString *)inputString;

@end

@interface JB_LendChoiceTableViewCell : UITableViewCell
@property (nonatomic, weak) id <JB_LendChoiceTableViewCellDelegate>delegate;

- (void)configureCellWithModel:(JB_LendCoinModel *)model hiddenLine:(BOOL)hiddenLine;
@end

NS_ASSUME_NONNULL_END
