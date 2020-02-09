//
//  Shop_Publish_View.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/11.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Shop_Publish_View.h"
#import "AFNetworking.h"
#import "WL_Network_Model.h"
#import "UIImageView+WebCache.h"

#define ktag(a) 1000000 + a
@interface Shop_Publish_View()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSString *_title;
    CGFloat _top;
    NSString *_subTitle;
    NSInteger _limit;
    NSInteger _imgLimit;
    NSInteger _imgType;

    NSMutableArray *_dataSoureArray;
    

}
@property (nonatomic, strong) UILabel *beiJIngLabel;
@property (nonatomic, strong) UILabel *beiJIngNumLabel;
@property (nonatomic, strong) UILabel *titleLabel;



@property (nonatomic, strong) UIView *septorLine;




@property (nonatomic, strong) UILabel *limitLable;



@property (nonatomic, strong) NSMutableArray *allBtnArray;

@property (nonatomic, strong) NSMutableArray *allImgArray;

@property (nonatomic, strong) NSString *dtitle; 

@property (nonatomic, strong) NSString *dsubtitle;
@property (nonatomic, assign) CGFloat addBtTopSpace;


@end


@implementation Shop_Publish_View
@synthesize imgUrlArray = _imgUrlArray;

- (void)setImgUrlArray:(NSMutableArray *)imgUrlArray
{
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:imgUrlArray];
    
    for (NSString *string in array) {
        if ([string isEqual:[NSNull null]] || [string isEqualToString:@"(null)"]) {
            [imgUrlArray removeObject:string];
        }
    }
    
    _imgUrlArray = imgUrlArray;
}

-(instancetype)initWithTop:(CGFloat)top Title:(NSString *)title subTiles:(NSString *)subTiles limit:(NSInteger)limit andDecripTitle:(NSString*)dtitle subTitle:(NSString*)dsubTitle andHeight:(CGFloat)height andImgLimit:(NSInteger)imgLimit andImgType:(NSInteger)type
{
    
    if (self = [super init])
    {
        _imgType=type;
        
        _top = top;
        
        _imgLimit=imgLimit;
        
        _title = title;
        
        _subTitle = subTiles;
        
        _limit = limit;
        
        _dtitle=dtitle;
        
        _dsubtitle=dsubTitle;
        
        if (_dtitle.length==0) {
            
            height-=25;
        }
        
        
        self.frame = CGRectMake(0, _top, ScreenWidth, height);
        
        self.backgroundColor = kBgColor353750;
        
        [self viewConfig];
        
    }
    return self;
};

-(void)viewConfig
{
    if (_title.length) {
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.limitLable];
        [self addSubview:self.textView];
        [self addSubview:self.septorLine];
        
        [self.textView addSubview:self.placeHolder];
    }
    
   
    
    
    if (_dtitle) {
        
        [self addSubview:self.beiJIngLabel];

    }
    
    if (_dsubtitle) {
        
        [self addSubview:self.beiJIngNumLabel];

        
    }
    
    
    [self addSubview:self.addImgeBtn];
   
}
-(NSMutableArray *)dataSoureArray
{
    if (!_dataSoureArray) {
        _dataSoureArray = [NSMutableArray array];
    }
    return _dataSoureArray;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:_title font:systemFont(15) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), ScaleW(15), ScreenWidth - ScaleW(30), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _titleLabel;
}

-(UITextView *)textView
{
    if (!_textView) {
        
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(15) + _titleLabel.bottom, _titleLabel.width, ScaleW(100))];
        _textView.backgroundColor = kBgColor353750;
        _textView.textColor = kMainTextColor;
        _textView.delegate = self;
        
       
    }
    return _textView;
}
-(UILabel *)placeHolder
{
    if (!_placeHolder) {
        _placeHolder = [[UILabel alloc]initWithFrame:CGRectMake(0, _titleLabel.bottom, _textView.width, ScaleW(15))];
        [_placeHolder label:_placeHolder font:ScaleW(15) textColor:kSubTxtColor text:_subTitle];
    }
    
    return _placeHolder;
}

