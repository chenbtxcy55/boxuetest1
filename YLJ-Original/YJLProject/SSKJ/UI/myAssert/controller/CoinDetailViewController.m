//
//  CoinDetailViewController.m
//  SSKJ
//
//  Created by 孙克强 on 2019/10/7.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "CoinDetailViewController.h"
#import "SKNewExchangeVC.h"
#import "SKMyChargeVC.h"
#import "SKMyExtractVC.h"

@interface CoinDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *chongDataSourceArr;
@property (nonatomic ,strong) NSMutableArray *tiBiDataSourceArr;
@property (nonatomic ,strong) NSMutableArray *duiDataSourceArr;
@property (nonatomic ,assign) NSInteger  mySelectedItem;
@property (nonatomic ,strong) UIImageView * lineImageView;
@property (nonatomic ,strong) UIView * bgView ;
@property (nonatomic ,strong) UIView * tableViewBgView;

@property (nonatomic ,assign) int currentPage;
@end

@implementation CoinDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [[self.codeStr componentsSeparatedByString:@"_"].firstObject uppercaseString];
    [self initView];
    
    self.mySelectedItem = 0;
    [self requstListrequset];
}
-(void)initView
{
    UIView * topView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(116))];
    topView.backgroundColor = kNavBGColor;
    
    [self.view  addSubview:topView];
    UILabel * topLab =[[UILabel alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(26), ScaleW(60), ScaleW(11))];
    topLab.textColor = UIColorFromARGB(0xffffff, 0.75);
    topLab.font = systemScaleFont(12);
    topLab.textAlignment = NSTextAlignmentLeft;
    topLab.text = SSKJLocalized(@"可用", nil);
    
    [topView addSubview:topLab];
    
    
    UILabel * bottomLab =[[UILabel alloc] initWithFrame:CGRectMake(topLab.left, ScaleW(17)+ topLab.bottom, (ScreenWidth -ScaleW(30) -ScaleW(30))/3, ScaleW(13))];
    bottomLab.textColor = kMainTextColor;
    bottomLab.font = systemScaleFont(12);
    bottomLab.textAlignment = NSTextAlignmentLeft;
    bottomLab.text = [WLTools noroundingStringWith:[self.codeDetailDic[@"usable"] doubleValue] afterPointNumber:6];
    
    [topView addSubview:bottomLab];

    {
        UILabel * topLab =[[UILabel alloc] initWithFrame:CGRectMake(ScaleW(145), ScaleW(26), ScaleW(60), ScaleW(11))];
        topLab.textColor = UIColorFromARGB(0xffffff, 0.75);
        topLab.font = systemScaleFont(12);
        topLab.textAlignment = NSTextAlignmentLeft;
        topLab.text = SSKJLocalized(@"冻结", nil);
        
        [topView addSubview:topLab];
        
        
        UILabel * bottomLab =[[UILabel alloc] initWithFrame:CGRectMake(topLab.left, ScaleW(17)+ topLab.bottom, (ScreenWidth -ScaleW(30) -ScaleW(30))/3, ScaleW(13))];
        bottomLab.textColor = kMainTextColor;
        bottomLab.font = systemScaleFont(12);
        bottomLab.textAlignment = NSTextAlignmentLeft;
        bottomLab.text = [WLTools noroundingStringWith:[self.codeDetailDic[@"frost"] doubleValue] afterPointNumber:6];
        
        [topView addSubview:bottomLab];
        
    }
    {
        UILabel * topLab =[[UILabel alloc] initWithFrame:CGRectMake(ScaleW(276), ScaleW(26), ScaleW(70), ScaleW(11))];
        topLab.textColor = UIColorFromARGB(0xffffff, 0.75);
        topLab.font = systemScaleFont(12);
        topLab.textAlignment = NSTextAlignmentLeft;
        topLab.text = SSKJLocalized(@"折合(CNY）", nil);
        
        [topView addSubview:topLab];
        
        
        UILabel * bottomLab =[[UILabel alloc] initWithFrame:CGRectMake(topLab.left, ScaleW(17)+ topLab.bottom, (ScreenWidth -ScaleW(30) -ScaleW(30))/3, ScaleW(13))];
        bottomLab.textColor = kMainTextColor;
        bottomLab.font = systemScaleFont(12);
        bottomLab.textAlignment = NSTextAlignmentLeft;
        bottomLab.text = [WLTools noroundingStringWith:[self.codeDetailDic[@"cnyprice"] doubleValue] afterPointNumber:2];
        
        [topView addSubview:bottomLab];
        
    }
    
    UIImageView * typeBgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(155)-ScaleW(64), ScreenWidth - ScaleW(30), ScaleW(50))];
    typeBgimageView.image = [UIImage imageNamed:@"login_Btn_bg"];
    typeBgimageView.userInteractionEnabled = YES;
    [self.view addSubview:typeBgimageView];
    
    NSArray * imageNameArr =@[@"chongbi_icon",@"tibi_icon",@"duihuan_icon"];
    NSArray * nameArr =@[@" 充币",@" 提币",@" 兑换"];

    for (int i = 0;  i<3 ; i++) {
        
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(typeBgimageView.width/3 * i, 0, typeBgimageView.width/3, ScaleW(50));
        [button setTitle:SSKJLocalized(nameArr[i], nil) forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:imageNameArr[i]] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = systemScaleFont(13);
        
        button.tag = 22223333+ i;
        
        [typeBgimageView addSubview:button];
        
        if (i!=2) {
            UIImageView * lineImageView =[[UIImageView alloc] initWithFrame:CGRectMake(button.right, ScaleW(12), ScaleW(1), ScaleW(27))];
            lineImageView.backgroundColor = kMainWihteColor;
            [typeBgimageView addSubview:lineImageView];
            
        }
        
        
        
    }
    
    
    UIView * bgView  =[[UIView alloc] initWithFrame:CGRectMake(ScaleW(15), typeBgimageView.bottom + ScaleW(10),ScreenWidth - ScaleW(30), ScaleW(41))];
    
    self.bgView = bgView;
    
    bgView.backgroundColor = kNavBGColor;
    
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:(CGSize){ScaleW(8)}];
    // 绘制4个角，指定角半径
    // bezierPath = [UIBezierPath bezierPathWithRoundedRect:imageView2.bounds cornerRadius:20.0];
    // 绘制圆
    // bezierPath = [UIBezierPath bezierPathWithOvalInRect:imageView2.bounds];
    // 初始化shapeLayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    // 设置绘制路径
    shapeLayer.path = bezierPath.CGPath;
    // 将shapeLayer设置为imageView2的layer的mask(遮罩)
    bgView.layer.mask = shapeLayer;
    
    
    
    [self.view addSubview:bgView];
    
    NSArray * segmentArr =@[@"充币记录",@"提币记录",@"兑换记录"];

    
    for (int i = 0;  i<3 ; i++) {
        
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(bgView.width/3 * i, 0, bgView.width/3, bgView.height);
        [button setTitle:SSKJLocalized(segmentArr[i], nil) forState:UIControlStateNormal];
        
        button.tag = 11112222 + i;
        [button addTarget:self action:@selector(recordEvent:) forControlEvents:UIControlEventTouchUpInside];

        button.titleLabel.font = systemScaleFont(13);
        
        [bgView addSubview:button];
        
        
        
    }
    
    UIButton * button = [bgView viewWithTag:11112222];
    
    
    UIImageView * lineImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, bgView.height - ScaleW(3), ScaleW(31), ScaleW(3))];
    
    lineImageView.backgroundColor = kMainWihteColor;
    
    [bgView addSubview:lineImageView];
    
    lineImageView.centerX = button.centerX;
    
    self.lineImageView = lineImageView;
    
    
    
    UIView * tableViewBgView =[[UIView alloc] initWithFrame:CGRectMake(ScaleW(15), self.bgView.bottom, ScreenWidth-ScaleW(30), ScreenHeight - Height_NavBar - self.bgView.bottom - ScaleW(26))];
    tableViewBgView.backgroundColor = kNavBGColor;
    UIBezierPath *bezierPath1 = [UIBezierPath bezierPathWithRoundedRect:tableViewBgView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:(CGSize){ScaleW(8)}];
    // 绘制4个角，指定角半径
    // bezierPath = [UIBezierPath bezierPathWithRoundedRect:imageView2.bounds cornerRadius:20.0];
    // 绘制圆
    // bezierPath = [UIBezierPath bezierPathWithOvalInRect:imageView2.bounds];
    // 初始化shapeLayer
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    // 设置绘制路径
    shapeLayer1.path = bezierPath1.CGPath;
    // 将shapeLayer设置为imageView2的layer的mask(遮罩)
    tableViewBgView.layer.mask = shapeLayer1;
    
    self.tableViewBgView = tableViewBgView;
    
    [self.view addSubview:tableViewBgView];
    
    
    
    [tableViewBgView addSubview:self.tableView];
    
    
    
    
    
    
}

