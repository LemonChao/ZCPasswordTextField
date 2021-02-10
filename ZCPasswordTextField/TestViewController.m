//
//  TestViewController.m
//  ZCPasswordTextField
//
//  Created by zchao on 2021/1/20.
//

#import "TestViewController.h"
#import "ZCPasswordTextField.h"
@interface TestViewController ()<UITextFieldDelegate>

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    ZCPasswordTextField *textField = [[ZCPasswordTextField alloc] initWithConfiguration:[ZCPasswordConfiguration configurationWithStyle:ZCPasswordTextFieldLineEncryption]];
    textField.frame = CGRectMake(20, 400, 335, 50);
    textField.delegate = self;
    [self.view addSubview:textField];

}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    NSLog(@"text:%@--%ld",textField.text, reason);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *new_string = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return new_string.length <= 6;
}

@end
