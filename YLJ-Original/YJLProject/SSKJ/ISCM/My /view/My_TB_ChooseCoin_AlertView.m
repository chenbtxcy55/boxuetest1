//
//  My_TB_ChooseCoin_AlertView.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/4/10.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "My_TB_ChooseCoin_AlertView.h"



@interface My_TB_ChooseCoin_AlertView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation My_TB_ChooseCoin_AlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];

        
        [self tableView];
    }
    return self;
}


#pragma mark - 列表表格视图
-(UITableView *)tableView
{
    if (_tableView==nil)
    {
        _tableView=[[UITableView alloc] init];
        
        _tableView.delegate=self;
        
        _tableView.dataSource=self;
        
        _tableView.backgroundColor= SKRandomColor;
        
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        [self addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(@0);
            
            make.centerX.equalTo(self.mas_centerX);
            
            make.width.equalTo(@(100));
            
            make.height.equalTo(@(120));
            
        }];
        
    }
    
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120 / 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
    //    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    WLLAssetsInfoModel *model = self.dataSource[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = SKRandomColor;
//    
//    cell.detailTextLabel.text = model.pname;
//    
    cell.detailTextLabel.textColor = SKRandomColor;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.coinBlock) {
        
        self.coinBlock(self.dataSource[indexPath.row]);
    }
}

- (void)setDataArr:(NSArray *)dataArr
{
    self.dataSource = [NSArray arrayWithArray:dataArr];
    
    [self.tableView reloadData];
}



@end
