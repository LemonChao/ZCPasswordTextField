//
//  ZCPasswordConfiguration.h
//  ZCPasswordTextField
//
//  Created by zchao on 2021/1/20.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger,ZCPasswordTextFieldStyle) {
//    ZCPasswordTextFieldLineNormal       = 0,    //下划线明文显示
//    ZCPasswordTextFieldLineEncryption   = 1,    //下划线密文显示
//    ZCPasswordTextFieldBorderNormal     = 2,    //带边框明文显示
//    ZCPasswordTextFieldBorderEncryption = 3,    //带边框密文显示
//    ZCPasswordTextFieldRectNormal       = 4,    //矩形明文显示
//    ZCPasswordTextFieldRectEncryption   = 5,    //矩形密文显示
//};

NS_ASSUME_NONNULL_BEGIN

@interface ZCPasswordConfiguration : NSObject

// item 显示的标题
@property(nonatomic, copy) NSString *title;

// item 字体颜色
@property(nonatomic, strong) UIColor *titleColor;

// 边框圆角， 默认0
@property(nonatomic, assign) NSInteger cornerRadius;

// 绘图字体
@property(nonatomic, strong) UIFont *font;

// 高亮状态
@property(nonatomic, assign) BOOL hightLighted;

// item 填充色(背景色)
@property(nonatomic, strong) UIColor *filledColor;

// item 高亮时颜色
@property(nonatomic, strong) UIColor *tintColor;



@end

NS_ASSUME_NONNULL_END
