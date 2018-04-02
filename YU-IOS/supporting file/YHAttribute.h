//
//  YHAttribute.h
//  YU-IOS
//
//  Created by yuhao on 2017/10/13.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#ifndef YHAttribute_h
#define YHAttribute_h


//屏幕适配
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenBounds [UIScreen mainScreen].bounds

#define VCSizeWidth  self.view.frame.size.width
#define VCSizeHeight self.view.frame.size.height

#define ViewSizeHight self.frame.size.height
#define ViewSizeWith  self.frame.size.width


//颜色
#define RGBA(R, G, B, A) \
[UIColor colorWithRed:    R/255.f green:G/255.f blue:B/255.f alpha:A]

#define SColor            RGBA(124, 185, 65, 1)


//userinfo
#define USERname @"userName"
#define USERPassword @"password"

#endif /* YHAttribute_h */