-(void)recordEvent:(UIButton*)sender
{
    self.mySelectedItem = sender.tag - 11112222;
    
    self.currentPage = 1;
    self.lineImageView.centerX = sender.centerX;

    switch (self.mySelectedItem) {
        case 0:
        {
            [self requstListrequset];
            
        }
            break;
        case 1:
        {
            [self requstListrequset];

        }
            break;
        case 2:
        {
            [self requstListrequset];

        }
            break;
        default:
            break;
    }
    
//    [self.tableView reloadData];
    
}
-(void)clickEvent:(UIButton*)sender
{
    switch (sender.tag -22223333) {
        case 0:
            {
                
                SKMyChargeVC * vc = [SKMyChargeVC new];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case 1:
        {
            SKMyExtractVC * vc = [SKMyExtractVC new];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            SKNewExchangeVC * vc = [SKNewExchangeVC new];
            
            
            vc.codeStr = self.codeStr;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(ScaleW(0), 0, ScreenWidth-ScaleW(30), ScreenHeight - Height_NavBar - self.bgView.bottom - ScaleW(26)-ScaleW(8)) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = kNavBGColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.separatorColor = kLineGrayColor;
        
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        WS(weakSelf);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf requstListrequset];
            
        }];
        
   
        //        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //            [weakSelf.tableView.mj_footer endRefreshing];
        //            !weakSelf.refreshFooter ? : weakSelf.refreshFooter();
        //        }];
    }
    return _tableView;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.mySelectedItem ==0) {
        
        
        return self.chongDataSourceArr.count == 0?1:self.chongDataSourceArr.count;
        
    }
    else  if (self.mySelectedItem ==1) {

        return self.tiBiDataSourceArr.count== 0?1:self.tiBiDataSourceArr.count;

    }
    else  if (self.mySelectedItem ==2) {
        

        return self.duiDataSourceArr.count== 0?1:self.duiDataSourceArr.count;

    }
    return 0;
}
    
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (self.mySelectedItem ==0) {
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell1"];
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell1"];
        }
        
        for (id view in [cell.contentView subviews])
        {
            
            [view removeFromSuperview];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        

        
        if (self.chongDataSourceArr.count==0) {
            
            cell.contentView.backgroundColor = cell.backgroundColor = kMainColor;

            self.tableViewBgView.backgroundColor = kMainColor;
            
            [SSKJ_NoDataView showNoData:self.chongDataSourceArr.count toView:cell.contentView offY:50];
            
            return cell;
        }
        cell.contentView.backgroundColor = cell.backgroundColor = kNavBGColor;

        self.tableViewBgView.backgroundColor = kNavBGColor;

        NSDictionary * dic = self.chongDataSourceArr[indexPath.row];
        UILabel * daishuLabel = [UILabel new];
        daishuLabel.textColor = kMainWihteColor;
        daishuLabel.font = systemFont(ScaleW(14));
        daishuLabel.text = SSKJLocalized(@"充币地址", nil);
        daishuLabel.textAlignment = NSTextAlignmentLeft;
        daishuLabel.frame =  CGRectMake(ScaleW(16), ScaleW(21),  ScaleW(60) , ScaleW(13));
        [cell.contentView addSubview:daishuLabel];
        
        UILabel * daishuLabel1 = [UILabel new];
        daishuLabel1.textColor = kSubTxtColor;
        daishuLabel1.font = systemFont(ScaleW(14));
        daishuLabel1.text = dic[@"chongzhi_url"];
        daishuLabel1.textAlignment = NSTextAlignmentLeft;
        daishuLabel1.frame =  CGRectMake(daishuLabel.right + ScaleW(20),ScaleW(21),  self.tableView.width - (daishuLabel.right + ScaleW(20) + ScaleW(16)) , ScaleW(13));
        [cell.contentView addSubview:daishuLabel1];
        
        
        
        UILabel * totalLabel = [UILabel new];
        totalLabel.textColor = kMainWihteColor;
        totalLabel.font = systemFont(ScaleW(14));
        totalLabel.textAlignment = NSTextAlignmentLeft;
        totalLabel.text = SSKJLocalized(@"充币数量", nil);
        
        totalLabel.frame =  CGRectMake(ScaleW(16) , ScaleW(48), ScaleW(60), ScaleW(13));
        [cell.contentView addSubview:totalLabel];
        
        
        
        UILabel * totalLabel1 = [UILabel new];
        totalLabel1.textColor = kSubTxtColor;
        totalLabel1.font = systemFont(ScaleW(14));
        totalLabel1.textAlignment = NSTextAlignmentLeft;
        totalLabel1.text = [WLTools noroundingStringWith:[dic[@"price"] doubleValue] afterPointNumber:6];
        
        totalLabel1.frame =  CGRectMake(totalLabel.right + ScaleW(20) , ScaleW(48), self.tableView.width - (totalLabel.right + ScaleW(20) +ScaleW(16)), ScaleW(13));
        [cell.contentView addSubview:totalLabel1];
        
        
        
        UILabel * jieLabel = [UILabel new];
        jieLabel.textColor = kMainWihteColor;
        jieLabel.font = systemFont(ScaleW(14));
        jieLabel.textAlignment = NSTextAlignmentLeft;
        jieLabel.frame =  CGRectMake(ScaleW(16) , ScaleW(73), ScaleW(60), ScaleW(13));
        jieLabel.text = SSKJLocalized(@"到账时间", nil);
        
        [cell.contentView addSubview:jieLabel];
        
        UILabel * jieLabel1 = [UILabel new];
        jieLabel1.textColor = kSubTxtColor;
        jieLabel1.font = systemFont(ScaleW(14));
        jieLabel1.textAlignment = NSTextAlignmentLeft;
        jieLabel1.frame =  CGRectMake(ScaleW(20) + jieLabel.right , ScaleW(73), self.tableView.width - (jieLabel.right + ScaleW(20) + ScaleW(16)), ScaleW(13));
        jieLabel1.text =[WLTools convertTimestamp:[dic[@"addtime"] longLongValue] andFormat:@"yyyy/MM/dd HH:mm"];
        
        [cell.contentView addSubview:jieLabel1];
        
        
        
        UIImageView * lineImageView =[[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(16), ScaleW(108)-1, ScreenWidth -ScaleW(30) - ScaleW(16)*2, 1)];
        lineImageView.backgroundColor = UIColorFromRGB(0x111c40);
        
        [cell.contentView addSubview:lineImageView];
        return cell;

    }
    else  if (self.mySelectedItem ==1) {
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell1"];
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell1"];
        }
        
        for (id view in [cell.contentView subviews])
        {
            
            [view removeFromSuperview];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        if (self.tiBiDataSourceArr.count==0) {
            
            self.tableViewBgView.backgroundColor = kMainColor;
            cell.contentView.backgroundColor = cell.backgroundColor = kMainColor;

            [SSKJ_NoDataView showNoData:self.tiBiDataSourceArr.count toView:cell.contentView offY:50];
            
            return cell;
        }
        cell.contentView.backgroundColor = cell.backgroundColor = kNavBGColor;

        self.tableViewBgView.backgroundColor = kNavBGColor;

        
        NSDictionary * dic = self.tiBiDataSourceArr[indexPath.row];

        
        UILabel * daishuLabel = [UILabel new];
        daishuLabel.textColor = kMainWihteColor;
        daishuLabel.font = systemFont(ScaleW(14));
        daishuLabel.text = SSKJLocalized(@"提币状态", nil);
        daishuLabel.textAlignment = NSTextAlignmentLeft;
        daishuLabel.frame =  CGRectMake(ScaleW(16), ScaleW(21),  ScaleW(60) , ScaleW(13));
        [cell.contentView addSubview:daishuLabel];
        
        UILabel * daishuLabel1 = [UILabel new];
        daishuLabel1.textColor = kSubTxtColor;
        daishuLabel1.font = systemFont(ScaleW(14));
        
        if ([dic[@"state"] intValue] == 1) {
            daishuLabel1.text = SSKJLocalized(@"待审核", nil);

        }
        else if ([dic[@"state"] intValue] == 2)
        {
            daishuLabel1.text = SSKJLocalized(@"到账中", nil);

        }
        else if ([dic[@"state"] intValue] == 3)
        {
            daishuLabel1.text = SSKJLocalized(@"已拒绝", nil);

        }else if ([dic[@"state"] intValue] == 4)
        {
            daishuLabel1.text = SSKJLocalized(@"已到账", nil);

        }else if ([dic[@"state"] intValue] == 5)
        {
            daishuLabel1.text = SSKJLocalized(@"失败", nil);

        }
        daishuLabel1.textAlignment = NSTextAlignmentLeft;
        daishuLabel1.frame =  CGRectMake(daishuLabel.right + ScaleW(20),ScaleW(21),  self.tableView.width - (daishuLabel.right + ScaleW(20) + ScaleW(16)) , ScaleW(13));
        [cell.contentView addSubview:daishuLabel1];
        
        
        
        UILabel * totalLabel = [UILabel new];
        totalLabel.textColor = kMainWihteColor;
        totalLabel.font = systemFont(ScaleW(14));
        totalLabel.textAlignment = NSTextAlignmentLeft;
        totalLabel.text = SSKJLocalized(@"提币地址", nil);
        
        totalLabel.frame =  CGRectMake(ScaleW(16) , daishuLabel.bottom + ScaleW(14), ScaleW(60), ScaleW(13));
        [cell.contentView addSubview:totalLabel];
        
        
        
        UILabel * totalLabel1 = [UILabel new];
        totalLabel1.textColor = kSubTxtColor;
        totalLabel1.font = systemFont(ScaleW(14));
        totalLabel1.textAlignment = NSTextAlignmentLeft;
        totalLabel1.text = dic[@"chongzhi_url"];
        
        totalLabel1.frame =  CGRectMake(totalLabel.right + ScaleW(20) , daishuLabel.bottom + ScaleW(14), self.tableView.width - (totalLabel.right + ScaleW(20) +ScaleW(16)), ScaleW(13));
        [cell.contentView addSubview:totalLabel1];
        
        
        
        UILabel * jieLabel = [UILabel new];
        jieLabel.textColor = kMainWihteColor;
        jieLabel.font = systemFont(ScaleW(14));
        jieLabel.textAlignment = NSTextAlignmentLeft;
        jieLabel.frame =  CGRectMake(ScaleW(16) , ScaleW(14)+ totalLabel.bottom, ScaleW(60), ScaleW(13));
        jieLabel.text = SSKJLocalized(@"提币数量", nil);
        
        [cell.contentView addSubview:jieLabel];
        
        UILabel * jieLabel1 = [UILabel new];
        jieLabel1.textColor = kSubTxtColor;
        jieLabel1.font = systemFont(ScaleW(14));
        jieLabel1.textAlignment = NSTextAlignmentLeft;
        jieLabel1.frame =  CGRectMake(ScaleW(20) + jieLabel.right , ScaleW(73), self.tableView.width - (jieLabel.right + ScaleW(20) + ScaleW(16)), ScaleW(13));
        jieLabel1.text = dic[@"price"];
        
        [cell.contentView addSubview:jieLabel1];
        
        
        
        
        
        
        UILabel * feeLabel = [UILabel new];
        feeLabel.textColor = kMainWihteColor;
        feeLabel.font = systemFont(ScaleW(14));
        feeLabel.textAlignment = NSTextAlignmentLeft;
        feeLabel.text = SSKJLocalized(@"手续费", nil);
        
        feeLabel.frame =  CGRectMake(ScaleW(16) , jieLabel.bottom + ScaleW(14), ScaleW(60), ScaleW(13));
        [cell.contentView addSubview:feeLabel];
        
        
        
        UILabel * feeLabel1 = [UILabel new];
        feeLabel1.textColor = kSubTxtColor;
        feeLabel1.font = systemFont(ScaleW(14));
        feeLabel1.textAlignment = NSTextAlignmentLeft;
        feeLabel1.text = [WLTools noroundingStringWith:[dic[@"txfee"] doubleValue] afterPointNumber:4];
        
        feeLabel1.frame =  CGRectMake(feeLabel.right + ScaleW(20) , jieLabel.bottom + ScaleW(14), self.tableView.width - (feeLabel.right + ScaleW(20) +ScaleW(16)), ScaleW(13));
        [cell.contentView addSubview:feeLabel1];
        
        
        
        UILabel * tiBiLabel = [UILabel new];
        tiBiLabel.textColor = kMainWihteColor;
        tiBiLabel.font = systemFont(ScaleW(14));
        tiBiLabel.textAlignment = NSTextAlignmentLeft;
        tiBiLabel.frame =  CGRectMake(ScaleW(16) , ScaleW(14)+ feeLabel.bottom, ScaleW(60), ScaleW(13));
        tiBiLabel.text = SSKJLocalized(@"提币时间", nil);
        
        [cell.contentView addSubview:tiBiLabel];
        
        UILabel * tiBiLabel1 = [UILabel new];
        tiBiLabel1.textColor = kSubTxtColor;
        tiBiLabel1.font = systemFont(ScaleW(14));
        tiBiLabel1.textAlignment = NSTextAlignmentLeft;
        tiBiLabel1.frame =  CGRectMake(ScaleW(20) + tiBiLabel.right , feeLabel.bottom+ ScaleW(14), self.tableView.width - (tiBiLabel.right + ScaleW(20) + ScaleW(16)), ScaleW(13));
        tiBiLabel1.text = [WLTools convertTimestamp:[dic[@"check_time"] longLongValue] andFormat:@"yyyy/MM/dd HH:mm"];
        
        [cell.contentView addSubview:tiBiLabel1];
        
        
        UIImageView * lineImageView =[[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(16), ScaleW(161)-1, ScreenWidth -ScaleW(30) - ScaleW(16)*2, 1)];
        lineImageView.backgroundColor = UIColorFromRGB(0x111c40);
        
        [cell.contentView addSubview:lineImageView];
        return cell;
        
    }
    else  {
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell1"];
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell1"];
        }
        
        for (id view in [cell.contentView subviews])
        {
            
            [view removeFromSuperview];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        if (self.duiDataSourceArr.count==0) {
            
            self.tableViewBgView.backgroundColor = kMainColor;
            cell.contentView.backgroundColor = cell.backgroundColor = kMainColor;

            [SSKJ_NoDataView showNoData:self.duiDataSourceArr.count toView:cell.contentView offY:50];

            return cell;
        }
        self.tableViewBgView.backgroundColor = kNavBGColor;
        cell.contentView.backgroundColor = cell.backgroundColor = kNavBGColor;

        NSDictionary * dic = self.duiDataSourceArr[indexPath.row];
        UILabel * daishuLabel = [UILabel new];
        daishuLabel.textColor = kMainWihteColor;
        daishuLabel.font = systemFont(ScaleW(14));
        daishuLabel.text = SSKJLocalized(@"兑换资产", nil);
        daishuLabel.textAlignment = NSTextAlignmentLeft;
        daishuLabel.frame =  CGRectMake(ScaleW(16), ScaleW(21),  ScaleW(60) , ScaleW(13));
        [cell.contentView addSubview:daishuLabel];
        
        UILabel * daishuLabel1 = [UILabel new];
        daishuLabel1.textColor = kSubTxtColor;
        daishuLabel1.font = systemFont(ScaleW(14));
        daishuLabel1.text =[NSString stringWithFormat:@"%@%@%@", dic[@"pname"],SSKJLocalized(@"兑换", nil), dic[@"expname"]];
        daishuLabel1.textAlignment = NSTextAlignmentLeft;
        daishuLabel1.frame =  CGRectMake(daishuLabel.right + ScaleW(20),ScaleW(21),  self.tableView.width - (daishuLabel.right + ScaleW(20) + ScaleW(16)) , ScaleW(13));
        [cell.contentView addSubview:daishuLabel1];
        
        
        
        UILabel * totalLabel = [UILabel new];
        totalLabel.textColor = kMainWihteColor;
        totalLabel.font = systemFont(ScaleW(14));
        totalLabel.textAlignment = NSTextAlignmentLeft;
        totalLabel.text = SSKJLocalized(@"兑换数量", nil);
        
        totalLabel.frame =  CGRectMake(ScaleW(16) , ScaleW(48), ScaleW(60), ScaleW(13));
        [cell.contentView addSubview:totalLabel];
        
        
        
        UILabel * totalLabel1 = [UILabel new];
        totalLabel1.textColor = kSubTxtColor;
        totalLabel1.font = systemFont(ScaleW(14));
        totalLabel1.textAlignment = NSTextAlignmentLeft;
        totalLabel1.text = [WLTools noroundingStringWith:[dic[@"num"] doubleValue] afterPointNumber:6];
        
        totalLabel1.frame =  CGRectMake(totalLabel.right + ScaleW(20) , ScaleW(48), self.tableView.width - (totalLabel.right + ScaleW(20) +ScaleW(16)), ScaleW(13));
        [cell.contentView addSubview:totalLabel1];
        
        
        
        UILabel * jieLabel = [UILabel new];
        jieLabel.textColor = kMainWihteColor;
        jieLabel.font = systemFont(ScaleW(14));
        jieLabel.textAlignment = NSTextAlignmentLeft;
        jieLabel.frame =  CGRectMake(ScaleW(16) , ScaleW(73), ScaleW(60), ScaleW(13));
        jieLabel.text = SSKJLocalized(@"到账数量", nil);
        
        [cell.contentView addSubview:jieLabel];
        
        UILabel * jieLabel1 = [UILabel new];
        jieLabel1.textColor = kSubTxtColor;
        jieLabel1.font = systemFont(ScaleW(14));
        jieLabel1.textAlignment = NSTextAlignmentLeft;
        jieLabel1.frame =  CGRectMake(ScaleW(20) + jieLabel.right , ScaleW(73), self.tableView.width - (jieLabel.right + ScaleW(20) + ScaleW(16)), ScaleW(13));
        jieLabel1.text = [WLTools noroundingStringWith:[dic[@"exnum"] doubleValue] afterPointNumber:6];
        
        [cell.contentView addSubview:jieLabel1];
        
        
        
        UILabel * timeLabel = [UILabel new];
        timeLabel.textColor = kMainWihteColor;
        timeLabel.font = systemFont(ScaleW(14));
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.frame =  CGRectMake(ScaleW(16) , ScaleW(97), ScaleW(60), ScaleW(13));
        timeLabel.text = SSKJLocalized(@"兑换时间", nil);
        
        [cell.contentView addSubview:timeLabel];
        
        UILabel * timeLabel1 = [UILabel new];
        timeLabel1.textColor = kSubTxtColor;
        timeLabel1.font = systemFont(ScaleW(14));
        timeLabel1.textAlignment = NSTextAlignmentLeft;
        timeLabel1.frame =  CGRectMake(ScaleW(20) + timeLabel.right , ScaleW(97), self.tableView.width - (timeLabel.right + ScaleW(20) + ScaleW(16)), ScaleW(13));
        timeLabel1.text = [WLTools convertTimestamp:[dic[@"addtime"] longLongValue] andFormat:@"yyyy/MM/dd HH:mm"];
        
        [cell.contentView addSubview:timeLabel1];
        
        
        UIImageView * lineImageView =[[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(16), ScaleW(131)-1, ScreenWidth -ScaleW(30) - ScaleW(16)*2, 1)];
        lineImageView.backgroundColor = UIColorFromRGB(0x111c40);
        
        [cell.contentView addSubview:lineImageView];
        return cell;
        
    }
    
    return nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.mySelectedItem ==0) {
        
        if (self.chongDataSourceArr.count>0) {
            return ScaleW(108);

        }
        return self.tableView.height+ScaleW(30);
    }
    else  if (self.mySelectedItem ==1) {
        if (self.tiBiDataSourceArr.count>0) {
            return ScaleW(161);

        }
        
        return self.tableView.height;

    }
    else  {
        
        if (self.duiDataSourceArr.count>0) {
            return ScaleW(130);
            
        }
        return self.tableView.height;

    }
    
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}
- (NSMutableArray *)chongDataSourceArr{
    if (!_chongDataSourceArr) {
        _chongDataSourceArr = [NSMutableArray array];
    }
    return _chongDataSourceArr;
}
- (NSMutableArray *)tiBiDataSourceArr{
    if (!_tiBiDataSourceArr) {
        _tiBiDataSourceArr = [NSMutableArray array];
    }
    return _tiBiDataSourceArr;
}
- (NSMutableArray *)duiDataSourceArr{
    if (!_duiDataSourceArr) {
        _duiDataSourceArr = [NSMutableArray array];
    }
    return _duiDataSourceArr;
}


