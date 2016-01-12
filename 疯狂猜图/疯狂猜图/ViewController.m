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
//图片按钮
@property(nonatomic, strong)UIButton *imageBtn;
//提示
@property(nonatomic, strong)UIButton *promptBtn;
//帮助
@property(nonatomic, strong)UIButton *helpBtn;
//大图
@property(nonatomic, strong)UIButton *bigPictureBtn;
//下一题
@property(nonatomic, strong)UIButton *nextBtn;
//蒙版
@property(nonatomic, strong)UIButton *mBBtn;

//数据模型
@property(nonatomic, strong)NSArray *answers;
///索引
@property(assign, nonatomic)int index;

///答案按钮
@property(nonatomic, strong)UIButton *answerBtn;
@property(nonatomic, strong)UIButton *optionBtn;

@end

@implementation ViewController

///设置状态栏
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //布置top
    [self setupTopViewSubViews];
    //初始化第一个问题
    self.index = -1;
    [self nextQuestion];
}

#pragma mark -  下一题

- (void)nextQuestion
{
    self.index++;
    //判断是否越界
    if (self.index == self.answers.count) {
        //弹出对话框
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题" message:@"已通关" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:cancel];
        [alertController addAction:okAction];

        return;
    }
   //根据index++ 获得对应模型
    ZYAnswerModel *question = self.answers[self.index];
    //将模型传到,  控件上
    [self setupQuestion:question];
    ///动态创建答案按钮
    [self setupMiddleSubviews:question];
    ///创建 待选按钮
    [self setupOptionbtns:question];
}

//将模型数据放在控件上
- (void)setupQuestion:(ZYAnswerModel *)question
{
    self.indexLb.text = [NSString stringWithFormat:@"%d / %lu", self.index + 1, self.answers.count];
    self.titleLb.text = question.title;
    [self.imageBtn setImage:[UIImage imageNamed:question.icon] forState:UIControlStateNormal];
    self.nextBtn.enabled = (self.index != self.answers.count - 1);
}


