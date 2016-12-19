//
//  ZoomViewController.m
//  CoolAnimateDemo
//
//  Created by dongzhensong on 16/11/29.
//  Copyright © 2016年 song. All rights reserved.
//

#import "ZoomViewController.h"

#define size_width [UIApplication sharedApplication].keyWindow.bounds.size.width

@interface ZoomViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIImageView *backGroundImageView;

@end

@implementation ZoomViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = YES;
    // 隐藏导航条下的线
    [self hideNaviBarLine:YES];
    [self.navigationController.navigationBar setBackgroundImage:[self drawPNGWithAlpha:0] forBarMetrics:(UIBarMetricsDefault)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    _backGroundImageView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, size_width, 211))];
    _backGroundImageView.image = [UIImage imageNamed:@"back"];
    _backGroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:_backGroundImageView belowSubview:self.tableView];
    
    UIView *clearHeaderView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, size_width, 211))];
    clearHeaderView.backgroundColor = [UIColor clearColor];
    
    self.tableView.tableHeaderView = clearHeaderView;
    
    
}

#pragma mark - ScrollViewDelegate -
//改变导航控制器的透明度
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //滚动就会走
    if (scrollView == self.tableView) {
        CGFloat yset = scrollView.contentOffset.y;
        CGFloat alpha = yset / 250 > 1 ? 1.0 : yset / 250 ;
        [self.navigationController.navigationBar setBackgroundImage:[self drawPNGWithAlpha:alpha] forBarMetrics:UIBarMetricsDefault];
        
        if (alpha == 1) {
            self.navigationController.navigationBar.translucent = NO;
        } else {
            self.navigationController.navigationBar.translucent = YES;
        }
        
        if (yset < 0) {
            // 放大效果
            NSLog(@"%.2f", yset);
            
            _backGroundImageView.bounds = CGRectMake(0, 0, 2000, 211-yset);
            _backGroundImageView.center = CGPointMake(size_width/2, (211-yset)/2);
            
        }
        
    }
}

#pragma mark - UITableViewDataSource, UITableViewDelegate -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [UITableViewCell new];
    
}


// 绘制一张图片
- (UIImage *)drawPNGWithAlpha:(CGFloat)alpha {
    UIColor *color = [UIColor colorWithRed:0/255.0 green:250/255.0 blue:250/225.0 alpha:alpha];
    //位图的大小
    CGSize size = CGSizeMake(1, 1);
    //绘制位图
    UIGraphicsBeginImageContext(size);
    //获取当前创建的内容
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    //充满指定的填充色
    CGContextSetFillColorWithColor(contextRef, color.CGColor);
    //指定充满的矩形
    CGContextFillRect(contextRef, CGRectMake(0, 0, 1, 1));
    //绘制图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //绘制结束
    UIGraphicsEndImageContext();
    return image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 隐藏/显示导航条下面那条线的方法
- (void)hideNaviBarLine:(BOOL)isNeedHide{
    for (UIView *tempView in self.navigationController.navigationBar.subviews) {
        if ([tempView isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            
            for (UIView *temp in tempView.subviews) {
                
                if ([temp isKindOfClass:[UIImageView class]]) {
                    
                    temp.hidden = isNeedHide;
                }
            }
        }
    }
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
