//
//  ProtocolModel.h
//  ZYW_MIT
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProtocolModel : NSObject
//content = <p></p><p>尊敬的用户：</p><p>&nbsp; &nbsp; 有什么不明白的地方，请填写反馈。我们将在第一时间处理。<br></p>;
//id = 7;
//title = 帮助中心;
//type = 10;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *type;


@end

NS_ASSUME_NONNULL_END
