//
//  ZXXImageArrowItem.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/7/26.
//  Copyright © 2017年 james. All rights reserved.
//

#import "ZXXImageArrowItem.h"

@implementation ZXXImageArrowItem
+ (instancetype)itemWithTitle:(NSString *)title rightImage:(UIImage *)rightImage WithAttribute:(void (^)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^)(ZXXImageArrowItem * _Nullable))option{
    return [self itemWithImage:nil subtitle:nil title:title rightImage:rightImage WithAttribute:attribute cellHeight:height WithOption:option];
}
+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title rightImage:(UIImage *)rightImage WithAttribute:(void (^)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^)(ZXXImageArrowItem * _Nullable))option{
    return [self itemWithImage:image subtitle:nil title:title rightImage:rightImage WithAttribute:attribute cellHeight:height WithOption:option];
}
+ (instancetype)itemWithImage:(UIImage *)image subtitle:(NSString *)subtitle title:(NSString *)title rightImage:(UIImage *)rightImage WithAttribute:(void (^)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^)(ZXXImageArrowItem * _Nullable))option{
    ZXXImageArrowItem *item = [[self alloc] init];
    item.image = image;
    item.title = title;
    item.subTitle = subtitle;
    item.rightImage = rightImage;
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
