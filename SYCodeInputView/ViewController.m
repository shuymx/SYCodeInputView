//
//  ViewController.m
//  SYCodeInputView
//
//  Created by shuyang on 2018/11/8.
//  Copyright © 2018年 shuyang. All rights reserved.
//

#import "ViewController.h"
#import "SYCodeInputView.h"

@interface ViewController ()

@property (nonatomic, strong) SYCodeInputView *inputView;
@property (nonatomic, strong) UILabel *codeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    SYCodeInputView *inputView = [[SYCodeInputView alloc]initWithItmeWidth:50 number:4];
    self.inputView = inputView;
    [self.view addSubview:inputView];
    inputView.frame = CGRectMake(12, 200, [[UIScreen mainScreen] bounds].size.width-24, 50);
    inputView.finishBlock = ^(NSString * _Nonnull code) {
        NSLog(@"%@",code);
        weakSelf.codeLabel.text = [NSString stringWithFormat:@"验证码: %@",code];
    };
    
    UILabel *codeLabel = [[UILabel alloc]init];
    codeLabel.font = [UIFont systemFontOfSize:14];
    codeLabel.text = [NSString stringWithFormat:@"验证码:"];
    codeLabel.frame = CGRectMake(12, CGRectGetMaxY(inputView.frame)+10, 180, 44);
    self.codeLabel = codeLabel;
    [self.view addSubview:codeLabel];
    
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"清除输入框" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clearCodeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.frame = CGRectMake(12, CGRectGetMaxY(codeLabel.frame), 100, 44);
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)clearCodeClick {
    [self.inputView clearCode];
}

@end
