//
//  BillingRecordsCell.h
//  SSKJ
//
//  Created by 孙 on 2019/7/23.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BillingRecordsCell : UITableViewCell
-(void)setValuedataSoure:(id)dataSoure type:(NSInteger)type;
-(void)setValuedataSoure:(id)dataSoure typeStr:(NSString*)type;

@end

NS_ASSUME_NONNULL_END
