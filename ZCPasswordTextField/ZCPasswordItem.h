//
//  ZCPasswordItem.h
//  ZCPasswordTextField
//
//  Created by zchao on 2021/1/20.
//

#import <UIKit/UIKit.h>
#import "ZCPasswordConfiguration.h"

typedef NS_ENUM(NSInteger,ZCPasswordTextFieldStyle) {
    ZCPasswordTextFieldLineNormal       = 0,    //下划线明文显示
    ZCPasswordTextFieldLineEncryption   = 1,    //下划线密文显示
    ZCPasswordTextFieldBorderNormal     = 2,    //带边框明文显示
    ZCPasswordTextFieldBorderEncryption = 3,    //带边框密文显示
    ZCPasswordTextFieldRectNormal       = 4,    //矩形明文显示
    ZCPasswordTextFieldRectEncryption   = 5,    //矩形密文显示
};

NS_ASSUME_NONNULL_BEGIN

@interface ZCPasswordItem : UIView

@property(nonatomic, assign) ZCPasswordTextFieldStyle style;

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

// item 高亮时颜色
@property(nonatomic, strong) UIColor *tintColor;

// item 高亮时颜色
@property(nonatomic, strong) UIColor *borderColor;

// 位于父视图的第几个 0:第一个
@property(nonatomic, assign) NSUInteger location;

// 父视图上item的总个数
@property(nonatomic, assign) NSUInteger count;



@property(nonatomic, strong) ZCPasswordConfiguration *config;

@end

NS_ASSUME_NONNULL_END