#pragma mark -  设置top部分

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
    
    ///图片标题
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
    
    //提示按钮
    UIButton *promptBtn = [UIButton buttonWithBackgroundImageForNor:@"btn_left" BackgroundImageForHei:@"btn_left_highlighted" imageNor:@"icon_tip" imageHei:nil titleNor:@"提示" titleHei:nil titleColorNor:[UIColor whiteColor] titleColorHei:nil];
    [self.backgroundView addSubview:promptBtn];
    self.promptBtn = promptBtn;
    
    [promptBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLb.top).offset(50);
        make.left.equalTo(self.backgroundView).offset(0);
        make.size.equalTo(CGSizeMake(60, 25));
    }];
    [promptBtn addTarget:self action:@selector(ClickPromptBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //帮助按钮
    UIButton *helpBtn = [UIButton buttonWithBackgroundImageForNor:@"btn_left" BackgroundImageForHei:@"btn_left_highlighted" imageNor:@"icon_help" imageHei:nil titleNor:@"帮助" titleHei:nil titleColorNor:[UIColor whiteColor] titleColorHei:nil];
    [self.backgroundView addSubview:helpBtn];
    self.helpBtn = helpBtn;
    
    [helpBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(promptBtn.bottom).offset(100);
        make.left.equalTo(self.backgroundView).offset(0);
        make.size.equalTo(CGSizeMake(60, 25));
    }];
    
    //大图按钮
    UIButton *bigPictureBtn = [UIButton buttonWithBackgroundImageForNor:@"btn_right" BackgroundImageForHei:@"btn_right_highlighted" imageNor:@"icon_img" imageHei:nil titleNor:@"大图" titleHei:nil titleColorNor:[UIColor whiteColor] titleColorHei:nil];
    [self.backgroundView addSubview:bigPictureBtn];
    self.bigPictureBtn = bigPictureBtn;
    [bigPictureBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLb.top).offset(50);
        make.right.equalTo(self.backgroundView).offset(0);
        make.size.equalTo(CGSizeMake(60, 25));
    }];
        //绑定点击接口
    [bigPictureBtn addTarget:self action:@selector(setupBigPicture)  forControlEvents:UIControlEventTouchUpInside];

    
    //下一题按钮
    UIButton *nextBtn = [UIButton buttonWithBackgroundImageForNor:@"btn_right" BackgroundImageForHei:@"btn_right_highlighted" imageNor:nil imageHei:nil titleNor:@"下一题" titleHei:nil titleColorNor:[UIColor whiteColor] titleColorHei:nil];
    [self.backgroundView addSubview:nextBtn];
    self.nextBtn = nextBtn;
    
    [nextBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bigPictureBtn.bottom).offset(100);
        make.right.equalTo(self.backgroundView).offset(0);
        make.size.equalTo(CGSizeMake(60, 25));
    }];
    [self.nextBtn addTarget:self action:@selector(nextQuestion) forControlEvents:UIControlEventTouchUpInside];
    
    //图片
    UIButton *imagebtn = [[UIButton alloc]init];
    [imagebtn setBackgroundImage:[UIImage imageNamed:@"center_img"] forState:UIControlStateNormal];
    [imagebtn setImage:[UIImage imageNamed:@"movie_zghhr"] forState:UIControlStateNormal];
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 5, 5, 5);
    [imagebtn setImageEdgeInsets:inset];
    [self.backgroundView addSubview:imagebtn];
    self.imageBtn = imagebtn;
    [imagebtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(170, 170));
        make.centerX.equalTo(self.backgroundView);
        make.topMargin.equalTo(self.titleLb.bottom).offset(10);
    }];
        //绑定点击接口
    [imagebtn addTarget:self action:@selector(changePictureFrame)  forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 点击图片/大图按钮/蒙版, 实现放大/缩小功能
- (void)setupBigPicture
{
    //0. 如果动画正在进行, 就返回
    if ([self.backgroundView isAnimating]) {
        return;
    }
    //1. 添加蒙版
    UIButton *mBBtn = [[UIButton alloc]init];
    mBBtn.frame = self.backgroundView.bounds;
    mBBtn.backgroundColor = [UIColor blackColor];
        //蒙版绑定点击方法
    [mBBtn addTarget:self action:@selector(setupSmallPicture) forControlEvents:UIControlEventTouchUpInside];
    mBBtn.alpha = 0;
    self.mBBtn = mBBtn;
    [self.backgroundView addSubview:mBBtn];
//    [mBBtn addSubview:self.imageBtn];
    [self.backgroundView bringSubviewToFront:self.imageBtn];//让照片在动画中不变透明的方法

    CGFloat imageW = self.backgroundView.bounds.size.width;
    CGFloat imageH = self.imageBtn.bounds.size.height / self.imageBtn.bounds.size.width * imageW;
    [self.imageBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backgroundView).offset(0);
        make.height.equalTo(imageH);
        make.center.equalTo(self.backgroundView);
    }];
    
    [UIView animateWithDuration:1.0 animations:^{
        [self.imageBtn layoutIfNeeded];
        mBBtn.alpha = 0.6;
    } completion:nil];
}

//蒙版点击照片缩小方法
- (void)setupSmallPicture
{
    //0. 如果动画正在进行, 就返回
    if ([self.backgroundView isAnimating]) {
        return;
    }

    [self.imageBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(170, 170));
        make.centerX.equalTo(self.backgroundView);
        make.topMargin.equalTo(self.titleLb.bottom).offset(10);
    }];
    
    [UIView animateWithDuration:1.0 animations:^{
        self.mBBtn.alpha = 0;
        [self.imageBtn layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.mBBtn removeFromSuperview];
        self.mBBtn = nil;
    }];
    
}

//点击图片判断是缩小/放大
- (void)changePictureFrame
{
    if (self.imageBtn.bounds.size.width < self.backgroundView.bounds.size.width) {
        [self setupBigPicture];
    }else{
        [self setupSmallPicture];
    }
}

