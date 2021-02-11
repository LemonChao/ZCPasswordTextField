//
//  TestViewController.m
//  ZCPasswordTextField
//
//  Created by zchao on 2021/1/20.
//

#import "TestViewController.h"
@interface TestViewController ()<UITextFieldDelegate>

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.field.delegate = self;
    [self.view addSubview:self.field];

    if (self.field.config.style == ZCPasswordTextFieldRectEncryption) {
        self.field.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *layoutTop = [NSLayoutConstraint constraintWithItem:self.field attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:200.0];
        NSLayoutConstraint *layoutLeft = [NSLayoutConstraint constraintWithItem:self.field attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20];
        NSLayoutConstraint *layoutRight = [NSLayoutConstraint constraintWithItem:self.field attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20];
        NSLayoutConstraint *layoutHeight = [NSLayoutConstraint constraintWithItem:self.field attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:50];
        
        [self.view addConstraints:@[layoutTop,layoutLeft,layoutRight,layoutHeight]];
   }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    NSLog(@"text:%@--%ld",textField.text, reason);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *new_string = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return new_string.length <= 6;
}

@end
