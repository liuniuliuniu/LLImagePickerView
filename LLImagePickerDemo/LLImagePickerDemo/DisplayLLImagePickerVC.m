//
//  DisplayLLImagePickerVC.m
//  LLImagePickerDemo
//
//  Created by liushaohua on 2017/6/1.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "DisplayLLImagePickerVC.h"
#import "LLImagePickerView.h"

@interface DisplayLLImagePickerVC ()

@end

@implementation DisplayLLImagePickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"自定义每行展示几张图片";
        
    // 每行 3张图片
    LLImagePickerView *pickerV = [LLImagePickerView ImagePickerViewWithFrame:CGRectMake(50, 70, [UIScreen mainScreen].bounds.size.width - 100, 0) CountOfRow:3];
    
    pickerV.showDelete = NO;
    pickerV.showAddButton = NO;
    pickerV.preShowMedias = @[@"1",
                              @"http://wx4.sinaimg.cn/mw690/7fa92467gy1fgyxf24ce2j20ku0he76x.jpg",
                              @"http://wx3.sinaimg.cn/mw690/005LAqUhly1fdbohcfw6xj30qe13ljzq.jpg"
                              ];
    [self.view addSubview:pickerV];
    
    // 每行 4张照片
    LLImagePickerView *pickerV2 = [LLImagePickerView ImagePickerViewWithFrame:CGRectMake(20, 250, [UIScreen mainScreen].bounds.size.width - 40, 0) CountOfRow:4];
    pickerV2.showDelete = NO;
    pickerV2.showAddButton = NO;
    pickerV2.preShowMedias = @[
                               @"1",
                               @"2",
                               @"3",
                               @"4",
                               @"http://wx4.sinaimg.cn/mw690/7fa92467gy1fgyxf24ce2j20ku0he76x.jpg",
                               @"http://wx3.sinaimg.cn/mw690/005LAqUhly1fdbohcfw6xj30qe13ljzq.jpg"
                               ];
    [self.view addSubview:pickerV2];
    
    // 每行 5张照片
    LLImagePickerView *pickerV3 = [LLImagePickerView ImagePickerViewWithFrame:CGRectMake(0, 500, [UIScreen mainScreen].bounds.size.width, 0) CountOfRow:5];
    pickerV3.showDelete = NO;
    pickerV3.showAddButton = NO;
    pickerV3.preShowMedias = @[
                               @"1",
                               @"2",
                               @"3",
                               @"4",
                               @"http://wx4.sinaimg.cn/mw690/7fa92467gy1fgyxf24ce2j20ku0he76x.jpg",
                               @"http://wx3.sinaimg.cn/mw690/005LAqUhly1fdbohcfw6xj30qe13ljzq.jpg"
                               ];
    [self.view addSubview:pickerV3];

}

@end
