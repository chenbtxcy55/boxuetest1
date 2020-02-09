//
//  News_NewsList_Cell.h
//  SSKJ
//
//  Created by zpz on 2019/6/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface News_NewsList_Cell : UITableViewCell


@property(nonatomic, strong)UIImageView *iconImageView;

@property(nonatomic, strong)UILabel *titleLabel;

@property(nonatomic, strong)UILabel *subTitleLabel;

@property(nonatomic, strong)UIView *lineView;


@end

NS_ASSUME_NONNULL_END
