//
//  YHCalenderView.m
//  YU-IOS
//
//  Created by yuhao on 2017/12/13.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import "YHCalenderView.h"
#import "YHCalendarWeekCell.h"
#import "YHCalendarDayCell.h"

#define CEll_week_height 30
#define CEll_day_height 59
#define CalendarView_Height CEll_week_height + 6 * CEll_day_height

#define margin_offset  0

#define DATANAME_Array @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"]

@interface YHCalenderView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    CGFloat   _itemWidth;
}


@end

@implementation YHCalenderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.calendarCollection.backgroundColor = [UIColor whiteColor];

    }
    return self;
}

- (UICollectionView *)calendarCollection{
    if (!_calendarCollection) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        CGFloat width = ScreenWidth - margin_offset*2;
        _itemWidth = floor(width / 7);
        CGFloat collectionWidth = _itemWidth * 7;
        CGFloat insetLeftRight = (ScreenWidth - collectionWidth)/2.0;
        _calendarCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(insetLeftRight, 0, collectionWidth, CalendarView_Height) collectionViewLayout:flowLayout];
        _calendarCollection.delegate = self;
        _calendarCollection.dataSource = self;
        _calendarCollection.bounces = NO;
        [_calendarCollection registerClass:[YHCalendarWeekCell class] forCellWithReuseIdentifier:@"week"];
        [_calendarCollection registerClass:[YHCalendarDayCell class] forCellWithReuseIdentifier:@"day"];

        [self addSubview:_calendarCollection];
    }
    return _calendarCollection;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == 0) return DATANAME_Array.count;
    return _sourceArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    static NSString * identifier = nil;
    if(section == 0)
    {
        identifier = @"week";
        YHCalendarWeekCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.backgroundColor = SColor;
        [cell setWeekName:DATANAME_Array[row]];
        return cell;
    }
    else
    {
        identifier = @"day";
        YHCalendarDayCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        [cell setCalendarModel:_sourceArray[row]];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
    {
        return CGSizeMake(_itemWidth, CEll_week_height);
    }
    return CGSizeMake(_itemWidth, CEll_day_height);
}




@end
