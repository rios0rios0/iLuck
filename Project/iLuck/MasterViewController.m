//
//  MasterViewController.m
//  iLuck
//
//  Created by Felipe Rios on 12/04/12.
//  Copyright (c) 1997 - 2012. All rights reserved.
//

#import "MasterViewController.h"

@implementation MasterViewController
@synthesize SoundRotate, SoundWinner, NSArrayColum1, NSArrayColum2, NSArrayColum3, UIButtonGo, UIPickerMachine;

- (IBAction)Play:(id)sender {
    int_attempts = int_attempts+1;
    BOOL bool_isWinner = NO;
    
    int int_lastValue = -1;
    int int_sequece;
    
    UIButtonGo.enabled = NO;
    AudioServicesPlaySystemSound(SoundRotate);
    
    for (int x = 0; x < 3; x++) {
        int int_newValue = random() % [self.NSArrayColum1 count];
        
        if (int_lastValue == int_newValue)
            int_sequece++;            
        else
            int_sequece = 1;
        
        int_lastValue = int_newValue;
        
        if (int_sequece == 3) {
            bool_isWinner = YES;
        }
        [UIPickerMachine selectRow: int_newValue inComponent: x animated: YES];
        [UIPickerMachine reloadComponent: x];
    }
    if (bool_isWinner) {
        [self performSelector: @selector(PlaySoundWinner) withObject: nil afterDelay: 1];
    } else {
        [self performSelector: @selector(EnableButton) withObject: nil afterDelay: 1.5];
    }
}

- (IBAction)More:(id)sender {
    UIActionSheet *As = [[UIActionSheet alloc] initWithTitle: @"More and Info" delegate: self cancelButtonTitle: nil destructiveButtonTitle: nil otherButtonTitles: @"More Apps", @"About This App", nil];
    [As setActionSheetStyle: UIActionSheetStyleBlackTranslucent];
    [As showInView: self.view];
    [As release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // MY APPLE ITUNES CHANNEL
    } else if (buttonIndex == 1) {
        UIAlertView *AV = [[UIAlertView alloc] initWithTitle: @"Info (About)" message: @"iLuck v1.0 \n\nCreated By: Felipe Rios \nCopyright © 1997 - 2012, \nAll Rights Reserved. \n\n*Twitter: @FDeveloping" delegate: self cancelButtonTitle: @"OK" otherButtonTitles: nil];
        [AV show];
        [AV release];
    }
}

- (void)PlaySoundWinner {
    AudioServicesPlaySystemSound(SoundWinner);
    NSString *msg = [[NSString alloc] initWithFormat: @"You Win After %d Attempts", int_attempts];
    UIAlertView *AV = [[UIAlertView alloc] initWithTitle: @"Congratulations!" message: msg delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
    [AV show];
    [AV release];
    [msg release];
    [self performSelector: @selector(EnableButton) withObject: nil afterDelay: 3];
}

- (void)EnableButton {
    UIButtonGo.enabled = YES;
}

#pragma mark PickerView Delegate and DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.NSArrayColum1 count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    NSString *columName = [[NSString alloc] initWithFormat: @"NSArrayColum%d", component + 1];
    NSArray *Resum = [self valueForKey: columName];
    [columName release];
    return [Resum objectAtIndex: row];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *imgAP = [UIImage imageNamed: @"Apple.png"];
    UIImage *imgMA = [UIImage imageNamed: @"Mac.png"];
    UIImage *imgMI = [UIImage imageNamed: @"Microsoft.png"];
    UIImage *imgWI = [UIImage imageNamed: @"Windows.png"];
    UIImage *imgGO = [UIImage imageNamed: @"Google.png"];
    UIImage *imgAN = [UIImage imageNamed: @"Android.png"];
    
    for (int i = 1; i <= 3; i++) {
        UIImageView *viewAP = [[UIImageView alloc] initWithImage: imgAP];
        UIImageView *viewMA = [[UIImageView alloc] initWithImage: imgMA];
        UIImageView *viewMI = [[UIImageView alloc] initWithImage: imgMI];
        UIImageView *viewWI = [[UIImageView alloc] initWithImage: imgWI];
        UIImageView *viewGO = [[UIImageView alloc] initWithImage: imgGO];
        UIImageView *viewAN = [[UIImageView alloc] initWithImage: imgAN];
        
        NSArray *arrayImgs = [[NSArray alloc] initWithObjects: viewAP, viewMA, viewMI, viewWI, viewGO, viewAN, nil];
        
        NSString *columName = [[NSString alloc] initWithFormat: @"NSArrayColum%d", i];
        
        [self setValue: arrayImgs forKey: columName];
        
        [columName release];
        [viewAP release];
        [viewMA release];
        [viewMI release];
        [viewWI release];
        [viewGO release];
        [viewAN release];
    }
    
    NSString *Path = [[NSBundle mainBundle] pathForResource: @"Winner" ofType: @"wav"];
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath: Path], &SoundWinner);
    Path = [[NSBundle mainBundle] pathForResource: @"Play" ofType: @"wav"];
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath: Path], &SoundRotate);
    srandom(time(NULL));
}


- (void)viewDidUnload
{
    self.NSArrayColum1 = nil;
    self.NSArrayColum2 = nil;
    self.NSArrayColum3 = nil;
    self.UIButtonGo = nil;
    self.UIPickerMachine = nil;
    AudioServicesDisposeSystemSoundID(SoundWinner);
    self.SoundWinner = 0;
    AudioServicesDisposeSystemSoundID(SoundRotate);
    self.SoundRotate = 0;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [NSArrayColum1 release];
    [NSArrayColum2 release];
    [NSArrayColum3 release];
    [UIButtonGo release];
    [UIPickerMachine release];
    AudioServicesDisposeSystemSoundID(SoundWinner);
    self.SoundWinner = 0;
    AudioServicesDisposeSystemSoundID(SoundRotate);
    self.SoundRotate = 0;
    [super dealloc];
}

@end
