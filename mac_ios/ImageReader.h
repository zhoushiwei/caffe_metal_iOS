//
//  ImageReader.h
//  CaffeSimple
//
//  Created by Wenbo Yang on 2017/2/3.
//  Copyright © 2017年 com.yangwenbo. All rights reserved.
//

#ifndef ImageReader_h
#define ImageReader_h

#include "caffe/caffe.hpp"
#import <UIKit/UIKit.h>
NSString* FilePathForResourceName(NSString* name, NSString* extension);

bool ReadImageToBlob(NSString *file_name,
                     const std::vector<float> &mean,
                     caffe::Blob<float>* input_layer,
                     UIImage* img_obj=nil);

bool ReadCameraToBlob(const std::vector<float> &mean,
                      caffe::Blob<float>* input_layer,
                      UIImage* img_obj=nil);
CGImageRef imageWithImage(CGImageRef image, CGSize newSize);
#endif /* ImageReader_h */
