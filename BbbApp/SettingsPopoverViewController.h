//
//  SettingsPopoverViewController.h
//  BbbApp
//
//  Created by Harry Layman on 10/30/12.
//  Copyright (c) 2012 Harry Layman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsPopoverViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *settingPageLabel;

@property (strong, nonatomic) NSString *labelText;
// colon separated values for all labels in current UI langague

@property (weak, nonatomic) IBOutlet UILabel *cnLangLabel;
@property (weak, nonatomic) IBOutlet UILabel *deLangLabel;

@property (weak, nonatomic) IBOutlet UILabel *enLangLabel;
@property (weak, nonatomic) IBOutlet UILabel *esLangLabel;
@property (weak, nonatomic) IBOutlet UILabel *frLangLabel;
@property (weak, nonatomic) IBOutlet UILabel *itLangLabel;
@property (weak, nonatomic) IBOutlet UILabel *jpLangLabel;
@property (weak, nonatomic) IBOutlet UILabel *krLangLabel;

@property (weak, nonatomic) IBOutlet UILabel *romanizationLabel;
@property (weak, nonatomic) IBOutlet UILabel *changesRestartLabel;


@property (weak, nonatomic) IBOutlet UIButton *cnSelectBtn;
@property (weak, nonatomic) IBOutlet UIButton *enSelectBtn;
@property (weak, nonatomic) IBOutlet UIButton *frSelectBtn;
@property (weak, nonatomic) IBOutlet UIButton *jpSelectBtn;

@property (weak, nonatomic) IBOutlet UIButton *deSelectBtn;
@property (weak, nonatomic) IBOutlet UIButton *esSelectBtn;
@property (weak, nonatomic) IBOutlet UIButton *itSelectBtn;
@property (weak, nonatomic) IBOutlet UIButton *krSelectBtn;

@property (weak, nonatomic) IBOutlet UILabel *colorStrip;


@property (strong, nonatomic) NSNumber *nxwL2;
@property (strong, nonatomic) NSNumber *romanBOOLasNSNINT;



@property (weak, nonatomic) IBOutlet UIButton *pinyinSelectBtn;


- (IBAction)en3Select:(id)sender;

- (IBAction)cnSelect:(id)sender;

- (IBAction)deSelect:(id)sender;


- (IBAction)es2Select:(id)sender;

- (IBAction)frSelect:(id)sender;
- (IBAction)itSelect:(id)sender;
- (IBAction)jpSelect:(id)sender;
- (IBAction)krSelect:(id)sender;
- (IBAction)romSelect:(id)sender;


- (IBAction)done:(id)sender;

@end
