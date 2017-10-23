//
//  LLImagePickerView.m
//  LLImagePickerDemo
//
//  Created by liushaohua on 2017/6/1.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "LLImagePickerView.h"
#import "LLImagePickerCell.h"
#import "LLImagePickerConst.h"
#import "LLImagePickerManager.h"

#import "TZImagePickerController.h"
#import "MWPhotoBrowser.h"

static NSInteger countOfRow;

@interface LLImagePickerView ()<UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MWPhotoBrowserDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) LLImagePickerHeightBlock block;

@property (nonatomic, copy) LLSelecttImageBackBlock backBlock;

/** 总的媒体数组 */
@property (nonatomic, strong) NSMutableArray *mediaArray;

/** 记录从相册中已选的Image Asset */
@property (nonatomic, strong) NSMutableArray *selectedImageAssets;

/** 记录从相册中已选的Image model */
@property (nonatomic, strong) NSMutableArray *selectedImageModels;

/** 记录从相册中已选的Video model*/
@property (nonatomic, strong) NSMutableArray *selectedVideoModels;

/** MWPhoto对象数组 */
@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation LLImagePickerView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.frame = CGRectMake(self.x, self.y, self.width, LLPicker_ScreenWidth/4);
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    _mediaArray = [NSMutableArray array];
    _preShowMedias = [NSMutableArray array];
    _selectedImageAssets = [NSMutableArray array];
    _selectedVideoModels = [NSMutableArray array];
    _selectedImageModels = [NSMutableArray array];
    _type = LLImageTypePhotoAndCamera;
    _showDelete = YES;
    _showAddButton = YES;
    _allowMultipleSelection = YES;    
    _maxImageSelected = 9;
    _backgroundColor = [UIColor whiteColor];
    [self configureCollectionView];
}

- (void)configureCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(self.width/countOfRow, self.width/countOfRow);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    [_collectionView registerClass:[LLImagePickerCell class] forCellWithReuseIdentifier:NSStringFromClass([LLImagePickerCell class])];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = _backgroundColor;
    [self addSubview:_collectionView];
}

#pragma mark - setter

- (void)setShowDelete:(BOOL)showDelete {
    _showDelete = showDelete;
}

- (void)setShowAddButton:(BOOL)showAddButton {
    _showAddButton = showAddButton;
    if (_mediaArray.count > countOfRow - 1 || _mediaArray.count == 0) {
        [self layoutCollection];
    }
}
- (void)setPreShowMedias:(NSArray *)preShowMedias {
    _preShowMedias = preShowMedias;
    
    NSMutableArray *temp = [NSMutableArray array];
    for (id object in preShowMedias) {
        LLImagePickerModel *model = [LLImagePickerModel new];
        if ([object isKindOfClass:[UIImage class]]) {
            model.image = object;
        }else if ([object isKindOfClass:[NSString class]]) {
            NSString *obj = (NSString *)object;
            if ([obj isValidUrl]) {
                model.imageUrlString = object;
            }else if ([obj isGifImage]) {
                //名字中有.gif是识别不了的（和自己的拓展名重复了，所以先去掉）
                NSString *name_ = obj.lowercaseString;
                if ([name_ containsString:@"gif"]) {
                    name_ = [name_ stringByReplacingOccurrencesOfString:@".gif" withString:@""];
                }
                model.image = [UIImage ll_setGifWithName:name_];
            }else {
                model.image = [UIImage imageNamed:object];
            }
        }else if ([object isKindOfClass:[LLImagePickerModel class]]) {
            model = object;
        }
        [temp addObject:model];
    }
    if (temp.count > 0) {
        [_mediaArray addObjectsFromArray:temp.copy];
        [self layoutCollection];
    }
}

- (void)setAllowPickingVideo:(BOOL)allowPickingVideo {
    _allowPickingVideo = allowPickingVideo;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    [_collectionView setBackgroundColor:backgroundColor];
}

#pragma mark - public method

- (void)observeViewHeight:(LLImagePickerHeightBlock)value {
    _block = value;
    //预防先加载数据源的情况
    if (_mediaArray.count > countOfRow - 1) {
        _block(_collectionView.height);
    }
}

- (void)observeSelectedMediaArray: (LLSelecttImageBackBlock)backBlock {
    _backBlock = backBlock;
}

