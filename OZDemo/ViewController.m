//
//  ViewController.m
//  OZDemo
//
//  Created by owen on 2018/6/5.
//  Copyright © 2018年 owen. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_WIDTH self.view.frame.size.width

#define titles @"可复用模块",@"错误整理",@"OC基础",@"React Native跨平台",@"Swift",@"实用技术",@"装逼特技",@"UI",@"多线程网络",@"HTML5",@"项目实战"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *OZTableView;
@property (nonatomic,strong) NSMutableArray *listArray;
@property (nonatomic,strong) NSMutableArray *heightArray;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"OZ工具盒";
    self.view.backgroundColor = [UIColor whiteColor];
    [self listArrayGetTitlesHeight];
    [self.view addSubview:self.OZTableView];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.listArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   return  1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //根据text长度去获取高度
    NSLog(@"%f",[_heightArray[indexPath.section]floatValue]);
    return [_heightArray[indexPath.section]floatValue]+22;
}

#pragma mark 根据文字数组获取高度,并添加到数组中
-(void)listArrayGetTitlesHeight{
    
    for (int i = 0; i<self.listArray.count; i++) {
        
        CGFloat height = [self cellHeightWithString:self.listArray[i]];
        [self.heightArray addObject:@(height)];
    }
}

#pragma mark 获得高度
- (CGFloat)cellHeightWithString:(NSString *)string
{
    
    CGFloat height = [string boundingRectWithSize:CGSizeMake(self.OZTableView.frame.size.width-44, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
    
    return height;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.listArray[indexPath.section];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(UITableView *)OZTableView{
    
    if (!_OZTableView) {
        _OZTableView =[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _OZTableView.delegate = self;
        _OZTableView.dataSource = self;
    }
    return _OZTableView;
}

-(NSMutableArray *)listArray{
    
    if (!_listArray) {
        _listArray = [NSMutableArray arrayWithObjects:titles, nil];
    }
    return _listArray;
}

-(NSMutableArray *)heightArray{
    
    if (!_heightArray) {
        _heightArray = [NSMutableArray array];
    }
    return _heightArray;
}


@end
