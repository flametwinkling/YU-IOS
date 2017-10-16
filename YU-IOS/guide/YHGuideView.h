//
//  YHGuideView.h
//  YU-IOS
//
//  Created by yuhao on 2017/10/16.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHGuideView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *indexImageView;
@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;
@property (weak, nonatomic) IBOutlet UIPageControl *indexPageControl;

+ (void)show;
@end
