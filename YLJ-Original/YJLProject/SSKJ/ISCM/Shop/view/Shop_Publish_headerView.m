//
//  Shop_Publish_headerView.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/11.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Shop_Publish_headerView.h"

#import "ETF_Default_ActionsheetView.h"

@interface Shop_Publish_headerView()

@property (nonatomic, strong) UIButton *bottomBtn;


@end

@implementation Shop_Publish_headerView

-(instancetype)init
{
    if (self = [super init])
    {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(700));
        [self addSubview:self.shuoView];
        [self addSubview:self.shopView];
        [self addSubview:self.detailView];
        [self addSubview:self.shopTypeTf];
//        [self addSubview:self.shopPriceTf];
        [self addSubview:self.daiShouStoreTf];
        [self addSubview:self.kuaiDiStoreTf];
        [self addSubview:self.shopStoreTf];
        [self addSubview:self.bottomBtn];
        self.height = self.bottomBtn.bottom;
    }
    return self;
}
-(Shop_Publish_View *)shuoView{
    
    if (nil == _shuoView) {
        
         _shuoView = [[Shop_Publish_View alloc]initWithTop:0 Title:@"" subTiles:@"" limit:0 andDecripTitle:SSKJLocalized(@"添加缩略图", nil) subTitle:@"" andHeight:ScaleW(120) andImgLimit:1 andImgType:3];
        
        [_shuoView.addImgeBtn setImage:[UIImage imageNamed:@"suolueTu"] forState:UIControlStateNormal];
        
    }
    
    return _shuoView;
    
}
-(Shop_Publish_View *)shopView

{
    if (!_shopView) {
        _shopView = [[Shop_Publish_View alloc]initWithTop:_shuoView.bottom +ScaleW(10) Title:SSKJLocalized(@"标题", nil) subTiles:SSKJLocalized(@"例如：【五双装】韩版复古女袜，五中颜色各一双", nil) limit:50 andDecripTitle:@"" subTitle:@"" andHeight:ScaleW(280) andImgLimit:5 andImgType:0];
          [_shopView.addImgeBtn setImage:[UIImage imageNamed:@"lunboTu"] forState:UIControlStateNormal];
    }
    return _shopView;
}
-(Shop_Publish_View *)detailView
{
    if (!_detailView) {
        _detailView = [[Shop_Publish_View alloc]initWithTop:_shopView.bottom +ScaleW(10) Title:SSKJLocalized(@"商品简介", nil) subTiles:SSKJLocalized(@"请填写商品简介", nil) limit:180 andDecripTitle:@"" subTitle:@"" andHeight:ScaleW(280)+ScaleW(60) andImgLimit:9 andImgType:2];
        [_detailView.addImgeBtn setImage:[UIImage imageNamed:@"lunboTu"] forState:(UIControlStateNormal)];

    }
    return _detailView;
}

-(UIInput_Title_TFView *)shopTypeTf
{
    if (!_shopTypeTf) {
        _shopTypeTf = [[UIInput_Title_TFView alloc]initWithTop:_detailView.bottom + ScaleW(10) title:SSKJLocalized(@"商品类别", nil) subTitle:SSKJLocalized(@"请选择商品类别", nil)];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = _shopTypeTf.bounds;
        [_shopTypeTf addSubview:btn];
        [btn btn:btn font:ScaleW(0) textColor:kMainColor text:@"" image:nil sel:@selector(gotoAction:) taget:self];
        
        UIImageView *gotoImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(353), ScaleW(19), ScaleW(7), ScaleW(15))];
        
        gotoImg.image = [UIImage imageNamed:@"arrow_right_icon"];
        
        [btn addSubview:gotoImg];
        
    }
    return _shopTypeTf;
}

-(void)gotoAction:(UIButton *)sender
{
    NSMutableArray *nameArray = [NSMutableArray array];
    
    NSMutableArray *idArray = [NSMutableArray array];
    for (NSDictionary *dic in [SSKJ_User_Tool sharedUserTool].typeArray) {
//        "type_id": "1",
//        "type_name": "电器",
//        "icon": "\/Uploads\/app\/banner\/2019\/09-12\/5d79a55ae22c487644.jpg"
        [nameArray addObject:dic[@"type_name"]];
        [idArray addObject:dic[@"type_id"]];
    }
    WS(weakSelf);
    [ETF_Default_ActionsheetView showWithItems:nameArray title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
        NSString *title = nameArray[selectIndex];
        weakSelf.cateId = idArray[selectIndex];
        weakSelf.shopTypeTf.textFild.text = title;
        
        
    } cancleBlock:^{
        
    }];
}

-(UIInput_Title_TFView *)shopPriceTf
{
    if (!_shopPriceTf) {
        _shopPriceTf = [[UIInput_Title_TFView alloc]initWithTop:_shopTypeTf.bottom title:SSKJLocalized(@"可售价格", nil) subTitle:SSKJLocalized(@"请填写可售价格         ", nil)];
//        [self addSubview:_shopPriceTf];
        
    }
    return _shopPriceTf;
}

-(UIInput_Title_TFView *)daiShouStoreTf{
    
    if (nil == _daiShouStoreTf) {
        
        _daiShouStoreTf = [[UIInput_Title_TFView alloc]initWithTop:_shopTypeTf.bottom title:SSKJLocalized(@"价    格", nil) subTitle:SSKJLocalized(@"请填写价格               元", nil)];

    }
    
    return _daiShouStoreTf;
    
}
-(UIInput_Title_TFView *)kuaiDiStoreTf{
    
    if (nil == _kuaiDiStoreTf) {
        
       
        _kuaiDiStoreTf = [[UIInput_Title_TFView alloc]initWithTop:_daiShouStoreTf.bottom title:SSKJLocalized(@"快递费用", nil) subTitle:SSKJLocalized(@"请填写快递费用           ", nil)];
        
        
       
    }
    
    return _kuaiDiStoreTf;
    
}
-(UIInput_Title_TFView *)shopStoreTf
{
    if (!_shopStoreTf) {
        _shopStoreTf = [[UIInput_Title_TFView alloc]initWithTop:_kuaiDiStoreTf.bottom title:SSKJLocalized(@"商品库存", nil) subTitle:SSKJLocalized(@"请填写商品库存", nil)];
        
    }
    return _shopStoreTf;
}

-(UIButton *)bottomBtn
{
    if (!_bottomBtn) {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomBtn.frame = CGRectMake(0,_shopStoreTf.bottom + ScaleW(15), ScreenWidth, ScaleW(49));
        [_bottomBtn btn:_bottomBtn font:ScaleW(16) textColor:kMainWihteColor text:SSKJLocalized(@"立即发布", nil) image:nil sel:@selector(bottomAction:) taget:self];
//        _bottomBtn.backgroundColor = kMainBlueColor;
//        [_bottomBtn setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
        _bottomBtn.backgroundColor = kTheMeColor;

    }
    
    return _bottomBtn;
    
}

-(void)bottomAction:(UIButton *)sender
{
    !self.commitBlock?:self.commitBlock(@{});
}
-(void)setModel:(ICC_PreOrder_GoodsInfo_Model *)model
{
    _model = model;
    
    
    self.shopView.textView.text = model.title;
    if (model) {
        self.shopView.placeHolder.text = @"";
    }
    
    
    self.shopPriceTf.textFild.text = model.price;
    
    self.shopStoreTf.textFild.text = model.store;
    
    
    
    
    
}
@end
