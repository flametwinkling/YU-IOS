//
//  YHMainThreeViewController.m
//  YU-IOS
//
//  Created by yuhao on 2017/12/21.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import "YHMainThreeViewController.h"

@interface YHMainThreeViewController ()

@end

@implementation YHMainThreeViewController




/**
 关于内存的分配
 栈区
 内存管理由系统控制，存储的为非静态的局部变量，例如：函数参数，在函数中生命的对象的指针等。当系统的栈区大小不够分配时， 系统会提示栈溢出。
 
 堆区
 内存管理由程序控制，存储的为malloc , new ,alloc出来的对象。
 如果程序没有控制释放，那么在程序结束时，由系统释放。但在程序运行过程中，会出现内存泄露、内存溢出问题。
 分配方式 类似于链表。
 
 全局存储区（静态存储区）
 全局变量、静态变量会存储在此区域。事实上全局变量也是静态的，因此，也叫全局静态存储区。
 存储方式： 初始化的全局变量跟静态变量放在一片区域，未初始化的全局变量与静态变量放在相邻的另一片区域。
 程序结束后由系统释放。
 
 文字常量区
 在程序中使用的常量存储在此区域。程序结束后，由系统释放。在程序中使用的常量，都会到文字常量区获取。
 
 程序代码区
 存放函数体的二进制代码。
 运行程序就是执行代码，代码要执行就要加载进内存。
 
*/


//static
/**
 
 1.作用于变量：
 
 用static声明局部变量时，则改变变量的存储方式（生命期），使变量成为静态的局部变量，即编译时就为变量分配内存，直到程序退出才释放存储单元。这样，使得该局部变量有记忆功能，可以记忆上次的数据，不过由于仍是局部变量，因而只能在代码块内部使用（作用域不变）。
 
 用static声明外部变量-------外部变量指在所有代码块{}之外定义的变量，它缺省为静态变量，编译时分配内存，程序结束时释放内存单元。同时 其作用域很广，整个文件都有效甚至别的文件也能引用它。为了限制某些外部变量的作用域，使其只在本文件中有效，而不能被其他文件引用，可以用static 关键字对其作出声明。
 
 　　总结：用static声明局部变量，使其变为静态存储方式(静态数据区)，作用域不变；用static声明外部变量，其本身就是静态变量，这只会改变其连接方式，使其只在本文件内部有效，而其他文件不可连接或引用该变量
 */

static NSString *variable = @"variable";//可以在implementation中
- (void)staticForvariable{//作用于变量
    static NSString *cellid = @"cellid";//比如在创建cell复用时，就需要让cellid不是在函数结束后就被释放，加上static后，直到程序结束，cellid都存在，就可实现cell的复用
    
    static YHMainThreeViewController *mamager;
    if (mamager == nil) {//单例和上面类似
        mamager = [[YHMainThreeViewController alloc] init];
    }
}


/**
 2.作用于函数：
 
 　　使用static用于函数定义时，对函数的连接方式产生影响，使得函数只在本文件内部有效，对其他文件是不可见的。这样的函数又叫作静态函数。使用静态函数的好处是，不用担心与其他文件的同名函数产生干扰，另外也是对函数本身的一种保护机制。
 
 　　如果想要其他文件可以引用本地函数，则要在函数定义时使用关键字extern，表示该函数是外部函数，可供其他文件调用。另外在要引用别的文件中定义的外部函数的文件中，使用extern声明要用的外部函数即可。
 */
 static  void staticFunction(int ss, NSString *s){//不用担心与其他文件的同名函数产生干扰
    NSLog(@"%d,%@",ss,s);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    variable = @"ssss";
    NSLog(@"va == %@",variable);
    staticFunction(1, @"ss");
   
    __strong NSString *strongStr = @"strong";
    __weak   NSString *weakStr = @"weak";
    
    
    /**
     对源头是NSMutableString的字符串，retain仅仅是指针引用，增加了引用计数器，这样源头改变的时候，用这种retain方式声明的变量（无论被赋值的变量是可变的还是不可变的），它也会跟着改变;而copy声明的变量，它不会跟着源头改变，它实际上是深拷贝。
     
     对源头是NSString的字符串，无论是retain声明的变量还是copy声明的变量，当第二次源头的字符串重新指向其它的地方的时候，它还是指向原来的最初的那个位置，也就是说其实二者都是指针引用，也就是浅拷贝
     
     另外说明一下，这两者对内存计数的影响都是一样的，都会增加内存引用计数，都需要在最后的时候做处理。
     
     其实说白了，对字符串为啥要用这两种方式？我觉得还是一个安全问题，比如声明的一个NSString *str变量，然后把一个NSMutableString *mStr变量的赋值给它了，如果要求str跟着mStr变化，那么就用retain;如果str不能跟着mStr一起变化，那就用copy。而对于要把NSString类型的字符串赋值给str，那两都没啥区别。不会影响安全性，内存管理也一样。
     

     */
    NSString *str = @"ss";
    self.retainStr = str;
    self.copStr = str;
    NSLog(@"%@:%p ,%@:%p",strongStr,&strongStr,weakStr,&weakStr);
    NSLog(@"str:%p, retain:%p, cop:%p",&str,&_retainStr,&_copStr);
}

/*
 当系统内存不足时，首先UIViewController的didReceiveMemoryWarining 方法会被调用，而didReceiveMemoryWarining 会判断当前ViewController的view是否显示在window上，
 
 如果没有显示在window上，则didReceiveMemoryWarining 会自动将viewcontroller 的view以及其所有子view全部销毁，然后调用viewcontroller的viewdidunload方法。
 
 如果当前UIViewController的view显示在window上，则不销毁该viewcontroller的view，当然，viewDidunload也不会被调用了。
 
  */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    //ios6之前是可以，自动调didReceiveMemoryWarning和viewDidUnLoad,ios6后只调用didReceiveMemoryWarning
    // 此处做兼容处理需要加上ios6.0的宏开关，保证是在6.0下使用的,6.0以前屏蔽以下代码，否则会在下面使用self.view时自动加载viewDidUnLoad
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        
        //需要注意的是self.isViewLoaded是必不可少的，其他方式访问视图会导致它加载 ，在WWDC视频也忽视这一点。
        
        if (self.isViewLoaded && !self.view.window)// 是否是正在使用的视图
            
        {
            
            self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
            
        }
        
    }
    
}


@end
