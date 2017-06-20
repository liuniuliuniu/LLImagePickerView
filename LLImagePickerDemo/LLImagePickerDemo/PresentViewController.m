//
//  PresentViewController.m
//  LLImagePickerDemo
//
//  Created by liushaohua on 2017/6/19.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "PresentViewController.h"
#import "LLImagePicker.h"

@interface PresentViewController ()

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
        
    CGFloat height = [LLImagePickerView defaultViewHeight];
    LLImagePickerView *pickerV = [[LLImagePickerView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, height)];
    pickerV.type = LLImageTypePhoto;
    pickerV.allowMultipleSelection = YES;        
    [self.view addSubview:pickerV];
    [pickerV observeSelectedMediaArray:^(NSArray<LLImagePickerModel *> *list) {
        NSLog(@"%@",list);
    }];
    
}

- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
