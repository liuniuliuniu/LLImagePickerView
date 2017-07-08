//
//  LLImagePickerConst.h
//  LLImagePickerDemo
//
//  Created by liushaohua on 2017/6/1.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LLMediaExt.h"
#import "UIViewController+LLMediaExt.h"
#import "UIImage+LLGif.h"
#import "UIImageView+LLMediaExt.h"
#import "NSString+LLMediaExt.h"

#define  LLPicker_ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define  LLPicker_ScreenHeight [UIScreen mainScreen].bounds.size.height
#define  LLPicker_ScreenBounds [UIScreen mainScreen].bounds
#define  LLPickerBackGroundColor [UIColor colorWithRed:0xf2/255.0 green:0xf4/255.0 blue:0xf9/255.0 alpha:1]

#define LLPickerRatio LLPicker_ScreenWidth/375.0

/** cell上删除按钮的宽 */
#define LLPickerDeleteButtonWidth LLPickerRatio * 18

//日志输出
#ifdef DEBUG
#define LLLog(...) NSLog(__VA_ARGS__)
#else
#define LLLog(...)
#endif