+ (instancetype)ImagePickerViewWithFrame:(CGRect)frame CountOfRow:(NSInteger)count{
    countOfRow = count;
    CGSize size = frame.size;
    size.height = size.width / count;
    frame.size = size;
    LLImagePickerView *imagePickerV = [[LLImagePickerView alloc]initWithFrame:frame];
    return imagePickerV;
}


- (void)reload {
    [self.collectionView reloadData];
}

#pragma mark -  Collection View DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _showAddButton ? ( _mediaArray.count == _maxImageSelected ? _mediaArray.count : _mediaArray.count + 1 ): _mediaArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LLImagePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LLImagePickerCell class]) forIndexPath:indexPath];
    cell.cellIndexPath = indexPath;
    
    if (indexPath.row == _mediaArray.count) {
        cell.icon.image = [UIImage imageNamed:@"LLImagePicker.bundle/AddMedia" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
        cell.videoImageView.hidden = YES;
        cell.deleteButton.hidden = YES;
    }else{
        LLImagePickerModel *model = [[LLImagePickerModel alloc]init];
        model = _mediaArray[indexPath.row];
        if (!model.isVideo && model.imageUrlString) {
            [cell.icon ll_setImageWithUrlString:model.imageUrlString placeholderImage:nil];
        }else {
            cell.icon.image = model.image;
        }
        cell.videoImageView.hidden = !model.isVideo;
        cell.deleteButton.hidden = !_showDelete;
        
        cell.LLClickDeleteButton = ^(NSIndexPath *cellIndexPath) {
            
            LLImagePickerModel *model = _mediaArray[cellIndexPath.row];
            
            if (!_allowMultipleSelection) {
                
                    for (NSInteger idx = 0; idx < _selectedImageModels.count; idx++) {
                        
                        if ([((LLImagePickerModel *)_selectedImageModels[idx]) isEqual:model ]) {
                            [_selectedImageAssets removeObjectAtIndex:idx];
                            [_selectedImageModels removeObject:model];
                            break;
                        }
                    }
                
                for (NSInteger idx = 0; idx < _selectedVideoModels.count; idx++) {
                    
                    if ([((LLImagePickerModel *)_selectedVideoModels[idx]) isEqual:model]) {
                        [_selectedVideoModels removeObject:model];
                    }
                }
            }
            [_mediaArray removeObjectAtIndex:cellIndexPath.row];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self layoutCollection];
            });
        };
    }
    return cell;
}

#pragma mark - collection view delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _mediaArray.count && _mediaArray.count >= _maxImageSelected) {
        [UIAlertController showAlertWithTitle:[NSString stringWithFormat:@"最多只能选择%ld张",(long)_maxImageSelected] message:nil actionTitles:@[@"确定"] cancelTitle:nil style:UIAlertControllerStyleAlert completion:nil];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    if (indexPath.row == _mediaArray.count) {
        switch (_type) {
            case LLImageTypePhoto:
                [self openAlbum];
                break;
            case LLImageTypeCamera:
                [self openCamera];
                break;
            case LLImageTypePhotoAndCamera:
            {
                LLActionSheetView *alert = [[LLActionSheetView alloc]initWithTitleArray:@[@"相册",@"相机"] andShowCancel: YES];
                alert.ClickIndex = ^(NSInteger index) {
                    if (index == 1){
                        [weakSelf openAlbum];
                    }else if (index == 2){
                        [weakSelf openCamera];
                    }
                };
                [alert show];
                break;
            }
            case LLImageTypeVideoTape:
                [self openVideotape];
                break;
            case LLImageTypeVideo:
                [self openVideo];
                break;
            default:
            {                
                LLActionSheetView *alert = [[LLActionSheetView alloc]initWithTitleArray:@[@"相册", @"相机", @"录像", @"视频"] andShowCancel: YES];                
                alert.ClickIndex = ^(NSInteger index) {
                    NSLog(@"%zd",index);
                    if (index == 4) {
                        [weakSelf openVideo];
                    }else if (index == 3){
                        [weakSelf openVideotape];
                    }else if (index == 2){
                        [weakSelf openCamera];
                    }else if (index == 1){
                        [weakSelf openAlbum];
                    }
                };
                [alert show];
            }
                break;
        }
    }else{
        // 展示媒体
        _photos = [NSMutableArray array];
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        browser.displayActionButton = NO;
        browser.alwaysShowControls = NO;
        browser.displaySelectionButtons = NO;
        browser.zoomPhotosToFill = YES;
        browser.displayNavArrows = NO;
        browser.startOnGrid = NO;
        browser.enableGrid = YES;
        for (LLImagePickerModel *model in _mediaArray) {
            MWPhoto *photo = [MWPhoto photoWithImage:model.image];
            photo.caption = model.name;
            if (model.isVideo) {
                if (model.mediaURL) {
                    photo.videoURL = model.mediaURL;
                }else {
                    photo = [photo initWithAsset:model.asset targetSize:CGSizeZero];
                }
            }else if (model.imageUrlString) {
                photo = [MWPhoto photoWithURL:[NSURL URLWithString:model.imageUrlString]];
            }
            [_photos addObject:photo];
        }
        [browser setCurrentPhotoIndex:indexPath.row];
        [[self viewController].navigationController pushViewController:browser animated:YES];
    }
}

