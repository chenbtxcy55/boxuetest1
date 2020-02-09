//
//  HeBi_SecondCertificate_View.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, PhotoType) {
    PhotoTypeFront,     // 身份证正面
    PhotoTypeBack,      // 身份证背面
    PhotoTypeHand,      // 手持身份证
};

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_SecondCertificate_View : UIView
@property (nonatomic, copy) void (^selectPhotoBlock)(PhotoType photoType);
@property (nonatomic, assign) PhotoType photoType;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *imgURL;

@end

NS_ASSUME_NONNULL_END
