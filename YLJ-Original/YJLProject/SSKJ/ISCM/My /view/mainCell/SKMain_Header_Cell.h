//
//  SKMain_Header_Cell.h
//  SSKJ
//
//  Created by 孙 on 2019/7/18.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKMain_Header_Cell : UITableViewCell

@property(nonatomic,strong)UILabel * phoneLab;

@property(nonatomic,strong)UILabel * uidLab;

@property(nonatomic,strong)UILabel * stateLab;

@property(nonatomic,strong)UIImageView * headerImageView;

@property(nonatomic,copy)void (^myBlock)(NSInteger index);
//@property(nonatomic,copy)void (^jumpMyInfo)(void);


@end

NS_ASSUME_NONNULL_END
