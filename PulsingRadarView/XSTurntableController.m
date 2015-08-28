//
//  XSTurntableController.m
//  PulsingRadarView
//
//  Created by jcliuzl on 15/8/28.
//  Copyright (c) 2015年 jcliuzl. All rights reserved.
//

#import "XSTurntableController.h"

#import "XSTurntableView.h"

@interface XSTurntableController ()

@end

@implementation XSTurntableController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    XSTurntableView *turntableView = [[XSTurntableView alloc]initWithFrame:CGRectMake(0.0,0.0,300,300)];
    turntableView.center = self.view.center;
    [self.view addSubview:turntableView];
    
    UIImageView *imagePoint = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_point.png"]];
    imagePoint.center = CGPointMake(self.view.center.x, self.view.center.y -70);
    [self.view addSubview:imagePoint];
    
    UIImageView *imageTop = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_center.png"]];
    imageTop.center = self.view.center;
    [self.view addSubview:imageTop];
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
