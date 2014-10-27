//
//  TCLSoundPlayer.h
//  TestCatalog
//
//  Created by Могрин on 10/20/14.
//  Copyright (c) 2014 Могрин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>

@interface TCLSoundPlayer : NSObject

@property (nonatomic,retain) NSMutableDictionary *audioFiles;

+ (TCLSoundPlayer *)sharedPlayer;
+ (void)playSound:(NSString*)soundName;

- (void)cacheWithFiles:(NSArray *)sounds;
- (void)playFile:(NSString*)soundFileName volume:(CGFloat)volume loops:(NSInteger)numberOfLoops;
- (void)resumePlaing:(NSString*)soundFileName;
- (void)resumePlaing:(NSString*)soundFileName withVolume:(CGFloat)volume;
- (void)pausePlaing:(NSString*)soundFileName;
- (void)stopPlaing:(NSString*)soundFileName;
- (BOOL)isPlaying:(NSString*)soundFileName;

@end
