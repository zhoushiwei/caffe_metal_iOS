//
//  ViewController.m
//  CaffeSimple
//
//  Created by Wenbo Yang on 2017/2/3.
//  Copyright © 2017年 com.yangwenbo. All rights reserved.
//

#import "ViewController.h"

#include <numeric>
#include "caffe.hpp"
#include "ImageReader.h"

@interface ViewController ()

@end

@implementation ViewController

caffe::Net<float> *_net;


- (void)viewDidLoad {
    [super viewDidLoad];
    caffe::Caffe::Get().set_mode(caffe::Caffe::GPU);
    // Do any additional setup after loading the view, typically from a nib.
    NSString *test_file_path = FilePathForResourceName(@"HKU", @"jpg");
    UIImage *image = [UIImage imageWithContentsOfFile:test_file_path];
    [_test_image setImage:image];
    self.currentImage = test_file_path;
    test_file_path = FilePathForResourceName(@"candy-style", @"jpg");
    self.styleImage = test_file_path;
    image = [UIImage imageWithContentsOfFile:self.styleImage];
    [self.style_viewer setImage:image];
    self.model_path = [NSString stringWithUTF8String:"a1"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
}

- (void)viewDidAppear:(BOOL)animated {
    caffe::CPUTimer timer;
    timer.Start();
//    int memory = (int)[NSProcessInfo processInfo].physicalMemory / (1024*1024);
    NSString *model_path = FilePathForResourceName(@"style", @"protobin");
//    if (memory < 1500){// for phsical memory smaller about 1GB
//        model_path = FilePathForResourceName(@"style5", @"protobin");
//    }else{
//        model_path = FilePathForResourceName(@"style", @"protobin");
//    }
   // NSString *model_path = FilePathForResourceName(@"style", @"protobin");
    _net = new caffe::Net<float>([model_path UTF8String], caffe::TEST);
    NSString *weight_path = FilePathForResourceName(@"a1", @"caffemodel");
    _net->CopyTrainedLayersFrom([weight_path UTF8String]);
//    caffe::Blob<float> *input_layer = _net->input_blobs()[0];
    timer.Stop();
    [_console insertText:[NSString stringWithFormat:@"%fms\n", timer.MilliSeconds()]];
//    LOG(INFO) << "Input layer info: channels:" << input_layer->channels()
//    << " width: " << input_layer->width() << " Height:" << input_layer->height();
    LOG(INFO) << [NSProcessInfo processInfo].physicalMemory / (1024*1024);
    
}

- (void)RunCaffeModel:(UIButton *)btn {
    
    // loading correspoinding models
    [_console insertText:@"\nCaffe model loading...\n"];
    
    NSString *weight_path = FilePathForResourceName(self.model_path, @"caffemodel");
    _net->CopyTrainedLayersFrom([weight_path UTF8String]);
    
    caffe::CPUTimer timer;
    [_console insertText:@"\nCaffe inferring...\n"];
    
    caffe::Blob<float> *input_layer = _net->input_blobs()[0];
//    NSString *test_file_path = FilePathForResourceName(@"t3", @"jpg");
    timer.Start();
    std::vector<float> mean({0.0, 0.0, 0.0});
//    if (!self.currentImage){
        if(! ReadImageToBlob(self.currentImage, mean, input_layer)) {
            LOG(INFO) << "ReadImageToBlob failed";
            [_console insertText:@"ReadImageToBlob failed"];
            return;
        }
//    }else{
//        if(! ReadCameraToBlob(mean, input_layer, self.currentImage)) {
//            LOG(INFO) << "ReadImageToBlob failed";
//            [_console insertText:@"ReadImageToBlob failed"];
//            return;
//        }
//    }
    for(int i = 0; i < 15; ++i) {
        @autoreleasepool{
            _net->Forward();
        }
        std::cout << "gg come to " << i << std::endl;
    }
    
    
    timer.Stop();
    
    
    //  code for style transfer
    caffe::Blob<float> *output_layer = _net->output_blobs()[0];
    
    
    std::cout << "The time used is " <<timer.MilliSeconds() <<std::endl;
     std::cout << "The time used is " <<timer.MilliSeconds() <<std::endl;
     std::cout << "The time used is " <<timer.MilliSeconds() <<std::endl;
     std::cout << "The time used is " <<timer.MilliSeconds() <<std::endl;
    std::cout << "The time used is " <<timer.MilliSeconds() <<std::endl;
    std::cout << "The time used is " <<timer.MilliSeconds() <<std::endl;
    std::cout << "The time used is " <<timer.MilliSeconds() <<std::endl;
    std::cout << "The time used is " <<timer.MilliSeconds() <<std::endl;
    std::cout << "The time used is " <<timer.MilliSeconds() <<std::endl;
    std::cout << "The time used is " <<timer.MilliSeconds() <<std::endl;
    std::cout << "The time used is " <<timer.MilliSeconds() <<std::endl;
    std::cout << "The time used is " <<timer.MilliSeconds() <<std::endl;
    std::cout << "The time used is " <<timer.MilliSeconds() <<std::endl;
    std::cout << "The time used is " <<timer.MilliSeconds() <<std::endl;
    std::cout << "The time used is " <<timer.MilliSeconds() <<std::endl;
    std::cout << "The time used is " <<timer.MilliSeconds() <<std::endl;
    std::cout << "The time used is " <<timer.MilliSeconds() <<std::endl;
    std::cout << "The time used is " <<timer.MilliSeconds() <<std::endl;
    std::cout << "The time used is " <<timer.MilliSeconds() <<std::endl;
    std::cout << "The time used is " <<timer.MilliSeconds() <<std::endl;
    //[_console insertText:[NSString stringWithFormat:@"Inference time (%fms): \n", timer.MilliSeconds()]];

    LOG(INFO) << "size of output" <<output_layer->shape_string();
    size_t width = output_layer->shape()[2];
    size_t height = output_layer->shape()[3];
    LOG(INFO) << width;
    LOG(INFO) << height;
    size_t bytesPerPixel = 4;
    //4 bytes per pixel (R, G, B, A) = 8 bytes for a 1x2 pixel image:
    unsigned char* rawData = new unsigned char[4 * width * height];
//    for (int i = 0; i < 256*256*3; i++) {
//        printf("%f," , output_layer->cpu_data()[i]);
//    }

    for (int i = 0; i < width; ++i) {
        for (int j = 0; j < height; ++j){
            size_t index = (i * width + j) * 4;
            size_t index_data = i*width + j;
            rawData[index] = (unsigned char)output_layer->cpu_data()[index_data];
            rawData[index+1] = (unsigned char)output_layer->cpu_data()[index_data+width*height];
            rawData[index+2] = (unsigned char)output_layer->cpu_data()[index_data+2*width*height];
            rawData[index+3] = 255;
//            LOG(INFO) << index_data;
        }
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    size_t bytesPerRow = bytesPerPixel * width;
    size_t bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast);

    CGImageRef cgImage = CGBitmapContextCreateImage(context);
    //This is your image:
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    //Don't forget to clean up:
    CGImageRelease(cgImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    // save image
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSData * binaryImageData = UIImagePNGRepresentation(image);

    [binaryImageData writeToFile:[basePath stringByAppendingPathComponent:@"output.png"] atomically:YES];
    
    delete _net;
    
    for (int i=0; i<10;++i){
        std::cout<<'gg'<<std::endl;
    }
    
    NSString *model_path = FilePathForResourceName(@"style", @"protobin");
    _net = new caffe::Net<float>([model_path UTF8String], caffe::TEST);
    
    [_test_image setImage:image];
    self.transferredImage =[basePath stringByAppendingPathComponent:@"output.png"];
    //NSMutableArray * myArray = [NSMutableArray array];
//
//
    
}

- (IBAction)SelectImage:(UIButton *)sender {
//    UIActionSheet *selecter = [[UIActionSheet alloc] initWithTitle:@"Select image option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
//                            @"camera",
//                            @"gallery",
//                            nil];
//    selecter.delegate = self;
//    selecter.tag = 1;
//    [selecter showInView:self.view];
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // remove cached data
    if (self.currentImage){
        [self removeImage:[NSString stringWithFormat:@"%@.png",@"cached"]];
    }
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSData *imageData = UIImagePNGRepresentation(chosenImage);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",@"cached"]];
    
    NSLog(@"pre writing to file");
    if (![imageData writeToFile:imagePath atomically:NO])
    {
        NSLog(@"Failed to cache image data to disk");
    }
    else
    {
        NSLog(@"the cachedImagedPath is %@",imagePath);
    }
    // release data
    self.currentImage = imagePath;
    UIImage* image = [UIImage imageWithContentsOfFile:self.currentImage];
    [_test_image setImage:image];
    delete _net;
    NSString *model_path = FilePathForResourceName(@"style", @"protobin");
    _net = new caffe::Net<float>([model_path UTF8String], caffe::TEST);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    self.model_path = [NSString stringWithUTF8String:"a1"];
                    self.styleImage = FilePathForResourceName(@"candy-style", @"jpg");
                    break;
                case 1:
                    self.model_path = [NSString stringWithUTF8String:"a3"];
                    self.styleImage = FilePathForResourceName(@"cubist-style", @"jpg");
                    break;
                case 2:
                    self.model_path = [NSString stringWithUTF8String:"a4"];
                    self.styleImage = FilePathForResourceName(@"edtaonisl", @"jpg");
                    break;
                case 3:
                    self.model_path = [NSString stringWithUTF8String:"a5"];
                    self.styleImage = FilePathForResourceName(@"fur-style", @"jpg");
                    break;
                case 4:
                    self.model_path = [NSString stringWithUTF8String:"a7"];
                    self.styleImage = FilePathForResourceName(@"hundertwasser-style", @"jpg");
                    break;
                case 5:
                    self.model_path = [NSString stringWithUTF8String:"a8"];
                    self.styleImage = FilePathForResourceName(@"hokusai-style", @"jpg");
                    break;
                case 6:
                    self.model_path = [NSString stringWithUTF8String:"a9"];
                    self.styleImage = FilePathForResourceName(@"kandinsky", @"jpg");
                    break;
                case 7:
                    self.model_path = [NSString stringWithUTF8String:"a10"];
                    self.styleImage = FilePathForResourceName(@"scream-style", @"jpg");
                    break;
                case 8:
                    self.model_path = [NSString stringWithUTF8String:"a11"];
                    self.styleImage = FilePathForResourceName(@"starry-style", @"jpg");
                    break;
                case 9:
                    self.model_path = [NSString stringWithUTF8String:"a12"];
                    self.styleImage = FilePathForResourceName(@"starrynight-style", @"jpg");
                    break;

                default:
                    break;
            }
            break;
        }
        default:
            break;
         
    }
    UIImage* image = [UIImage imageWithContentsOfFile:self.styleImage];
    [self.style_viewer setImage:image];
}

