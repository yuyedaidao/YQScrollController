//
//  YQScrollController.h
//  YQScrollController
//
//  Created by Wang on 15/7/24.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

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
@property (nonatomic, assign) NSInteger selectedIndex;
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;
@end
