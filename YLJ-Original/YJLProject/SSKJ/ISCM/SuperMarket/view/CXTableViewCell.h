//
//  CXTableViewCell.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *intoShopLab;
@property (weak, nonatomic) IBOutlet UILabel *titleContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *textContent;
@property (weak, nonatomic) IBOutlet UIImageView *shopImg;

@end

NS_ASSUME_NONNULL_END