- (IBAction)SelectStyle:(UIButton *)styler{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select style option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Candy",
                            @"cubist",
                            @"edtaonisl",
                            @"Fur",
                            @"hundertwasser",
                            @"hokusai",
                            @"kandinsky",
                            @"The Scream",
                            @"Starry Night",
                            @"starrynight",
                            nil];
    popup.delegate = self;
    popup.tag = 1;
    [popup showInView:self.view];
}

- (IBAction)SaveImage:(UIButton *)saver {
    if (self.currentImage && self.transferredImage){
        // save the image to gallery
//        NSLog(self.currentImage);
        UIImage *original_image = [UIImage imageWithContentsOfFile:self.currentImage];
        UIImage *output_image = [UIImage imageWithContentsOfFile:self.transferredImage];
        UIImageWriteToSavedPhotosAlbum(original_image, nil, nil, nil);
         UIImageWriteToSavedPhotosAlbum(output_image, nil, nil, nil);
        UIAlertView *savedSuccessFullyAlert = [[UIAlertView alloc] initWithTitle:@"Info:" message:@"Image successfully saved" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
                [savedSuccessFullyAlert show];
    }
}

- (void)removeImage:(NSString *)filename
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:filename];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
//    if (success) {
//        UIAlertView *removedSuccessFullyAlert = [[UIAlertView alloc] initWithTitle:@"Congratulations:" message:@"Successfully removed" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
//        [removedSuccessFullyAlert show];
//    }
//    else
//    {
//        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
//    }
}

@end

