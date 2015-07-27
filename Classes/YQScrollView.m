//
//  YQScrollView.m
//  YQScrollController
//
//  Created by Wang on 15/7/27.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import "YQScrollView.h"

@implementation YQScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    return YES;
}
@end
