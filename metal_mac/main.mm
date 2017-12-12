//
//  main.m
//  metal_mac
//
//  Created by Tec GSQ on 27/11/2017.
//  Copyright © 2017 Tec GSQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <gtest/gtest.h>
#include "syncedmem.hpp"
#include <assert.h>
//#include "mtlpp.hpp"
#include "caffe/caffe.hpp"
#include "test_caffe_main.hpp"
//using namespace caffe;

#include <numeric>
#include "ImageReader.h"


caffe::Net<float> *_net;

int main(int argc, char** argv) {

    

    caffe::CPUTimer timer;
    
    caffe::Caffe::Get().set_mode(caffe::Caffe::CPU);
    
    timer.Start();
    NSString *modle_path = @"style.protobin"; //FilePathForResourceName(@"style", @"protobin");
    _net = new caffe::Net<float>([modle_path UTF8String], caffe::TEST);
    NSString *weight_path = @"a1.caffemodel";//FilePathForResourceName(@"weight", @"caffemodel");
    _net->CopyTrainedLayersFrom([weight_path UTF8String]);
    caffe::Blob<float> *input_layer = _net->input_blobs()[0];
    timer.Stop();
    
    
    LOG(INFO) << "Input layer info: channels:" << input_layer->channels()
    << " width: " << input_layer->width() << " Height:" << input_layer->height();
    
    NSString *test_file_path = @"HKU.jpg"; //FilePathForResourceName(@"test_image", @"jpg");
    timer.Start();
    std::vector<float> mean({0, 0, 0});
    if(! ReadImageToBlob(test_file_path, mean, input_layer)) {
        LOG(INFO) << "ReadImageToBlob failed";
        return 0;
    }
    
    
    _net->Forward();
    timer.Stop();
    
    std::cout << "The time used is hahahaha" << timer.MicroSeconds() << std::endl;
    
    
    
    //  code for style transfer
    caffe::Blob<float> *output_layer = _net->output_blobs()[0];
    FILE *f = fopen("input.ppm", "wb");
    fprintf(f, "P6\n%i %i 255\n", input_layer->width(), input_layer->width());
    for (int y = 0; y < input_layer->width(); y++) {
        for (int x = 0; x < input_layer->width(); x++) {
            fputc(output_layer->cpu_data()[y * input_layer->width() + x], f);   // 0 .. 255
            fputc(output_layer->cpu_data()[y * input_layer->width() + x + input_layer->width() * input_layer->width()], f); // 0 .. 255
            fputc(output_layer->cpu_data()[y * input_layer->width() + x + 2 * input_layer->width() * input_layer->width()], f);  // 0 .. 255
            //std::cout << output_layer->cpu_data()[y * input_layer->width() + x]<< std::endl;   // 0 .. 255
            //std::cout <<output_layer->cpu_data()[y * input_layer->width() + x + input_layer->width() * input_layer->width()] << std::endl; // 0 .. 255
            //std::cout << output_layer->cpu_data()[y * input_layer->width() + x + 2 * input_layer->width() * input_layer->width()]<< std::endl;  // 0 .. 255
        }
    }
    fclose(f);
    
    delete _net;
    int i = 9;
    
    for (i=0; i<10;++i){
        cout<<'gg'<<endl;
    }
    
}
