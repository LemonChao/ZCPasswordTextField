//
//  ZCPasswordItem.m
//  ZCPasswordTextField
//
//  Created by zchao on 2021/1/20.
//

#import "ZCPasswordItem.h"

@implementation ZCPasswordItem


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
        
        self.titleColor = [UIColor blackColor];
        self.cornerRadius = 0;
        self.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        self.hightLighted = NO;
        self.tintColor = [UIColor blueColor];
        self.borderColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
        if (self.style == ZCPasswordTextFieldLineEncryption || self.style == ZCPasswordTextFieldBorderEncryption || self.style == ZCPasswordTextFieldRectEncryption) {
            self.title = @"●";
        }else {
            self.title = @"";
        }
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // 字符串13●4●2●5●7●6●●•∙••
    if (self.title.length) {
        if (self.style == ZCPasswordTextFieldLineEncryption || self.style == ZCPasswordTextFieldBorderEncryption || self.style == ZCPasswordTextFieldRectEncryption) {
            self.title = @"●";
        }
    }
    
    NSDictionary *attributes = @{NSFontAttributeName:self.font,NSForegroundColorAttributeName:self.titleColor};
    
    CGSize wordSize = [self.title boundingRectWithSize:rect.size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    [self.title drawInRect:CGRectMake((rect.size.width-wordSize.width)/2, (rect.size.height-wordSize.height)/2, wordSize.width, wordSize.height) withAttributes:attributes];
    
    // 下划线样式
    if (self.style == ZCPasswordTextFieldLineNormal || self.style == ZCPasswordTextFieldLineEncryption) {
        [self drawLineStyle:rect];
    }
    
    // 边框样式
    if (self.style == ZCPasswordTextFieldBorderNormal || self.style == ZCPasswordTextFieldBorderEncryption) {
        if (self.cornerRadius <= 0) {
            [self drawBorderStyle:rect];
        }else {
            [self drawRoundrectStyle:rect];
        }
    }
    
    
}

// 绘制下划线样式
- (void)drawLineStyle:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 线条宽
    CGContextSetLineWidth(context, 1.0);
    // 线条颜色
    if (self.hightLighted) {
        CGContextSetStrokeColorWithColor(context, self.tintColor.CGColor);
    }else {
        CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);

    }
    // 起点坐标
    CGContextMoveToPoint(context, 0, rect.size.height);
    // 终点坐标
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    // 绘制路径
    CGContextStrokePath(context);
}

// 绘制矩形边框样式
- (void)drawBorderStyle:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGSize size = rect.size;
    // 线条宽
    CGContextSetLineWidth(context, 1.0);
    // 线条颜色
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    
    if (self.location == self.count-1) {
        CGContextAddRect(context, CGRectMake(0, 0, size.width, size.height));
    }else {
        CGPoint points[4] = {CGPointMake(size.width, 0), CGPointMake(0, 0), CGPointMake(0, size.height), CGPointMake(size.width, size.height)};
        CGContextAddLines(context, points, 4);
    }
    CGContextStrokePath(context);
}


// 画圆角矩形
- (void)drawRoundrectStyle:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGSize size = rect.size;
    // 线条宽
    CGContextSetLineWidth(context, 1.0);
    // 线条颜色
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    if (self.location == 0) {// 第一个
        CGContextMoveToPoint(context, size.width, 0);
        CGContextAddLineToPoint(context, self.cornerRadius, 0);
        CGContextAddArcToPoint(context, 0, 0, 0, size.height-self.cornerRadius, self.cornerRadius);
        CGContextAddLineToPoint(context, 0, size.height-self.cornerRadius);
        CGContextAddArcToPoint(context, 0, size.height, size.width, size.height, self.cornerRadius);
        CGContextAddLineToPoint(context, size.width, size.height);
    }else if (self.location == self.count-1) { //最后一个
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, size.width-self.cornerRadius, 0);
        CGContextAddArcToPoint(context, size.width, 0, size.width, size.height-self.cornerRadius, self.cornerRadius);
        CGContextAddLineToPoint(context, size.width, size.height-self.cornerRadius);
        CGContextAddArcToPoint(context, size.width, size.height, size.width-self.cornerRadius, size.height, self.cornerRadius);
        CGContextAddLineToPoint(context, 0, size.height);
        CGContextClosePath(context);
    }else {//
        CGPoint points[4] = {CGPointMake(size.width, 0), CGPointMake(0, 0), CGPointMake(0, size.height), CGPointMake(size.width, size.height)};
        CGContextAddLines(context, points, 4);
    }
    
    CGContextStrokePath(context);
}

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass(self.class));
}

@end
