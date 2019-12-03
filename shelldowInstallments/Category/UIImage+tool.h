//
//  UIImage+tool.h
//  testToolDemo
//
//  Created by 段贤才 on 16/6/28.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (tool)

+ (instancetype)imageWithOringalName:(NSString *)imageName;

+ (instancetype)imageWithStretchableName:(NSString *)imageName;
/** 按比例缩放,size 是你要把图显示到 多大区域 ScaleAspectfill */
+ (UIImage *)imageCompressAspectFillSizeScale:(UIImage *)sourceImage targetSize:(CGSize)size;
/** 指定宽度按比例缩放 ScaleAspectFit */
+ (UIImage *)imageCompressAspectFitSizeScale:(UIImage *)sourceImage targetSize:(CGSize)defineSize;
/**
 *  等比缩放 ScaleAspectFit
 *
 *  @param size 设置尺寸
 *
 *  @return image
 */
-(UIImage *)scaleImageToSize:(CGSize)size;
/**
 *  自定长宽 ScaleToFill
 *
 *  @param reSize 设置尺寸
 *
 *  @return image
 */
-(UIImage *)imageReSize:(CGSize)reSize;
/**
 *  剪切
 *
 *  @param cutRect 选取截取部分
 *
 *  @return image
 */
-(UIImage *)cutImageWithRect:(CGRect)cutRect;
/**
 *  压缩
 *
 *  @param image 待压缩的图片
 *
 *  @return image
 */
+ (UIImage *)smallTheImage:(UIImage *)image;
/**
 *  压缩（上传）
 *
 *  @param image 待压缩图片
 *
 *  @return 图片的二进制文件
 */
+ (NSData *)smallTheImageBackData:(UIImage *)image;

/**
 压缩指定最大大小图片

 @param image 图片
 @param maxLength 字节
 @return 图片
 */
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;
/**
 *  view转位图（一般用于截图）
 *
 *  @param view 需要转化的view
 *
 *  @return image
 */
+ (UIImage *)imageFromView:(UIView*)view;

- (NSString *)saveImageToDocumentWithfolder:(NSString *)folder fileName:(NSString *)fileName;
- (NSString *)saveImageToCachesWithfolder:(NSString *)folder fileName:(NSString *)fileName;
- (NSString *)saveImageToTemporaryWithfolder:(NSString *)folder fileName:(NSString *)fileName;

/**
 二维码生成
 @param string 二维码内容
 @param size 图片宽度
 @return 二维码图片
 */
+ (UIImage *)produceRQcodeWithDataString:(NSString *)string withSize:(CGFloat) size;

+ (NSString *)calulateImageFileSize:(UIImage *)image;

@end
