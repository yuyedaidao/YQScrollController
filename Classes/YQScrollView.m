//
//  YQScrollView.m
//  YQScrollController
//
//  Created by Wang on 15/7/27.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import "YQScrollView.h"

@implementation YQScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self.panGestureRecognizer addTarget:self action:@selector(panGestureRecognizer:)];
    }
    return self;
}
- (void)panGestureRecognizer:(UIPanGestureRecognizer *)pan{
    BOOL shouldPaning = NO;
    if(self.contentOffset.x <= 0)
    {
        shouldPaning = YES;
    }
    if(shouldPaning)
    {
        if([self.yq_delegate respondsToSelector:@selector(yq_panGestureRecognizer:)]){
            [self.yq_delegate yq_panGestureRecognizer:pan];
        }
    }
    
}
- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    return YES;
}
@end
