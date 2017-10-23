//
//  UIImageView+LLExtension.h
//  LLImagePickerDemo
//
//  Created by liushaohua on 2017/6/1.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImageView (LLExtension)

- (void)ll_setImageWithUrlString: (NSString *)urlString placeholderImage: (UIImage *)placeholderImage;
@end
