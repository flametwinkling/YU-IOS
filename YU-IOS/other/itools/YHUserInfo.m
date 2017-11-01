//
//  YHUserInfo.m
//  达达口语
//
//  Created by dev on 16/6/23.
//  Copyright © 2016年 YH. All rights reserved.
//

#import "YHUserInfo.h"

@implementation YHUserInfo


// 保存用户信息

+(void)saveUserInfoValue:(NSString *)value forKey:(NSString *)key
{
    NSUserDefaults * s = [NSUserDefaults standardUserDefaults];
    [s setObject:value forKey:key];
    [s synchronize];
}

// 读取保存信息
+ (NSString *)readUserInfoByKey:(NSString *)key
{
    NSUserDefaults * s = [NSUserDefaults standardUserDefaults];
    return [s objectForKey:key];
}

//删除用户信息
+(void)removeUserinfoBykey:(NSString *)key{
    NSUserDefaults *s = [NSUserDefaults standardUserDefaults];
    [s removeObjectForKey:key];
    [s synchronize];
}


@end
