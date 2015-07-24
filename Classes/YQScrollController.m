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
@end

@implementation YQScrollController


- (void)configureVariables{
    //之所以不建议在init函数里调用点语法是因为父类有可能调用子类的某些方法，如果恰巧调用了重写的Set函数就容易出不易觉察的问题
    _titleFont = [UIFont systemFontOfSize:15];
    _titleColor = [UIColor blackColor];
    _titleHeight = 30;
    _titleBackground = [UIColor whiteColor];
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


- (void)prepareTitleView{
    UIView *titleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), self.titleHeight)];
    titleBgView.backgroundColor = self.titleColor;
    [self.view addSubview:titleBgView];
    
}

- (void)prepareScrollView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-self.titleHeight)];
    [self.view addSubview:self.scrollView];
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

}

/*
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView{
 
 }
 - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
 
 }
 - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
 
 }
 */

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
