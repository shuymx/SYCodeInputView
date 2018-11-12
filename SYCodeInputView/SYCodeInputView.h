//
//  SYCodeInputView.h
//  SYCodeInputView
//
//  Created by shuyang on 2018/11/8.
//  Copyright © 2018年 shuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SYCodeInputViewFinishBlock)(NSString *code);

@interface SYCodeInputView : UIView

-(instancetype)initWithItmeWidth:(CGFloat)width number:(NSInteger)number;
/***/
@property (nonatomic, copy) SYCodeInputViewFinishBlock finishBlock;
//清除验证码
-(void)clearCode;

@end

NS_ASSUME_NONNULL_END
