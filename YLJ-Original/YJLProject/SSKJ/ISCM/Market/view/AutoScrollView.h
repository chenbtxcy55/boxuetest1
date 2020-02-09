//
//  AutoScrollView.h
//  SSKJ
//
//  Created by zpz on 2019/7/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AutoScrollView : UIView

- (instancetype)initWithImages:(NSArray *)imgs timeInterval:(NSTimeInterval)interval;

- (void)setImages:(NSArray *)imgs;

@property (nonatomic,copy)void(^selectedBlock)(NSInteger);


@end


@interface AutoScrollViewCell : UICollectionViewCell

@property(nonatomic, strong)UIImageView *imageV;

@end


NS_ASSUME_NONNULL_END
