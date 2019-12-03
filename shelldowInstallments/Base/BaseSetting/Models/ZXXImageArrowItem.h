//
//  ZXXImageArrowItem.h
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/7/26.
//  Copyright © 2017年 james. All rights reserved.
//

#import "ZXXSetItem.h"

@interface ZXXImageArrowItem : ZXXSetItem
/**
 ,一个TitleLable,右边为一个带Label的箭头
 
 @param title 主标题
 @param rightImage 右边的Label
 @param attribute 可以设置文字的颜色和位置
 @param height cell的高度
 @param option 点击cell要做的事情
 @return ZXXLabelArrowItem
 */
+ (instancetype _Nonnull)itemWithTitle:(NSString *_Nullable)title rightImage:(UIImage *_Nullable)rightImage WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable attribute))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXImageArrowItem * _Nullable item))option;
/**
 左边一个ImageView,一个TitleLable,右边为一个带Label的箭头
 
 @param image 图片
 @param title 主标题
 @param rightImage 右边的Label
 @param attribute 可以设置文字的颜色和位置
 @param height cell的高度
 @param option 点击cell要做的事情
 @return ZXXLabelArrowItem
 */
+ (instancetype _Nonnull)itemWithImage:(UIImage *_Nullable)image title:(NSString *_Nullable)title rightImage:(UIImage *_Nullable)rightImage WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable attribute))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXImageArrowItem * _Nullable item))option;
/**
 左边一个ImageView,一个TitleLable,一个subTitle,右边为一个带Label的箭头
 
 @param image 图片
 @param subtitle 副标题
 @param title 主标题
 @param rightImage 右边的Label
 @param attribute 可以设置文字的颜色和位置
 @param height cell的高度
 @param option 点击cell要做的事情
 @return ZXXLabelArrowItem
 */
+ (instancetype _Nonnull)itemWithImage:(UIImage *_Nullable)image subtitle:(NSString *_Nullable)subtitle title:(NSString *_Nullable)title rightImage:(UIImage *_Nullable)rightImage WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable attribute))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXImageArrowItem * _Nullable item))option;
@end
