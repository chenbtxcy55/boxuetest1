//
//  MineTableCell.h
//  SSKJ
//
//  Created by apple on 2019/8/16.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineTableCell : UITableViewCell
@property (nonatomic,strong) UIImageView *rightImgView;
-(void)setDataWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
