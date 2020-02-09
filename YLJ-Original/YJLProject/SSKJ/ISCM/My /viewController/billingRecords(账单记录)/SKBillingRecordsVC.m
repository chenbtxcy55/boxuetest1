//
//  SKBillingRecordsVC.m
//  SSKJ
//
//  Created by 孙 on 2019/7/23.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SKBillingRecordsVC.h"

#import "BillingRecordsCell.h"

#import "JMDropMenu.h"

#import "STOViewControlView.h"

@interface SKBillingRecordsVC ()<UITableViewDelegate,UITableViewDataSource, UINavigationControllerDelegate,UIImagePickerControllerDelegate,JMDropMenuDelegate>
@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,assign)int  page;

@property(nonatomic,assign)int  type;

@property(nonatomic,strong)NSMutableArray * myDataArr;

@property(nonatomic,strong)NSMutableArray * myShaiXuanKeyArr;
@property(nonatomic,strong)NSMutableArray * myShaiXuanValueArr;
@property(nonatomic,strong)UILabel * showTile;
@property(nonatomic,strong)UIImageView * jiaoImageView;

@property (nonatomic, strong) STOViewControlView *controlView;

@property (nonatomic, strong) NSString *typeStr;

@end

@implementation SKBillingRecordsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    self.page = 1;

    [self initView];
}
-(void)initView
{
//    UIImageView* lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, .5)];
//    lineImageView.backgroundColor = WLColor(231,234,237,1);
//    [self.view addSubview:lineImageView];
//    UIView *style = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, ScreenWidth, 50)];
//    style.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];
//    style.alpha = 1;
//    [self.view addSubview:style];
//
//
//
//    UILabel * showTile1 = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 40, 50)];
//    showTile1.textColor = kTitleGrayColor;
//    showTile1.font = systemMediumFont(15);
////    showTile1.adjustsFontSizeToFitWidth = YES;
//    showTile1.textAlignment = NSTextAlignmentLeft;
//    showTile1.text = @"类型";
//
//    [style addSubview:showTile1];
//
//
//    UILabel * showTile = [[UILabel alloc]initWithFrame:CGRectMake(showTile1.right + 15, 0, 80, 50)];
//    showTile.textColor = [UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
//    showTile.font = systemMediumFont(15);
////    showTile.adjustsFontSizeToFitWidth = YES;
//    showTile.textAlignment = NSTextAlignmentCenter;
//    showTile.text = @"";
//    showTile.userInteractionEnabled = YES;
//    [style addSubview:showTile];
//    UITapGestureRecognizer * tapGesture =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBiTypeEvent:)];
//    [showTile addGestureRecognizer:tapGesture];
//
//    self.showTile = showTile;
//
//
//
//    UIImageView * jiaoImageView =[[UIImageView alloc] initWithFrame:CGRectMake(showTile.right + 6 , 25 +6, 6, 6)];
//    jiaoImageView.image = [UIImage imageNamed:@"my_right_bottom"];
//
//    [style addSubview:jiaoImageView];
    
    
    [self.view addSubview:self.controlView];
    
    [self.view addSubview:self.mainTableView];
    
//    self.jiaoImageView = jiaoImageView;
    
    
}


-(void)changeBiTypeEvent:(UIGestureRecognizer *)gesture
{
    
    [JMDropMenu showDropMenuFrame:CGRectMake(8, gesture.view.bottom+ Height_NavBar, 120, self.myShaiXuanValueArr.count * 40) ArrowOffset:80.f TitleArr:self.myShaiXuanValueArr ImageArr:@[@"",@""] Type:JMDropMenuTypeQQ LayoutType:JMDropMenuLayoutTypeTitle RowHeight:40.f Delegate:self];
    
}
//-(STOViewControlView *)controlView
//{
//    if (!_controlView) {
//       // _controlView = [[STOViewControlView alloc]initWithTop:<#(CGFloat)#> titleArray:<#(nonnull NSArray *)#>];
//        _controlView.top = 0;
//        WS(weakSelf);
//        _controlView.btnClickedBlock = ^(NSInteger index) {
//            //[weakSelf.contenScrollView setContentOffset:CGPointMake(index *ScreenWidth, 0) animated:YES];
//        };
//
//    }
//    return _controlView;
//}
- (void)didSelectRowAtIndex:(NSInteger)index Title:(NSString *)title Image:(NSString *)image {
    NSLog(@"index----%zd,  title---%@, image---%@", index, title, image);
    
    self.type = [self.myShaiXuanKeyArr[index] intValue];
    self.showTile.text = self.myShaiXuanValueArr[index];

  
    
    NSLog(@"typeStr::%@",self.typeStr);
    
    self.showTile.width = [title boundingRectWithSize:CGSizeMake(ScreenWidth - 80-15-10, self.showTile.height) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.showTile.font} context:nil].size.width +10;
    self.jiaoImageView.left = self.showTile.right + 6;
    [self requestRecordList];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [self requestAsset_type];
    self.title = SSKJLocalized(@"账单记录", nil);
    
}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ScaleW(43), ScreenWidth, ScreenHeight-Height_NavBar - ScaleW(43)) style:UITableViewStyleGrouped];
        _mainTableView.backgroundColor = WLColor(246, 247, 251, 1);
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedRowHeight = 0;
        
        _mainTableView.estimatedSectionFooterHeight = 0;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mainTableView registerClass:[BillingRecordsCell class] forCellReuseIdentifier:@"BillingRecordsCell"];
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        WS(weakSelf);
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            weakSelf.page = 1;
            [weakSelf requestRecordList];
            
        }];
        
        _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            weakSelf.page ++;
            [weakSelf requestRecordList];
        }];
    }
    return _mainTableView;
}
#pragma mark -- UITableViewDelegate,UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.myDataArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * dic = self.myDataArr[indexPath.row];
    NSString * text = dic[@"memo"];
    CGFloat height = [text boundingRectWithSize:CGSizeMake(ScaleW(238), 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:systemScaleFont(14)} context:nil].size.height;
    return ScaleW(18*2 + 13*3 + 17*3) + (height >17?height:17);
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BillingRecordsCell * cell =[tableView dequeueReusableCellWithIdentifier:@"BillingRecordsCell"];
    
    NSDictionary * dic = self.myDataArr[indexPath.row];
    
    NSLog(@"u=index:::%ld",self.controlView.currentIndex);
      self.typeStr=self.myShaiXuanValueArr[self.controlView.currentIndex];
    
    [cell setValuedataSoure:dic typeStr:self.typeStr];
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
//    if (section == 0) {
//        return 10;
//    }
    return CGFLOAT_MIN;
}

