# Caffe_metal_iOS

Caffe-iOS is modifed from the master version of Caffe, a popular deep learning platform. It is designed for those inference tasks on mobile devices in iOS.

* Plug-in-and-play: General models can be directly compiled and run with corresponding parameter files. All files required are exactly what needed in general Caffe.
* Memory-optimized: Specific memory optimization for single inference tasks. Reduces 95% memory requirment on ResNet related tasks.
* GPU-accelerated: Core math computations are equipped with GPU acceleration (Metal2 Performance Shaders). Raw implementation without careful optimization has already 50% performance enhancement.


## Tested Platforms
* macOS 10.13
* iOS 11.0+

## Example: Neural Style Transfer on iOS
1. Open the Xcode project and setup with your own developer id and buddle.
2. Chosse "MacOS" as target and run the desktop version
3. Choose "iOS devicecs" as target and run the iOS version in iPhone, currently only iPhone 8 has been tested.
4. Choose "ios_sim" to run simulator, which may lead to some problems with insufficient simulation.

## TODO:
- [ ] Complete full metal support of math functions as well as specific operations
- [ ] Optimization of metal implementation
- [ ] Provide libdnn suppport for Convolution and Deconvolution
- [ ] Implement half precision floating point calculation





