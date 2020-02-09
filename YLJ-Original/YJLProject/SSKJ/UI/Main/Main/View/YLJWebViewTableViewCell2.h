//
//  YLJWebViewTableViewCell2.h
//  SSKJ
//
//  Created by cy5566 on 2019/11/28.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLJWebViewTableViewCell2 : UITableViewCell
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,copy) NSString *htmlString;

@property (nonatomic, copy) void(^changeHeightBlock)(NSInteger webViewHeightChanged);
@end

NS_ASSUME_NONNULL_END
