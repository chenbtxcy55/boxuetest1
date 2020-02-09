//
//  HomepageCollectionViewCell.h
//  SSKJ
//
//  Created by 张本超 on 2019/5/15.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSKJ_Market_Index_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomepageCollectionViewCell : UICollectionViewCell
-(void)setCoinModel:(SSKJ_Market_Index_Model *)coinModel;
@end

NS_ASSUME_NONNULL_END
