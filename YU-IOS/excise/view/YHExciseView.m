//
//  YHExciseView.m
//  YU-IOS
//
//  Created by yuhao on 2017/10/20.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import "YHExciseView.h"
#import "YHPlayerAnimation.h"
#import "YHOrderRecorderView.h"
#import "DGActivityIndicatorView.h"

@interface YHExciseView()<AVAudioPlayerDelegate,YHRecordArcViewDelegate>
{
    YHPlayerAnimation *playeranima;
}
@property (nonatomic,readwrite) YHOrderRecorderView *recordView;
@property (nonatomic,copy) NSString *recordSavePathName;

@end

@implementation YHExciseView

#pragma mark - recordview
- (YHOrderRecorderView *)recordView{
    if (!_recordView) {
        _recordView = [[YHOrderRecorderView alloc] initWithFrame:playeranima.frame];
        _recordView.recordSavePathName = self.recordSavePathName;
        [_recordView startForFilePath:self.recordSavePathName];
        _recordView.delegate = self;
    }
    return _recordView;
}

#pragma mark - recorder
-(NSString *)recordSavePathName{
    
    _recordSavePathName = [self getSavePath:  [NSString stringWithFormat:@"%@%@/%@",[YHUserInfo readUserInfoByKey:USERname],@"-myRecord",@"myvoice"] recordTag:_currentIndex];
    
    return _recordSavePathName;
}

-(NSString *)getSavePath:(NSString *) recordsaveName recordTag:(NSInteger)recordtag{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:recordsaveName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if(!(isDirExist && isDir))
        
    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"创建文件夹失败！");
        }
        NSLog(@"创建文件夹成功，文件路径%@",path);
    }
    
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%ld.wav",(long)recordtag]];
    NSLog(@"file path:%@",path);
    
    return path;
}



- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        [self setupSubviews];
    }
    return self;
}

-(void)setupSubviews{
    UIImageView *headerIv = [[UIImageView alloc] init];
    headerIv.backgroundColor = [UIColor yellowColor];
    [self addSubview:headerIv];
    
    [headerIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    headerIv.image = [UIImage imageNamed:@"avatar"];
    headerIv.layer.cornerRadius = headerIv.fWidth/2;
    headerIv.layer.masksToBounds = YES;
    
    UILabel *textBel = [[UILabel alloc] init];
    textBel.backgroundColor = [UIColor redColor];
    textBel.textColor = [UIColor greenColor];
    [textBel setFont:[UIFont systemFontOfSize:22]];
    textBel.text = @"Masonry.systemFontOfSize";
    [self addSubview:textBel];
    
    [textBel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerIv.mas_bottom).offset(5);
        make.right.equalTo(self.mas_right).offset(-90);
        make.left.mas_equalTo(5);
        make.height.mas_equalTo(80);
    }];
    
    UILabel *scoreBel = [[UILabel alloc] init];
    scoreBel.backgroundColor = [UIColor redColor];
    scoreBel.textColor = [UIColor greenColor];
    [scoreBel setFont:[UIFont systemFontOfSize:22]];
    scoreBel.textAlignment = NSTextAlignmentCenter;
    scoreBel.text = @"80";
    [self addSubview:scoreBel];
    
    [scoreBel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textBel.mas_right).offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
        make.top.bottom.equalTo(textBel);
    }];
    
    [self addPlayAnimation];

}

-(void)addPlayAnimation{
    playeranima = [[YHPlayerAnimation alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
    playeranima.pillarNum = 15;
    playeranima.pillarColor = [UIColor greenColor];
    playeranima.pillarWidth = 3;
    [playeranima commonInit];
    [self addSubview:playeranima];
    [playeranima startAnimation];
    
    [playeranima mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(130);
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-60);
        make.height.mas_equalTo(60);
    }];
    [self performSelector:@selector(addRecordAnimation) withObject:nil afterDelay:2];
}

-(void)addRecordAnimation{
    [playeranima stopAnimation];
    [playeranima removeFromSuperview];
    playeranima = nil;
    
    [self addSubview:self.recordView];
    [_recordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(130);
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-60);
        make.height.mas_equalTo(60);
    }];

    
    [self performSelector:@selector(startGrade) withObject:nil afterDelay:1];

}

-(void)startGrade{
    [_recordView removeFromSuperview];
    _recordView = nil;
    [self waiteForGrade];
}

-(void)waiteForGrade{
    
    UIView *gradeview = [[UIView alloc] init];
    gradeview.tag = 22222+5;
    gradeview.backgroundColor = [UIColor redColor];
    
    [self addSubview:gradeview];
    
    [gradeview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(130);
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-60);
        make.height.mas_equalTo(60);
    }];

    CGFloat gradeviewHeight = 60;

    DGActivityIndicatorView  *activityview = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader tintColor:[UIColor whiteColor] size:gradeviewHeight];
    [gradeview addSubview:activityview];
    
    [activityview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(gradeviewHeight);
        make.centerX.mas_equalTo(gradeview.center.x + gradeviewHeight/2);
        make.top.mas_equalTo(gradeviewHeight/2);
        make.height.mas_equalTo(gradeviewHeight);
    }];
    [activityview startAnimating];
    
    NSString * message = @"打分中";
    UILabel *label = [[UILabel alloc] init];
    CGSize size = CGSizeMake(200, MAXFLOAT);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12],NSFontAttributeName,nil];
    CGSize LabelSize = [message boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    label.text = message;
    label.textColor = [UIColor greenColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:12];
    [gradeview addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LabelSize.width);
        make.center.equalTo(gradeview);
        make.height.mas_equalTo(LabelSize.height);
    }];
    
}



@end
