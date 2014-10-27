//
//  TCLSoundPlayer.m
//  TestCatalog
//
//  Created by Могрин on 10/20/14.
//  Copyright (c) 2014 Могрин. All rights reserved.
//


#import "TCLSoundPlayer.h"

@implementation TCLSoundPlayer

@synthesize audioFiles;

static TCLSoundPlayer * sharedPlayer = NULL;

+ (TCLSoundPlayer *) sharedPlayer {
    if ( !sharedPlayer || sharedPlayer == NULL ) {
        sharedPlayer = [[TCLSoundPlayer alloc] init];
    }
    
    return sharedPlayer;
}

+ (void)playSound:(NSString*)soundName {
    SystemSoundID volleyFile;
    NSString *volleyPath = [[NSBundle mainBundle] pathForResource:soundName ofType:nil];
    CFURLRef volleyURL = (CFURLRef ) CFBridgingRetain([NSURL fileURLWithPath:volleyPath]); 
    AudioServicesCreateSystemSoundID (volleyURL, &volleyFile);
    AudioServicesPlaySystemSound(volleyFile);
}

- (void)cacheWithFiles:(NSArray *)sounds {
    NSBundle *mainBundle = [NSBundle mainBundle]; //read files
    NSError *error;
    
    self.audioFiles = [NSMutableDictionary dictionary];
    
    for (NSString *fileName in sounds) {
        NSURL *soundURL = [NSURL fileURLWithPath:[mainBundle pathForResource:fileName ofType:nil]];
        AVAudioPlayer *myAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
        
        if (myAudioPlayer) {
            [myAudioPlayer prepareToPlay];
            [audioFiles setObject:myAudioPlayer forKey:fileName];
        } else {
            NSLog(@"Error in file(%@): %@", fileName, [error localizedDescription]);
        }
    }
}

- (void)playFile:(NSString*)soundFileName volume:(CGFloat)volume loops:(NSInteger)numberOfLoops {
    AVAudioPlayer *sound = [audioFiles objectForKey:soundFileName];
    sound.volume = volume;
    sound.numberOfLoops = numberOfLoops;
    sound.currentTime = 0.0f;
    [sound play];
}

- (void)resumePlaing:(NSString*)soundFileName {
    AVAudioPlayer *sound = [audioFiles objectForKey:soundFileName];
    [sound play];
}

- (void)resumePlaing:(NSString*)soundFileName withVolume:(CGFloat)volume {
    AVAudioPlayer *sound = [audioFiles objectForKey:soundFileName];
    sound.volume = volume;
    [sound play];
}

- (void)pausePlaing:(NSString*)soundFileName {
    AVAudioPlayer *sound = [audioFiles objectForKey:soundFileName];
    [sound pause];
}

- (void)stopPlaing:(NSString*)soundFileName {
    AVAudioPlayer *sound = [audioFiles objectForKey:soundFileName];
    [sound stop];
}

- (BOOL)isPlaying:(NSString*)soundFileName {
    AVAudioPlayer *sound = [audioFiles objectForKey:soundFileName];
    return sound.playing;
}

@end
