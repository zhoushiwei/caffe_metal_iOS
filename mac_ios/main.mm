//
//  main.m
//  metal_mac
//
//  Created by Tec GSQ on 27/11/2017.
//  Copyright © 2017 Tec GSQ. All rights reserved.
//

//#import <Foundation/Foundation.h>
////#include <gtest/gtest.h>
//#include "syncedmem.hpp"
//#include <assert.h>
////#include "mtlpp.hpp"
//#include "caffe/caffe.hpp"
//#include "test_caffe_main.hpp"
////using namespace caffe;
//
//#include <numeric>
//#include "ImageReader.h"
//
//
//caffe::Net<float> *__net;

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char** argv) {
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    
    /*caffe::CPUTimer timer;
    
    caffe::Caffe::Get().set_mode(caffe::Caffe::GPU);
    
    timer.Start();
    NSString *modle_path = FilePathForResourceName(@"style", @"protobin");//@"style.protobin"; //
    __net = new caffe::Net<float>([modle_path UTF8String], caffe::TEST);
    NSString *weight_path = FilePathForResourceName(@"a1", @"caffemodel");//@"a1.caffemodel";//
    __net->CopyTrainedLayersFrom([weight_path UTF8String]);
    caffe::Blob<float> *input_layer = __net->input_blobs()[0];
    timer.Stop();
    
    
    LOG(INFO) << "Input layer info: channels:" << input_layer->channels()
    << " width: " << input_layer->width() << " Height:" << input_layer->height();
    
    NSString *test_file_path = FilePathForResourceName(@"HKU", @"jpg"); //@"HKU.jpg"; //FilePathForResourceName(@"test_image", @"jpg");
    timer.Start();
    std::vector<float> mean({0, 0, 0});
    if(! ReadImageToBlob(test_file_path, mean, input_layer)) {
        LOG(INFO) << "ReadImageToBlob failed";
        return 0;
    }
//    
    
    __net->Forward();
    timer.Stop();
    
    std::cout << "The time used is hahahaha" << timer.MicroSeconds() << std::endl;
    
    
    
    //  code for style transfer
    caffe::Blob<float> *output_layer = __net->output_blobs()[0];
    FILE *f = fopen("input.ppm", "wb");
//    fprintf(f, "P6\n%i %i 255\n", input_layer->width(), input_layer->width());
    for (int y = 0; y < input_layer->width(); y++) {
        for (int x = 0; x < input_layer->width(); x++) {
            std::cout << output_layer->cpu_data()[y * input_layer->width() + x]<< std::endl;   // 0 .. 255
            std::cout <<output_layer->cpu_data()[y * input_layer->width() + x + input_layer->width() * input_layer->width()] << std::endl; // 0 .. 255
            std::cout << output_layer->cpu_data()[y * input_layer->width() + x + 2 * input_layer->width() * input_layer->width()]<< std::endl;  // 0 .. 255
        }
    }
    fclose(f);
    
    delete __net;
    int i = 9;
    
    for (i=0; i<10;++i){
//        cout<<'gg'<<endl;
    }*/
    
}

