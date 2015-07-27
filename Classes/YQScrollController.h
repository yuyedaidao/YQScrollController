//
//  YQScrollController.h
//  YQScrollController
//
//  Created by Wang on 15/7/24.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQScrollView.h"

@interface YQScrollController : UIViewController

@property (nonatomic, strong) NSArray *viewControllers;

/**
 *  titleView的高度
 */
@property (nonatomic, assign) IBInspectable CGFloat titleHeight;
@property (nonatomic, strong) IBInspectable UIColor *titleBackground;
@property (nonatomic, strong) IBInspectable UIColor *titleColor;
@property (nonatomic, strong) IBInspectable UIColor *titleSelectedColor;
@property (nonatomic, strong) IBInspectable UIFont *titleFont;
@property (nonatomic, assign) IBInspectable NSInteger firstSelectedIndex;
/**
 *  标题视图左右两边留空占总宽度的比例
 */
@property (nonatomic, assign) IBInspectable CGFloat titleViewEdgePaddingRate;
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, weak) id<YQScrollContrllerDelegate> yq_panDelegate;

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;
@end
