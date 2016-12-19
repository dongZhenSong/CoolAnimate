//
//  WaveViewController.m
//  CoolAnimateDemo
//
//  Created by dongzhensong on 16/11/29.
//  Copyright © 2016年 song. All rights reserved.
//

#import "WaveViewController.h"
#import "DZSWaveView.h"

@interface WaveViewController ()

@end

@implementation WaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    DZSWaveView *waveView = [[DZSWaveView alloc] initWithFrame:(CGRectMake(0, 64, self.view.frame.size.width, 300))];
    
    [self.view addSubview:waveView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