-(void)requstListrequset
{
    [self.tableView.mj_footer resetNoMoreData];
    WS(weakSelf);
   
    
    [self.tableView reloadData];
    NSMutableDictionary *pamas = [NSMutableDictionary dictionary];
    //[pamas setObject:kuserUid forKey:@"iid"];
    NSString *page = [NSString stringWithFormat:@"%d",_currentPage];
    [pamas setObject:self.pidStr forKey:@"pid"];
    NSString * url =@"";
    if (self.mySelectedItem == 0) {
        [pamas setObject:@"recharge" forKey:@"type"];

        url = kIscm_record_list_Api;
        
    }
    else if (self.mySelectedItem == 1)
    {
        [pamas setObject:@"cash" forKey:@"type"];
        url = kIscm_record_list_Api;

        
    }
    else if (self.mySelectedItem == 2)
    {
        [pamas setObject:@(3) forKey:@"type"];

        url = kIscm_asset_detail_Api;

    }

    
    [pamas setObject:page forKey:@"p"];
    [pamas setObject:@(10) forKey:@"size"];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:url RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

        [weakSelf.tableView.mj_header endRefreshing];
        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        
        NSArray *list = nil;
        
        if (self.mySelectedItem == 0) {
            list = net_model.data[@"res"];

        }
        else if (self.mySelectedItem == 1)
        {
            list = net_model.data[@"res"];

            
        }
        else if (self.mySelectedItem == 2)
        {
             list = net_model.data[@"list"];
            
        }
        
        
        if (net_model.status.integerValue == 200) {
            if (weakSelf.currentPage ==1) {
                if (self.mySelectedItem == 0) {
                    [self.chongDataSourceArr removeAllObjects];

                }
                else if (self.mySelectedItem == 1)
                {
                    [self.tiBiDataSourceArr removeAllObjects];

                    
                }
                else if (self.mySelectedItem == 2)
                {
                    [self.duiDataSourceArr removeAllObjects];

                    
                }
            }
            for (NSDictionary * dic in list) {
                
                
                if (self.mySelectedItem == 0) {
                    [self.chongDataSourceArr addObject:dic];

                }
                else if (self.mySelectedItem == 1)
                {
                    [self.tiBiDataSourceArr addObject:dic];

                    
                }
                else if (self.mySelectedItem == 2)
                {
                    [self.duiDataSourceArr addObject:dic];

                    
                }
                
            }
//            [SSKJ_NoDataView showNoData:self.duiDataSourceArr.count toView:self.tableView offY:0];
            
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {

        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
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