-(UILabel *)limitLable
{
    if (!_limitLable) {
        
       
        _limitLable = [WLTools allocLabel: [NSString stringWithFormat:@"0/%ld",_limit] font:systemFont(ScaleW(13)) textColor:kSubSubTxtColor frame:CGRectMake(ScreenWidth/2.f, _titleLabel.top, ScreenWidth/2.f-ScaleW(15), ScaleW(13)) textAlignment:(NSTextAlignmentRight)];
        //_limitLable.hidden = YES;
    }
    return _limitLable;
}

-(UIView *)septorLine
{
    if (!_septorLine) {
        if ([self.dtitle hasPrefix:SSKJLocalized(@"店铺", nil)]) {
            
            _septorLine = [[UIView alloc]initWithFrame:CGRectMake(0, _textView.bottom, ScreenWidth, ScaleW(10))];
        }
        else{
            
          _septorLine = [[UIView alloc]initWithFrame:CGRectMake(0, _textView.bottom, ScreenWidth, ScaleW(1))];
        }
   
        _septorLine.backgroundColor = kLineGrayColor;
    }
    return _septorLine;
}

-(UIButton *)addImgeBtn
{
    if (!_addImgeBtn)
    {
        _addImgeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_addImgeBtn btn:_addImgeBtn font:ScaleW(15) textColor:0 text:@"" image:nil sel:@selector(addImgeBtnAction:) taget:self];
        
        _addImgeBtn.backgroundColor = UIColorFromRGB(0x5a5c76);
        
        
        if (_dtitle.length) {
            _addImgeBtn.frame = CGRectMake(ScaleW(15),_beiJIngLabel.bottom+ScaleW(15), ScaleW(64), ScaleW(64));
            _addBtTopSpace=_beiJIngLabel.bottom+ScaleW(15);
            
        }
        else if(_title.length){
            _addImgeBtn.frame = CGRectMake(ScaleW(15),_septorLine.bottom+ScaleW(15), ScaleW(64), ScaleW(64));
            _addBtTopSpace=_septorLine.bottom+ScaleW(15);

        }
        else{
            
            
            _addImgeBtn.frame = CGRectMake(ScaleW(15),ScaleW(15), ScaleW(64), ScaleW(64));
            _addBtTopSpace=ScaleW(15);

        }
       
        
        [_addImgeBtn setImage:[UIImage imageNamed:@"shopShot"] forState:(UIControlStateNormal)];

        
    }
    return _addImgeBtn;
}

