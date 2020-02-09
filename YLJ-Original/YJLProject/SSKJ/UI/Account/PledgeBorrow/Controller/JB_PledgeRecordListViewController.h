//
//  JB_PledgeRecordListViewController.h
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JB_PledgeRecordListViewController : SSKJ_BaseViewController
@property (nonatomic, assign) BOOL hiddenHeaderView;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, assign) NSString *coinPid;//币种信息
@end

NS_ASSUME_NONNULL_END
