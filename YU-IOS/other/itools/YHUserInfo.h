//
//  YHUserInfo.h
//  达达口语
//
//  Created by dev on 16/6/23.
//  Copyright © 2016年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHUserInfo : NSObject

+(void)saveUserInfoValue:(NSString *)value forKey:(NSString *)key;
+ (NSString *)readUserInfoByKey:(NSString *)key;
+(void)removeUserinfoBykey:(NSString *)key;

@end
