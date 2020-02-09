//
//  AccountTableViewCell.h
//  SSKJ
//
//  Created by 张本超 on 2019/4/18.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MyTeamListModel;
@interface AccountTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *telNumLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) NSString *nameValue;
@property (nonatomic, strong) NSString *vValues;

@end

NS_ASSUME_NONNULL_END
