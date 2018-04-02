//
//  YHFiveViewController.m
//  YU-IOS
//
//  Created by yuhao on 2018/3/30.
//  Copyright © 2018年 yuhao. All rights reserved.
//

#import "YHFiveViewController.h"
#import "NSString+YHSearch.h"

@interface YHFiveViewController ()

@end

@implementation YHFiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *bel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    bel.center = self.view.center;
    bel.textColor = [UIColor blackColor];
    [bel setTextAlignment:NSTextAlignmentCenter];
    bel.text = @" this a ishome about this is!";
    [self.view addSubview:bel];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:bel.text];

//    NSArray *arr = [bel.text getRange:@" is"];
//    for (int i=0; i<arr.count; i++) {
//        NSRange ranges = NSMakeRange([arr[i] integerValue], @"is".length);
//        [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]  range:ranges];
//        bel.attributedText = attributedStr;
//    }
    
//    NSString *str = @"abd&d dd";
//    NSCharacterSet *characterset = [NSCharacterSet characterSetWithCharactersInString:@" &"];
//    NSArray *dd = [str componentsSeparatedByCharactersInSet:characterset];
//    NSArray *ss = [str componentsSeparatedByString:@" &"];
//    NSLog(@"dd == %@ ss == %@",dd,ss);
    
    
    NSCharacterSet *characterset = [NSCharacterSet characterSetWithCharactersInString:@",.?!\"'"];
    NSArray *strArr = [bel.text componentsSeparatedByCharactersInSet:characterset];
    NSString *strs = [strArr componentsJoinedByString:@" "];
    NSLog(@"ssss == %@",strs);
    NSRange range = [strs rangeOfString:@" is " options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound) {
        [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]  range:range];
        bel.attributedText = attributedStr;
    }

}

 //mark - 获取这个字符串中的所有xxx的所在的index
- (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText
{
    
    NSMutableArray *arrayRanges = [NSMutableArray arrayWithCapacity:3];
    
    if (findText == nil && [findText isEqualToString:@""])
    {
        
        return nil;
        
    }
    
    NSRange rang = [text rangeOfString:findText]; //获取第一次出现的range
    
    if (rang.location != NSNotFound && rang.length != 0)
    {
        
        [arrayRanges addObject:[NSNumber numberWithInteger:rang.location]];//将第一次的加入到数组中
        
        NSRange rang1 = {0,0};
        
        NSInteger location = 0;
        
        NSInteger length = 0;
        
        for (int i = 0;; i++)
        {
            
            if (0 == i)
            {//去掉这个xxx
                
                location = rang.location + rang.length;
                
                length = text.length - rang.location - rang.length;
                
                rang1 = NSMakeRange(location, length);
                
            }
            else
            {
                
                location = rang1.location + rang1.length;
                
                length = text.length - rang1.location - rang1.length;
                
                rang1 = NSMakeRange(location, length);
                
            }
            
            //在一个range范围内查找另一个字符串的range
            
            rang1 = [text rangeOfString:findText options:NSCaseInsensitiveSearch range:rang1];
            
            if (rang1.location == NSNotFound && rang1.length == 0)
            {
                
                break;
                
            }
            else//添加符合条件的location进数组
                
                [arrayRanges addObject:[NSNumber numberWithInteger:rang1.location]];
            
        }
        
        return arrayRanges;
        
    }
    
    return nil;
    
}

@end
