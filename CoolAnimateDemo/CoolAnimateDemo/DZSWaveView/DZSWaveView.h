//
//  DZSWaveView.h
//  WaveDemo
//
//  Created by dongzhensong on 16/11/28.
//  Copyright © 2016年 song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZSWaveView : UIView

@property (nonatomic, strong) CADisplayLink *waveDisplaylink;
@property (nonatomic, strong) CAShapeLayer *firstWaveLayer;
@property (nonatomic, strong) CAShapeLayer *secondWaveLayer;

@end
