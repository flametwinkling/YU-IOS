//
//  YHDropDownMenuView.h
//  YU-IOS
//
//  Created by yuhao on 2018/2/28.
//  Copyright © 2018年 yuhao. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 分类条的高度 */
#define TitleBarHeight 45
/* cell的高度*/
#define TableCellHeight 45

@interface YHDropDownMenuView : UIView

/* 分类标题 数组 */
@property (nonatomic, strong) NSMutableArray *titleArr;

/**
 *  数据源--二维数组
 *  每一个大分类里, 都可以有很多个小分类(条件)
 */
@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@property (nonatomic, assign) CGFloat startY;

@end
