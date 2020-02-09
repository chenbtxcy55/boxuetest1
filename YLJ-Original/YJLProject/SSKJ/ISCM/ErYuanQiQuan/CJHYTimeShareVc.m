//
//  CJHYTimeShareVc.m
//  SSKJ
//
//  Created by 张本超 on 2019/8/28
#import "CJHYTimeShareVc.h"
#import "CJHYTimeShareView.h"
#import "News_NewsList_Cell.h"

static NSString * cellID = @"News_NewsList_Cell";

@interface CJHYTimeShareVc ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong) CJHYTimeShareView *headerView;

@property(nonatomic, strong)NSArray *array;
@end

@implementation CJHYTimeShareVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableView];
    [self setvalueAction];
    
    [self addRightNavItemWithTitle:SSKJLocalized(@"保存", nil) color:kMainWihteColor font:systemFont(ScaleW(15))];
    
}

-(void)rigthBtnAction:(id)sender
{
    [self loadImageFinished:[self captureImageFromView:self.view]];
    
    
}

- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error == nil) {
        [MBProgressHUD showError:SSKJLocalized(@"保存成功", nil)];
    }
    
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}


//截图功能
-(UIImage *)captureImageFromView:(UIView *)view
{
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    CGRect rect = [keyWindow bounds];
    
    UIGraphicsBeginImageContextWithOptions(rect.size,YES, 0.0);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}



-(void)setvalueAction
{
    self.headerView.model = self.model;
}
-(CJHYTimeShareView *)headerView
{
    if (!_headerView) {
        _headerView = [[CJHYTimeShareView alloc]init];
        
    }
    return _headerView;
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScaleW(136);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    News_NewsList_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - lazy load
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView setSeparatorColor:kLineColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[News_NewsList_Cell class] forCellReuseIdentifier:cellID];
        if (@available(iOS 11.0, *)){
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(@0);
            make.top.equalTo(@(0));
        }];
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}


@end
