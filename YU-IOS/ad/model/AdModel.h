//
//  AdModel.h
//  YU-IOS
//
//  Created by yuhao on 2017/10/13.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdModel : NSObject

/** 广告图片 url */
@property(nonatomic,strong) NSString* w_picurl;
/** 原始链接 */
@property(nonatomic,strong) NSString* ori_curl;
/** 图片宽度 */
@property(nonatomic, assign) CGFloat w;
/** 图片高度 */
@property(nonatomic, assign) CGFloat h;

@end
