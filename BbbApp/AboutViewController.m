//
//  AboutViewController.m
//  BbbApp
//
//  Created by Harry Layman on 11/1/12.
//  Copyright (c) 2012 Harry Layman. All rights reserved.
//

#import "AboutViewController.h"
#import "Constants.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) setLabelBGColor:(UILabel *)labelToUpdate
             toColorIDX:(int)colorIDX {
    
    float rd, gr, bl;
    
    //  CN Green is  211, 249, 188
    rd = 211.00/255.00;
    gr = 249.00/255.00;
    bl = 188.00/255.00;
    
    // [label setBackgroundColor:[UIColor clearColor]];
    // [UIColor colorWithRed:0 green:0.518 blue:0 alpha:1]
    // note #color code for green is #008400: - 84 hex is 8 * 16 + 4 = 1132; 132/255 = .517647.
    
    //
    //    Green  CN: 211, 249, 188
    //    Yellow DE: 245, 228, 156
    //    BLUE   EN: 153, 217, 234
    //    Gray   ES: 220, 220, 220
    //    Pink   FR: 255, 163, 177
    //    Tan    IT: 228, 170, 122
    //  Violette JP: 219, 211, 235
    //    Orange KR: 255, 198, 147
    
    
    
    
    if (colorIDX == kCN) {
        //  CN Green is          211, 249, 188
        rd = 211.00/255.00;
        gr = 249.00/255.00;
        bl = 188.00/255.00;
    } else if (colorIDX == kDE){
        //  DE yellowish is  245, 228, 156
        rd = 245.00/255.00;
        gr = 228.00/255.00;
        bl = 156.00/255.00;
    } else if (colorIDX == kEN){
        //  EN cyan ish  is    153,217,234
        rd = 153.00/255.00;
        gr = 217.00/255.00;
        bl = 234.00/255.00;
    } else if (colorIDX == kES){
        //  ES is grayish is  220, 220,220
        rd = 220.00/255.00;
        gr = 220.00/255.00;
        bl = 220.00/255.00;
    } else if (colorIDX == kFR){
        //  FR pink ish  is  255, 163, 177
        rd = 255.00/255.00;
        gr = 163.00/255.00;
        bl = 177.00/255.00;
    } else if (colorIDX == kIT){
        //  IT tan       is  228, 170, 122
        rd = 228.00/255.00;
        gr = 170.00/255.00;
        bl = 122.00/255.00;
    } else if (colorIDX == kJP){
        //  CN orang is      219, 211, 235
        rd = 219.00/255.00;
        gr = 211.00/255.00;
        bl = 235.00/255.00;
    } else if (colorIDX == kKR){
        //  CN violette is       255, 198, 147
        rd = 255.00/255.00;
        gr = 198.00/255.00;
        bl = 147.00/255.00;
        
        
    } else {
        //  EN cyan ish  is    153,217,234
        rd = 153.00/255.00;
        gr = 217.00/255.00;
        bl = 234.00/255.00;
        
        
    }
    
    
    [labelToUpdate setBackgroundColor:[UIColor
                                       colorWithRed:rd green:gr blue:bl alpha:1]];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    NSLog(@"Got to settings window with string %@", _labelText);
//    us nsuserdefaults -- not passing string anymore...
    
    BOOL bL1R, bL2R;
    int klocL1R, klocL2R;
    
    NSString *lang1ValueString,  *lang2ValueString;
    NSString *lang1RValueString, *lang2RValueString;
    NSString *dbVersionString;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // but i want to get L1, L2, L1R, L2R from NSuserdefaults here.
    
    // also use constnats for DB and SW version..
    
    
    
    
    // lables were stored in NSUserDefaults during viewDidLoad of rootViewController (BbbAppViewController)
    // has kL1, kL2, paage heading:romanizationheading:Change Requires Restart:  Chinese: German: Englosh: Spanish: etc....
    
    //    _labelText = [[NSUserDefaults standardUserDefaults] stringForKey:kLanguageLabels];
    
    NSString *langLabels = [[NSString alloc] initWithString:[defaults objectForKey:kLanguageLabels]];
    
    NSArray *listItems = [langLabels componentsSeparatedByString:@":"];

    
//    NSLog(@"Got to about window with string %@", langLabels);
    
//    NSString *thisFrameString =  [[NSString alloc] initWithFormat:@"%@", _dataObject];
    int lL1, lL2;
    lL1 = [listItems[0] integerValue];
    lL2 = [listItems[1] integerValue];
//    NSLog(@"lL1 and lL2 are %d and %d", lL1, lL2);
    //    NSString *thisFrameString =  [[NSString alloc] initWithFormat:@"%@", _dataObject];
    // set colorstrip based on L1
    //    [self setLabelBGColor:(_textSetNameEtc) toColorIDX:l1Val];
    [self setLabelBGColor:(_colorStrip) toColorIDX:(lL1)];
    
//  show other nsUserDefaults
    
    //		NSLog(@"\n\nGot DB version of: %@.\n", dbVer.text);
	
    bL1R  = [defaults boolForKey:kL1RomanizationChoice];
    
    if (bL1R == TRUE) {
        //        NSLog(@" bL1R enabled...");
        klocL1R = 1;
        lang1RValueString = @"Enabled (YES).";
    }
    else {
        
        klocL1R = 0;
        //        NSLog(@"bL1R disabled....");
        lang1RValueString = @"Not Enabled (NO).";
    }

    bL2R  = [defaults boolForKey:kL2RomanizationChoice];
    
    if (bL2R == TRUE) {
        //        NSLog(@" bL2R enabled...");
        klocL2R = 1;
        lang2RValueString = @"Enabled (YES).";
    }
    else {
        
        klocL2R = 0;
        //        NSLog(@"bL2R disabled....");
        lang2RValueString = @"Not Enabled (NO).";
    }
    
//
    dbVersionString = [defaults objectForKey:kDatabaseVersion];
    _dbVersion.text = dbVersionString;
    

    _swVersion.text = kSoftwareVersion;
    
    lang1ValueString = [defaults objectForKey:kFirstLangChoice];
    lang2ValueString = [defaults objectForKey:kSecondLangChoice];
    
    _l1Value.text = lang1ValueString;
    _l2Value.text = lang2ValueString;
    
    _l1rValue.text = lang1RValueString;
    _l2rValue.text = lang2RValueString;
    
    

    
//    if ([[NSUserDefaults standardUserDefaults]  objectForKey:@"LL"]) {
//        llVal.text = [[NSUserDefaults standardUserDefaults]
//                      stringForKey:@"LL"];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setColorStrip:nil];
    [self setDbVersion:nil];
    [self setSwVersion:nil];
    [self setL1Value:nil];
    [self setL2Value:nil];
    [self setL1rValue:nil];
    [self setL2rValue:nil];
    [super viewDidUnload];
}
- (IBAction)gotoURL:(id)sender {

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kWLURL]];
    
}
@end
