//
//  YLJ_Shop_OrderList_TableViewCell.m
//  SSKJ
//
//  Created by cy5566 on 2019/11/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "YLJ_Shop_OrderList_TableViewCell.h"
@interface YLJ_Shop_OrderList_TableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *shopImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statuesLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@end
@implementation YLJ_Shop_OrderList_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configCellWithModel:(YLJOrderListModel *)model{
    NSString *urlStr = model.pic_path;
    NSString *nUrlStr = [WLTools imageURLWithURL:urlStr];
    [self.shopImgView sd_setImageWithURL:[NSURL URLWithString:nUrlStr] placeholderImage:[UIImage imageNamed:@"shopSmallPic"]];
    self.titleLabel.text = model.goods_name;
    self.timeLabel.text = model.create_time;
    self.countLabel.text = [NSString stringWithFormat:@"共%@件商品",model.num];
    self.totalLabel.text = [NSString stringWithFormat:@"%@",[WLTools setTotalPriceWithJifen:model.can_sell_price andPrice:model.total_price]];
    switch ([model.status intValue]) {
        case -1:
        {
            self.statuesLabel.text = @"已取消";
        }
            break;
        case 1:
        {
            self.statuesLabel.text = @"待发货";
            
        }
            break;
        case 2:
        {
            self.statuesLabel.text = @"已发货";
            
        }
            break;
            
        default:
            break;
    }
}
@end