#pragma mark - <MWPhotoBrowserDelegate>

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}

#pragma mark - 布局

///重新布局collectionview
- (void)layoutCollection {
    
    NSInteger allImageCount = _showAddButton ?(_mediaArray.count == _maxImageSelected ? _mediaArray.count : _mediaArray.count + 1 ): _mediaArray.count;
    NSInteger maxRow = (allImageCount - 1) / countOfRow + 1;
    _collectionView.height = allImageCount == 0 ? 0 : maxRow * self.collectionView.width/countOfRow;
    
    self.height = _collectionView.height;
    //block回调
    !_block ?  : _block(_collectionView.height);
    !_backBlock ?  : _backBlock(_mediaArray);
    
    [_collectionView reloadData];
}

#pragma mark - actions

/** 相册 */
- (void)openAlbum {
    NSInteger count = 0;
    if (!_allowMultipleSelection) {
        count = _maxImageSelected - (_mediaArray.count - _selectedImageModels.count);
    }else {
        count = _maxImageSelected - _mediaArray.count;
    }
    TZImagePickerController *imagePickController = [[TZImagePickerController alloc] initWithMaxImagesCount:count delegate:self];
    //是否 在相册中显示拍照按钮
    imagePickController.allowTakePicture = NO;
    //是否可以选择显示原图
    imagePickController.allowPickingOriginalPhoto = NO;
    //是否 在相册中可以选择视频
    imagePickController.allowPickingVideo = _allowPickingVideo;
    if (!_allowMultipleSelection) {
        imagePickController.selectedAssets = _selectedImageAssets;
    }
    
    [[self viewController] presentViewController:imagePickController animated:YES completion:nil];
}

/** 相机 */
- (void)openCamera {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        
     [[self viewController] presentViewController:picker animated:YES completion:nil];

    }else{
        [UIAlertController showAlertWithTitle:@"该设备不支持拍照" message:nil actionTitles:@[@"确定"] cancelTitle:nil style:UIAlertControllerStyleAlert completion:nil];
    }
}

/** 录像 */
- (void)openVideotape {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSArray * mediaTypes =[UIImagePickerController  availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = mediaTypes;
        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        picker.videoQuality = UIImagePickerControllerQualityTypeMedium; //录像质量
        picker.videoMaximumDuration = 600.0f; //录像最长时间
    } else {
        [UIAlertController showAlertWithTitle:@"当前设备不支持录像" message:nil actionTitles:@[@"确定"] cancelTitle:nil style:UIAlertControllerStyleAlert completion:nil];
    }
    
     [[self viewController] presentViewController:picker animated:YES completion:nil];
    
}

/** 视频 */
- (void)openVideo {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
    picker.allowsEditing = YES;
    
    [[self viewController] presentViewController:picker animated:YES completion:nil];
}


