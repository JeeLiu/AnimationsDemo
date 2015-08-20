//
//  CollectionScaleViewController.m
//  PulsingRadarView
//
//  Created by jcliuzl on 15/8/20.
//  Copyright (c) 2015年 jcliuzl. All rights reserved.
//

#import "CollectionScaleViewController.h"
#import "ScaleFlowLayout.h"
#import "ScaleCollectionViewCell.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
static NSString * const kCollectionViewCellReuseIdentifier = @"CollectionViewCellReuseIdentifier";

@interface CollectionScaleViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,ScaleCollectionViewCellDelegate> {
    BOOL dragEnable;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ScaleFlowLayout* defaultLayout;

@property (nonatomic, strong) UIImageView* dragMaskView;
@end

@implementation CollectionScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.dragMaskView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section  {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ScaleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    NSString *imgName = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imgName];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"begin");
    dragEnable = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"end");
    dragEnable = YES;
    
    [self configMidCellPanEnable];
}

- (void)configMidCellPanEnable {
    CGFloat scale = 1.0;
    ScaleCollectionViewCell* midCell;
    for (ScaleCollectionViewCell *cell in self.collectionView.visibleCells) {
        cell.panEnable = NO;
        CATransform3D transform =  cell.layer.transform;
        if (transform.m11 > scale) {
            scale = transform.m11;
            midCell = cell;
            //break;
        }
    }
    
    midCell.panEnable = YES;
}

- (void)CellDidPan:(UIPanGestureRecognizer*) recognizer{
    if (!dragEnable)
        return;
    
    CGPoint translation = [recognizer translationInView:self.view];
    UIImageView* originImageView = (UIImageView*)recognizer.view;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.dragMaskView.image = originImageView.image;
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        self.dragMaskView.hidden = NO;
        
        CGPoint imageCenter = [self.view convertPoint:originImageView.center fromView:originImageView];
        
        self.dragMaskView.center = CGPointMake(imageCenter.x + translation.x, imageCenter.y + translation.y);
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        //self.dragMaskView.hidden = YES;
        self.dragMaskView.transform = CGAffineTransformMakeScale(1.6, 1.6);
        [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.dragMaskView.transform = CGAffineTransformMakeScale(0.5, 0.5);
            
        } completion:^(BOOL finished) {
            self.dragMaskView.hidden = YES;
            self.dragMaskView.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }
    
}

#pragma mark - getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 200)collectionViewLayout:[ScaleFlowLayout flowLayout]];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.collectionViewLayout = self.defaultLayout;
        _collectionView.showsHorizontalScrollIndicator = NO;
        CGFloat width = self.defaultLayout.itemSize.width;
        
        _collectionView.contentInset = UIEdgeInsetsMake(0, SCREEN_WIDTH/2 - width/2 , 0, SCREEN_WIDTH/2 - width/2);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[ScaleCollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCellReuseIdentifier];
        
    }
    return _collectionView;
}
- (ScaleFlowLayout* )defaultLayout {
    if (!_defaultLayout) {
        _defaultLayout = [ScaleFlowLayout flowLayout];
    }
    return _defaultLayout;
}

- (UIImageView* )dragMaskView {
    if (!_dragMaskView) {
        CGFloat wid = self.defaultLayout.itemSize.width * self.defaultLayout.zoomScale;
        _dragMaskView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, wid, wid)];
        _dragMaskView.hidden = YES;
        _dragMaskView.layer.cornerRadius = CGRectGetWidth(_dragMaskView.frame)/2;
        _dragMaskView.layer.masksToBounds = YES;
    }
    return _dragMaskView;
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
