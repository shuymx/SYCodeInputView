//
//  SYTextField.h
//  SYCodeInputView
//
//  Created by shuyang on 2018/11/8.
//  Copyright © 2018年 shuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SYTextField;

@protocol SYTextFieldDelegate <NSObject>
@optional;

-(void)didClickBackWard:(SYTextField*)textField;

@end

@interface SYTextField : UITextField

/***/
@property (nonatomic, weak) id<SYTextFieldDelegate> sy_delegate;

@end

NS_ASSUME_NONNULL_END
