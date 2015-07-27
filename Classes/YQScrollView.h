//
//  YQScrollView.h
//  YQScrollController
//
//  Created by Wang on 15/7/27.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YQScrollContrllerDelegate <NSObject>

@optional
- (void)yq_panGestureRecognizer:(UIPanGestureRecognizer *)gesture;

@end

@interface YQScrollView : UIScrollView

@property (nonatomic, weak) id<YQScrollContrllerDelegate> yq_delegate;

@end
