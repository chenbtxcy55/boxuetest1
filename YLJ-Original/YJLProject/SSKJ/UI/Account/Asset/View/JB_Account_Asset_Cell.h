//
//  JB_Account_Asset_Cell.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JB_Account_Asset_Index_Model.h"
#import "JB_Account_Asset_HeaderView.h"
NS_ASSUME_NONNULL_BEGIN

@interface JB_Account_Asset_Cell : UITableViewCell
-(void)setCellWithModel:(JB_Account_Asset_Index_Model *)coinModel assetType:(AssetType)assetType;
@end

NS_ASSUME_NONNULL_END
