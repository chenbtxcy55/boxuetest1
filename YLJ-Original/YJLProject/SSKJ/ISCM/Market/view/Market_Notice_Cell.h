//
//  Market_Notice_Cell.h
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/4/26.
//  Copyright © 2019 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GoCoin_TradingGuide_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface Market_Notice_Cell : UITableViewCell

- (void)initDataWithModel:(GoCoin_TradingGuide_Model *)Model;

@end

NS_ASSUME_NONNULL_END
