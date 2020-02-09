//
//  AutoScrollView.m
//  SSKJ
//
//  Created by zpz on 2019/7/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "AutoScrollView.h"

static NSString * collectionCellID = @"AutoScrollViewCell";


@interface AutoScrollView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong)NSArray *imageArray;
@property(nonatomic, assign)NSTimeInterval timeInterva;

@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic)NSInteger currentRow;
@property(nonatomic, strong)UIPageControl *pageControl;

@end

@implementation AutoScrollView

- (instancetype)initWithImages:(NSArray *)imgs timeInterval:(NSTimeInterval)interval{
    if (self == [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(205))]) {
        self.timeInterva = interval;
        [self setupSubviews];
        [self setImages:imgs];
    }
    return self;
}


- (void)setupSubviews{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat height = self.height;
    CGFloat width = self.width;
    layout.itemSize = CGSizeMake(width, height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:layout];
    _collectionView.backgroundColor = kMainBackgroundColor;
    [self addSubview:_collectionView];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerClass:[AutoScrollViewCell class] forCellWithReuseIdentifier:collectionCellID];
    if (@available(iOS 11.0, *)){
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }

}

- (void)setImages:(NSArray *)imgs{
    
    if (!imgs.count) {
        return;
    }
    
    [self stopTimer];

    self.imageArray = imgs;
    [self.collectionView reloadData];
    self.pageControl.numberOfPages = self.imageArray.count;
    
    NSIndexPath *index = [[self.collectionView indexPathsForVisibleItems] firstObject];
    if (index.row) {
      [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    if (self.imageArray.count > 1) {
        
        NSMutableArray *arr = [NSMutableArray arrayWithArray:self.imageArray];
        [arr insertObject:self.imageArray.lastObject atIndex:0];
        [arr addObject:self.imageArray.firstObject];
        self.imageArray = [arr copy];
        
        [self addTimer];
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        
        self.collectionView.scrollEnabled = YES;

    }else{
        self.collectionView.scrollEnabled = NO;
    }
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {

        _pageControl = [[UIPageControl alloc]init];
        [_pageControl setValue:[UIImage imageNamed:@"marker_banner_current"] forKeyPath:@"_currentPageImage"];
        [_pageControl setValue:[UIImage imageNamed:@"marker_banner_unCurrent"] forKeyPath:@"_pageImage"];
        
        
        //    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        //    self.pageControl.pageIndicatorTintColor = [UIColor blueColor];
        //    [self.pageControl addTarget:self action:@selector(pageControlAction:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pageControl];
        
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.bottom.offset(-0);
        }];
    }
    
    return _pageControl;
}


- (void)addTimer
{
    [self stopTimer];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterva target:self selector:@selector(changeScrollViewOffset:) userInfo:nil repeats:YES];
}

- (void)stopTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)changeScrollViewOffset:(NSTimer *)sender
{
    
    NSIndexPath *index = [[self.collectionView indexPathsForVisibleItems] firstObject];
    NSInteger row = index.row;
//    NSLog(@"-----%zd", row);


    if (row == (self.imageArray.count - 1)) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        row = 1;
        self.pageControl.currentPage = 1;

    }else{
        if (row == (self.imageArray.count - 2)) {
            self.pageControl.currentPage = 0;
        }else{
            self.pageControl.currentPage = row;
        }
    }
    
//    NSLog(@"处理后-----%zd", row);

    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:(row + 1) inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

#pragma mark - collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    AutoScrollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    
    [cell.imageV sd_setImageWithURL:self.imageArray[indexPath.row]];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSLog(@"%s", __func__);
    if (self.selectedBlock) {
        self.selectedBlock(indexPath.row);
    }
    
}


// 将要开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}
// 完成减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSIndexPath *index = [[self.collectionView indexPathsForVisibleItems] firstObject];
    NSInteger row = index.row;
//    NSLog(@"scrollViewDidEndDecelerating %zd", row);

    if (row == 0) {
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.imageArray.count - 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];

        self.pageControl.currentPage = self.imageArray.count - 2;

        
    } else if (row == self.imageArray.count - 1){
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        self.pageControl.currentPage = 1;

    }else{
        self.pageControl.currentPage = row - 1;
    }
    
    [self addTimer];
}


@end


@implementation AutoScrollViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self bgImageView];
    }
    return self;
}

- (void)bgImageView{
        self.imageV = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:self.imageV];
}

@end
