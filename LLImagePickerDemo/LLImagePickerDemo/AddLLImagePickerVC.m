//
//  AddLLImagePickerVC.m
//  LLImagePickerDemo
//
//  Created by liushaohua on 2017/6/1.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "AddLLImagePickerVC.h"
#import "LLImagePickerView.h"

@interface AddLLImagePickerVC ()

@end

@implementation AddLLImagePickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);    
    CGFloat height = [LLImagePickerView defaultViewHeight];
    LLImagePickerView *pickerV = [[LLImagePickerView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height)];
    pickerV.type = LLImageTypePhoto;
    pickerV.maxImageSelected = 5;
    pickerV.allowMultipleSelection = NO;
    pickerV.allowPickingVideo = YES;
    self.tableView.tableHeaderView = pickerV;    
    [pickerV observeSelectedMediaArray:^(NSArray<LLImagePickerModel *> *list) {
        NSLog(@"%@",list);
    }];    
}


@end