#pragma mark - TZImagePickerController Delegate
//处理从相册单选或多选的照片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
    if ([_selectedImageAssets isEqualToArray: assets]) {
        return;
    }
    //每次回传的都是所有的asset 所以要初始化赋值
    if (!_allowMultipleSelection) {
        _selectedImageAssets = [NSMutableArray arrayWithArray:assets];
    }
    NSMutableArray *models = [NSMutableArray array];
    //2次选取照片公共存在的图片
    NSMutableArray *temp = [NSMutableArray array];
    NSMutableArray *temp2 = [NSMutableArray array];
    for (NSInteger index = 0; index < assets.count; index++) {
        PHAsset *asset = assets[index];
        [[LLImagePickerManager manager] getMediaInfoFromAsset:asset completion:^(NSString *name, id pathData) {
            
            LLImagePickerModel *model = [[LLImagePickerModel alloc] init];
            model.name = name;
            model.uploadType = pathData;
            model.image = photos[index];
            //区分gif
            if ([NSString isGifWithImageData:pathData]) {
                model.image = [UIImage ll_setGifWithData:pathData];
            }
                        
            if (!_allowMultipleSelection) {
                //用数组是否包含来判断是不成功的。。。
                for (LLImagePickerModel *md in _selectedImageModels) {
                    // 新方法
                    if ([md isEqual:model] ) {
                        [temp addObject:md];
                        [temp2 addObject:model];
                        break;
                    }
                }
            }
            
            [models addObject:model];
            
            if (index == assets.count - 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!_allowMultipleSelection) {
                        //删除公共存在的，剩下的就是已经不存在的
                        [_selectedImageModels removeObjectsInArray:temp];
                        //总媒体数组删先除掉不存在，这样不会影响排列的先后顺序
                        [_mediaArray removeObjectsInArray:_selectedImageModels];
                        //将这次选择的进行赋值，深复制
                        _selectedImageModels = [models mutableCopy];
                        //这次选择的删除公共存在的，剩下的就是新添加的
                        [models removeObjectsInArray:temp2];
                        //总媒体数组中在后面添加新数据
                        [_mediaArray addObjectsFromArray:models];
                    }else {
                        [_selectedImageModels addObjectsFromArray:models];
                        [_mediaArray addObjectsFromArray:models];
                    }
                    
                    [self layoutCollection];
                });
            }
        }];
    }
}
///选取视频后的回调
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    [[LLImagePickerManager manager] getMediaInfoFromAsset:asset completion:^(NSString *name, id pathData) {
        LLImagePickerModel *model = [[LLImagePickerModel alloc] init];
        model.name = name;
        model.uploadType = pathData;
        model.image = coverImage;
        model.isVideo = YES;
        model.asset = asset;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!_allowMultipleSelection) {
                //用数组是否包含来判断是不成功的。。。
                for (LLImagePickerModel *tmp in _selectedVideoModels) {
                    if ([tmp isEqual:model]) {
                        return ;
                    }
                }
            }
            [_selectedVideoModels addObject:model];
            [_mediaArray addObject:model];
            [self layoutCollection];
        });
    }];
}

#pragma mark - UIImagePickerController Delegate
///拍照、选视频图片、录像 后的回调（这种方式选择视频时，会自动压缩，但是很耗时间）
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    NSURL *imageAssetURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    ///视频 和 录像
    if ([mediaType isEqualToString:@"public.movie"]) {
        
        NSURL *videoAssetURL = [info objectForKey:UIImagePickerControllerMediaURL];
        PHAsset *asset;
        //录像没有原图 所以 imageAssetURL 为nil
        if (imageAssetURL) {
            PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:@[imageAssetURL] options:nil];
            asset = [result firstObject];
        }
        [[LLImagePickerManager manager] getVideoPathFromURL:videoAssetURL PHAsset:asset enableSave:NO completion:^(NSString *name, UIImage *screenshot, id pathData) {
            LLImagePickerModel *model = [[LLImagePickerModel alloc] init];
            model.image = screenshot;
            model.name = name;
            model.uploadType = pathData;
            model.isVideo = YES;
            model.mediaURL = videoAssetURL;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_mediaArray addObject:model];
                [self layoutCollection];
            });
        }];
    }
    
    else if ([mediaType isEqualToString:@"public.image"]) {
        
        UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
        //如果 picker 没有设置可编辑，那么image 为 nil
        if (image == nil) {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        PHAsset *asset;
        //拍照没有原图 所以 imageAssetURL 为nil
        if (imageAssetURL) {
            PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:@[imageAssetURL] options:nil];
            asset = [result firstObject];
        }
        [[LLImagePickerManager manager] getImageInfoFromImage:image PHAsset:asset completion:^(NSString *name, NSData *data) {
            LLImagePickerModel *model = [[LLImagePickerModel alloc] init];
            model.image = image;
            model.name = name;
            model.uploadType = data;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_mediaArray addObject:model];
                [self layoutCollection];
            });
        }];
    }
}


@end
