//
//  NSString+tool.m
//  categoryTest
//
//  Created by 段贤才 on 16/6/22.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import "NSString+tool.h"
#import "NSDate+MJ.h"
@implementation NSString (tool)

- (BOOL) isNullString{
    if(self == nil) {
        return YES;
    }
    
    if((NSNull *)self == [NSNull null]) {
        return YES;
    }
    
    if(self.length == 0) {
        return YES;
    }
    
    if([self isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}
+ (NSString *) getDeviceIdentifierForVendor{
    return  [[UIDevice currentDevice].identifierForVendor UUIDString];
}

+ (NSString *)getAppVersions{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

+ (NSString *)getWeekDay:(NSTimeInterval)time {
    //创建一个星期数组
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    //将时间戳转换成日期
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}

+ (NSString*) format:(NSTimeInterval) time;
{
    if (time < 0)
    {
        return @"";
    }
    
    NSDateFormatter *formatter;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:time/1000];
    return [formatter stringFromDate:date];
}

+ (NSString*) formatTime:(NSTimeInterval) time;
{
    if (time < 0)
    {
        return @"";
    }
    
    NSDateFormatter *formatter;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:time/1000];
    return [formatter stringFromDate:date];
}

+ (NSString *) formatDateAndTime:(NSTimeInterval)time;{
    if (time < 0) {
        return @"";
    }
    NSDateFormatter *formatter;
    formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time/1000];
    return [formatter stringFromDate:date];
}

- (RangeFormatType)checkRange:(NSRange)range{
    NSInteger loc = range.location;
    NSInteger len = range.length;
    if (loc>=0 && len>0) {
        if (range.location + range.length <= self.length) {
            return RangeCorrect;
        }
        else{
            NSLog(@"The range out-of-bounds!");
            return RangeOut;
        }
    }
    else{
        NSLog(@"The range format is wrong: NSMakeRange(a,b) (a>=0,b>0). ");
        return RangeError;
    }
}

- (NSMutableAttributedString *)changeColor:(UIColor *)color
                                  andRange:(NSRange)range{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if ([self checkRange:range] == RangeCorrect) {
        if (color) {
            [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
        else{
            NSLog(@"color is nil");
        }
        
    }
    return attributedStr;
}

- (NSString *)afterPointZeroClear{
    if ([self containsString:@"."]) {
        NSArray<NSString *> *arr = [self componentsSeparatedByString:@"."];
        if ([arr.lastObject integerValue]>0) {
            NSMutableString *last = arr.lastObject.mutableCopy;
            while (last.length>0) {
                if ([last characterAtIndex:(last.length-1)]=='0') {
                    [last deleteCharactersInRange:NSMakeRange((last.length-1), 1)];
                }else{
                    break;
                }
            }
            return [NSString stringWithFormat:@"%@.%@",arr.firstObject,last];
        }else{
            return [NSString stringWithFormat:@"%@",arr.firstObject];
        }
    }else{
        return self;
    }
}
- (NSMutableAttributedString *)changeFont:(UIFont *)font
                                 andRange:(NSRange)range{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if ([self checkRange:range] == RangeCorrect) {
        if (font) {
            [attributedStr addAttribute:NSFontAttributeName value:font range:range];
        }
        else{
            NSLog(@"font is nil...");
        }
    }
    return attributedStr;
}


- (NSMutableAttributedString *)changeColor:(UIColor *)color
                              andColorRang:(NSRange)colorRange
                                   andFont:(UIFont *)font
                              andFontRange:(NSRange)fontRange{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if ([self checkRange:colorRange] == RangeCorrect) {
        if (color) {
            [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:colorRange];
        }
        else{
            NSLog(@"color is nil");
        }
    }
    if ([self checkRange:fontRange] == RangeCorrect) {
        if (font) {
            [attributedStr addAttribute:NSFontAttributeName value:font range:fontRange];
        }
        else{
            NSLog(@"font is nil...");
        }
    }
    return attributedStr;
}

- (NSMutableAttributedString *)changeColor:(UIColor *)color andRanges:(NSArray<NSValue *> *)ranges{
    __block NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if (color) {
        [ranges enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange range = [(NSValue *)obj rangeValue];
            if ([self checkRange:range] == RangeCorrect) {
                [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
            }
            else{
                NSLog(@"index:%lud",(unsigned long)idx);
            }
            
        }];
    }
    else{
        NSLog(@"color is nil...");
    }
    return attributedStr;
}

- (NSMutableAttributedString *)changeFont:(UIFont *)font andRanges:(NSArray<NSValue *> *)ranges{
    __block NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if (font) {
        [ranges enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange range = [(NSValue *)obj rangeValue];
            if ([self checkRange:range] == RangeCorrect) {
                [attributedStr addAttribute:NSFontAttributeName value:font range:range];
            }
            else{
                NSLog(@"index:%lud",(unsigned long)idx);
            }
            
        }];
    }
    else{
        NSLog(@"font is nil...");
    }
    return attributedStr;
}

- (NSMutableAttributedString *)changeColorAndFont:(NSArray<NSDictionary *> *)changes{
    __block NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    [changes enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIColor *color = obj[XCColorKey];
        UIFont *font = obj[XCFontKey];
        NSArray<NSValue *> *ranges = obj[XCRangeKey];
        if (!color) {
            NSLog(@"warning: NSColorKey -> nil! index:%ld",(unsigned long)idx);
        }
        if (!font) {
            NSLog(@"warning: NSFontKey -> nil! index:%ld",(unsigned long)idx);
        }
        if (ranges.count>0) {
            [ranges enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSRange range = [obj rangeValue];
                if ([self checkRange:range] == RangeCorrect) {
                    if (color) {
                        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
                    }
                    if (font) {
                        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
                    }
                }
                else{
                    NSLog(@"index:%ld",(unsigned long)idx);
                }
                
            }];
        }
        else{
            NSLog(@"warning: NSRangeKey -> nil! index:%ld",(unsigned long)idx);
        }
    }];
    return attributedStr;
    
}

- (NSMutableAttributedString *)changeWithStr:(NSString *)str andColor:(UIColor *)color andFont:(UIFont *)font{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    NSUInteger length = self.length;
    while (length > str.length) {
        NSRange range = [self rangeOfString:str options:NSBackwardsSearch range:NSMakeRange(0, length)];
        if ([self checkRange:range] == RangeCorrect) {
            if (color) {
                [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
            }
            if (font) {
                [attributedStr addAttribute:NSFontAttributeName value:font range:range];
            }
            length = range.location;
        }
        else{
            length = str.length - 1;
        }
    }
    return attributedStr;
}
- (NSMutableAttributedString *)addCenterLine{
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:self attributes:attribtDic];
    return attributeStr;
}
- (NSMutableAttributedString *)addDownLine{
    
     NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:self attributes:attribtDic];
    return attributeStr;
}

- (NSString *)create_timeWithFormat:(NSString *)dateFormat
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = dateFormat;
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:self];
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [create deltaWithNow];
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
//            fmt.dateFormat = @"昨天 HH:mm:ss";
//            return [fmt stringFromDate:create];
            return @"昨天";
        } else { // 其他
//            fmt.dateFormat = @"MM-dd HH:mm:ss";
//            return [fmt stringFromDate:create];
            fmt.dateFormat = @"yyyy-MM-dd";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
//        return self;
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:create];
    }
}

+ (id)JSONObjectWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return jsonObj;
}

@end