-(void)addImgeBtnAction:(UIButton *)sender
{
    
    
    [self alertController];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.placeHolder.hidden = YES;
    if (_textView.text.length) {
        
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (!_textView.text.length) {
        self.placeHolder.hidden = NO;
    }
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    NSString *contentText = textView.text;
    self.placeHolder.hidden = YES;

    if (contentText.length > _limit) {
        [MBProgressHUD showError:@"输入长度大于限制数"];
        _textView.text = [contentText substringToIndex:_limit];
    }
    else
    {
        self.limitLable.text = [NSString stringWithFormat:@"%ld/%ld",textView.text.length,_limit];
    }
    
    
}




#pragma mark -----------上传图片

- (void)alertController {
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
    }];
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:SSKJLocalized(@"打开相机", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self presentPickerConroller:imagePickerController sourceType:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:SSKJLocalized(@"打开相册", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self presentPickerConroller:imagePickerController sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    [alertVc addAction:cancle];
    [alertVc addAction:camera];
    [alertVc addAction:photo];
    alertVc.modalPresentationStyle = UIModalPresentationFullScreen;

    [[self topViewController]  presentViewController:alertVc animated:YES completion:nil];
}
- (void)presentPickerConroller:(UIImagePickerController *)imagePickerController sourceType:(UIImagePickerControllerSourceType)sourceType
{
    if (_imgType ==2) {
        
        imagePickerController.allowsEditing=NO;
    }
    else{
        imagePickerController.allowsEditing=YES;

    }
    imagePickerController.sourceType = sourceType;
    imagePickerController.videoQuality=UIImagePickerControllerQualityTypeMedium;
    
    imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;

    //WS(weakSelf);
    [[self topViewController] presentViewController:imagePickerController animated:YES completion:^{
        //LSLog(Localized(@"present成功", nil));
        // [weakSelf hiddenView];
    }];
}
- (void)saveImage:(UIImage *)image
{
    NSMutableArray *array =  self.dataSoureArray;
    
    [array addObject:image];
    
    self.dataSoureArray = array;
    
    [self showBt];
    
}
-(void)setOldImgArray:(NSArray *)oldImgArray{
  
    for (UIImageView *image in self.allImgArray) {
        [image removeFromSuperview];
    }
    
    for (UIImageView *btn in self.allBtnArray) {
        [btn removeFromSuperview];
    }
    
    [self.dataSoureArray removeAllObjects];
    
    self.dataSoureArray=[[NSMutableArray alloc]initWithCapacity:oldImgArray.count];
      [self showBt];
    
    
     [WLTools fetchCacheImgs:oldImgArray finishBlk:^(NSArray *arrImgs) {
         NSInteger maxnum=5;
         
         CGFloat space=ScaleW(15);
         
         CGFloat btWidth = (self.width-(maxnum+1)*space)/5.0;
         
         [self.dataSoureArray addObjectsFromArray:arrImgs];
        
         self.addImgeBtn.left = space+(self.dataSoureArray.count%maxnum)* (btWidth + space);
         self.addImgeBtn.top = self->_addBtTopSpace+(btWidth+space)*(self.dataSoureArray.count/maxnum);
         
         
         for (int i = 0; i < self.dataSoureArray.count; i ++ ) {
             
             UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(space+(i%maxnum)* (btWidth +space),self.addImgeBtn.top+(btWidth+space)*(i/maxnum), btWidth, btWidth)];
             
             [self.allImgArray addObject:imageView];
             
             [self addSubview:imageView];
             
             
             if ([self.dataSoureArray[i] isKindOfClass:[UIImage class]]) {
                 UIImage *img=self.dataSoureArray[i];

                 [imageView setImage:img];

             }
             
             UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
             
             deleteBtn.frame = CGRectMake(imageView.right-ScaleW(10),  imageView.top-ScaleW(10), ScaleW(19), ScaleW(19));
             
             [deleteBtn setBackgroundImage:[UIImage imageNamed:@"delet_btn"] forState:(UIControlStateNormal)];
             
             [deleteBtn addTarget:self action:@selector(deleAction:) forControlEvents:(UIControlEventTouchUpInside)];
             
             deleteBtn.tag = ktag(i);
             
             [self.allBtnArray addObject:deleteBtn];
             
             [self addSubview:deleteBtn];
             
         }
         
         
    }];
    
    
    
    NSMutableString *mstr=[NSMutableString new];
    
    for (int i=0; i<oldImgArray.count; i++) {
        
        NSString *str=oldImgArray[i];
        
        if (i==oldImgArray.count -1) {
            
            [mstr appendFormat:@"%@,",str];
            
        }
        else{
            
            [mstr appendFormat:@"%@",str];
            
        }
    }
    self.contenUrlString=mstr;
    
    self.contenUrlArray=[oldImgArray mutableCopy];
    
    self.imgUrlArray=[oldImgArray mutableCopy];
    
    
}
-(void)showBt{
    if (self.dataSoureArray.count>=_imgLimit) {
        
        self.addImgeBtn.hidden=YES;
    }
    else{
        self.addImgeBtn.hidden=NO;
        
    }
    
}
-(void)setDataSoureArray:(NSMutableArray *)dataSoureArray
{
    _dataSoureArray = dataSoureArray;
    
    [self showBt];

//    if (_dataSoureArray.count > 3) {
//
//        [_dataSoureArray removeObjectAtIndex:0];
//    }
    
    for (UIImageView *image in self.allImgArray) {
        [image removeFromSuperview];
    }
    
    for (UIImageView *btn in self.allBtnArray) {
        [btn removeFromSuperview];
    }
    
    NSInteger maxnum=5;
    
    CGFloat space=ScaleW(15);
    
    CGFloat btWidth = (self.width-(maxnum+1)*space)/maxnum;
    
    for (int i = 0; i < _dataSoureArray.count; i ++ ) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15)+(i%maxnum)* (btWidth +space), _addBtTopSpace+(btWidth+space)*(i/maxnum), btWidth, btWidth)];
        
        [self.allImgArray addObject:imageView];
        
        [self addSubview:imageView];
        
        if ([_dataSoureArray[i] isKindOfClass:[UIImage class]]) {
            imageView.image = _dataSoureArray[i];

            
        }
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        deleteBtn.frame = CGRectMake(imageView.right-ScaleW(10),  imageView.top-ScaleW(10), ScaleW(19), ScaleW(19));
        
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"delet_btn"] forState:(UIControlStateNormal)];
        
        [deleteBtn addTarget:self action:@selector(deleAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        deleteBtn.tag = ktag(i);
        
        [self.allBtnArray addObject:deleteBtn];
        
        [self addSubview:deleteBtn];
        
    }
    
//    self.addImgeBtn.left = ScaleW(15)+(_dataSoureArray.count)* (ScaleW(64) + ScaleW(10));
    
    self.addImgeBtn.left = space+(self.dataSoureArray.count%maxnum)* (btWidth + space);
    self.addImgeBtn.top = self->_addBtTopSpace+(btWidth+space)*(self.dataSoureArray.count/maxnum);
    
}

