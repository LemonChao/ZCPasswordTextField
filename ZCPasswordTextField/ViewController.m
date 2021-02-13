//
//  ViewController.m
//  ZCPasswordTextField
//
//  Created by zchao on 2021/1/20.
//

#import "ViewController.h"
#import "ZCPasswordTextField.h"
#import "TestViewController.h"

@interface ViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = @[@"下划线高亮明文密码输入框样式",@"下划线高亮密文密码输入框样式",@"矩形边框明文输入框样式",@"矩形边框密文输入框样式",@"圆角边框明文输入框样式",@"圆角边框密文密码输入框样式",@"矩形块明文密码输入框样式",@"矩形块密文密码输入框样式"];
    
    [self.view addSubview:self.tableView];
    
    NSLayoutConstraint *layoutCenterX = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];

    NSLayoutConstraint *layoutCenterY = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    NSLayoutConstraint *layoutWidth = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    NSLayoutConstraint *layoutHeight = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];

    [self.view addConstraints:@[layoutCenterX,layoutCenterY,layoutWidth,layoutHeight]];

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = self.array[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString *title = cell.textLabel.text;
    ZCPasswordTextField *field;
    TestViewController *testVC = [[TestViewController alloc] init];
    
    if ([title isEqualToString:@"矩形边框明文输入框样式"]) {
        field = [[ZCPasswordTextField alloc] init];
        field.frame = CGRectMake(20, 200, 335, 50);
        field.config.style = ZCPasswordTextFieldBorderNormal;
    }
    else if ([title isEqualToString:@"矩形边框密文输入框样式"]) {
        field = [[ZCPasswordTextField alloc] initWithFrame:CGRectMake(20, 200, 335, 50)];
    }
    else if ([title isEqualToString:@"圆角边框明文输入框样式"]) {
        ZCPasswordConfiguration *config = [ZCPasswordConfiguration configurationWithStyle:ZCPasswordTextFieldBorderNormal];
        config.cornerRadius = 10.0;
        field = [[ZCPasswordTextField alloc] initWithConfiguration:config];
        field.frame = CGRectMake(20, 200, 335, 50);
    }
    else if ([title isEqualToString:@"圆角边框密文密码输入框样式"]) {
        ZCPasswordConfiguration *config = [[ZCPasswordConfiguration alloc] initWithStyle:ZCPasswordTextFieldBorderEncryption];
        config.cornerRadius = 10.0;
        field = [[ZCPasswordTextField alloc] initWithFrame:CGRectMake(20, 200, 335, 50) configuration:config];
    }
    else if ([title isEqualToString:@"下划线高亮明文密码输入框样式"]) {
        ZCPasswordConfiguration *config = [[ZCPasswordConfiguration alloc] initWithStyle:ZCPasswordTextFieldLineNormal];
        field = [[ZCPasswordTextField alloc] initWithFrame:CGRectMake(20, 200, 335, 50) configuration:config];

    }
    else if ([title isEqualToString:@"下划线高亮密文密码输入框样式"]) {
        ZCPasswordConfiguration *config = [[ZCPasswordConfiguration alloc] initWithStyle:ZCPasswordTextFieldLineEncryption];
        config.titleColor = [UIColor blueColor];
        config.borderColor = [UIColor magentaColor];
        config.hightBorderColor = [UIColor orangeColor];
        field = [[ZCPasswordTextField alloc] initWithFrame:CGRectMake(20, 200, 335, 50) configuration:config];
    }
    else if ([title isEqualToString:@"矩形块明文密码输入框样式"]) {
        ZCPasswordConfiguration *config = [[ZCPasswordConfiguration alloc] initWithStyle:ZCPasswordTextFieldRectNormal];
        field = [[ZCPasswordTextField alloc] initWithFrame:CGRectMake(20, 200, 335, 50) configuration:config];
    }
    else if ([title isEqualToString:@"矩形块密文密码输入框样式"]) {
        ZCPasswordConfiguration *config = [[ZCPasswordConfiguration alloc] initWithStyle:ZCPasswordTextFieldRectEncryption];
        field = [[ZCPasswordTextField alloc] initWithConfiguration:config];
    }
    testVC.field = field;
    testVC.title = title;
    [self.navigationController pushViewController:testVC animated:YES];
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    return _tableView;
}

@end
