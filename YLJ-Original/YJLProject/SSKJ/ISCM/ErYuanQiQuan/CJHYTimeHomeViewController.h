

#import "SSKJ_BaseViewController.h"
#import "JB_Market_Index_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface CJHYTimeHomeViewController : SSKJ_BaseViewController
@property (nonatomic, assign) BOOL isFromBBTrade;

@property (nonatomic, strong) JB_Market_Index_Model *coinModel;

@end

NS_ASSUME_NONNULL_END
