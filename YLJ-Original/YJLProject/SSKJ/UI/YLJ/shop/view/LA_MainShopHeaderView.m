//
//  LA_MainShopHeaderView.m
//  SSKJ
//
//  Created by GT on 2019/7/25.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "LA_MainShopHeaderView.h"
#import "UIButton+WebCache.h"
#import "SPButton.h"
#import "MyLayout.h"
#import "LA_MainShopCollectionCell.h"



@interface LA_MainShopHeaderView()
<SDCycleScrollViewDelegate>


@property(nonatomic, strong) MyLinearLayout *contentLayout;
@property (nonatomic,strong) MyLinearLayout *ageSelectLayout;
@property (nonatomic,strong) UIImageView *bottomImgView;
@property (nonatomic,strong) UIButton *gotoShopBtton;


@end
@implementation LA_MainShopHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = kMainWihteColor;

    MyLinearLayout *contentLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
//    contentLayout.padding = UIEdgeInsetsMake(ScaleW(0), ScaleW(0), ScaleW(25), ScaleW(0)); //设置布局内的子视图离自己的边距.
    contentLayout.myHorzMargin = 0;                          //同时指定左右边距为0表示宽度和父视图一样宽
    contentLayout.heightSize.lBound(self.heightSize, ScaleW(0), 1);//高度虽然是wrapContentHeight的。但是最小的高度不能低于父视图的高度加10.
    self.contentLayout = contentLayout;
    contentLayout.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentLayout];
//    rootLayout.insetsPaddingFromSafeArea = UIRectEdgeAll;  //您可以在这里将值改变为UIRectEdge的其他类型然后试试运行的效果。并且在运行时切换横竖屏看看效果
}



- (void)setDataSourceArray:(NSArray *)dataSourceArray {
    _dataSourceArray = dataSourceArray;
    [self.ageSelectLayout removeFromSuperview];
    [self.bottomImgView removeFromSuperview];
    [self setupMidView];

}

- (void)setupMidView {
    [self.contentLayout addSubview:self.gotoShopBtton];
    //垂直线性布局套水平线性布局
    MyLinearLayout *ageSelectLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.ageSelectLayout = ageSelectLayout;
    ageSelectLayout.myTop = ScaleW(15);
    ageSelectLayout.wrapContentHeight = YES;
    ageSelectLayout.padding = UIEdgeInsetsMake(ScaleW(5), ScaleW(5), ScaleW(5), ScaleW(5));
    ageSelectLayout.gravity = MyGravity_Horz_Fill;   //布局视图里面的所有子视图的宽度和布局相等。
    ageSelectLayout.myHorzMargin = 0;

    ageSelectLayout.subviewHSpace = ScaleW(10);   //里面所有子视图之间的水平间距。

    [self.contentLayout addSubview:ageSelectLayout];
    
    for (int i = 0; i < self.dataSourceArray.count; i++)
//        for (int i = 0; i < 3; i++)
    {
        LA_MainShopCollectionCell *cell = [[LA_MainShopCollectionCell alloc] initWithFrame:CGRectZero];
        [cell.backBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.backBtn.tag = 1000 + i;
        LA_MainShopHotListModel *lModel = self.dataSourceArray[i];
        cell.lModel = lModel;
        cell.myHeight = ScaleW(190);
        cell.weight = 1.0;   //这里面每个子视图的宽度都是比重为1，最终的宽度是均分父视图的宽度。
        [ageSelectLayout addSubview:cell];
        

    }

    UIImageView *bottomImgView = [FactoryUI createImageViewWithFrame:CGRectZero imageName:@"ylj_img_place"];
    self.bottomImgView = bottomImgView;
    bottomImgView.myTop = ScaleW(20);
    bottomImgView.myLeading = ScaleW(15);
    bottomImgView.myTrailing = ScaleW(15);
    bottomImgView.myHeight = ScaleW(100);
    bottomImgView.myBottom = ScaleW(15);
    [self.contentLayout addSubview:bottomImgView];
}






-(UIButton *)gotoShopBtton
{
    if (!_gotoShopBtton)
    {
        _gotoShopBtton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_gotoShopBtton btn:_gotoShopBtton font:ScaleW(0) textColor:nil text:@"" image:[UIImage imageNamed:@"ylj_img_yq"] sel:@selector(guanggaoEvent) taget:self];
//        _gotoShopBtton.topPos.equalTo(self).offset(10);  //顶部边距设置为10。
        _gotoShopBtton.myTop = ScaleW(15);  //上边间距15
        _gotoShopBtton.myLeading = ScaleW(15); //左边边距15
        //    v1.myLeft = 10; //左边边距10
        _gotoShopBtton.myWidth =  ScreenWidth - ScaleW(30);
        _gotoShopBtton.myHeight = ScaleW(80);     //设置布局尺寸
//        UILabel *hotTitle = [WLTools allocLabel:SSKJLocalized(@"诚信店铺 震撼来袭", nil) font:systemBoldFont(ScaleW(15)) textColor:kMainTextColor frame:CGRectMake(ScaleW(127), ScaleW(54), ScaleW(130), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
//
//        [_gotoShopBtton addSubview:hotTitle];
//
//
//        UILabel *hotTitle1 = [WLTools allocLabel:SSKJLocalized(@"YEC商城甄选海量优质商家", nil) font:systemFont(ScaleW(12)) textColor:kMainTextColor frame:CGRectMake(ScaleW(127), ScaleW(78), ScaleW(150), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
//
//        [_gotoShopBtton addSubview:hotTitle1];
    }
    return _gotoShopBtton;
}
#pragma mark - Action
- (void)guanggaoEvent {
    NSLog(@"点击了广告");
    if (self.guanggaoBlock) {
        self.guanggaoBlock();
    }
}

- (void)btnAction:(UIButton *)sender {
    NSLog(@"点击了第%ld个按钮",sender.tag - 1000);
    if (self.selectBlock) {
        self.selectBlock(sender.tag - 1000);
    }
}



@end
