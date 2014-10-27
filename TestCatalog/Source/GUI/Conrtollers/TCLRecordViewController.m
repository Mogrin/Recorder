//
//  TCLRecordViewController.m
//  TestCatalog
//
//  Created by Могрин on 10/22/14.
//  Copyright (c) 2014 Могрин. All rights reserved.
//

#import "TCLRecordViewController.h"

@interface TCLRecordViewController ()

@end

@implementation TCLRecordViewController

@synthesize recorder;
@synthesize recordButton;
@synthesize stopButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [stopButton setEnabled:NO];
    NSError *eror;
    
    // Set the audio file
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               @"MyAudio.m4a",
                               nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&eror];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:&eror];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
    
}

-(IBAction)toRecord:(id)sender
{
    NSError *eror;
    
    if (!recorder.recording) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:&eror];
        
        // Start recording
        [recorder record];
        [recordButton setTitle:@"Pause" forState:UIControlStateNormal];
        
    } else {
        
        // Pause recording
        [recorder pause];
        [recordButton setTitle:@"Record" forState:UIControlStateNormal];
    }
    
    [stopButton setEnabled:YES];
}

-(IBAction)toStop:(id)sender
{
    NSError *eror;
    
    [recorder stop];    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:&eror];
    
    /*NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newDir = [NSEntityDescription insertNewObjectForEntityForName:@"Directory" inManagedObjectContext:context];
    [newDir setValue:@"MyAudio.m4a" forKey:@"title"];
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }*/
}

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{
    [recordButton setTitle:@"Record" forState:UIControlStateNormal];    
    [stopButton setEnabled:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

@end
