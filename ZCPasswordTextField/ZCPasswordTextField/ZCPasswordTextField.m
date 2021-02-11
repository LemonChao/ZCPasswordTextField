//
//  ZCPasswordTextField.m
//  ZCPasswordTextField
//
//  Created by zchao on 2021/1/20.
//

#import "ZCPasswordTextField.h"
#import "ZCPasswordItem.h"

@interface ZCPasswordTextField ()

@property(nonatomic, strong) NSMutableArray <ZCPasswordItem *>*items;

// 输入的总长度 默认6
@property(nonatomic, assign) NSUInteger length;
@property(nonatomic, assign) NSUInteger currLen;
@property(nonatomic, assign) NSUInteger oldLen;

@end


@implementation ZCPasswordTextField


- (instancetype)initWithFrame:(CGRect)frame
{
    ZCPasswordConfiguration *config = [[ZCPasswordConfiguration alloc] init];
    
    return [self initWithFrame:frame configuration:config];
}

- (instancetype)initWithConfiguration:(ZCPasswordConfiguration *)config
{
    return [self initWithFrame:CGRectZero configuration:config];
}


- (instancetype)initWithFrame:(CGRect)frame configuration:(ZCPasswordConfiguration *)config {
    self = [super initWithFrame:frame];
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
        self.backgroundColor = [UIColor whiteColor];
        self.config = config;
       self.length = config.length;
        self.currLen = 0;
        self.oldLen = 0;
        self.items = [NSMutableArray arrayWithCapacity:config.length];
        for (int i = 0; i < config.length; i++) {
            ZCPasswordItem *item = [[ZCPasswordItem alloc] initWithConfiguration:config];
            item.location = i;
            [self.items addObject:item];
        }
        UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:self.items];
        stackView.axis = UILayoutConstraintAxisHorizontal;
        stackView.alignment = UIStackViewDistributionFill;
        stackView.distribution = UIStackViewDistributionFillEqually;
        if (config.style == ZCPasswordTextFieldBorderNormal || config.style == ZCPasswordTextFieldBorderEncryption) {
            stackView.spacing = 0;
        }else {
            stackView.spacing = config.spacing;
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
    [self performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.3];
    return self;
}

- (void)textFieldChanged:(UITextField *)textField {
    _currLen = textField.text.length;

    // 1：输入变长
    static BOOL increase = 1;
    increase = _currLen > _oldLen;
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
        [self resignFirstResponder];
    }     
}


- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        menuController.menuVisible = NO;
#pragma clang diagnostic pop
    }
    return false;
}


@end




@implementation ZCPasswordConfiguration

- (instancetype)init {
    return [self initWithStyle:ZCPasswordTextFieldBorderEncryption];
}

+ (ZCPasswordConfiguration *)configurationWithStyle:(ZCPasswordTextFieldStyle)style {
    ZCPasswordConfiguration *config = [[self alloc] initWithStyle:style];
    return config;
}


- (instancetype)initWithStyle:(ZCPasswordTextFieldStyle)style
{
    self = [super init];
    if (self) {
        self.style = style;
        self.length = 6;
        switch (style) {
            case ZCPasswordTextFieldLineNormal:
            case ZCPasswordTextFieldLineEncryption:
            {
                self.spacing = 10;
                self.itemBGColor = [UIColor clearColor];
                self.titleColor = [UIColor blackColor];
                self.cornerRadius = 0;
                self.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
                self.hightBorderColor = [UIColor blueColor];
                self.borderColor = [UIColor lightGrayColor];
            }
                break;
            case ZCPasswordTextFieldBorderNormal:
            case ZCPasswordTextFieldBorderEncryption:
            {
                self.spacing = 0;
                self.itemBGColor = [UIColor whiteColor];
                self.titleColor = [UIColor blackColor];
                self.cornerRadius = 0;
                self.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
                self.hightBorderColor = [UIColor blueColor];
                self.borderColor = [UIColor blackColor];
            }
                break;
            case ZCPasswordTextFieldRectNormal:
            case ZCPasswordTextFieldRectEncryption:
            {
                self.spacing = 10;
                self.itemBGColor = [UIColor lightGrayColor];
                self.titleColor = [UIColor blackColor];
                self.cornerRadius = 0;
                self.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
                self.hightBorderColor = [UIColor blueColor];
                self.borderColor = [UIColor lightGrayColor];
            }
                break;
       default://Border
            {
                self.spacing = 0;
                self.itemBGColor = [UIColor whiteColor];
                self.titleColor = [UIColor blackColor];
                self.cornerRadius = 0;
                self.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
                self.hightBorderColor = [UIColor blueColor];
                self.borderColor = [UIColor blackColor];
            }
                break;
        }
    }
    return self;
}

@end


