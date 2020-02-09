//
//  AJSearchBar.h
//  准到-ipad
//
//  Created by zhundao on 2017/9/8.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AJSearchBarBlock)(void);

@protocol SearchDelegate <NSObject>

- (void)searchWithStr :(NSString *)text;

- (void)qingChu;

@end


@interface AJSearchBar : UIView

@property (nonatomic, copy) AJSearchBarBlock block;

@property(nonatomic,copy)NSString *AJPlaceholder;

@property(nonatomic,strong)UIColor *AJCursorColor;

@property(nonatomic,weak) id<SearchDelegate> SearchDelegate;

@property(nonatomic,strong )NSString *name;

@end
