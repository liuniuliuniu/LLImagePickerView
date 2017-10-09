//
//  LLImagePickerCell.m
//  LLImagePickerDemo
//
//  Created by liushaohua on 2017/6/1.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "LLImagePickerCell.h"
#import "LLImagePickerConst.h"

@implementation LLImagePickerCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    _icon = [[UIImageView alloc] init];
    _icon.clipsToBounds = YES;
    _icon.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_icon];
    
    _deleteButton = [[UIButton alloc] init];
    [_deleteButton setBackgroundImage:[UIImage imageNamed:@"LLImagePicker.bundle/deleteButton" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [_deleteButton addTarget:self action:@selector(clickDeleteButton) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteButton];
    
    _videoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LLImagePicker.bundle/ShowVideo" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil]];
    [self.contentView addSubview:_videoImageView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _icon.frame = CGRectMake(LLPickerDeleteButtonWidth/2, LLPickerDeleteButtonWidth/2, self.bounds.size.width - LLPickerDeleteButtonWidth, self.bounds.size.width - LLPickerDeleteButtonWidth);
    _deleteButton.frame = CGRectMake(self.bounds.size.width - LLPickerDeleteButtonWidth, 0, LLPickerDeleteButtonWidth, LLPickerDeleteButtonWidth);
    _videoImageView.frame = CGRectMake(self.bounds.size.width/4, self.bounds.size.width/4, self.bounds.size.width/2, self.bounds.size.width/2);
}
- (void)clickDeleteButton {

    !_LLClickDeleteButton ?  : _LLClickDeleteButton(self.cellIndexPath);
}

@end
