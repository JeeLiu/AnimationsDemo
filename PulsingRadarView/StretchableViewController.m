//
//  StretchableViewController.m
//  PulsingRadarView
//
//  Created by jcliuzl on 15/8/7.
//  Copyright (c) 2015年 jcliuzl. All rights reserved.
//

#import "StretchableViewController.h"
#import "StickyHeaderView.h"
@interface StretchableViewController ()

@end

@implementation StretchableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    StickyHeaderView *headerView = [[StickyHeaderView alloc] initWithHeight:150];
    
    headerView.backgroundColor = [UIColor blueColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Image"]];
    [headerView addSubview:imageView];
    imageView.frame = headerView.bounds;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview:headerView];
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