-(void)deleAction:(UIButton *)sender
{
        
    NSMutableArray *array =  self.dataSoureArray;
        
    [array removeObjectAtIndex:sender.tag - ktag(0)];
        
    self.dataSoureArray = array;
        
   
    
    NSMutableArray *imgArray = self.contenUrlArray;
    
    if (imgArray.count >sender.tag - ktag(0)) {
        
        [imgArray removeObjectAtIndex:sender.tag - ktag(0)];

    }
    
    self.contenUrlArray = imgArray;
    
    if (self.imgUrlArray.count >sender.tag - ktag(0)) {
        
        [self.imgUrlArray removeObjectAtIndex:sender.tag - ktag(0)];
        
        
    }
    
    
    [self showBt];

}


-(NSMutableArray *)allImgArray
{
    if (!_allImgArray) {
        _allImgArray = [NSMutableArray array];
    }
    return _allImgArray;
}
-(NSMutableArray *)allBtnArray
{
    if (!_allBtnArray) {
        _allBtnArray = [NSMutableArray array];
    }
    return _allBtnArray;
}


#pragma mark - photo delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //获取返回的图片
  UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    UIImage *newImage = [UIImage imageWithData:imageData];
    
    [self upLoadImgImge:newImage];
    
    [self performSelector:@selector(saveImage:) withObject:newImage afterDelay:0.5];
    
    [[self topViewController] dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
}


