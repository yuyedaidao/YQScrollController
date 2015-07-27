//
//  YQScrollController.m
//  YQScrollController
//
//  Created by Wang on 15/7/24.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import "YQScrollController.h"

@interface YQScrollController ()<UIScrollViewDelegate>


@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *containerViews;
@property (nonatomic, strong) NSMutableArray *titleButtons;
@property (nonatomic, strong) UIImageView *titleFlagImgView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) CGFloat segmentWidth;
@end

@implementation YQScrollController


- (void)configureVariables{
    //之所以不建议在init函数里调用点语法是因为父类有可能调用子类的某些方法，如果恰巧调用了重写的Set函数就容易出不易觉察的问题
    _titleFont = [UIFont systemFontOfSize:15];
    _titleColor = [UIColor blackColor];
    _titleHeight = 30;
    _titleBackground = [UIColor whiteColor];
    _firstSelectedIndex = 0;
}

- (instancetype)init{
    if(self = [super init]){
        [self configureVariables];
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        [self configureVariables];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareTitleView];
    [self prepareScrollView];
}

#pragma mark prepare
- (void)prepareTitleView{
    UIView *titleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), self.titleHeight)];
    titleBgView.backgroundColor = self.titleBackground;
    [self.view addSubview:titleBgView];
    
    self.titleFlagImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blue_line_and_shadow"]];
    [titleBgView addSubview:self.titleFlagImgView];
    self.titleFlagImgView.frame = CGRectMake(0, 0, 59, self.titleHeight);
    NSAssert(self.viewControllers.count, @"大叔，你都没有给ViewController，我给你控制啥？");
    CGFloat width = self.titleViewEdgePaddingRate >= 1 ? CGRectGetWidth(self.view.bounds) : CGRectGetWidth(self.view.bounds) * (1-self.titleViewEdgePaddingRate);
    CGFloat paddingLeft = (CGRectGetWidth(self.view.bounds)-width)/2;
    self.segmentWidth = width/self.viewControllers.count;
    self.titleButtons = [NSMutableArray array];
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL *stop) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleButton setTitle:obj.title forState:UIControlStateNormal];
        [titleButton setTitleColor:self.titleColor forState:UIControlStateNormal];
        [titleButton setTitleColor:self.titleSelectedColor forState:UIControlStateSelected];
        [titleButton addTarget:self action:@selector(titleSelected:) forControlEvents:UIControlEventTouchUpInside];
        [titleBgView addSubview:titleButton];
        titleButton.contentEdgeInsets = UIEdgeInsetsMake(5, 15, 5, 15);
        [titleButton sizeToFit];
        titleButton.center = CGPointMake(paddingLeft+self.segmentWidth*idx+self.segmentWidth/2, CGRectGetHeight(titleBgView.bounds)/2);
        titleButton.tag = idx;
        [self.titleButtons addObject:titleButton];
        if(idx == self.firstSelectedIndex){
            self.titleFlagImgView.center = CGPointMake(titleButton.center.x, self.titleHeight/2);
            self.currentIndex = self.firstSelectedIndex;
        }
    }];
    self.selectedIndex = self.currentIndex;
}

- (void)prepareScrollView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-self.titleHeight)];
    [self.view addSubview:self.scrollView];
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.containerViews = @[].mutableCopy;
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL *stop) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.bounds)*idx, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds))];
        [self.scrollView addSubview:view];
        [self.containerViews addObject:view];
        //添加到父控制器
        [self addChildViewController:obj];
        [view addSubview:obj.view];
        obj.view.frame = view.bounds;
        [obj didMoveToParentViewController:self];
    }];
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.bounds)*self.viewControllers.count, CGRectGetHeight(self.scrollView.bounds));

}


#pragma mark self handler

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    [self setSelectedIndex:selectedIndex animated:NO];
    
}
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated{
    NSAssert(selectedIndex < self.viewControllers.count, @"越界了大哥");
    if(_selectedIndex != selectedIndex){
        _selectedIndex = selectedIndex;
        self.currentIndex = selectedIndex;
        [self.scrollView scrollRectToVisible:CGRectMake(self.segmentWidth*selectedIndex, 0, self.segmentWidth, CGRectGetHeight(self.scrollView.bounds)) animated:animated];
        UIButton *titleButton = self.titleButtons[selectedIndex];
        [UIView animateWithDuration:0.3 animations:^{
            self.titleFlagImgView.center = titleButton.center;
        } completion:nil];
    }
    
}

- (void)titleSelected:(UIButton *)titleButton{
    [self titleSelected:titleButton scrollVC:YES];
}

- (void)titleSelected:(UIButton *)titleButton scrollVC:(BOOL)scroll{
    NSInteger index = titleButton.tag;
    if(self.currentIndex == index){
        return;
    }
    self.currentIndex = index;
    [self.titleButtons enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
        obj.selected = (titleButton == obj);
    }];
    if(scroll){
        [self.scrollView scrollRectToVisible:CGRectMake(index * CGRectGetWidth(self.scrollView.bounds), 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds)) animated:YES];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.titleFlagImgView.center = titleButton.center;
    } completion:nil];
}
/*
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView{
 
 }
 */
 - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
     NSInteger index = scrollView.contentOffset.x/CGRectGetWidth(scrollView.bounds);
     [self titleSelected:self.titleButtons[index] scrollVC:NO];
 }
 - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
     if(!decelerate){
         [self scrollViewDidEndDecelerating:scrollView];
     }
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
