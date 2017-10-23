//
//  LLImagePickerView.h
//  LLImagePickerDemo
//
//  Created by liushaohua on 2017/6/1.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLImagePickerModel.h"

typedef enum : NSUInteger {
    LLImageTypePhotoAndCamera,// 本地相机和图片
    LLImageTypePhoto,// 本地图片
    LLImageTypeCamera,// 相机拍摄
    LLImageTypeVideoTape,// 录像
    LLImageTypeVideo,// 视频
    LLImageTypeAll,// 所有资源
} LLImageType;

typedef void(^LLImagePickerHeightBlock)(CGFloat height);

typedef void(^LLSelecttImageBackBlock)(NSArray<LLImagePickerModel *> *list);

// 负责展示的V
@interface LLImagePickerView : UIView

/**
 * 需要展示的媒体的资源类型：如仅显示图片等，默认是 LLImageTypePhotoAndCamera
 */
@property (nonatomic,assign) LLImageType type;
/**
 * 预先展示的媒体数组。如果一开始有需要显示媒体资源，可以先传入进行显示，没有的话可以不赋值。
 * 传入的如果是图片类型，则可以是：UIImage，NSString，至于其他的都可以传入 LLImagePickerModel类型
 * 当前只支持图片和视频
 */
@property (nonatomic, strong) NSArray *preShowMedias;
/**
 * 最大资源选择个数,（包括 preShowMedias 预先展示数据）. default is 9
 */
@property (nonatomic, assign) NSInteger maxImageSelected;
/**
 * 是否显示删除按钮. Defaults is YES
 */
@property (nonatomic, assign) BOOL showDelete;

/**
 * 是否需要显示添加按钮. Defaults is YES
 */
@property (nonatomic, assign) BOOL showAddButton;

/**
 * 是否允许 在选择图片的同时可以选择视频文件. default is NO
 */
@property (nonatomic, assign) BOOL allowPickingVideo;

/**
 * 是否允许 同个图片或视频进行多次选择. default is YES
 */
@property (nonatomic, assign) BOOL allowMultipleSelection;

/**
 * 底部collectionView的 backgroundColor
 */
@property (nonatomic, strong) UIColor *backgroundColor;

#pragma mark - methods

/**
 * 监控view的高度变化，如果不和其他控件一起使用，则可以不用监控高度变化
 */
- (void)observeViewHeight: (LLImagePickerHeightBlock)value;

/**
 * 随时监控当前选择到的媒体文件
 */
- (void)observeSelectedMediaArray: (LLSelecttImageBackBlock)backBlock;


/**
 唯一的初始化方法 CountOfRow:每行展示的数量

 @param frame  Frame 
 @param count countOfRow
 @return instance
 */
+ (instancetype)ImagePickerViewWithFrame:(CGRect)frame CountOfRow:(NSInteger)count;

/**
 * 刷新
 */
- (void)reload;
/**
*   打开摄像头
*/
- (void)openCamera;
/**
*   打开相册
*/
- (void)openAlbum;

@end
