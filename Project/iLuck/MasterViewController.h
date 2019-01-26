//
//  MasterViewController.h
//  iLuck
//
//  Created by Felipe Rios on 12/04/12.
//  Copyright (c) 1997 - 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface MasterViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate> {
    int int_attempts;
    NSArray *NSArrayColum1;
    NSArray *NSArrayColum2;
    NSArray *NSArrayColum3;
    UIButton *UIButtonGo;
    UIPickerView *UIPickerMachine;
}

@property (nonatomic) SystemSoundID SoundRotate;
@property (nonatomic) SystemSoundID SoundWinner;
@property (nonatomic, retain) NSArray *NSArrayColum1;
@property (nonatomic, retain) NSArray *NSArrayColum2;
@property (nonatomic, retain) NSArray *NSArrayColum3;
@property (nonatomic, retain) IBOutlet UIButton *UIButtonGo;
@property (nonatomic, retain) IBOutlet UIPickerView *UIPickerMachine;

- (IBAction)Play:(id)sender;
- (IBAction)More:(id)sender;

@end
