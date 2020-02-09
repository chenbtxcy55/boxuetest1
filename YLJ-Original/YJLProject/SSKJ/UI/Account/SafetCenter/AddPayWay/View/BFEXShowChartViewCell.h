//
//  BFEXShowChartViewCell.h
//  ZYW_MIT
//
//  Created by 张本超 on 2018/7/3.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFEXShowChartViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *selectImg;

@property (nonatomic, strong) UITextField *inputTextView;
//+(instancetype)getCellFromTable:(UITableView *)table;
-(void)setValueWith:(NSDictionary *)dic type:(NSString *)type;
@property (nonatomic, copy) void(^backImg)(UIImageView *img);
@end
