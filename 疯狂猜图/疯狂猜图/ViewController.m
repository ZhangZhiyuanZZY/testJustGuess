//
//  ViewController.m
//  疯狂猜图
//
//  Created by 章芝源 on 15/12/22.
//  Copyright © 2015年 ZZY. All rights reserved.
//

#import "ViewController.h"
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
/*
 纯手写代码
 */
@interface ViewController ()
//大的三部分视图
@property(nonatomic, strong)UIImageView *backgroundView;
@property(nonatomic, strong)UIView *middleView;
@property(nonatomic, strong)UIView *bottomView;

//上半部分
//分数按钮
@property(nonatomic, strong)UIButton *scoreBtn;
//页数索引
@property(nonatomic, strong)UILabel *indexLb;
//图片标题
@property(nonatomic, strong)UILabel *titleLb;
//图片
@property(nonatomic, strong)UIImageView *imageView;
//提示
@property(nonatomic, strong)UIButton *promptBtn;
//帮助
@property(nonatomic, strong)UIButton *helpBtn;
//大图
@property(nonatomic, strong)UIButton *bigPictureBtn;
//下一题
@property(nonatomic, strong)UIButton *nextBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //top部分子视图
    [self setupTopViewSubViews];
}

- (void)setupTopViewSubViews
{
    //分数
    UIButton *scoreBtn = [[UIButton alloc]init];
    [scoreBtn setImage:[UIImage imageNamed:@"coin"] forState:UIControlStateNormal];
    [scoreBtn setTitle:@"10000" forState:UIControlStateNormal];
    scoreBtn.userInteractionEnabled = NO;
    [self.backgroundView addSubview:scoreBtn];
    self.scoreBtn = scoreBtn;
    [scoreBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundView).offset(20);
        make.right.equalTo(self.backgroundView).offset(-20);
        make.size.equalTo(CGSizeMake(100, 20));
    }];
    
    //当前页索引
    UILabel *indexLb = [[UILabel alloc]init];
    indexLb.text = @"1/7";
    indexLb.textColor = [UIColor whiteColor];
    [self.backgroundView addSubview:indexLb];
    indexLb.textAlignment = NSTextAlignmentCenter;
    self.indexLb = indexLb;
    [indexLb makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundView);
        make.top.equalTo(self.backgroundView).offset(50);
        make.size.equalTo(CGSizeMake(175, 20));
    }];
    
    //图片标题
    UILabel *titleLb = [[UILabel alloc]init];
    titleLb.text = @"创业励志电影";
    titleLb.textColor = [UIColor whiteColor];
    [self.backgroundView addSubview:titleLb];
    self.titleLb = titleLb;
    titleLb.textAlignment = NSTextAlignmentCenter;
    [titleLb makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(275, 20));
        make.top.equalTo(self.indexLb.bottom).offset(10);
        make.centerX.equalTo(self.backgroundView);
    }];
    
    //图片
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"movie_zghhr"];
    [self.backgroundView addSubview:imageView];
    self.imageView = imageView;
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(170, 170));
        make.centerX.equalTo(self.backgroundView);
        make.topMargin.equalTo(self.titleLb.bottom).offset(10);
    }];
    
    //提示按钮
    UIButton *promptBtn = [UIButton buttonWithBackgroundImageForNor:@"btn_left" BackgroundImageForHei:@"btn_left_highlighted" imageNor:@"icon_tip" imageHei:nil titleNor:@"提示" titleHei:nil titleColorNor:[UIColor whiteColor] titleColorHei:nil];
    [self.backgroundView addSubview:promptBtn];
    self.promptBtn = promptBtn;
    
    [promptBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.top).offset(20);
        make.left.equalTo(self.backgroundView).offset(0);
        make.size.equalTo(CGSizeMake(60, 25));
    }];
    
    //帮助按钮
    UIButton *helpBtn = [UIButton buttonWithBackgroundImageForNor:@"btn_left" BackgroundImageForHei:@"btn_left_highlighted" imageNor:@"icon_help" imageHei:nil titleNor:@"帮助" titleHei:nil titleColorNor:[UIColor whiteColor] titleColorHei:nil];
    [self.backgroundView addSubview:helpBtn];
    self.helpBtn = helpBtn;
    
    [helpBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imageView.bottom).offset(-20);
        make.left.equalTo(self.backgroundView).offset(0);
        make.size.equalTo(CGSizeMake(60, 25));
    }];
    
    //大图按钮
    
    //下一题按钮
    
    
}


#pragma mark - 懒加载
//底下的view
- (UIImageView *)backgroundView
{
    if (_backgroundView == nil) {
        _backgroundView = [[UIImageView alloc]init];
        self.backgroundView.image = [UIImage imageNamed:@"bj"];
        [self.view addSubview:self.backgroundView];
        self.backgroundView.userInteractionEnabled = YES;
        [_backgroundView makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(self.view).offset(0);
            CGFloat topHeight = [UIScreen mainScreen].bounds.size.height;
            make.height.equalTo(topHeight);
        }];
    }
    return _backgroundView;
}

- (UIView *)middleView
{
    if (!_middleView) {
        _middleView = [[UIView alloc]init];
        self.middleView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:self.middleView];

        [_middleView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backgroundView).offset(0);
            make.left.right.equalTo(self.view).offset(0);
            CGFloat midHeight = [UIScreen mainScreen].bounds.size.height * 0.1;
            make.height.equalTo(midHeight);
        }];
    }
    return _middleView;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
         self.bottomView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:self.bottomView];
       
        [_bottomView makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.bottom.equalTo(self.view).offset(0);
    
        }];
    }
    return _bottomView;
}


@end
