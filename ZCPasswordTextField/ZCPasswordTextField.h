//
//  ZCPasswordTextField.h
//  ZCPasswordTextField
//
//  Created by zchao on 2021/1/20.
//

#import <UIKit/UIKit.h>
#import "ZCPasswordItem.h"

typedef NS_ENUM(NSInteger,ZCPasswordTextFieldStyle) {
    ZCPasswordTextFieldLineNormal       = 0,    //下划线明文显示
    ZCPasswordTextFieldLineEncryption   = 1,    //下划线密文显示
    ZCPasswordTextFieldBorderNormal     = 2,    //带边框明文显示
    ZCPasswordTextFieldBorderEncryption = 3,    //带边框密文显示
    ZCPasswordTextFieldRectNormal       = 4,    //矩形明文显示
    ZCPasswordTextFieldRectEncryption   = 5,    //矩形密文显示
};

NS_ASSUME_NONNULL_BEGIN
@class ZCPasswordConfiguration;
@interface ZCPasswordTextField : UITextField

/*
   textField: shouldChangeCharactersInRange: replacementString:
   外面必须要指定了ZCPasswordTextField 的delege,并实现textField: shouldChangeCharactersInRange: replacementString: 并在超过指定length 后返回NO，停止接收新的输入.eg
 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
     NSString *new_string = [textField.text stringByReplacingCharactersInRange:range withString:string];
     return new_string.length <= 6;
 }
*/
@property(nonatomic, strong) ZCPasswordConfiguration *config;


- (instancetype)initWithConfiguration:(ZCPasswordConfiguration *)config;


/// 初始化
/// @param frame 输入的总长度 默认6
/// @param config 默认ZCPasswordTextFieldLineNormal
- (instancetype)initWithFrame:(CGRect)frame configuration:(ZCPasswordConfiguration *)config;

@end







@interface ZCPasswordConfiguration : NSObject

@property(nonatomic, assign) ZCPasswordTextFieldStyle style;

// field 密码长度
@property(nonatomic, assign) NSUInteger length;
// item 横向间距 (只在ZCPasswordTextFieldBorderNormal/Encryption样式下无效)
@property(nonatomic, assign) NSUInteger spacing;

// item 背景色
@property(nonatomic, strong) UIColor *itemBGColor;

// item 字体颜色
@property(nonatomic, strong) UIColor *titleColor;

// item 边框圆角， 默认0(只在ZCPasswordTextFieldBorderNormal/Encryption样式下有效)
@property(nonatomic, assign) NSInteger cornerRadius;

// item 绘图字体
@property(nonatomic, strong) UIFont *font;

// item 高亮时边框颜色 (只在ZCPasswordTextFieldLineNormal/Encryption样式下有效)
@property(nonatomic, strong) UIColor *hightBorderColor;

// item 边框颜色
@property(nonatomic, strong) UIColor *borderColor;


+ (ZCPasswordConfiguration *)configurationWithStyle:(ZCPasswordTextFieldStyle)style;

- (instancetype)initWithStyle:(ZCPasswordTextFieldStyle)style;
@end

NS_ASSUME_NONNULL_END