#pragma mark - 设置待选区
///创建待选按钮
- (void)setupOptionbtns:(ZYAnswerModel *)question
{
    ///待选区, 可交互
    self.bottomView.userInteractionEnabled = YES;
    ///将上一页的所有待选按钮移除
    [self.bottomView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat optionBtnW = 35;
    CGFloat optionBtnH = 35;
    //两个按钮之间的距离
    CGFloat margin = 10;
    //第一行距离顶部的距离
    CGFloat top = 0;
    //每行显示的个数
    int colums = 7;
    //每行第一个距离左边框的距离
    CGFloat leftMargin = ([UIScreen mainScreen].bounds.size.width - optionBtnW * colums - (colums - 1) * margin) / 2;
    for (int i = 0; i < question.options.count ; i++ ) {
        UIButton *optionBtn = [[UIButton alloc]init];
        //绑定唯一tag
        optionBtn.tag = i;
        [optionBtn setBackgroundImage:[UIImage imageNamed:@"btn_option"] forState:UIControlStateNormal];
        [optionBtn setBackgroundImage:[UIImage imageNamed:@"btn_option_highlighted"] forState:UIControlStateHighlighted];
        //行
        CGFloat row = i / colums;
        //列
        CGFloat col = i % colums;
        CGFloat optionBtnX = leftMargin + col * (margin + optionBtnW);
        CGFloat optionBtnY = top + row * (margin + optionBtnH);
        optionBtn.frame = CGRectMake(optionBtnX, optionBtnY, optionBtnW, optionBtnH);
        
        //绑定点击时间
        [optionBtn addTarget:self action:@selector(ClickOptionBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bottomView addSubview:optionBtn];
        //给按钮设置文字
        [optionBtn setTitle:question.options[i] forState:UIControlStateNormal];
        //设置文字颜色
        [optionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (void)ClickOptionBtn:(UIButton *)sender
{
    //隐藏被点击的按钮
    sender.hidden = YES;
    //被点击按钮的文字给, 答案按钮
    NSString *text = sender.currentTitle;
    for (UIButton *button in self.middleView.subviews) {
        ///如果答案按钮为空, 那么对其进行赋值, 一直循环直到, 答案按钮为空
        if (button.currentTitle == nil) {
            [button setTitle:text forState:UIControlStateNormal];
            //把被点击的待选按钮的tag给, 答案按钮
            button.tag = sender.tag;
            //跳出
            break;
        }
    }
    BOOL isFull = YES;
    //判断答案按钮们 有没有满, 满的话, 设置待选区不可选, 判断答案正确与否,不正确显示红色, 正确答案按钮文字变蓝, 都到下一题;
    NSMutableString *answerString = [[NSMutableString alloc]init];
    //遍历每个按钮, 按钮都不为空就为满
    for (UIButton *btn in self.middleView.subviews) {
        if (btn.currentTitle == nil) {
            isFull = NO;
        }else{
         [answerString appendString:btn.currentTitle];
        }
    }
    if (isFull) {
        ZYAnswerModel *answerModel = self.answers[self.index];
        //答案满了让, 待选区不能交互
        self.bottomView.userInteractionEnabled = NO;
        //答案是否正确
        if ([answerString isEqualToString:answerModel.answer]) {
            [self setAnswerBtnColor:[UIColor blueColor]];
            //增加分数
            [self setupScore:500];
            //1秒后进入下一题
            [self performSelector:@selector(nextQuestion) withObject:nil afterDelay:0.5];
        
        }else{
            //错误
            [self setAnswerBtnColor:[UIColor redColor]];
        }
    }
}

///设置分数
- (void)setupScore:(int)score
{
    int currentScore = self.scoreBtn.currentTitle.intValue;
    currentScore += score;
    [self.scoreBtn setTitle:[NSString stringWithFormat:@"%d", currentScore] forState:UIControlStateNormal];
}


#pragma mark - 设置答案区
//中间答题按钮
- (void)setupMiddleSubviews:(ZYAnswerModel *)question
{
    ///每次到新的一题, 删除原有的答案按钮
    [self.middleView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    ///获取当前问题答案的文字个数
    NSUInteger len = question.answer.length;
    CGFloat answerH = 35;
    CGFloat answerW = answerH;
    CGFloat answerY = 15;
    CGFloat margin = 10;
    for (int i = 0; i < len ; i++ ) {
        UIButton *answerBtn = [[UIButton alloc]init];
        [answerBtn setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [answerBtn setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
        ///设置答案的文字颜色
        [answerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        CGFloat leftMargin = ([UIScreen mainScreen].bounds.size.width - len * answerW - margin * (len - 1)) * 0.5;
        CGFloat answerX = leftMargin + ( answerW + margin ) * i;
        answerBtn.frame = CGRectMake(answerX, answerY, answerW, answerH);
        ///给按钮绑定点击事件
        [answerBtn addTarget:self action:@selector(ClickAnswerBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.middleView addSubview:answerBtn];
    }
}

///答案的点击事件
- (void)ClickAnswerBtn:(UIButton *)sender
{
    ///把所有答案的按钮文字颜色设置成黑色, 把答案填满之后变的颜色变回来
    [self setAnswerBtnColor:[UIColor blackColor]];
    
    ///遍历待选按钮,
    for (UIButton *btnOption in self.bottomView.subviews) {
        if (btnOption.tag == sender.tag) {        ///怎么是不是
            btnOption.hidden = NO;
            break;
        }
    }
    //把文字隐藏
    [sender setTitle:nil forState:UIControlStateNormal];
    //设置待选区可以交互
    self.middleView.userInteractionEnabled = YES;
}

#pragma mark - 设置颜色工具接口
- (void)setAnswerBtnColor:(UIColor *)color
{
    //遍历控件
    for (UIButton *btn in self.middleView.subviews) {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
}


#pragma mark - 点击提示
- (void)ClickPromptBtn
{
    ///减分
    int score = self.scoreBtn.currentTitle.intValue;
    score -= 1000;
    [self.scoreBtn setTitle:[NSString stringWithFormat:@"%d", score] forState:UIControlStateNormal];
    
    ///提示一个字
    //1. 把所有答案按钮内容清空, 就是把所有按钮都按一遍
    for (UIButton *button in self.middleView.subviews) {
        [self ClickAnswerBtn:button];
    }
    ZYAnswerModel *answer = self.answers[self.index];
    //2. 获取答案的第一个字符
    NSString *firtString = [answer.answer substringToIndex:1];
    //3. 点击对应的待选按钮
    for (UIButton *button in self.bottomView.subviews) {
        if ([firtString isEqualToString:button.currentTitle]) {
            //点击该按钮
            [self ClickOptionBtn:button];
        }
    }
    
}


#pragma mark - 懒加载
//数据模型
- (NSArray *)answers
{
    if (_answers == nil) {
        _answers = [[NSArray alloc]init];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"questions.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in array) {
           ZYAnswerModel *answer = [ZYAnswerModel ZYAnswerModelWithDitc:dict];
            [arrayM addObject:answer];
        }
        _answers = arrayM;
    }
    return _answers;
}

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
        [self.backgroundView addSubview:self.middleView];
//        _middleView.backgroundColor = [UIColor yellowColor];
        [_middleView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nextBtn.bottom).offset(30);
            make.left.right.equalTo(self.backgroundView).offset(0);
            CGFloat midHeight = [UIScreen mainScreen].bounds.size.height * 0.15;
            make.height.equalTo(midHeight);
        }];
    }
    return _middleView;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
//        _bottomView.backgroundColor = [UIColor blueColor];
        [self.backgroundView addSubview:self.bottomView];
        [_bottomView makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.equalTo(self.backgroundView).offset(0);
            make.top.equalTo(self.middleView.bottom).offset(0);
        }];
    }
    return _bottomView;
}


@end
