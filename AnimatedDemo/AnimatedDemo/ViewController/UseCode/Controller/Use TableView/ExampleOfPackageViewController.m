//
//  ExampleOfPackageViewController.m
//  AnimatedDemo
//
//  Created by tigerAndBull on 2018/11/17.
//  Copyright © 2018年 tigerAndBull. All rights reserved.
//

#import "ExampleOfPackageViewController.h"

#import "PackageTableViewCell.h"
#import "TABAnimated.h"
#import <TABKit/TABKit.h>

#import "Game.h"

@interface ExampleOfPackageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ExampleOfPackageViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    
    // 启动动画
    // 默认延迟时间0.4s
    [self.tableView tab_startAnimationWithCompletion:^{
        // 请求数据
        // ...
        // 获得数据
        // ...
        [self afterGetData];
    }];
}

- (void)afterGetData {
    [self.tableView tab_endAnimationEaseOut];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *str = @"PackageTableViewCell";
    PackageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[PackageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Game *headGame = [[Game alloc]init];
    headGame.title = [NSString stringWithFormat:@"头视图标题"];
    headGame.content = [NSString stringWithFormat:@"这里是头视图内容"];
    headGame.cover = @"head.jpg";
    [cell updateWithGame:headGame];
    
    return cell;
}

#pragma mark - Initize Methods

/**
 initialize view
 初始化视图
 */
- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

#pragma mark - Lazy Methods

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 80;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[PackageTableViewCell class] cellHeight:80];
    }
    return _tableView;
}

@end
