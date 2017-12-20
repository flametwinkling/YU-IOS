//
//  AdModel.h
//  YU-IOS
//
//  Created by yuhao on 2017/10/13.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdModel : NSObject

/** 获取广告地址*/
@property (nonatomic,copy) NSString *ad_url;
/** 获取广告id*/
@property (nonatomic,copy) NSString *ad_id;
/** 图片宽度 */
@property(nonatomic, assign) CGFloat w;
/** 图片高度 */
@property(nonatomic, assign) CGFloat h;


/** 广告是否显示 */
@property(nonatomic,assign) BOOL adShow;

@end
