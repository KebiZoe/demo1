//
//  ZXXSettingCell.m
//  ZXXWeb
//
//  Created by zoekebi on 16/10/24.
//  Copyright © 2016年 www.iphonetrain.com. All rights reserved.
//

#import "ZXXSettingCell.h"
#import "CalculateSize.h"

#define TITLEFONT [UIFont fontWithName:@"STHeitiSC-Light" size:15]
#define SUBTITLEFONT [UIFont fontWithName:@"STHeitiSC-Light" size:13]

#define TITLECOLOR [UIColor colorWithWhite:0.200 alpha:1.000]
#define SUBTITLECOLOR [UIColor colorWithWhite:0.400 alpha:1.000]

#define ARROWLABLEFONT FONT(14)
#define ARROWLABLECOLOR [UIColor colorWithWhite:0.600 alpha:1.000]
#define TEXTFIELDFONT [UIFont fontWithName:@"STHeitiSC-Light" size:15]
#define TEXTFIELDCOLOR [UIColor colorWithWhite:0.400 alpha:1.000]

static NSString *placeholder = @"请输入文字";
@interface ZXXSettingCell ()<UITextFieldDelegate>

/**
 右边提示数字
 */
@property (nonatomic, weak)ZXXBadgeView *badgeView;
/**
 控件开关
 */
@property (nonatomic, weak)UISwitch *switchView;

/**
 右侧label
 */
@property (nonatomic, weak)UILabel *label;

/**
 右侧带有label和跳转icon
 */
@property (nonatomic, weak)UILabel *arrowLabel;

/**
 右侧带有image和跳转icon
 */
@property (nonatomic, weak)UIImageView *arrowImage;

/**
 右侧textField
 */
@property(nonatomic,strong)UITextField *textField;

@end

@implementation ZXXSettingCell

- (ZXXBadgeView *)badgeView{
    if (_badgeView == nil) {
        ZXXBadgeView *badgeView = [ZXXBadgeView buttonWithType:UIButtonTypeCustom];
        UIView *view = [[UIView alloc] init];
        [view addSubview:badgeView];
        self.accessoryView = view;
        [badgeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view);
            make.centerY.equalTo(view);
        }];
        _badgeView = badgeView;
    }
    return _badgeView;
}

- (UISwitch *)switchView{
    if (_switchView == nil) {
        UISwitch *switchView = [[UISwitch alloc] init];
        self.accessoryView = switchView;
        [switchView addTarget:self action:@selector(switchViewValueChanged) forControlEvents:UIControlEventValueChanged];
        _switchView = switchView;
    }
    return _switchView;
}
- (void)switchViewValueChanged{
    self.item.on = self.switchView.on;
    self.item.option(self.item);
}

- (UILabel *)label{
    if (_label == nil) {
        UILabel *label = [[UILabel alloc] init];
        self.accessoryView = label;
        _label = label;
    }
    return _label;
}

/**带有label和跳转icon*/
- (UILabel *)arrowLabel{
    if (_arrowLabel == nil) {
        UIView *view = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] init];
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        UIImageView *imgV = [[UIImageView alloc] initWithImage:UIImageMake(@"btn_next_mine")];
        [view addSubview:imgV];
        [view addSubview:label];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view);
            make.centerY.equalTo(view);
        }];
//        [label makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(imgV.left).offset(-10);
//            make.centerY.equalTo(view);
//            make.width.lessThanOrEqualTo(@(SCREEN_WIDTH-120));
//        }];
        _arrowLabel = label;
        self.accessoryView = view;
    }
    return _arrowLabel;
}
- (UIImageView *)arrowImage{
    if (_arrowImage == nil) {
        UIView *view = [[UIView alloc] init];
        UIImageView *arrowImage = [[UIImageView alloc] init];
        
        UIImageView *imgV = [[UIImageView alloc] initWithImage:UIImageMake(@"btn_next_mine")];
        [view addSubview:imgV];
        [view addSubview:arrowImage];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view);
            make.centerY.equalTo(view);
        }];
        _arrowImage = arrowImage;
        self.accessoryView = view;
    }
    return _arrowImage;
}
- (UITextField *)textField{
    if (_textField == nil) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNoteTodoAction) name:UIKeyboardWillHideNotification object:nil];
        UITextField *textField = [[UITextField alloc] init];
        textField.textAlignment = NSTextAlignmentRight;
        textField.delegate = self;
        textField.returnKeyType = UIReturnKeyDone;
        textField.font = TEXTFIELDFONT;
        textField.textColor = TEXTFIELDCOLOR;
        textField.placeholder = placeholder;
        self.accessoryView = textField;
        _textField = textField;
    }
    return _textField;
}

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.item.rightTitle isEqualToString:textField.text]) {
        return;
    }else{
        self.item.rightTitle = textField.text;
    }
}
- (void)receiveNoteTodoAction{
    [self endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if ([self.reuseIdentifier containsString:CELLCOMMON_EDIT]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:UIKeyboardWillHideNotification object:nil];
    }
}

