//
//  YHExciseViewController.m
//  YU-IOS
//
//  Created by yuhao on 2017/10/17.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import "YHExciseViewController.h"
#import "YHExciseView.h"
#import "YHExciseCell.h"

@interface YHExciseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _selectedTag;
}
@property (nonatomic,retain) UITableView *tableview;
@end

@implementation YHExciseViewController


- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VCSizeWidth, VCSizeHeight) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [self.view addSubview:_tableview];
    }
    return _tableview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedTag = -1;
    self.tableview.backgroundColor = [UIColor greenColor];
}

#pragma mark -
#pragma mark tableview func
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float cellH;

    if (indexPath.row == _selectedTag) {
        cellH = 300;
    }else{
        cellH = 80;
    }
    return cellH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";
    YHExciseCell *cell = [_tableview dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YHExciseCell" owner:self options:nil]lastObject];
    }
    cell.cellText.text = @"mainBundle,mainBundle,mainBundle,mainBundle";
    cell.cellText.backgroundColor = [UIColor redColor];
    if (indexPath.row == 2) {
        cell.scoreBel.text = @"100";

    }else{
        cell.headerIv.image = [UIImage imageNamed:@"avatar"];
    }
    
    if (indexPath.row == _selectedTag) {
        [UIView animateWithDuration:1.0 animations:^{
            [cell.contentView removeFromSuperview];
            YHExciseView *exciseview = [[YHExciseView alloc] init];
            exciseview.backgroundColor = [UIColor yellowColor];
            cell.backgroundView = exciseview;
        } completion:^(BOOL finished) {

        }];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedTag = indexPath.row;
    [_tableview reloadData];
}


@end
