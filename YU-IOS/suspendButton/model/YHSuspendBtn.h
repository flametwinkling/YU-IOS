//
//  YHSuspendBtn.h
//  YU-IOS
//
//  Created by yuhao on 2017/12/18.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PayCentBlock)(void);
typedef void(^PerCentBlock)(void);
typedef void(^LogoutBlock)(void);
typedef void(^UpUserBlock)(void);
typedef void (^OpenSiginBlock)(void);

@interface YHSuspendBtn : NSObject

+(instancetype)defaultManagerWithImageName:(NSString*)name;
// 显示（默认）
- (void)showWindow;
// 隐藏
- (void)dissmissWindow;

-(void)setUserType;

-(void)setOnclickListenerWithPayCent:(PayCentBlock)payBlock PerCentBlock:(PerCentBlock)perBlock LogoutBlock:(LogoutBlock)logoutBlock UpUserBlock:(UpUserBlock)upUserBlock OpenSiginBlock:(OpenSiginBlock)opensiginBlock;
@property (nonatomic,copy)PayCentBlock payBlock;
@property (nonatomic,copy)PerCentBlock perBlock;
@property (nonatomic,copy)LogoutBlock logoutBlock;
@property (nonatomic,copy)UpUserBlock upUserBlock;
@property (nonatomic,copy)OpenSiginBlock opensiginBlock;
@end
