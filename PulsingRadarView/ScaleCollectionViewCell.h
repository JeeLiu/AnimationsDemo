//
//  ScaleCollectionViewCell.h
//  PulsingRadarView
//
//  Created by jcliuzl on 15/8/20.
//  Copyright (c) 2015年 jcliuzl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScaleCollectionViewCellDelegate;
@interface ScaleCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) id<ScaleCollectionViewCellDelegate> delegate;

@property (nonatomic, assign) BOOL panEnable;

@property (nonatomic, strong) UIImageView* imageView;
@end



@protocol ScaleCollectionViewCellDelegate <NSObject>

- (void)CellDidPan:(UIPanGestureRecognizer*) recognizer;

@end