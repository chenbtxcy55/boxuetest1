//
//  SKMy_Info_DetailVC.m
//  SSKJ
//
//  Created by 孙 on 2019/7/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SKMy_Info_DetailVC.h"
#import "UIImagePickerController+ST.h"
#import "RegularExpression.h"

@interface SKMy_Info_DetailVC ()<UITableViewDelegate,UITableViewDataSource, UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong)UIImage * myImage;

@end

@implementation SKMy_Info_DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainTableView];
    [self.navigationController setNavigationBarHidden:NO];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    self.title = SSKJLocalized(@"个人信息", nil);
    
}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height_NavBar) style:UITableViewStyleGrouped];
        _mainTableView.backgroundColor = WLColor(246, 247, 251, 1);
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedRowHeight = 0;
        
        _mainTableView.estimatedSectionFooterHeight = 0;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _mainTableView.scrollEnabled = NO;
    }
    return _mainTableView;
}
#pragma mark -- UITableViewDelegate,UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    for (id view in [cell.contentView subviews])
    {
        
        [view removeFromSuperview];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel * label = [UILabel new];
    label.textColor = [UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:ScaleW(15)];
    label.textAlignment = NSTextAlignmentLeft;
    label.frame =  CGRectMake(15, 0, 100, 50);

    [cell.contentView addSubview:label];
    
    UILabel * contentLabel = [UILabel new];
    contentLabel.textColor = [UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
    contentLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:ScaleW(14)];
    contentLabel.textAlignment = NSTextAlignmentRight;
    contentLabel.frame =  CGRectMake(ScreenWidth-200 - 15, 0, 200, 50);
    [cell.contentView addSubview:contentLabel];
    
    UIImageView* lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49.5, ScreenWidth, .5)];
    lineImageView.backgroundColor = WLColor(231,234,237,1);
    [cell.contentView addSubview:lineImageView];
    
    switch (indexPath.row) {
        case 0:
        {
            label.text = @"账户名";
            
            contentLabel.text =[self setupTitle:kISCMPhoneNumber];

            contentLabel.hidden = NO;
            

            
        }
            break;
        case 1:
        {
            
            label.text = @"头像";
            contentLabel.hidden = YES;

            
         
            UIImageView * headerImageView =[[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 8 -15 -12 -37, (50 -37)/2, 37, 37)];
          
            headerImageView.layer.cornerRadius =  headerImageView.height/2;
            
            headerImageView.layer.masksToBounds = YES;
            
            headerImageView.image =[UIImage imageNamed:@"my_header"];
            
            if (self.myImage) {
                
                headerImageView.image = self.myImage;
            }
            else
            {
                
//                [headerImageView sd_setImageWithURL:[NSURL URLWithString:[SSKJ_User_Tool sharedUserTool].userInfoModel.upic] placeholderImage:[UIImage imageNamed:@"my_header"]];
                [headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ProductBaseServer,[SSKJ_User_Tool sharedUserTool].userInfoModel.upic]] placeholderImage:[UIImage imageNamed:@"my_header"]];
            }
            
            [cell.contentView addSubview:headerImageView];
            
            UIImageView * arrowImageView =[[UIImageView alloc] initWithFrame:CGRectMake(headerImageView.right + 12, (50-14)/2, 8, 14)];
            arrowImageView.image =[UIImage imageNamed:@"my_rightArrow"];
            
            [cell.contentView addSubview:arrowImageView];
            
            UIButton * headBtn =[UIButton buttonWithType:UIButtonTypeCustom];
            
            headBtn.frame = CGRectMake(0, 0, ScreenWidth, 50);
            
            [headBtn addTarget:self action:@selector(headEvent:) forControlEvents:UIControlEventTouchUpInside];
            headBtn.backgroundColor = [UIColor clearColor];
             
            [cell.contentView addSubview:headBtn];

        }
            break;
        case 2:
        {
            
            label.text = @"UID";
            contentLabel.text = [SSKJ_User_Tool sharedUserTool].userInfoModel.uid;

            
            
            
        }
            break;
       
        default:
            break;
    }
    
    
    
    
    return cell;
    
    
    
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return [UIView new];
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
#pragma mark -- 点击头像
-(void)headEvent:(UIButton *)sender
{
    UIAlertController *alertController = [[UIAlertController alloc]init];
    
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *controller = [UIImagePickerController imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
        
        if ([controller isAvailableCamera] && [controller isSupportTakingPhotos]) {
            [controller setDelegate:self];
            controller.modalPresentationStyle = UIModalPresentationFullScreen;

            [self presentViewController:controller animated:YES completion:nil];
        }else {
            NSLog(@"%s %@", __FUNCTION__, @"相机权限受限");
        }
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *controller = [UIImagePickerController imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [controller setDelegate:self];
        if ([controller isAvailablePhotoLibrary]) {
            controller.modalPresentationStyle = UIModalPresentationFullScreen;

            [self presentViewController:controller animated:YES completion:nil];
        }    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:action0];
    [alertController addAction:action1];
    [alertController addAction:action2];
    alertController.modalPresentationStyle = UIModalPresentationFullScreen;

    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - 2.UIImagePickerController的委托

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *imageOriginal = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        [self uploadImage:imageOriginal];
        
      
       
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark 上传图片
-(void)uploadImage:(UIImage*)image
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //!< 限制图片在1M以内
    image = [UIImage compressImageQuality:image toByte:(1*1024)];
    WS(weakSelf);
    [[WLHttpManager shareManager]  upLoadImageByUrl:kIscm_Home_set_photo_Api ImageName:@"file_pic" Params:nil Image:image CallBack:^(id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         
         
         WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         //!< 如果上传成功就把当前图片地址存到数组中并进行下一步操作
         if (netModel.status.integerValue == SUCCESSED)
         {
             self.myImage = image;
             
             [self.mainTableView reloadData];
             
         }
         else
         {
             [MBProgressHUD showError:netModel.msg];
         }
     } Failure:^(NSError *error)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
     }];
}

- (NSString *)setupTitle:(NSString *)title {
    NSMutableString* str1 = [[NSMutableString alloc]initWithString:title];
    NSString *mobileStr;
    if ([RegularExpression validateMobile:title] ) {
        mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }else{
        NSRange range = [title rangeOfString:@"@"];
        
        if (range.location == 0) {
            [str1 insertString:@"*" atIndex:1];
            mobileStr = [NSString stringWithFormat:@"%@",str1];
        }else if (range.location == 1){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"*"];
        }else if (range.location == 2){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"****"];
        }else if (range.location == 3){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(1, 2) withString:@"****"];
        }else if (range.location == 4){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(2, 2) withString:@"****"];
        }else if (range.location == 5){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(2, 3) withString:@"****"];
        }else{
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(2, 4) withString:@"****"];
        }
    }
    return mobileStr;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
