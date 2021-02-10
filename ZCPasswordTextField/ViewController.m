//
//  ViewController.m
//  ZCPasswordTextField
//
//  Created by zchao on 2021/1/20.
//

#import "ViewController.h"
#import "ZCPasswordTextField.h"
#import "TestViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    ZCPasswordTextField *textField = [[ZCPasswordTextField alloc] initWithLength:6 style:ZCPasswordTextFieldBorderNormal spacing:10];
//    textField.frame = CGRectMake(20, 200, 335, 50);
    ZCPasswordTextField *textField = [[ZCPasswordTextField alloc] initWithFrame:CGRectMake(20, 200, 335, 50)];
    textField.delegate = self;
    [self.view addSubview:textField];
    UICollectionView *table;
}


- (IBAction)jumpToTestVC:(UIButton *)sender {
    
    TestViewController *textVC = [[TestViewController alloc] init];
    
    [self.navigationController pushViewController:textVC animated:YES];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    NSLog(@"text:%@--%ld",textField.text, reason);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *new_string = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return new_string.length <= 6;
}

@end
