//
//  ViewController.m
//  PulsingRadarView
//
//  Created by jcliuzl on 15/8/7.
//  Copyright (c) 2015年 jcliuzl. All rights reserved.
//

#import "ViewController.h"
#import "PulsingRadarView.h"
@interface ViewController ()
@property (strong, nonatomic) PulsingRadarView *radarView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGSize raderSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width);
    
    self.radarView = [[PulsingRadarView alloc] initWithFrame:CGRectMake(0, (self.view.bounds.size.height-raderSize.height)/2, raderSize.width, raderSize.height)];
    
    [self.view addSubview:self.radarView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
