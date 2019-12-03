//
//  BYIdCardInfoAuthIOSApi.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/18.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "BYIdCardInfoAuthIOSApi.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImage+tool.h"
@implementation BYIdCardInfoAuthIOSApi
- (NSString *)requestUrl {
    return @"/certifyUser/idCardInfoAuthIOS";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    NSMutableDictionary *dict=[super requestArgument];
    NSDictionary *dd=@{
                       @"idCard":_idCard?:@"",
                       @"name":_name?:@"",
                       @"sex":_sex?:@"",
                       @"cardAddr":_cardAddr?:@"",
                       @"nation":_nation?:@"",
                       @"validStart":_validStart?:@"",
                       @"validEnd":_validEnd?:@"",
                       };
    [dict addEntriesFromDictionary:dd];
    return dict;
}
- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        
        NSData *imageDataf =UIImageJPEGRepresentation(self.front, 1.0);
        NSData *imageDatab =UIImageJPEGRepresentation(self.back,1.0);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *frontfileName = [NSString stringWithFormat:@"%@f.png", str];
        NSString *backfileName = [NSString stringWithFormat:@"%@b.png", str];
        [formData appendPartWithFileData:imageDataf name:@"front" fileName:frontfileName mimeType:@"image/png"];
        [formData appendPartWithFileData:imageDatab name:@"back" fileName:backfileName mimeType:@"image/png"];
    };
}
@end
