//
//  DisplayLLImagePickerVC.m
//  LLImagePickerDemo
//
//  Created by liushaohua on 2017/6/1.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "DisplayLLImagePickerVC.h"
#import "LLImagePicker.h"

@interface DisplayLLImagePickerVC ()

@end

@implementation DisplayLLImagePickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    CGFloat height = [LLImagePickerView defaultViewHeight];
    LLImagePickerView *pickerV = [[LLImagePickerView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height)];
    pickerV.showDelete = NO;
    pickerV.showAddButton = NO;
    pickerV.preShowMedias = @[@"1",@"2",@"3",@"4"];
    self.tableView.tableHeaderView = pickerV;
}


@end
