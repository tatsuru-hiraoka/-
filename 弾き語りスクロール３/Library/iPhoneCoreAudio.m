/*
 *  iPhoneCoreAudio.c
 *
 *  Created by nagano on 09/07/20.
 *
 */

#include "iPhoneCoreAudio.h"

AudioStreamBasicDescription AUCanonicalASBD(Float64 sampleRate, 
                                            UInt32 channel){
    AudioStreamBasicDescription audioFormat;
    audioFormat.mSampleRate         = sampleRate;
    audioFormat.mFormatID           = kAudioFormatLinearPCM;
    audioFormat.mFormatFlags        = kAudioFormatFlagIsFloat | kAudioFormatFlagsNativeEndian | kAudioFormatFlagIsPacked | kAudioFormatFlagIsNonInterleaved;
    audioFormat.mChannelsPerFrame   = channel;
    audioFormat.mBytesPerPacket     = sizeof(Float32);
    audioFormat.mBytesPerFrame      = sizeof(Float32);
    audioFormat.mFramesPerPacket    = 1;
    audioFormat.mBitsPerChannel     = 8 * sizeof(Float32);
    audioFormat.mReserved           = 0;
    return audioFormat;
}


AudioStreamBasicDescription CanonicalASBD(Float64 sampleRate, 
                                          UInt32 channel){
    AudioStreamBasicDescription audioFormat;
    audioFormat.mSampleRate         = sampleRate;
    audioFormat.mFormatID           = kAudioFormatLinearPCM;
    audioFormat.mFormatFlags        = kAudioFormatFlagIsFloat | kAudioFormatFlagsNativeEndian | kAudioFormatFlagIsPacked | kAudioFormatFlagIsNonInterleaved;
    audioFormat.mChannelsPerFrame   = channel;
    audioFormat.mBytesPerPacket     = sizeof(Float32) * audioFormat.mChannelsPerFrame;
    audioFormat.mBytesPerFrame      = sizeof(Float32) * audioFormat.mChannelsPerFrame;
    audioFormat.mFramesPerPacket    = 1;
    audioFormat.mBitsPerChannel     = 8 * sizeof(Float32);
    audioFormat.mReserved           = 0;
    return audioFormat;
}