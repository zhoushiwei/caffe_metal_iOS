//
//  ViewController.h
//  CaffeSimple
//
//  Created by Wenbo Yang on 2017/2/3.
//  Copyright © 2017年 com.yangwenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UINavigationControllerDelegate,
                                              UIImagePickerControllerDelegate,
                                              UIActionSheetDelegate>

#pragma mark Console
@property (nonatomic,strong) IBOutlet UITextView *console;
@property (strong, nonatomic) IBOutlet UIImageView *style_viewer;

@property (nonatomic,strong) IBOutlet UIImageView *test_image;

#pragma mark ClickEvent
- (IBAction)RunCaffeModel:(UIButton *)btn;
- (IBAction)SelectImage:(UIButton *)sender;
- (IBAction)SelectStyle:(UIButton *)styler;
- (IBAction)SaveImage:(UIButton *)saver;

@property  NSString * currentImage;
@property  NSString * transferredImage;
@property  NSString * styleImage;
@property  NSString * model_path;
@property  UIImage  * tmp_image;
- (void)removeImage:(NSString *)filename;

@end