//kIscm_asset_type_Api
-(void)requestAsset_type
{

    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_asset_type_Api RequestType:RequestTypeGet Parameters:@{@"ios":@(1)} Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {
            
        
//            [weakSelf.myShaiXuanKeyArr addObjectsFromArray:[net_model.data allKeys]];
            

//            NSArray *arrSort = [[net_model.data allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
//                if ([obj1 intValue] > [obj2 intValue]){
//                    return NSOrderedDescending;
//                }
//                if ([obj1 intValue] < [obj2 intValue]){
//                    return NSOrderedAscending;
//                }
//                return NSOrderedSame;
//            }];
            NSMutableArray * arrSort  = [NSMutableArray array];
            
            for (int i = 0; i< [net_model.data count]; i++) {
                NSDictionary * dic = net_model.data[i];
                [arrSort addObject:[dic allKeys][0]];
                
            }
            
            
            for (int i = 0; i<arrSort.count; i++) {
                NSString * key = [NSString stringWithFormat:@"%@",arrSort[i]] ;
                
                [weakSelf.myShaiXuanKeyArr addObject:key];
                
                NSDictionary * dic = net_model.data[i];

                [weakSelf.myShaiXuanValueArr addObject:dic[key]];

            }
            weakSelf.controlView = [[STOViewControlView alloc]initWithTop:0 titleArray:weakSelf.myShaiXuanValueArr];
            weakSelf.controlView.btnClickedBlock = ^(NSInteger index) {
                //[weakSelf.contenScrollView setContentOffset:CGPointMake(index *ScreenWidth, 0) animated:YES];
                
                weakSelf.type = [weakSelf.myShaiXuanKeyArr[index] intValue];

                weakSelf.page = 1;
                [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];

                [weakSelf requestRecordList];

            };
            [weakSelf.view addSubview:weakSelf.controlView];
            weakSelf.type = [weakSelf.myShaiXuanKeyArr[0] intValue];
            
            weakSelf.showTile.text = weakSelf.myShaiXuanValueArr[0];
            [weakSelf requestRecordList];
            
        }else{
            
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        
    }];
}

-(void)requestRecordList
{

    NSDictionary *params = @{
                             @"type":@(self.type),
                             @"p":@(1),
                             @"size":@(10)
                             };
    
    
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_caiwu_ISCM_Api RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {
            
            
            if (weakSelf.page == 1) {
                [weakSelf.myDataArr removeAllObjects];
                
            }
            
            [weakSelf.myDataArr addObjectsFromArray:net_model.data[@"res"]];
            
            [SSKJ_NoDataView showNoData:self.myDataArr.count toView:weakSelf.mainTableView offY:0];
            
            [weakSelf.mainTableView reloadData];
            
        }else{
            
            [MBProgressHUD showError:net_model.msg];
        }
        [self endRefresh];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        [self endRefresh];
        
    }];
    
}
-(void)endRefresh
{
    [_mainTableView.mj_footer endRefreshing];
    [_mainTableView.mj_header endRefreshing];
    
}
-(NSMutableArray *)myShaiXuanKeyArr
{
    if (_myShaiXuanKeyArr == nil) {
        
        _myShaiXuanKeyArr =[NSMutableArray array];
    }
    
    return _myShaiXuanKeyArr;
}
-(NSMutableArray *)myShaiXuanValueArr
{
    if (_myShaiXuanValueArr == nil) {
        
        _myShaiXuanValueArr =[NSMutableArray array];
    }
    
    return _myShaiXuanValueArr;
}
-(NSMutableArray *)myDataArr
{
    if (_myDataArr == nil) {
        
        _myDataArr =[NSMutableArray array];
    }
    
    return _myDataArr;
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
