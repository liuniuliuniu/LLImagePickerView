//
//  LLActionSheetView.h
//  LLActionSheetView
//
//  Created by liushaohua on 2017/5/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LLActionSheetView;

@protocol LLActionSheetDelegate <NSObject>

- (void)actionSheetView:(LLActionSheetView *)actionSheetView clickButtonAtIndex:(NSInteger )buttonIndex;

@end


@interface LLActionSheetView : UIView

// 支持代理
@property (nonatomic,weak) id <LLActionSheetDelegate> delegate;

// 支持block
@property (nonatomic,copy) void (^ClickIndex) (NSInteger index);

/**
 根据数组进行文字显示,返回index
 @param titleArr 传入显示的数组
 @param show 是否显示取消按钮
 @return return value description
 */
- (instancetype)initWithTitleArray:(NSArray *)titleArr
                     andShowCancel:(BOOL )show;

- (void)show;


@end
