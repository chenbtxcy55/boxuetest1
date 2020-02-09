//
//  Shop_PublishView_ViewController.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/11.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Shop_PublishView_ViewController.h"

#import "Shop_Publish_headerView.h"

#import "Shop_PuplishSucess_View.h"

#define KNUM @"0123456789."
#define KZNUM @"0123456789"


@interface Shop_PublishView_ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) Shop_Publish_headerView *headerView;

@property (nonatomic, strong) Shop_PuplishSucess_View *sucessView;

@property (nonatomic, strong) NSMutableArray *LArray;

@property (nonatomic, strong) NSMutableArray *JArray;

@property (nonatomic, strong) NSString *imgCut;


@end

@implementation Shop_PublishView_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    
    self.title = SSKJLocalized(@"发布商品", nil);
    
    if (_model) {
        
        self.title=SSKJLocalized(@"编辑商品", nil);
        
        [self.headerView.shopView limitHidden];
        [self.headerView.detailView limitHidden];

        [self loadGoodsDetail];
        
        
   }
    
    
}
-(void)loadGoodsDetail{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *pamas = @{@"goods_id":_model.id};
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:KEditGoodsInfo RequestType:RequestTypeGet Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [self.tableView.mj_header endRefreshing];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status integerValue] == SUCCESSED) {
            
          
            
            ICC_PreOrder_GoodsInfo_Model *model=[ICC_PreOrder_GoodsInfo_Model mj_objectWithKeyValues:netWorkModel.data];
            self->_model=model;
            
            
            self.headerView.shopView.textView.text =model.name;
            
            self.headerView.detailView.textView.text=model.details;
            
            self.headerView.cateId=[NSString stringWithFormat:@"%@",model.category_id];
            
            NSArray *typearray=[SSKJ_User_Tool sharedUserTool].typeArray;
            
            
            for (NSDictionary *dict in typearray) {
                
              SsLog(@"type_name::::%@",[dict objectForKey:@"type_name"]);
                
                if ([[dict objectForKey:@"type_id"] integerValue]== [model.category_id integerValue]) {
             
                    SsLog(@"type_name::::%@",[dict objectForKey:@"type_name"]);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.headerView.shopTypeTf.textFild.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"type_name"]];
                    });
                   
                

                }
            }
//            self.headerView.shopPriceTf.textFild.text=[NSString stringWithFormat:@"%@",model.can_sell_price];
             self.headerView.daiShouStoreTf.textFild.text=[NSString stringWithFormat:@"%@",model.rmb_price];
            self.headerView.kuaiDiStoreTf.textFild.text=[NSString stringWithFormat:@"%@",model.freight];
            self.headerView.shopStoreTf.textFild.text=[NSString stringWithFormat:@"%@",model.skus];
            
            self.headerView.shopView.oldImgArray=model.pic_urls;
           self.headerView.detailView.oldImgArray=model.detail_pic_urls;
            
            if (model.thumbnail_pic.length) {
                
                self.headerView.shuoView.oldImgArray=@[model.thumbnail_pic];

            }
