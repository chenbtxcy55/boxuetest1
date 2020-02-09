//
//  SKMyExtract_RecordVC.m
//  SSKJ
//
//  Created by 孙 on 2019/7/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SKMyExtract_RecordVC.h"
#import "SKMyExtract_RecordCell.h"
#import "JMDropMenu.h"

@interface SKMyExtract_RecordVC ()<UITableViewDelegate,UITableViewDataSource, UINavigationControllerDelegate,UIImagePickerControllerDelegate,JMDropMenuDelegate>
@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,assign)int page;
@property(nonatomic,strong)NSMutableArray * myDataArr;

@property(nonatomic,strong)UILabel * showTile;
@end

@implementation SKMyExtract_RecordVC
-(NSMutableArray *)myDataArr
{
    if (_myDataArr == nil) {
        _myDataArr =[NSMutableArray array];
    }
    return _myDataArr;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    self.page = 1;

    [self initView];
}
-(void)initView
{
    
    UIImageView* lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, .5)];
    lineImageView.backgroundColor = WLColor(231,234,237,1);
    [self.view addSubview:lineImageView];
    UIView *style = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, ScreenWidth, 50)];
    style.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];
    style.alpha = 1;
    [self.view addSubview:style];
    
    
    UILabel * showTile1 = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 30, 50)];
    showTile1.textColor = kTitleGrayColor;
    showTile1.font = systemMediumFont(15);
    showTile1.adjustsFontSizeToFitWidth = YES;
    showTile1.textAlignment = NSTextAlignmentLeft;
    showTile1.text = @"币种";
    
    [style addSubview:showTile1];
    
    
        UILabel * showTile = [[UILabel alloc]initWithFrame:CGRectMake(showTile1.right + 15, 0, 60, 50)];
        showTile.textColor = [UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
        showTile.font = systemMediumFont(15);
        showTile.adjustsFontSizeToFitWidth = YES;
        showTile.textAlignment = NSTextAlignmentCenter;
        showTile.text = @"ETH";
        showTile.userInteractionEnabled = YES;
        [style addSubview:showTile];
        UITapGestureRecognizer * tapGesture =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBiTypeEvent:)];
        [showTile addGestureRecognizer:tapGesture];
    
    self.showTile = showTile;
    
    
    UIImageView * jiaoImageView =[[UIImageView alloc] initWithFrame:CGRectMake(showTile.right + 6 , 25 +6, 6, 6)];
    jiaoImageView.image = [UIImage imageNamed:@"my_right_bottom"];
    
    [style addSubview:jiaoImageView];
    
    [self.view addSubview:self.mainTableView];

    
}

-(void)changeBiTypeEvent:(UIGestureRecognizer *)gesture
{
    
    [JMDropMenu showDropMenuFrame:CGRectMake(8, gesture.view.bottom+ Height_NavBar, 120, 88) ArrowOffset:80.f TitleArr:@[@"ETH",@"ISCM"] ImageArr:@[@"",@""] Type:JMDropMenuTypeQQ LayoutType:JMDropMenuLayoutTypeTitle RowHeight:40.f Delegate:self];
    
}
- (void)didSelectRowAtIndex:(NSInteger)index Title:(NSString *)title Image:(NSString *)image {
    NSLog(@"index----%zd,  title---%@, image---%@", index, title, image);
    self.showTile.text = title;
    
    [self requestRecordList];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self requestRecordList];
    self.title = SSKJLocalized(@"提币记录", nil);
    
}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-Height_NavBar) style:UITableViewStyleGrouped];
        _mainTableView.backgroundColor = WLColor(246, 247, 251, 1);
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedRowHeight = 0;
        
        _mainTableView.estimatedSectionFooterHeight = 0;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mainTableView registerClass:[SKMyExtract_RecordCell class] forCellReuseIdentifier:@"SKMyExtract_RecordCell"];
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
    
    return ScaleW(18*2 + 13*3 + 17*4);
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SKMyExtract_RecordCell * cell =[tableView dequeueReusableCellWithIdentifier:@"SKMyExtract_RecordCell"];
    
    NSDictionary *myDic = self.myDataArr[indexPath.row];
    [cell setValuedataSoure:myDic type:1];
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
    if (section == 0) {
        return 10;
    }
    return CGFLOAT_MIN;
}
-(void)requestRecordList
{
    
    
    NSDictionary *params = @{
                             @"pid":[self.showTile.text isEqualToString:@"ETH"]?@(3):@(0),
                             @"type":@"cash",
                             @"p":@(1),
                             @"size":@(10)
                             };
    
    
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_Recognize_record_Api RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
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
        [weakSelf endRefresh];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        [weakSelf endRefresh];
        
    }];
}
-(void)endRefresh
{
    [_mainTableView.mj_header endRefreshing];
    [_mainTableView.mj_footer endRefreshing];
    
    
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
