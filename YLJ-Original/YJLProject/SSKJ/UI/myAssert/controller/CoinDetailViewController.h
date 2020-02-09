//
//  CoinDetailViewController.h
//  SSKJ
//
//  Created by 孙克强 on 2019/10/7.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoinDetailViewController : SSKJ_BaseViewController

@property(nonatomic,copy)NSString * pidStr;

@property(nonatomic,copy)NSString * codeStr;

@property(nonatomic,copy)NSDictionary * codeDetailDic;

@end

NS_ASSUME_NONNULL_END
