//
//  DZSWaveView.m
//  WaveDemo
//
//  Created by dongzhensong on 16/11/28.
//  Copyright © 2016年 song. All rights reserved.
//

#import "DZSWaveView.h"

@interface DZSWaveView ()

@property (nonatomic, strong) UIColor *firstWaveColor;
@property (nonatomic, strong) UIColor *secondWaveColor;

@end

@implementation DZSWaveView

{
    CGFloat waveA;//水纹振幅
    CGFloat waveW ;//水纹周期
    CGFloat offsetX; //位移
    CGFloat currentK; //当前波浪高度Y
    CGFloat waveSpeed;//水纹速度
    CGFloat waterWaveWidth; //水纹宽度
    NSTimer *timer;
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds  = YES;
        [self setUp];
    }
    
    return self;
}


-(void)setUp
{
    //设置波浪的宽度
    waterWaveWidth = self.frame.size.width;
    //设置波浪的颜色
    _firstWaveColor = [UIColor cyanColor];
    //设置波浪的颜色
    _secondWaveColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1];
    //设置波浪流动速度
    waveSpeed = 0.02;
    //设置振幅
    waveA = 10;
    //设置周期
    waveW = 1/30.0 / 2;
    //设置波浪纵向位置
    currentK = self.frame.size.height/2;//屏幕居中
    
    [self configurateWaveLayer];
    
    //启动定时器
    /*
    _waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
    [_waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
     */
    
    // timer = [NSTimer timerWithTimeInterval:0.05 target:self selector:@selector(getCurrentWave:) userInfo:nil repeats:YES];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(getCurrentWave:) userInfo:nil repeats:YES];
}


- (void)configurateWaveLayer{

    //初始化layer
    if (_firstWaveLayer == nil) {
        //初始化
        _firstWaveLayer = [CAShapeLayer layer];
        //设置闭环的颜色
        _firstWaveLayer.fillColor = _firstWaveColor.CGColor;
        //设置边缘线的颜色
        _firstWaveLayer.strokeColor = [UIColor clearColor].CGColor;
        //设置边缘线的宽度
        _firstWaveLayer.lineWidth = 0.5;
        // _firstWaveLayer.strokeStart = 0.0;
        // _firstWaveLayer.strokeEnd = 0.8;
        [self.layer addSublayer:_firstWaveLayer];
    }
    
    //初始化layer
    if (_secondWaveLayer == nil) {
        //初始化
        _secondWaveLayer = [CAShapeLayer layer];
        //设置闭环的颜色
        _secondWaveLayer.fillColor = _secondWaveColor.CGColor;
        //设置边缘线的颜色
        _secondWaveLayer.strokeColor = [UIColor clearColor].CGColor;
        //设置边缘线的宽度
        _secondWaveLayer.lineWidth = 0.5;
        //        _secondWaveLayer.strokeStart = 0.0;
        //        _secondWaveLayer.strokeEnd = 0.8;
        [self.layer insertSublayer:_secondWaveLayer below:_firstWaveLayer];
    }
    
}


-(void)getCurrentWave:(CADisplayLink *)displayLink
{
    //实时的位移
    offsetX -= waveSpeed;
    [self setCurrentFirstWaveLayerPath];
    [self setCurrentSecondWaveLayerPath];
}

-(void)setCurrentFirstWaveLayerPath{
    //创建一个路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentK;
    //将点移动到 x=0,y=currentK的位置
    CGPathMoveToPoint(path, nil, 0, y);
    for (NSInteger x = 0.0f; x<=waterWaveWidth; x++) {
        //正玄波浪公式
        y = waveA * sin(waveW * x+ offsetX)+currentK;
        //将点连成线
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    _firstWaveLayer.path = path;
    CGPathRelease(path);
}

-(void)setCurrentSecondWaveLayerPath{
    //创建一个路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentK;
    
    CGFloat forawrd = M_PI/waveW/2;
    
    //将点移动到 x=0,y=currentK的位置
    CGPathMoveToPoint(path, nil, 0, y);
    for (NSInteger x = 0.0f; x<=waterWaveWidth; x++) {
        // cosin波浪公式
        y = waveA * cos(waveW * x+ offsetX - forawrd)+currentK;
        //将点连成线
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    _secondWaveLayer.path = path;
    CGPathRelease(path);
}


-(void)dealloc
{
    [_waveDisplaylink invalidate];
    [timer invalidate];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
