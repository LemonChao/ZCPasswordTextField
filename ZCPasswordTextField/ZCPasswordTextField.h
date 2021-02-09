//
//  ZCPasswordTextField.h
//  ZCPasswordTextField
//
//  Created by zchao on 2021/1/20.
//

#import <UIKit/UIKit.h>
#import "ZCPasswordItem.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZCPasswordTextField : UITextField

/*
   textField: shouldChangeCharactersInRange: replacementString:
   外面必须要指定了ZCPasswordTextField 的delege,并实现textField: shouldChangeCharactersInRange: replacementString: 并在超过指定length 后返回NO，停止接收新的输入.eg
 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
     NSString *new_string = [textField.text stringByReplacingCharactersInRange:range withString:string];
     return new_string.length <= 6;
 }
*/
@property (nonatomic,weak) id <UITextFieldDelegate> aDelegate;

/// 初始化
/// @param length 输入的总长度 默认6
/// @param style 默认ZCPasswordTextFieldLineNormal
- (instancetype)initWithLength:(NSUInteger)length style:(ZCPasswordTextFieldStyle)style;

/// 初始化
/// @param length 输入的总长度 默认6
/// @param style 默认ZCPasswordTextFieldLineNormal
/// @param spacing item间距 默认0
- (instancetype)initWithLength:(NSUInteger)length style:(ZCPasswordTextFieldStyle)style spacing:(CGFloat)spacing;


@end


NS_ASSUME_NONNULL_END
