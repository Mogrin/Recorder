//
//  TCLRecordViewController.h
//  TestCatalog
//
//  Created by Могрин on 10/22/14.
//  Copyright (c) 2014 Могрин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <AVFoundation/AVFoundation.h>

@interface TCLRecordViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (retain, nonatomic) AVAudioRecorder *recorder;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

-(IBAction)toRecord:(id)sender;
-(IBAction)toStop:(id)sender;


@end
