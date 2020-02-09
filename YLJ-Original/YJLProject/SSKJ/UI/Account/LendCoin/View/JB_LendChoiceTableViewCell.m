//
//  JB_LendChoiceTableViewCell.m
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_LendChoiceTableViewCell.h"

@interface JB_LendChoiceTableViewCell()
<UITextFieldDelegate>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *subTitleLB;
@property (nonatomic, strong) UIImageView *arrowIM;
@property (nonatomic, strong) UITextField *inputTF;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) JB_LendCoinModel *coinModel;
@end

@implementation JB_LendChoiceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.titleLB];
        [self.bgView addSubview:self.subTitleLB];
        [self.bgView addSubview:self.arrowIM];
        [self.bgView addSubview:self.inputTF];
        [self.bgView addSubview:self.lineView];
        [self setupMasnory];
    }
    return self;
}

#pragma mark -- Private Method

- (void)configureCellWithModel:(JB_LendCoinModel *)model hiddenLine:(BOOL)hiddenLine {
    self.coinModel = model;
    self.lineView.hidden = hiddenLine;
    self.titleLB.text = model.title?:@"";
    self.subTitleLB.text = model.subTitle?:@"";
    self.inputTF.placeholder = model.inputPlaceHolder?:@"";
    self.inputTF.keyboardType = model.keyboardType;
    if (model.inputText.length == 0) {
        self.inputTF.text = @"";
    }else{
        self.inputTF.text = [WLTools noroundingStringWith:model.inputText.doubleValue afterPointNumber:4];
    }
    
    
    if (model.type == JB_LendChoiceCellType_Normal) {
        [self setupTypeNormal];
    }
    if (model.type == JB_LendChoiceCellType_Arrow) {
        [self setupTypeArrow];
    }
    if (model.type == JB_LendChoiceCellType_Input) {
        [self setupTypeInput];
    }
    if (model.type == JB_LendChoiceCellType_InputUnEble) {
        [self setupTypeInputUnEble];
    }
//    [self.inputTF setValue:[UIColor colorWithHexStringToColor:@"bbbbbb"] forKeyPath:@"_placeholderLabel.textColor"];
    
    NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: model.inputPlaceHolder?:@"" attributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexStringToColor:@"bbbbbb"]}];
    
    self.inputTF.attributedPlaceholder = placeholderString1;
    
    if ([model.title containsString:SSKJLocalized(@"密码", nil)]) {
        self.inputTF.secureTextEntry = YES;
    }else{
        self.inputTF.secureTextEntry = NO;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
    if ([string isEqualToString:@""]) {
        [futureString replaceCharactersInRange:range withString:string];
    }else{
        [futureString  insertString:string atIndex:range.location];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputTFInfoWithModel:inputString:)]) {
        [self.delegate inputTFInfoWithModel:self.coinModel inputString:futureString];
    }
    
    return YES;
}


- (void)setupTypeNormal {
    self.subTitleLB.hidden = YES;
    self.arrowIM.hidden = YES;
    self.inputTF.hidden = YES;
    self.inputTF.enabled = NO;
    
    [self.subTitleLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-ScaleW(17));
        make.centerY.equalTo(self.bgView);
    }];
    self.subTitleLB.hidden = NO;
}

- (void)setupTypeArrow {
    self.subTitleLB.hidden = YES;
    self.arrowIM.hidden = YES;
    self.inputTF.hidden = YES;
    self.inputTF.enabled = NO;
    
    [self.subTitleLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowIM.mas_left).offset(-ScaleW(7));
        make.centerY.equalTo(self.bgView);
    }];
    self.subTitleLB.hidden = NO;
    self.arrowIM.hidden = NO;
}

- (void)setupTypeInput {
    self.subTitleLB.hidden = YES;
    self.arrowIM.hidden = YES;
    self.inputTF.hidden = YES;
    self.inputTF.enabled = NO;
    
    [self.subTitleLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-ScaleW(17));
        make.centerY.equalTo(self.bgView);
    }];
    self.subTitleLB.hidden = NO;
    self.inputTF.hidden = NO;
    self.inputTF.enabled = YES;
}

- (void)setupTypeInputUnEble {
    self.subTitleLB.hidden = YES;
    self.arrowIM.hidden = YES;
    self.inputTF.hidden = YES;
    self.inputTF.enabled = NO;
    
    [self.subTitleLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-ScaleW(17));
        make.centerY.equalTo(self.bgView);
    }];
    self.subTitleLB.hidden = NO;
    self.inputTF.hidden = NO;
    self.inputTF.enabled = NO;
}

- (void)setupMasnory {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
        make.height.mas_equalTo(ScaleW(65));
    }];
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(17));
        make.centerY.equalTo(self.bgView);
    }];
    [self.arrowIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-ScaleW(17));
        make.centerY.equalTo(self.bgView);
    }];
    [self.subTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowIM.mas_left).offset(-ScaleW(7));
        make.centerY.equalTo(self.bgView);
    }];
    [self.inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.subTitleLB.mas_left).offset(-ScaleW(7));
        make.centerY.equalTo(self.bgView);
        make.height.mas_equalTo(ScaleW(65));
        make.width.equalTo(self).offset(ScaleW(150));
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(17));
        make.right.equalTo(self.bgView);
        make.top.equalTo(self.bgView).offset(ScaleW(64));
        make.height.mas_equalTo(ScaleW(1));
    }];
    
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = kSubBackgroundColor;
    }
    return _bgView;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc]init];
        _titleLB.textColor = kTextColorb2b9e7;
        _titleLB.font = [UIFont boldSystemFontOfSize:ScaleW(14)];
        _titleLB.text = SSKJLocalized(@"", nil);
        _titleLB.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLB;
}

- (UILabel *)subTitleLB {
    if (!_subTitleLB) {
        _subTitleLB = [[UILabel alloc]init];
        _subTitleLB.textColor = kTextColor6b6fb9;
        _subTitleLB.font = [UIFont boldSystemFontOfSize:ScaleW(13)];
        _subTitleLB.text = SSKJLocalized(@"", nil);
        _subTitleLB.adjustsFontSizeToFitWidth = YES;
        _subTitleLB.hidden = YES;
    }
    return _subTitleLB;
}

- (UITextField *)inputTF {
    if (!_inputTF) {
        _inputTF = [[UITextField alloc]init];
        _inputTF.textColor = kMainWihteColor;
        _inputTF.font = [UIFont systemFontOfSize:ScaleW(13)];
//        [_inputTF setValue:kTextDarkBlueColor forKeyPath:@"_placeholderLabel.textColor"];
        
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: @"" attributes:@{NSForegroundColorAttributeName : kTextDarkBlueColor}];
        
        self.inputTF.attributedPlaceholder = placeholderString1;
        _inputTF.hidden = YES;
        _inputTF.enabled = NO;
        _inputTF.textAlignment = NSTextAlignmentRight;
        _inputTF.delegate = self;
    }
    return _inputTF;
}

- (UIImageView *)arrowIM {
    if (!_arrowIM) {
        _arrowIM = [[UIImageView alloc]init];
        _arrowIM.image = [UIImage imageNamed:@"arrow_right_icon"];
        _arrowIM.hidden = YES;
    }
    return _arrowIM;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kLineGrayColor;
    }
    return _lineView;
}
@end