//            self.headerView.shopView.contenUrlString=model.pic_urls;
//            self.headerView.detailView.contenUrlString=model.detail_pics;

            
            
        }else{
            [MBProgressHUD showError:netWorkModel.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
}
-(Shop_Publish_headerView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[Shop_Publish_headerView alloc]init];
        WS(weakSelf);
        
        _headerView.commitBlock = ^(NSDictionary * _Nonnull pamas) {
            if (weakSelf.model) {
                [weakSelf edtingActionRequst];
            }else{
                [weakSelf  publishActionRequst];
            }
           
        };
        if (_model) {
             _headerView.model = _model;
        }
        _headerView.shopPriceTf.textFild.delegate=self;
        _headerView.daiShouStoreTf.textFild.delegate=self;
        _headerView.kuaiDiStoreTf.textFild.delegate=self;
        _headerView.shopStoreTf.textFild.delegate=self;

        
       
    }
    return _headerView;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:KNUM];
    
    if (textField == self.headerView.shopStoreTf.textFild) {
        tmpSet = [NSCharacterSet characterSetWithCharactersInString:KZNUM];
    }
    int i = 0;
    while (i < string.length) {
        NSString * string2 = [string substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string2 rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


-(void)publishActionRequst
{
   // AB_Shop_order_owner_goods_add_post
    
    WS(weakSelf);
//    store_id    是    int    店铺ID
//    name    是    string    商品名称
//    sku_pics    是    string    商品图片
//    detail    是    text    商品简介
//    detai_pics    是    string    简介图片
//    can_sell_price    是    decimal    可售价格
//    wait_sell_price    是    decimal    待售价格
//    skus    是    int    商品库存
//    category_id    是    int    商品类型
//    freight    物流费用
    
    if (self.headerView.shuoView.contenUrlString.length == 0) {
        
        showAlert(@"请上传缩略图");
        return;
        
    }
    if (self.headerView.shopView.textView.text.length == 0) {
        
        showAlert(@"请填写商品名称");
        return;
        
    }
    
    if (self.headerView.shopView.shotCutString.length == 0) {
        
        showAlert(@"请上传商品轮播图");
        return;
        
    }
    
    if (self.headerView.detailView.textView.text.length == 0) {
        
        showAlert(@"请填写商品简介");
        return;
        
    }
    
    if (self.headerView.shopView.contenUrlString.length == 0) {
        
        showAlert(@"请上传商品详情图片");
        return;
        
    }
    
    if (self.headerView.cateId.length == 0) {
        
        showAlert(@"请选择商品类别");
        return;
        
    }

//    if ( self.headerView.shopPriceTf.textFild.text.length == 0) {
//
//        showAlert(@"请填写可售价格");
//        return;
//
//    }
    
    if (self.headerView.daiShouStoreTf.textFild.text.length == 0) {
        
        showAlert(@"请填写价格");
        return;
        
    }
    
    if (self.headerView.kuaiDiStoreTf.textFild.text.length == 0) {
        
        showAlert(@"请填写快递费用");
        return;
        
    }
    
    if (self.headerView.shopStoreTf.textFild.text.length == 0) {
        
        showAlert(@"请填写商品库存");
        return;
        
    }
    
    
    NSDictionary *params = @{@"name":self.headerView.shopView.textView.text,
         @"thumbnail_pic":self.headerView.shuoView.contenUrlString,
                            @"detail":self.headerView.detailView.textView.text,
//                             @"rmb_price":self.headerView.shopPriceTf.textFild.text,
                            @"rmb_price":self.headerView.daiShouStoreTf.textFild.text,
                                 @"category_id":self.headerView.cateId,
                              @"sku_pics":self.headerView.shopView.contenUrlString,
                             @"detail_pics":self.headerView.detailView.contenUrlString,
                              @"freight":self.headerView.kuaiDiStoreTf.textFild.text,
                             @"skus":self.headerView.shopStoreTf.textFild.text};
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_order_owner_goods_add_post RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == 200) {
            
            weakSelf.sucessView.hidden = NO;
           
          weakSelf.sucessView.ensureBlock = ^{
                weakSelf.sucessView.hidden = YES;
              [weakSelf.navigationController popViewControllerAnimated:YES];
            };
        }else{
            
            
            
        }
        //[MBProgressHUD showError:net_model.msg];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}

-(void)edtingActionRequst
{
    // AB_Shop_order_owner_goods_add_post
    
    WS(weakSelf);
    //    必选    类型    说明
    //    title    是    string    商品名称
    //    price    是    float    商品价格
    //    cateid    是    float    商品类型
    //    store    是    int    库存
    //    thumb    是    string    商品封面图地址
    //    thumb_list    是    string    商品轮播图 多个图片地址以 , 拼接
    //    content    否    string    商品简介
    //    remark    否    string    商品备注
    //    jianjie    是    string    详情简介图 多个图片地址以 , 拼接
    
  
//        self.headerView.shopView.dataSoureArray = lunbo;
//        self.headerView.detailView.dataSoureArray = jianjie;
   
    
   
    
    if (self.headerView.shuoView.contenUrlString.length == 0) {
        
        showAlert(@"请上传缩略图");
        return;
        
    }
    if (self.headerView.shopView.textView.text.length == 0) {
        
        showAlert(@"请填写商品名称");
        return;
        
    }
    
    if (self.headerView.shopView.shotCutString.length == 0) {
        
        showAlert(@"请上传商品轮播图");
        return;
        
    }
    
    if (self.headerView.detailView.textView.text.length == 0) {
        
        showAlert(@"请填写商品简介");
        return;
        
    }
    
    if (self.headerView.shopView.contenUrlString.length == 0) {
        
        showAlert(@"请上传商品详情图片");
        return;
        
    }
    
    if (self.headerView.cateId.length == 0) {
        
        showAlert(@"请选择商品类别");
        return;
        
    }
    
//    if ( self.headerView.shopPriceTf.textFild.text.length == 0 ) {
//
//        showAlert(@"请填写可售价格");
//        return;
//
//    }
//
  
   
    
    if (self.headerView.daiShouStoreTf.textFild.text.length == 0) {
        
        showAlert(@"请填写价格");
        return;
        
    }
    if (self.headerView.kuaiDiStoreTf.textFild.text.length == 0) {
        
        showAlert(@"请填写快递费用");
        return;
        
    }
  
    if (self.headerView.shopStoreTf.textFild.text.length == 0) {
        
        showAlert(@"请填写商品库存");
        return;
        
    }
   
    
    NSDictionary *params = @{@"name":self.headerView.shopView.textView.text,
                             @"thumbnail_pic":self.headerView.shuoView.contenUrlString,
                             @"detail":self.headerView.detailView.textView.text,
//                             @"can_sell_price":self.headerView.shopPriceTf.textFild.text,
                             @"rmb_price":self.headerView.daiShouStoreTf.textFild.text,
                             @"category_id":self.headerView.cateId,
                             @"sku_pics":self.headerView.shopView.shotCutString,
                             @"detail_pics":self.headerView.shopView.contenUrlString,
                             @"freight":self.headerView.kuaiDiStoreTf.textFild.text,
                             @"skus":self.headerView.shopStoreTf.textFild.text,
                             @"goods_id":_model.id
                             };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:VPay_Shop_EditGoods_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (net_model.status.integerValue == 200) {
            
             [kNotifyCenter postNotificationName:@"reloadOther2" object:nil];
            
            
//            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            
            
        }
        [MBProgressHUD showError:net_model.msg];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}



-(Shop_PuplishSucess_View *)sucessView
{
    if (!_sucessView) {
        _sucessView = [[Shop_PuplishSucess_View alloc]init];
        
        WS(weakSelf);
        self.sucessView.hidden = YES;
        
        
    }
    return _sucessView;
    
    
}
-(UITableView *)tableView
{
    if (nil == _tableView) {
        
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 10;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        _tableView.separatorColor = kMainBackgroundColor;
        _tableView.backgroundColor = kNavBGColor;

        
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        _tableView.tableHeaderView = self.headerView;
        
        // [_tableView registerClass:[JB_FBC_DealHall_Cell class] forCellReuseIdentifier:cellid];
        // WS(weakSelf);
        //        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //           // [weakSelf headerRefresh];
        //        }];
        
        //        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //           // [weakSelf footerRefresh];
        //        }];
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(210);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleW(0.001);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Shop_OrderList_TableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"Shop_OrderList_TableViewCell"];
    }
    
    return cell;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_model) {
         [self.headerView.shopView clearDatas];
    }else{
       [self.headerView.shopView showData];
    }
   
}
-(void)setModel:(ICC_PreOrder_GoodsInfo_Model *)model
{
    _model = model;
    if (_model) {
        NSMutableArray *jianjie =[NSMutableArray array];
        for (NSString *string in _model.jianjie_list) {
            UIImage*img = [UIImage imageFromURLString:string];
            [jianjie addObject:img];
        }
        [self.JArray addObjectsFromArray:_model.jianjie_list];
        NSMutableArray *lunbo =[NSMutableArray array];
        for (NSString *string in _model.lunbotu_list) {
            UIImage*img = [UIImage imageFromURLString:string];
            [lunbo addObject:img];
        }
        [self.LArray addObjectsFromArray:_model.lunbotu_list];
        self.headerView.shopView.dataSoureArray = lunbo;
        self.headerView.detailView.dataSoureArray = jianjie;
        self.headerView.shopView.imgUrlArray = [_model.lunbotu_list mutableCopy];
         self.headerView.detailView.imgUrlArray = [_model.jianjie_list mutableCopy];
        self.headerView.detailView.textView.text = self.model.content;
        [self.headerView.detailView clearDatas];
    }
    
}
-(NSMutableArray *)LArray{
    if (!_LArray) {
        _LArray = [NSMutableArray array];
    }
    return _LArray;
}

-(NSMutableArray *)JArray{
    if (!_JArray) {
        _JArray = [NSMutableArray array];
    }
    return _JArray;
}

@end
