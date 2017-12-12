//
//  tanh_layer.metal
//  metal_mac
//
//  Created by Tec GSQ on 30/11/2017.
//  Copyright © 2017 Tec GSQ. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;


kernel void
TanHForward(const device int* int__ [[ buffer(0) ]],
            const device float *in [[buffer(1)]],
            device float *out [[buffer(2)]],
            uint2 gid [[ thread_position_in_grid ]],
            uint2 tpg [[ threads_per_grid ]])
{
    for (int index = gid.x; index < int__[0]; index += tpg.x){
        out[index] = tanh(in[index]);
    }
}

kernel void
BNLLForward(const device int* int__ [[ buffer(0) ]],
            const device float *in [[buffer(1)]],
            device float *out [[buffer(2)]],
            uint2 gid [[ thread_position_in_grid ]],
            uint2 tpg [[ threads_per_grid ]])
{
    for (int index = gid.x; index < int__[0]; index += tpg.x){
        out[index] = in[index] > 0 ? in[index] + log(1. + exp(-in[index])) : log(1. + exp(in[index]));
    }
}


kernel void
ReLUForward(const device int* int__ [[ buffer(0) ]],
            const device float* float__ [[buffer(1)]],
            const device float *in [[buffer(2)]],
            device float *out [[buffer(3)]],
            uint2 gid [[ thread_position_in_grid ]],
            uint2 tpg [[ threads_per_grid ]])
{
    for (int index = gid.x; index < int__[0]; index += tpg.x){
        out[index] = in[index] > 0 ? in[index] : in[index] * float__[0];
    }
}







kernel void
metal_Saxpy(const device int* int__ [[ buffer(0) ]],
            const device int* float__ [[ buffer(1) ]],
            const device float *in [[buffer(2)]],
            device float *out [[buffer(3)]],
            uint2 gid [[ thread_position_in_grid ]],
            uint2 tpg [[ threads_per_grid ]])
{
    for (int index = gid.x; index < int__[0]; index += tpg.x){
        out[index] = tanh(in[index]);
    }
}


kernel void
metal_Sscal(const device int* int__ [[ buffer(0) ]],
            const device int* float__ [[ buffer(1) ]],
            const device float *in [[buffer(2)]],
            device float *out [[buffer(3)]],
            uint2 gid [[ thread_position_in_grid ]],
            uint2 tpg [[ threads_per_grid ]])
{
    for (int index = gid.x; index < int__[0]; index += tpg.x){
        out[index] = tanh(in[index]);
    }
}
