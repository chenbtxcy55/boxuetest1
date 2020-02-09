//
//  FBCGetBillViewController.m
//  SSKJ
//
//  Created by 张本超 on 2019/5/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "FBCGetBillViewController.h"

@interface FBCGetBillViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pswTf;

@end

@implementation FBCGetBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_pswTf setBorderWithWidth:1 andColor:kLineGrayColor];
    _pswTf.leftViewMode = UITextFieldViewModeAlways;
  UIView *  view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 12, 45)];
    _pswTf.leftView = view;
    [_pswTf textField:_pswTf textFont:13 placeHolderFont:13 text:nil placeText:@"请输入安全密码" textColor: kMainTextColor placeHolderTextColor:kTextDarkBlueColor];
}

- (IBAction)cancellAction:(id)sender {
}
- (IBAction)ensureBtn:(id)sender {
}

@end
