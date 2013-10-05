//
//  SettingsViewController.m
//  BbbApp
//
//  Created by Harry Layman on 10/29/12.
//  Copyright (c) 2012 Harry Layman. All rights reserved.
//

#import "SettingsViewController.h"
#import "Constants.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
//    get the bL2R value
    
}



-(IBAction) changeL2RoamizationSwitch: (id) sender {
    NSLog(@"In L2RomanizationSwitch...");
    
    
}

- (IBAction)onCNButton:(id)sender {
}

- (IBAction)onDEbutton:(id)sender {
}

- (IBAction)onENbutton:(id)sender {
}

- (IBAction)onESbotton:(id)sender {
}

- (IBAction)onFRbutton:(id)sender {
}

- (IBAction)onITbutton:(id)sender {
}

- (IBAction)onJPbutton:(id)sender {
}

- (IBAction)onKRbutton:(id)sender {
}

- (IBAction)done:(id)sender {
//    [self.delegate settingsViewControllerDidFinish:self];

    
}

- (IBAction)changeL2Romanization:(id)sender {
}


//
//-(void) settingsViewControllerDidFinish: (SettingsViewController *) controller {
//    
//    // save L2 language selection and L2Romanization selection in NSUSERDEFAUTLS
//
//    //      [[NSUserDefaults standardUserDefaults] setInteger:useAlphaSetting forKey:kUseAlpha];
//    //		NSLog(@"Wrote out useAlpha as: %d.   MILAN", sUA); //useAlphaSetting);
//    //    [[NSUserDefaults standardUserDefaults] setInteger:pEM forKey:kPreventEM];
//    // [[NSUserDefaults standardUserDefaults] setInteger:preventEMSetting forKey:kPreventEM];
//    //	[[NSUserDefaults standardUserDefaults] setInteger:gSetIDX forKey:kSetToUse];
//    
//    //  [[NSUserDefaults standardUserDefaults] setInteger:lives forKey:kLivesKey];
//    //  by calling delegate all the time, might be extra overhead. could not call delgate if values invalid etc.
//	
//    //  NSLog(@"Next is call to settingsViewControllerDidFinish delegate...\n");
//    
//   
//    
//}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
