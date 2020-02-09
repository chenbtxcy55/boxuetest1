//
//  GoodsDetailCell.m
//  SSKJ
//
//  Created by apple on 2019/9/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "GoodsDetailCell.h"

@implementation GoodsDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier] ) {
        
        [self confiUI];
        
        self.contentView.backgroundColor = self.backgroundColor = kBgColor353750;
    }
    
    return self;
}



-(void)confiUI{
    
    self.img =[UIImageView new];
    
    [self.contentView addSubview:self.img];
    
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
}
-(void)setModel:(ImgModel *)model{
    
    _model=model;
   
//    [self.img sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:_model.url]]];
    
    if (_model.imgheight>0) {
        [self.img removeFromSuperview];
        [self confiUI];

        [self.img sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:model.url]]];
        [self.img mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(self->_model.imgheight);
            
            
        }];
        return;
    }
   
    [self.img sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:model.url]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        SsLog(@"finish_imgUrlwidth:::%f",image.size.width);
        
        if (image.size.height>0) {
            WS(weakself);
            
            NSString *width = [NSString stringWithFormat:@"%f",image.size.width];
             NSString *height = [NSString stringWithFormat:@"%f",image.size.height];
            double Rati = [height floatValue]/[width floatValue];
            
            NSLog(@"Rati::::%f",Rati);
            
            model.imgheight=ScreenWidth*[height floatValue]/[width floatValue];
            NSLog(@"img____%f",model.imgheight);
            [self.img mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(model.imgheight);
                
                
            }];
            if (weakself.block) {
                
                weakself.block();
                
            }
            
        }
       
        
    }];
    
    
}
@end
