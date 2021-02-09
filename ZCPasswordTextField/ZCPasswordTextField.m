//
//  ZCPasswordTextField.m
//  ZCPasswordTextField
//
//  Created by zchao on 2021/1/20.
//

#import "ZCPasswordTextField.h"
#import "ZCPasswordConfiguration.h"


// 内部用stackView布局
// item 画图方式实现

@interface ZCPasswordTextField ()

@property(nonatomic, strong) NSMutableArray <ZCPasswordItem *>*items;

// 输入的总长度 默认6
@property(nonatomic, assign) NSUInteger length;
@property(nonatomic, assign) NSUInteger currLen;
@property(nonatomic, assign) NSUInteger oldLen;

// 默认ZCPasswordTextFieldLineNormal
@property(nonatomic, assign) ZCPasswordTextFieldStyle style;

@end


@implementation ZCPasswordTextField

- (instancetype)initWithLength:(NSUInteger)length style:(ZCPasswordTextFieldStyle)style {
    return [self initWithLength:length style:style spacing:0];
}

- (instancetype)initWithLength:(NSUInteger)length style:(ZCPasswordTextFieldStyle)style spacing:(CGFloat)spacing {
    self = [super init];
    
    if (self) {
        // 这个属性不能设置为NO，否则布局错乱
//        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.borderStyle = UITextBorderStyleNone;
        self.clearButtonMode = UITextFieldViewModeNever;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.keyboardType = UIKeyboardTypeNumberPad;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.textColor = [UIColor clearColor];
        self.tintColor = [UIColor clearColor];
        [self addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        self.length = length;
        self.currLen = 0;
        self.oldLen = 0;
        self.backgroundColor = [UIColor whiteColor];
        self.style = style;
        self.items = [NSMutableArray arrayWithCapacity:length];
        for (int i = 0; i < length; i++) {
            ZCPasswordItem *item = [[ZCPasswordItem alloc] init];
            item.style = style;
            item.location = i;
            item.count = length;
            item.cornerRadius = 0;
            if (i == 0) { // 初始化时第一个设置高亮状态
                item.hightLighted = YES;
            }
            if (style == ZCPasswordTextFieldRectNormal || style == ZCPasswordTextFieldRectEncryption) {
                item.backgroundColor = [UIColor lightGrayColor];
            }
            [self.items addObject:item];
        }
        UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:self.items];
        stackView.axis = UILayoutConstraintAxisHorizontal;
        stackView.alignment = UIStackViewDistributionFill;
        stackView.distribution = UIStackViewDistributionFillEqually;
        if (style == ZCPasswordTextFieldBorderNormal || style == ZCPasswordTextFieldBorderEncryption) {
            stackView.spacing = 0;
        }else {
            stackView.spacing = spacing;
        }
        stackView.userInteractionEnabled = NO;
        stackView.backgroundColor = [UIColor clearColor];
        stackView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:stackView];

        NSLayoutConstraint *layoutCenterX = [NSLayoutConstraint constraintWithItem:stackView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];

        NSLayoutConstraint *layoutCenterY = [NSLayoutConstraint constraintWithItem:stackView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
        NSLayoutConstraint *layoutWidth = [NSLayoutConstraint constraintWithItem:stackView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
        NSLayoutConstraint *layoutHeight = [NSLayoutConstraint constraintWithItem:stackView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];

        [self addConstraints:@[layoutCenterX,layoutCenterY,layoutWidth,layoutHeight]];

    }
    
    [self performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.5];
    
    return self;
}


- (void)textFieldChanged:(UITextField *)textField {
    _currLen = textField.text.length;

    // 1：输入变长
    static BOOL increase = 1;
    increase = _currLen > _oldLen;
    NSLog(@"目前输入显示--%@--当前长度%ld--上次长度%ld--增加%d", textField.text, _currLen,_oldLen, increase);
    if (increase) {// 输入变长
        ZCPasswordItem *item = [self.items objectAtIndex:_currLen-1];
        item.title = [textField.text substringFromIndex:_currLen-1];
        item.hightLighted = NO;
        [item setNeedsDisplay];
        if (_currLen < self.length) { //往后多刷新一个
            ZCPasswordItem *hightItem =[self.items objectAtIndex:_currLen];
            hightItem.hightLighted = YES;
            [hightItem setNeedsDisplay];
        }
    }
    else{ // 输入变短
        ZCPasswordItem *item = [self.items objectAtIndex:_oldLen-1];
        item.hightLighted = YES;
        item.title = @"";
        [item setNeedsDisplay];
        
        if (_oldLen < self.length) {
            ZCPasswordItem *hightItem = [self.items objectAtIndex:_oldLen];
            hightItem.hightLighted = NO;
            [hightItem setNeedsDisplay];
        }
    }
    
    _oldLen = _currLen;
    if (_currLen == self.length) {
        NSLog(@"---输入完毕---");
        [self resignFirstResponder];
    }     
}

- (BOOL)isReachMaxCountCharacterRange:(NSRange)range replacmentString:(NSString *)string {
    if (self.length < 1) {
        return false;
    }
    NSString *new_string = [self.text stringByReplacingCharactersInRange:range withString:string];
    if (new_string.length > self.length) {
        return YES;
    }
    return false;
}


- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        menuController.menuVisible = NO;
    }
    return false;
}

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass(self.class));
}

@end


