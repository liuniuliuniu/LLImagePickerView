//
//  PresentViewController.m
//  LLImagePickerDemo
//
//  Created by liushaohua on 2017/6/19.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "PresentViewController.h"
#import "LLImagePickerView.h"

@interface PresentViewController ()

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    LLImagePickerView *pickerV = [LLImagePickerView ImagePickerViewWithFrame:CGRectMake(50, 150, [UIScreen mainScreen].bounds.size.width - 100, 0) CountOfRow:3];
    pickerV.type = LLImageTypePhoto;
    pickerV.allowMultipleSelection = YES;
    pickerV.showAddButton = YES;
    pickerV.showDelete = YES;
    
    [self.view addSubview:pickerV];
    [pickerV observeSelectedMediaArray:^(NSArray<LLImagePickerModel *> *list) {
        NSLog(@"%@",list);
    }];    
}

- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
