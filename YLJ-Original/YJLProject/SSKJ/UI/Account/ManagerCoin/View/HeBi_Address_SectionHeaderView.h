//
//  HeBi_Address_SectionHeaderView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_Address_SectionHeaderView : UITableViewHeaderFooterView
@property (nonatomic, copy) void (^addBlock)(NSString *coinName);

@property (nonatomic, copy) NSString *coinName;
@end

NS_ASSUME_NONNULL_END
