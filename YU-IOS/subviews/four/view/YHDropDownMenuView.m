//
//  YHDropDownMenuView.m
//  YU-IOS
//
//  Created by yuhao on 2018/2/28.
//  Copyright © 2018年 yuhao. All rights reserved.
//

#import "YHDropDownMenuView.h"

@interface YHDropDownMenuView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *titleBar;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UITableView *dropDownMenuTableView;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, retain) NSMutableArray *titleBtnArr;

@property (nonatomic, retain) YHButton *selectedBtn;

@end

@implementation YHDropDownMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.titleBar];
    }
    return self;
}

- (UIView *)titleBar
{
    if (!_titleBar) {
        _titleBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewSizeWith, TitleBarHeight)];
        _titleBar.backgroundColor = [UIColor whiteColor];
    }
    return _titleBar;
}

- (void)setDataSourceArr:(NSMutableArray *)dataSourceArr
{
    _dataSourceArr = dataSourceArr;
    
    self.titleBtnArr = [[NSMutableArray alloc] init];
    
    CGFloat btnW = ViewSizeWith/_titleArr.count;
    CGFloat btnH = TitleBarHeight;
    CGFloat btnImageW = 15;
    CGFloat btnTitleW = 60;
    
    for (NSInteger i=0; i<self.titleArr.count; i++) {
        YHButton *titleBtn = [[YHButton alloc] initWithFrame:CGRectMake(btnW*i, 0, btnW, btnH)];
        [titleBtn setImage:[UIImage imageNamed:@"灰箭头" ] forState:UIControlStateNormal];
        [titleBtn setTitle:_titleArr[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [titleBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [titleBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleBtn setImageRect:CGRectMake((btnW - btnImageW - btnTitleW)/2, (btnH - btnImageW)/2, btnImageW, btnImageW)];
        [titleBtn setTitleRect:CGRectMake((btnW - btnImageW - btnTitleW)/2 + btnImageW, 0, btnTitleW, btnH)];
        
        titleBtn.tag = i;
        
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleBar addSubview:titleBtn];
        
        [self.titleBtnArr addObject:titleBtn];
    }
    
    // 中间分割竖线
    for (NSInteger i=0; i<_titleArr.count-1; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(btnW*(i+1), 9, 1, btnH-18)];
        line.backgroundColor = [UIColor blackColor];
        [self.titleBar addSubview:line];
    }
}


- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.startY + TitleBarHeight, ViewSizeWith, ScreenHeight)];
        _bgView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [_bgView addGestureRecognizer:tapGest];
    }
    return _bgView;
}

- (UITableView *)dropDownMenuTableView{
    if (!_dropDownMenuTableView) {
        _dropDownMenuTableView = [[UITableView alloc] init];
        _dropDownMenuTableView.delegate = self;
        _dropDownMenuTableView.dataSource = self;
        _dropDownMenuTableView.scrollEnabled = YES;
    }
    return _dropDownMenuTableView;
}

- (void)show {
    [self.superview addSubview:self.bgView];
    [self.superview addSubview:self.dropDownMenuTableView];
    [UIView animateWithDuration:0.25 animations:^{
        self.dropDownMenuTableView.frame = CGRectMake(0, self.startY + TitleBarHeight, ViewSizeWith, MIN(TableCellHeight * 5, TableCellHeight * self.dataSource.count));
        
    } completion:^(BOOL finished) {
        [self.dropDownMenuTableView reloadData];
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.dropDownMenuTableView.frame = CGRectMake(0, self.startY, ViewSizeWith, 0);
        self.selectedBtn.imageView.transform = CGAffineTransformMakeRotation(0.01);
        self.selectedBtn.selected = NO;
    } completion:^(BOOL finished) {
        [self removeSubviews];
    }];
}

- (void)removeSubviews
{
    [UIView animateWithDuration:0.25 animations:^{
        self.selectedBtn.imageView.transform = CGAffineTransformMakeRotation(0.01);
    }];
    !_bgView?:[_bgView removeFromSuperview];
    _bgView=nil;
    
    !_dropDownMenuTableView?:[_dropDownMenuTableView removeFromSuperview];
    _dropDownMenuTableView=nil;
    self.dataSource = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return TableCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.selectedBtn setTitle:_dataSource[indexPath.row] forState:UIControlStateNormal];
    [self hide];
}

- (void)titleBtnClick:(YHButton *)sender{
    self.selectedBtn = sender;
    if (_selectedBtn.selected == NO) {
        self.dataSource = _dataSourceArr[sender.tag];
        [self show];
        _selectedBtn.selected = YES;
    }else{
        [self hide];
        _selectedBtn.selected = NO;
    }
    //被选中的和未被选中的动画
    for (YHButton *btn in self.titleBtnArr) {
        if (btn == sender) {
            [UIView animateWithDuration:0.25 animations:^{
                btn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                btn.imageView.transform = CGAffineTransformMakeRotation(0);
                btn.selected = NO;
            }];
        }
    }
}

@end
