//
//  SliderTableHeader.h
//  SSKJ
//
//  Created by 张本超 on 2019/5/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SliderTableHeader : UIView
@property (nonatomic, copy) void(^btnClicked)(NSInteger index);
@property (nonatomic, assign) NSInteger currentIndex;
@end

NS_ASSUME_NONNULL_END
