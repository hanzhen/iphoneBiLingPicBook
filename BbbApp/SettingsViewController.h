//
//  SettingsViewController.h
//  BbbApp
//
//  Created by Harry Layman on 10/29/12.
//  Copyright (c) 2012 Harry Layman. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SettingsViewControllerDelegate;

@interface SettingsViewController : UIViewController {
    id<SettingsViewControllerDelegate> delegate;
    
    IBOutlet UIButton *cnButton, *deButton, *enButton, *esButton;
    IBOutlet UIButton *frButton, *itButton, *jpButton, *krButton;
    
    IBOutlet UISwitch *L2Romanization;

}


- (IBAction)onCNButton:(id)sender;
- (IBAction)onDEbutton:(id)sender;
- (IBAction)onENbutton:(id)sender;
- (IBAction)onESbotton:(id)sender;
- (IBAction)onFRbutton:(id)sender;
- (IBAction)onITbutton:(id)sender;
- (IBAction)onJPbutton:(id)sender;
- (IBAction)onKRbutton:(id)sender;


- (IBAction)done:(id)sender;

- (IBAction)changeL2Romanization:(id)sender;

//@property (weak, nonatomic) IBOutlet UIButton *cnButton;
//@property (weak, nonatomic) IBOutlet UIButton *deButton;
//@property (weak, nonatomic) IBOutlet UIButton *enButton;
//@property (weak, nonatomic) IBOutlet UIButton *esButton;
//@property (weak, nonatomic) IBOutlet UIButton *frButton;
//@property (weak, nonatomic) IBOutlet UIButton *itButton;
//@property (weak, nonatomic) IBOutlet UIButton *jpButton;
//@property (weak, nonatomic) IBOutlet UIButton *krButton;

//
//@property (strong, nonatomic) id
//<SettingsViewControllerDelegate> delegate;


@end

@protocol SettingsViewControllerDelegate

-(void) settingsViewControllerDidFinish: (SettingsViewController *) controller;

@end