+ (instancetype)cellTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier{
    
    ZXXSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        cell.separatorInset = UIEdgeInsetsMake(0, 12, 0, 0);
    }
    return cell;
}

- (void)setItem:(ZXXSetItem *)item{
    _item = item;
    if ([item class] != [ZXXArrowItem class]&&[item class] != [ZXXLabelArrowItem class]&&[item class] != [ZXXImageArrowItem class]) {// 不是ZXXArrowItem样式时可为不可选中样式
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    if (item.class == [ZXXArrowItem class]) {//
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (item.class == [ZXXCheakItem class]){
        if (item.cheak == YES) {
            self.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            self.accessoryType = UITableViewCellAccessoryNone;
        }
    }else if (item.class == [ZXXLabelItem class]){
        self.label.text = item.rightTitle;
        if (item.attribute.rightTitleFont!=nil) {
            self.label.font = item.attribute.rightTitleFont;
        }else{
            self.label.font = ARROWLABLEFONT;
        }
        if (item.attribute.rightTitleColor!=nil) {
            self.label.textColor = item.attribute.rightTitleColor;
        }else{
            self.label.textColor = ARROWLABLECOLOR;
        }
        [self.label sizeToFit];
    }else if (item.class == [ZXXLabelArrowItem class]){//
        self.arrowLabel.text = item.rightTitle;
        [self.arrowLabel sizeToFit];
        if (item.attribute.rightTitleFont!=nil) {
            self.arrowLabel.font = item.attribute.rightTitleFont;
        }else{
            self.arrowLabel.font = ARROWLABLEFONT;
        }
        if (item.attribute.rightTitleColor!=nil) {
            self.arrowLabel.textColor = item.attribute.rightTitleColor;
        }else{
            self.arrowLabel.textColor = ARROWLABLECOLOR;
        }
    }else if (item.class == [ZXXImageArrowItem class]){//
        if (item.attribute.rightImageDict) {
            [self.arrowImage setImageWithURL:[NSURL URLWithString:item.attribute.rightImageDict[@"imageUrl"]] placeholder:[UIImage imageNamed:item.attribute.rightImageDict[@"placeHolder"]]];
        }else{
            [self.arrowImage setImage:item.rightImage];
        }
    }else if (item.class == [ZXXBadgeItem class]){//
        self.badgeView.badgeValue = item.badgeValue;
    }else if (item.class == [ZXXSwitchItem class]){
        self.switchView.on = item.on;
    }else if (item.class == [ZXXTextFieldItem class]){
        self.textField.text = item.rightTitle;
        if (item.attribute.rightTitleFont!=nil) {
            self.textField.font = item.attribute.rightTitleFont;
        }else{
            self.textField.font = TEXTFIELDFONT;
        }
        if (item.attribute.rightTitleColor!=nil) {
            self.textField.textColor = item.attribute.rightTitleColor;
        }else{
            self.textField.textColor = TEXTFIELDCOLOR;
        }
        if (item.attribute.rightPlaceHolder!=nil) {
            self.textField.placeholder = item.attribute.rightPlaceHolder;
        }else{
            self.textField.placeholder = placeholder;
        }
        if (item.attribute.rightTextField_forbidEdit){
            self.textField.enabled = NO;
        }else{
            self.textField.enabled = YES;
        }
    }
    
    if (item.title) {
        self.textLabel.text = item.title;
        if (item.attribute.titleFont!=nil) {
            self.textLabel.font = item.attribute.titleFont;
        }else{
            self.textLabel.font = TITLEFONT;
        }
        if (item.attribute.titleColor!=nil) {
            self.textLabel.textColor = item.attribute.titleColor;
        }else{
            self.textLabel.textColor = TITLECOLOR;
        }
    }else{
        self.textLabel.text = nil;
    }
    if (item.subTitle) {
        self.detailTextLabel.text = item.subTitle;
        if (item.attribute.subTitleFont!=nil) {
            self.detailTextLabel.font = item.attribute.subTitleFont;
        }else{
            self.detailTextLabel.font = SUBTITLEFONT;
        }
        if (item.attribute.subTitleColor!=nil) {
            self.detailTextLabel.textColor = item.attribute.subTitleColor;
        }else{
            self.detailTextLabel.textColor = SUBTITLECOLOR;
        }
    }else{
        self.detailTextLabel.text = nil;
    }
    if (item.attribute.imageDict) {
        [self.imageView setImageWithURL:[NSURL URLWithString:item.attribute.imageDict[@"imageUrl"]] placeholder:[UIImage imageNamed:item.attribute.imageDict[@"placeHolder"]]];
    }else{
        if (item.image) {
            self.imageView.image = item.image;
        }else{
            self.imageView.image = nil;
        }
    }
    
    self.imageEdgeInsets = item.attribute.imageEdgeInsets;
    self.textLabelEdgeInsets = item.attribute.textLabelEdgeInsets;
    self.detailTextLabelEdgeInsets = item.attribute.detailTextLabelEdgeInsets;
    self.accessoryEdgeInsets = item.attribute.accessoryEdgeInsets;
    
}

/// 在父类中已经实现了布局。只要设置相关的属性就行了
- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.item.class == [ZXXTextFieldItem class]) {
        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-20);
        }];
    }else if (self.item.class == [ZXXImageArrowItem class]){
        if (!UIEdgeInsetsEqualToEdgeInsets(self.accessoryEdgeInsets, UIEdgeInsetsZero)) {
            if (!CGSizeEqualToSize(self.item.attribute.rightImageSize, CGSizeZero)) {
                [self.accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self).offset(-20-self.accessoryEdgeInsets.right);
                    make.centerY.equalTo(self);
                    make.size.sizeOffset(CGSizeMake(self.item.attribute.rightImageSize.width+20, self.item.attribute.rightImageSize.height));
                }];
                [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.bottom.equalTo(self.accessoryView);
                    make.right.equalTo(self.accessoryView).offset(-20);
                    make.size.sizeOffset(self.item.attribute.rightImageSize);
                }];
                
            }else{
                [self.accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self).offset(-20-self.accessoryEdgeInsets.right);
                    make.centerY.equalTo(self);
                    make.size.sizeOffset(CGSizeMake(44, 24));
                }];
                [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.bottom.equalTo(self.accessoryView);
                    make.right.equalTo(self.accessoryView).offset(-20);
                    make.size.sizeOffset(CGSizeMake(24, 24));
                }];
            }
        }else{
            if (!CGSizeEqualToSize(self.item.attribute.rightImageSize, CGSizeZero)) {
                [self.accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self).offset(-20);
                    make.centerY.equalTo(self);
                    make.size.sizeOffset(CGSizeMake(self.item.attribute.rightImageSize.width+20, self.item.attribute.rightImageSize.height));
                }];
                [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.bottom.equalTo(self.accessoryView);
                    make.right.equalTo(self.accessoryView).offset(-20);
                    make.size.sizeOffset(self.item.attribute.rightImageSize);
                }];
                
            }else{
                [self.accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self).offset(-20);
                    make.centerY.equalTo(self);
                    make.size.sizeOffset(CGSizeMake(44, 24));
                }];
                [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.bottom.equalTo(self.accessoryView);
                    make.right.equalTo(self.accessoryView).offset(-20);
                    make.size.sizeOffset(CGSizeMake(24, 24));
                }];
            }
        }
    }else if(self.item.class == [ZXXLabelArrowItem class]){
        CGFloat labelWidth;
        CGFloat labelHeight;
        if (self.item.attribute.rightTitleFont) {
            labelWidth = [CalculateSize sizeForNoticeTitle:self.item.rightTitle font:self.item.attribute.rightTitleFont maxW:SCREEN_WIDTH-120].width;
            labelHeight = [CalculateSize sizeForNoticeTitle:self.item.rightTitle font:self.item.attribute.rightTitleFont maxW:CGFLOAT_MAX].height;
        }else{
            labelWidth = [CalculateSize sizeForNoticeTitle:self.item.rightTitle font:ARROWLABLEFONT maxW:SCREEN_WIDTH-120].width;
            labelHeight = [CalculateSize sizeForNoticeTitle:self.item.rightTitle font:ARROWLABLEFONT maxW:CGFLOAT_MAX].height;
        }
        if (!UIEdgeInsetsEqualToEdgeInsets(self.accessoryEdgeInsets, UIEdgeInsetsZero)) {
            [self.accessoryView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-20-self.accessoryEdgeInsets.right);
                make.centerY.equalTo(self);
                make.width.offset(labelWidth+16);
                make.height.equalTo(self.arrowLabel);
            }];
        }else{
            [self.accessoryView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-20);
                make.centerY.equalTo(self);
                make.width.offset(labelWidth+16);
                make.height.equalTo(self.arrowLabel);
            }];
        }
        self.arrowLabel.frame = CGRectMake(0, 0, labelWidth, labelHeight);
    }
    
    if (self.item.attribute.circular_clips) {
        CGRect rect = self.imageView.frame;
        self.imageView.layer.cornerRadius = (rect.size.width + rect.size.height)/4;
        self.imageView.layer.masksToBounds = YES;
        if (self.item.class == [ZXXImageArrowItem class]&&!CGSizeEqualToSize(self.item.attribute.rightImageSize, CGSizeZero)) {
            self.arrowImage.layer.cornerRadius = self.item.attribute.rightImageSize.width/2;
            self.arrowImage.layer.masksToBounds = YES;
        }else if (self.item.class == [ZXXImageArrowItem class]&&CGSizeEqualToSize(self.item.attribute.rightImageSize, CGSizeZero)){
            self.arrowImage.layer.cornerRadius = 12;
            self.arrowImage.layer.masksToBounds = YES;
        }
    }else{
        self.imageView.layer.cornerRadius = 0;
    }
}

- (void)dealloc{
    if (_textField) {
        [[NSNotificationCenter defaultCenter]removeObserver:self];
    }
}
@end
