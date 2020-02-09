//
//  SuperNotifaTableViewCell.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/13.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuperNotifaTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headerImg;

@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIView *septorLine;



@end

NS_ASSUME_NONNULL_END
