//
//  ZXXLabelItem.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/7/26.
//  Copyright © 2017年 james. All rights reserved.
//

#import "ZXXLabelItem.h"

@implementation ZXXLabelItem
+ (instancetype)itemWithTitle:(NSString *)title rightTitle:(NSString *)rightTitle WithAttribute:(void (^)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^)(ZXXLabelItem * _Nullable))option{
    return [self itemWithImage:nil subtitle:nil title:title rightTitle:rightTitle WithAttribute:attribute cellHeight:height WithOption:option];
}
+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title rightTitle:(NSString *)rightTitle WithAttribute:(void (^)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^)(ZXXLabelItem * _Nullable))option{
    return [self itemWithImage:image subtitle:nil title:title rightTitle:rightTitle WithAttribute:attribute cellHeight:height WithOption:option];
}
+ (instancetype)itemWithImage:(UIImage *)image subtitle:(NSString *)subtitle title:(NSString *)title rightTitle:(NSString *)rightTitle WithAttribute:(void (^)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^)(ZXXLabelItem * _Nullable))option{
    ZXXLabelItem *item = [[self alloc] init];
    item.image = image;
    item.title = title;
    item.subTitle = subtitle;
    item.rightTitle = rightTitle;
    if (attribute!=nil) {
        ZXXAttributeItem *attri = [[ZXXAttributeItem alloc] init];
        item.attribute = attri;
        attribute(attri);
    }
    
    item.height = height;
    item.option = option;
    return item;
}
@end