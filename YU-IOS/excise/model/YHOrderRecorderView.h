//
//  YHOrderRecorderView.h
//  口语伙伴
//
//  Created by yuhao on 2017/9/26.
//  Copyright © 2017年 YH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#define MAX_RECORD_DURATION 60.0
#define WAVE_UPDATE_FREQUENCY   0.1
#define SILENCE_VOLUME   45.0
#define SOUND_METER_COUNT  6
#define HUD_SIZE  320

@class YHOrderRecorderView;
@protocol YHRecordArcViewDelegate <NSObject>

- (void)recordArcView:(YHOrderRecorderView *)arcView voiceRecorded:(NSString *)recordPath length:(float)recordLength;

@end

@interface YHOrderRecorderView : UIView<AVAudioRecorderDelegate>

@property (nonatomic,copy) NSString *recordSavePathName;
@property(readwrite, nonatomic, strong) AVAudioRecorder *recorder;

@property(weak, nonatomic) id<YHRecordArcViewDelegate> delegate;
- (void)startForFilePath:(NSString *)filePath;
- (void)commitRecording;
@end
