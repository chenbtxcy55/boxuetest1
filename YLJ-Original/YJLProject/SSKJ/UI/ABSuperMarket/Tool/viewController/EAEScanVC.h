//
//  EAEScanVC.h
//  SSKJ
//
//  Created by 张超 on 2018/9/14.
//  Copyright © 2018年 James. All rights reserved.
//

#import  "SSKJ_BaseViewController.h"

typedef void(^QRUrlBlock)(NSString *url);

@interface EAEScanVC : SSKJ_BaseViewController

@property (nonatomic, copy) QRUrlBlock qrUrlBlock;

@end