-(void)upLoadImgImge:(UIImage *)img
{
//    WS(weakSelf);
//
//    //DragonCommonFileUpImgUrl
//
//    NSData *data = UIImageJPEGRepresentation(img, 1);
//    double value =  (3*1024*1024.f)/data.length;
//    if (value > 1) {
//        value = 1.f;
//    }
//    if (value<=1) {
//        value = value;
//    }
//    NSLog(@"%.f",value);
//    data = UIImageJPEGRepresentation(img, value);
//    UIImage *resultImage = [UIImage imageWithData:data];
//    NSArray *photosArr = @[resultImage];
//    //NSLog(@"photosArr : %@",photosArr);
//    // 基于AFN3.0+ 封装的HTPPSession句柄
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    //[manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"systemType"];
//    manager.requestSerializer.timeoutInterval = 20;
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
//    // 在parameters里存放照片以外的对象
//
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.superview.superview animated:YES];
//
//    [manager POST:KuploadImg parameters:@{@"file":resultImage} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        //         formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
//        //         这里的photoArr是你存放图片的数组
//
//        for (int i = 0; i < photosArr.count; i++)
//        {
//
//            UIImage *image = photosArr[i];
//
//            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
//
//            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
//            // 要解决此问题，
//            // 可以在上传时使用当前的系统事件作为文件名
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            // 设置时间格式
//            [formatter setDateFormat:@"yyyyMMddHHmmss"];
//
//            NSString *dateString = [formatter stringFromDate:[NSDate date]];
//
//            NSString *fileName = [NSString  stringWithFormat:@"%@_%d.jpg", dateString,i];
//
//            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
//
//
//
//        }
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        //             //LSLog(Localized(@"---上传进度--- %@", nil),uploadProgress);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        //LSLog(Localized(@"```上传成功``` %@", nil),responseObject);
//        [hud hideAnimated:YES];
//        WL_Network_Model *netwok_model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
//
//
//        NSArray *array=netwok_model.data;
//        NSDictionary *dict=array.firstObject;
//
//        [weakSelf.imgUrlArray addObject:[NSString stringWithFormat:@"%@",dict[@"pic_url"]]];
//
//
//        self.contenUrlArray = self.imgUrlArray;
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [hud hideAnimated:YES];
//        [MBProgressHUD showError:@"上传失败"];
//
//    }];
    
    WS(weakSelf);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.superview.superview animated:YES];
    
    NSMutableDictionary *dict=[NSMutableDictionary new];
    
    [dict setObject:@(_imgType) forKey:@"type"];
    
    [[WLHttpManager shareManager]  upLoadImageByUrl:KuploadImg ImageName:@"file" Params:dict Image:img CallBack:^(id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.superview.superview animated:YES];
         
         
         WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         //!< 如果上传成功就把当前图片地址存到数组中并进行下一步操作
         if (netModel.status.integerValue == SUCCESSED)
         {
             
         
             
             [weakSelf.imgUrlArray addObject:netModel.data];
            
             weakSelf.contenUrlArray=weakSelf.imgUrlArray;
             
             SsLog(@"count::%ld",weakSelf.imgUrlArray.count);
         SsLog(@"contenUrlArrayCount::%ld",weakSelf.contenUrlArray.count);

         }
         else
         {
             [MBProgressHUD showError:netModel.msg];
         }
         
     } Failure:^(NSError *error)
     {
         
       [MBProgressHUD hideHUDForView:weakSelf.superview.superview animated:YES];         [MBProgressHUD showError:error.localizedDescription];
         
      }];
}
-(NSMutableArray *)imgUrlArray
{
    if (!_imgUrlArray) {
        _imgUrlArray = [NSMutableArray array];
        
    }
    return _imgUrlArray;
}

-(void)setContenUrlArray:(NSMutableArray *)contenUrlArray
{
    _contenUrlArray = contenUrlArray;
  
    self.shotCutString = _contenUrlArray.lastObject;
  
   
    
    NSMutableString *mstr=[NSMutableString new];
    
    for (int i=0; i<_contenUrlArray.count; i++) {
        
        NSString *url=_contenUrlArray[i];
        
        if (i==_contenUrlArray.count-1) {
            
            [mstr appendFormat:@"%@",url];
            
        }
        
        else{
            
            [mstr appendFormat:@"%@,",url];
            
        }
    }
    self.contenUrlString=mstr;
    
}

-(UILabel *)beiJIngLabel{
    
    if (nil == _beiJIngLabel) {
        
        if (_title) {
            
             _beiJIngLabel=[WLTools allocLabel:_dtitle font:systemFont(14) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), _septorLine.bottom+ScaleW(15), ScaleW(145), 15) textAlignment:NSTextAlignmentLeft];
        }
        else{
             _beiJIngLabel=[WLTools allocLabel:_dtitle font:systemFont(14) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), ScaleW(15), ScaleW(145), 15) textAlignment:NSTextAlignmentLeft];
        }
       
        
        _beiJIngLabel.adjustsFontSizeToFitWidth=YES;
        
    }
    
    return _beiJIngLabel;
    
}
-(UILabel *)beiJIngNumLabel{
    
    if (nil == _beiJIngNumLabel) {
        
        
        _beiJIngNumLabel=[WLTools allocLabel:_dsubtitle font:systemFont(12) textColor:kSubSubTxtColor frame:CGRectMake(_beiJIngLabel.right, _beiJIngLabel.top, 150, 14) textAlignment:NSTextAlignmentLeft];
        
        _beiJIngNumLabel.adjustsFontSizeToFitWidth=YES;
    }
    
    return _beiJIngNumLabel;
    
}


-(void)clearDatas
{
    self.placeHolder.hidden = YES;
};

-(void)showData
{
    self.placeHolder.hidden = NO;
};

-(void)limitHidden
{
    self.limitLable.hidden = YES;
}
@end
