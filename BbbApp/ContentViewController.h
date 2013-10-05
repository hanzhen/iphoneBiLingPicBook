//
//  ContentViewController.h
//  BbbApp
//
//  Created by Harry Layman on 10/20/12.
//  Copyright (c) 2012 Harry Layman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsPopoverViewController.h"

//@property (strong, nonatomic) *NSString settingsLabelsDelimitedString;

@protocol PageControlDelegate <NSObject>
- (void)backwardTap:(id)sender;
- (void)forwardTap:(id)sender;
- (void)prevTap:(id)sender;
- (void)nextTap:(id)sender;

@end

@interface ContentViewController : UIViewController

@property (assign, nonatomic) id <PageControlDelegate> delegate;


@property (weak, nonatomic) IBOutlet UILabel *textL111;
@property (weak, nonatomic) IBOutlet UILabel *textL211;
@property (weak, nonatomic) IBOutlet UILabel *textL112;
@property (weak, nonatomic) IBOutlet UILabel *textL212;

@property (weak, nonatomic) IBOutlet UILabel *textL121;
@property (weak, nonatomic) IBOutlet UILabel *textL221;
@property (weak, nonatomic) IBOutlet UILabel *textL122;
@property (weak, nonatomic) IBOutlet UILabel *textL222;

@property (weak, nonatomic) IBOutlet UILabel *settingsLabelDelimitedStringHolder;

@property (weak, nonatomic) IBOutlet UIImageView *imageView11;

@property (weak, nonatomic) IBOutlet UIImageView *imageView12;

@property (weak, nonatomic) IBOutlet UIImageView *imageView21;

@property (weak, nonatomic) IBOutlet UIImageView *imageView22;

//@property (weak, nonatomic) IBOutlet UIWebView *webView;  // this one will go...


@property (weak, nonatomic) IBOutlet UILabel *textSetNameEtc;

//@property (weak, nonatomic) IBOutlet UILabel *textL111;
//@property (weak, nonatomic) IBOutlet UILabel *textL211;
//
//@property (weak, nonatomic) IBOutlet UILabel *textL112;
//@property (weak, nonatomic) IBOutlet UILabel *textL212;
//
//@property (weak, nonatomic) IBOutlet UILabel *textL121;
//@property (weak, nonatomic) IBOutlet UILabel *textL221;
//
//@property (weak, nonatomic) IBOutlet UILabel *textL122;
//@property (weak, nonatomic) IBOutlet UILabel *textL222;
//
//@property (weak, nonatomic) IBOutlet UILabel *pageHead;
//
//@property (weak, nonatomic) IBOutlet UIView *imageView11;
//@property (weak, nonatomic) IBOutlet UIView *imageView12;
//@property (weak, nonatomic) IBOutlet UIView *imageView21;
//@property (weak, nonatomic) IBOutlet UIView *imageView22;


// @property (nonatomic, retain) IBOutlet UIButton *nextSetButton;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) id dataObject;

- (IBAction)skipAhead:(id)sender;
- (IBAction)skipNext:(id)sender;

- (IBAction)skipBackward:(id)sender;
- (IBAction)skipPrev:(id)sender;


- (IBAction)doAbout:(id)sender;

- (IBAction)doSettings:(id)sender;

@end
