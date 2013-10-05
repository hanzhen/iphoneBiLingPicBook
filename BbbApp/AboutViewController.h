//
//  AboutViewController.h
//  BbbApp
//
//  Created by Harry Layman on 11/1/12.
//  Copyright (c) 2012 Harry Layman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;
@property (strong, nonatomic) NSString *labelText;
// colon separated values for all labels in current UI langague
@property (weak, nonatomic) IBOutlet UILabel *colorStrip;
@property (weak, nonatomic) IBOutlet UILabel *dbVersion;
@property (weak, nonatomic) IBOutlet UILabel *swVersion;

@property (weak, nonatomic) IBOutlet UILabel *l1Value;
@property (weak, nonatomic) IBOutlet UILabel *l2Value;

@property (weak, nonatomic) IBOutlet UILabel *l1rValue;

@property (weak, nonatomic) IBOutlet UILabel *l2rValue;

- (IBAction)gotoURL:(id)sender;



@end
