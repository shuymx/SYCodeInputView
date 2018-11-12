//
//  SYCodeInputView.m
//  SYCodeInputView
//
//  Created by shuyang on 2018/11/8.
//  Copyright © 2018年 shuyang. All rights reserved.
//

#import "SYCodeInputView.h"
#import "SYTextField.h"

@interface SYCodeInputView()<UITextFieldDelegate,SYTextFieldDelegate>

/***/
@property (nonatomic, assign) NSInteger number;
/***/
@property (nonatomic, assign) CGFloat width;
/***/
@property (nonatomic, strong) NSMutableArray *textMuArray;
@property (nonatomic, strong) NSMutableArray *lineMuArray;

@end

@implementation SYCodeInputView

-(instancetype)initWithItmeWidth:(CGFloat)width number:(NSInteger)number {
    if (self = [super init]) {
        
        self.width = width;
        self.number = number;
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [super layoutSubviews];
    
    for (int i = 0 ; i < self.number; i++) {
        
        SYTextField *textField = [[SYTextField alloc]init];
        
        textField.layer.borderColor = [UIColor clearColor].CGColor;
        textField.layer.borderWidth = 0.5;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.textColor = [UIColor redColor];
        textField.tintColor = [UIColor redColor];
        textField.secureTextEntry = NO;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.tag = i;
        textField.delegate = self;
        textField.font = [UIFont systemFontOfSize:22];
        textField.sy_delegate = self;
        
        [self.textMuArray addObject:textField];
        [self addSubview:textField];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        [self.lineMuArray addObject:line];
        
        //计算间隙
        CGFloat space = ([[UIScreen mainScreen] bounds].size.width-24-_number*_width)/3;
        
        textField.frame = CGRectMake((_width+space)*i, 0, _width, _width-1);
        line.frame = CGRectMake((_width+space)*i, _width+5, _width, 1);
        
        if (i == 0) {
            [textField becomeFirstResponder];
        }
    }
}

-(void)clearCode {
    for (int i = 0 ; i < self.number; i++) {
        SYTextField *textF = self.textMuArray[i];
        textF.text = @"";
        UIView *lineF = self.lineMuArray[i];
        lineF.backgroundColor = [UIColor lightGrayColor];
        if (i == 0) {
            [textF becomeFirstResponder];
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //检测对应的位置才能返回yes。
    __block BOOL isF = NO;
    __block NSInteger index = 0;
    //获取点击位置
    [self.textMuArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SYTextField *textF = obj;
        if (textField == textF) {
            index = idx;
            *stop = YES;
        }
    }];
    
    //找到应该弹起键盘的位置
    __block NSInteger keyIndex = 0;
    [self.textMuArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SYTextField *textF = obj;
        if (textF.text.length < 1) {
            keyIndex = idx;
            *stop = YES;
        }
    }];
    
    if (textField.text.length > 0) {
        //已经有数字了的，过虐
        isF = NO;
    }else{
        //还没有输入的，判断上一个
        if (index > 0) {
            //点击非第0个
            SYTextField *textF1 = self.textMuArray[index-1];
            if (textF1.text.length > 0) {
                isF = YES;
            }else{
                isF = NO;
            }
        }else {
            //点击第0个
            if (textField.text.length < 1) {
                isF = YES;
            }
        }
    }
    
    //弹起键盘
    if (index != keyIndex) {
        SYTextField *textF = self.textMuArray[keyIndex];
        [textF becomeFirstResponder];
    }
    
    return isF;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (!textField.hasText) {
        
        NSInteger index = textField.tag;
        
        if (index == self.number-1) {
            
            SYTextField *textF = self.textMuArray[index];
            textF.text = string;
            
            NSString *code = @"";
            
            for (SYTextField *textf in self.textMuArray) {
                code = [NSString stringWithFormat:@"%@%@",code,textf.text];
            }
            //传出的数据
            if (self.finishBlock) {
                self.finishBlock(code);
            }
            
            return NO;
        }
        
        SYTextField *textF = self.textMuArray[index];
        textF.text = string;
        
        UIView *lineF = self.lineMuArray[index];
        lineF.backgroundColor = [UIColor redColor];
        
        SYTextField *textF1 = self.textMuArray[index+1];
        [textF1 becomeFirstResponder];
        
    }
    
    return NO;
}

-(void)didClickBackWard:(SYTextField *)textField {
    //输入满最后一位时自动取消了，不需要考虑最后一位的回删
    for (int i = 0 ; i < self.number; i++) {
        
        SYTextField *textF = self.textMuArray[i];
        
        if (textField == textF) {
            
            if (i > 0) {
                SYTextField *textF1 = self.textMuArray[i-1];
                
                UIView *lineF = self.lineMuArray[i-1];
                lineF.backgroundColor = [UIColor lightGrayColor];
                
                if (textF1.hasText) {
                    textF1.text = @"";
                }
                [textF1 becomeFirstResponder];
            }
        }
    }
}


#pragma mark 懒加载数据
-(NSMutableArray *)textMuArray
{
    if (!_textMuArray) {
        _textMuArray = [NSMutableArray array];
    }
    return _textMuArray;
}

-(NSMutableArray *)lineMuArray
{
    if (!_lineMuArray) {
        _lineMuArray = [NSMutableArray array];
    }
    return _lineMuArray;
}


@end
