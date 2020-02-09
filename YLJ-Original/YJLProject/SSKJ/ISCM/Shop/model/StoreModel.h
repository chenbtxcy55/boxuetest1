//
//  StoreModel.h
//  SSKJ
//
//  Created by apple on 2019/9/16.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreModel : NSObject

@property (nonatomic,strong) NSString *id;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *phone;

@property (nonatomic,strong) NSString *address;

@property (nonatomic,strong) NSString *detail;

@property (nonatomic,strong) NSArray *pic_urls;

@property (nonatomic,strong) NSArray *detail_pic_urls;

@property (nonatomic,strong) NSArray *thumbnail_pic;


@property (nonatomic,strong) NSString *qq;

@end

NS_ASSUME_NONNULL_END
