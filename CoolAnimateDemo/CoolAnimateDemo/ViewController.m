//
//  ViewController.m
//  CoolAnimateDemo
//
//  Created by dongzhensong on 16/11/28.
//  Copyright © 2016年 song. All rights reserved.
//

#import "ViewController.h"
#import "ZoomViewController.h"
#import "WaveViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *titleArr; //


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"动画效果";
    
    self.titleArr = @[@"下拉放大", @"波浪"].mutableCopy;
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}


#pragma  mark - UITableViewDataSource, UITableViewDelegate -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row < self.titleArr.count) {
        cell.textLabel.text = self.titleArr[indexPath.row];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < self.titleArr.count) {
        NSString *title = self.titleArr[indexPath.row];
        if ([title isEqualToString:@"下拉放大"]) {
            ZoomViewController *zoomVC = [ZoomViewController new];
            
            [self.navigationController pushViewController:zoomVC animated:YES];
            
        }else if([title isEqualToString:@"波浪"]){
            WaveViewController *waveVC = [WaveViewController new];
            
            
            
            [self.navigationController pushViewController:waveVC animated:YES];
        }
    }
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
