//
//  LWViewController.m
//  LWGrayTheme
//
//  Created by jk_wlw on 01/04/2022.
//  Copyright (c) 2022 jk_wlw. All rights reserved.
//

#import "LWViewController.h"
#import <LWGrayTheme/LWGrayThemeManager.h>


@interface LWViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation LWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [LWGrayThemeManager configCanGray:YES];
    [LWGrayThemeManager handleGrayThemeWithSuperView:self.view];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self changeUI];
}

- (void)changeUI{
    
    //动态添加
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label1.textColor = [UIColor blueColor];
    label1.text = @"新添加的label";
    [self.view addSubview:label1];
    
    //后改label颜色
    self.testLabel.textColor = [UIColor redColor];
    self.testLabel.text = @"改变后label";
    self.testLabel.backgroundColor = [UIColor yellowColor];
    self.imgView.image = [UIImage imageNamed:@"test"];
    
    NSString *str = @"testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest";
    // 创建 NSMutableAttributedString
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
     
    // 设置字体和设置字体的范围
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:30.0f]
                    range:NSMakeRange(0, 3)];
    // 添加文字颜色
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor redColor]
                    range:NSMakeRange(17, 7)];
    // 添加下划线
    [attrStr addAttribute:NSUnderlineStyleAttributeName
                    value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                    range:NSMakeRange(8, 7)];

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60, 300, 200, 0)];
    label.backgroundColor = [UIColor greenColor];
    // 自动换行
    label.numberOfLines = 0;
    // 设置label的富文本
    label.attributedText = attrStr;
    // label高度自适应
    [label sizeToFit];
    [self.view addSubview:label];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
