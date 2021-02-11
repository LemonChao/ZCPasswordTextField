//
//  ZCPasswordItem.h
//  ZCPasswordTextField
//
//  Created by zchao on 2021/1/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZCPasswordConfiguration;
@interface ZCPasswordItem : UIView

// item 显示的标题
@property(nonatomic, copy) NSString *title;

// 高亮状态
@property(nonatomic, assign) BOOL hightLighted;

// 位于父视图的第几个 0:第一个
@property(nonatomic, assign) NSUInteger location;

@property(nonatomic, strong) ZCPasswordConfiguration *config;

- (instancetype)initWithConfiguration:(ZCPasswordConfiguration *)config;

@end

NS_ASSUME_NONNULL_END
