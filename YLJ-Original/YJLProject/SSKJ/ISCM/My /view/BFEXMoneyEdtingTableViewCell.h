//
//  BFEXMoneyEdtingTableViewCell.h
//  ZYW_MIT
//
//  Created by 张本超 on 2018/7/17.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFEXMoneyEdtingTableViewCell : UITableViewCell
@property (nonatomic, copy) void(^deleBlock)(void);

-(void)setValueWithData:(id)data;
@end
