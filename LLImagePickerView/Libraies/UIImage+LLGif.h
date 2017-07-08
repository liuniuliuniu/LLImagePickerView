//
//  UIImage+LLGif.h
//  LLImagePickerDemo
//
//  Created by liushaohua on 2017/6/1.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LLGif)

/** 根据gif的name 设置image */
+ (UIImage *)ll_setGifWithName: (NSString *)name;

/** 根据gif的data 设置image */
+ (UIImage *)ll_setGifWithData: (NSData *)data;

@end
