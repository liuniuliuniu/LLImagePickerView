//
//  EditLLImagePickerVC.m
//  LLImagePickerDemo
//
//  Created by liushaohua on 2017/6/2.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "EditLLImagePickerVC.h"
#import "LLImagePickerView.h"

@interface EditLLImagePickerVC ()


@property (nonatomic,weak) LLImagePickerView * pickerV;

@end

@implementation EditLLImagePickerVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    CGFloat height = [LLImagePickerView defaultViewHeight];
    UIView *headerV = [UIView new];
    
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    titleLbl.text = @"展示区域";
    [headerV addSubview:titleLbl];    
    LLImagePickerView *pickerV = [[LLImagePickerView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLbl.frame) + 10, [UIScreen mainScreen].bounds.size.width, height)];
    pickerV.showDelete = NO;
    pickerV.showAddButton = NO;
    // png jpg gif 
    pickerV.preShowMedias = @[@"4",@"1",@"http://s1.dwstatic.com/group1/M00/AA/B8/b9a8f39ed9c8609354a07cc38452aef9.gif"];
    pickerV.allowMultipleSelection = NO;
    pickerV.allowPickingVideo = YES;
    self.pickerV = pickerV;
    // 动态变换高度
    [pickerV observeViewHeight:^(CGFloat height) {
        CGRect rect = headerV.frame;
        rect.size.height = CGRectGetMaxY(pickerV.frame);
        headerV.frame = rect;
    }];
    
    [pickerV observeSelectedMediaArray:^(NSArray<LLImagePickerModel *> *list) {
        for (LLImagePickerModel *model in list) {
            // 在这里取到模型的数据
            NSLog(@"%@",model);
        }
    }];
    [headerV addSubview:pickerV];
    headerV.frame = CGRectMake(0, 0, self.view.frame.size.width, CGRectGetMaxY(pickerV.frame));
    self.tableView.tableHeaderView = headerV;
}

- (IBAction)editAction:(UIBarButtonItem *)sender {
    UIBarButtonItem *bar = (UIBarButtonItem *)sender;
    if ([bar.title isEqualToString:@"编辑"]) {
        self.pickerV.showAddButton = YES;
        self.pickerV.showDelete = YES;
        [self.pickerV reload];
        [bar setTitle:@"预览"];
    }else{
        [bar setTitle:@"编辑"];
        self.pickerV.showAddButton = NO;
        self.pickerV.showDelete = NO;
        [self.pickerV reload];
    }
}



@end
