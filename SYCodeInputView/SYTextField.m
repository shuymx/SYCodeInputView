//
//  SYTextField.m
//  SYCodeInputView
//
//  Created by shuyang on 2018/11/8.
//  Copyright © 2018年 shuyang. All rights reserved.
//

#import "SYTextField.h"

@implementation SYTextField

-(void)deleteBackward {
    
    [super deleteBackward];
    
    if (self.sy_delegate && [self.sy_delegate respondsToSelector:@selector(didClickBackWard:)]) {
        [self.sy_delegate didClickBackWard:self];
    }
}

@end
