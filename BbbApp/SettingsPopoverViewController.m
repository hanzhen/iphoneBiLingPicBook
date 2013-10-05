//
//  SettingsPopoverViewController.m
//  BbbApp
//
//  Created by Harry Layman on 10/30/12.
//  Copyright (c) 2012 Harry Layman. All rights reserved.
//

#import "SettingsPopoverViewController.h"
#import "Constants.h"

@interface SettingsPopoverViewController ()

@end

@implementation SettingsPopoverViewController

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
    UIImage *selectedBtn    =[UIImage imageNamed:@"selected20.png"];
    UIImage *unSelectedBtn  =[UIImage imageNamed:@"unSelected20.png"];
    
//    NSLog(@"Arrive settings popover view controller....");
    /* this is where we unpack labelText string and update all the
     label text in this display (10 values; don't mess with ok label
     
     such as... 
     _scene2Label.text = _labelText;
     
     */
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // lables were stored in NSUserDefaults during viewDidLoad of rootViewController (BbbAppViewController)
    // has kL1, kL2, paage heading:romanizationheading:Change Requires Restart:  Chinese: German: Englosh: Spanish: etc....
    
//    _labelText = [[NSUserDefaults standardUserDefaults] stringForKey:kLanguageLabels];
    
    _labelText = [defaults objectForKey:kLanguageLabels];
    
    
    BOOL bL2R;
    int bL2RsettingINT;
    
//    NSLog(@"Got to settings window with string %@", _labelText);
    
//    NSString *thisFrameString =  [[NSString alloc] initWithFormat:@"%@", _dataObject];
    
    NSArray *listItems = [_labelText componentsSeparatedByString:@":"];
    
    
      bL2R   = [defaults boolForKey:kL2RomanizationChoice];
//    bL2R   = [[NSUserDefaults standardUserDefaults] boolForKey:kL2RomanizationChoice]; // get ROM setting
    
    if (bL2R)   {
            bL2RsettingINT = 1;
//            NSLog(@"bL2R is YES");
            [_pinyinSelectBtn setImage:selectedBtn forState:UIControlStateNormal];

    }
        else {
//            NSLog(@"bL2R is NO");
            bL2RsettingINT = 0;
            [_pinyinSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    }
    
    _romanBOOLasNSNINT = [NSNumber numberWithInt:bL2RsettingINT];
    
    // instance var for state of romanization for L2 switch

    int arrayCount;
    
    arrayCount = (int)[listItems count];
    
    int lL1, lL2;
    int newL2int;
    
    
    lL1 = [listItems[0] integerValue];
    lL2 = [listItems[1] integerValue];

    newL2int = lL2;
    
//    NSLog(@"lL1 and lL2 are %d and %d", lL1, lL2);
    
    // set colorstrip based on L1
    
//    [self setLabelBGColor:(_textSetNameEtc) toColorIDX:l1Val];
    [self setLabelBGColor:(_colorStrip) toColorIDX:(lL1)];
    
    
    
    // make NSNumber from int...
    
    _nxwL2 = [NSNumber numberWithInt:newL2int];
    
    

    
    _settingPageLabel.text = listItems[2];
    _romanizationLabel.text = listItems[3];
    _changesRestartLabel.text = listItems[4];
    
    _cnLangLabel.text = listItems[5];
    _deLangLabel.text = listItems[6];
    _enLangLabel.text = listItems[7];
    _esLangLabel.text = listItems[8];
    
    _frLangLabel.text = listItems[9];
    _itLangLabel.text = listItems[10];
    _jpLangLabel.text = listItems[11];
    _krLangLabel.text = listItems[12];

    
    if (lL2 == kCN) {
        
//        NSLog(@"set with kL2 = kCN");

        [_cnSelectBtn setImage:selectedBtn forState:UIControlStateNormal];
        
        [_deSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_enSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_esSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        
        [_frSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_itSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_jpSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_krSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    
    }  else if (lL2 == kEN) {
        
        [_enSelectBtn setImage:selectedBtn forState:UIControlStateNormal];
        
        [_deSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_cnSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_esSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        
        [_frSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_itSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_jpSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_krSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        
    }  else if (lL2 == kDE) {
        
        [_deSelectBtn setImage:selectedBtn forState:UIControlStateNormal];
        
        [_cnSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_enSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_esSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        
        [_frSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_itSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_jpSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_krSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        
    }  else if (lL2 == kES) {
        
        [_esSelectBtn setImage:selectedBtn forState:UIControlStateNormal];
        
        [_deSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_enSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_cnSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        
        [_frSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_itSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_jpSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_krSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        
    }  else if (lL2 == kFR) {
        
        [_frSelectBtn setImage:selectedBtn forState:UIControlStateNormal];
        
        [_deSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_enSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_esSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        
        [_cnSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_itSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_jpSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_krSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        
    }  else if (lL2 == kIT) {
        
        [_itSelectBtn setImage:selectedBtn forState:UIControlStateNormal];
        
        [_deSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_enSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_esSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        
        [_frSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_cnSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_jpSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_krSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        
    }  else if (lL2 == kJP) {
        
        [_jpSelectBtn setImage:selectedBtn forState:UIControlStateNormal];
        
        [_deSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_enSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_esSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        
        [_frSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_itSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_cnSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_krSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        
    }  else if (lL2 == kKR) {
        
        [_krSelectBtn setImage:selectedBtn forState:UIControlStateNormal];
        
        [_deSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_enSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_esSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        
        [_frSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_itSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_jpSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_cnSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        
    }  else  { // default to EN
        
        [_enSelectBtn setImage:selectedBtn forState:UIControlStateNormal];
        
        [_deSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_cnSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_esSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        
        [_frSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_itSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_jpSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [_krSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        
    }
        

        
        
    
//    [aButton setImage: aButtonImage  forState:(UIControlStateNormal)];
    
    // debug
    
//    NSLog(@"---->items in arrray is %d.", arrayCount);
//    NSLog(@"0 item is %@<", listItems[0]);
//    NSLog(@"1 item is %@<", listItems[1]);
//    NSLog(@"2 item is %@<", listItems[2]);
//    NSLog(@"3 item is %@<", listItems[3]);
//    NSLog(@"4 item is %@<", listItems[4]);
//    NSLog(@"5 item is %@<", listItems[5]);
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)en3Select:(id)sender {

    UIImage *selectedBtn    =[UIImage imageNamed:@"selected20.png"];
    UIImage *unSelectedBtn  =[UIImage imageNamed:@"unSelected20.png"];
    [_enSelectBtn setImage:selectedBtn forState:UIControlStateNormal];

    _nxwL2 = [NSNumber numberWithInt:kEN];

    [_deSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_cnSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_esSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];

    [_frSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_itSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_jpSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_krSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] setObject:kLEN
                                              forKey:kSecondLangChoice];//

    
}

- (IBAction)cnSelect:(id)sender {
    
    UIImage *selectedBtn    =[UIImage imageNamed:@"selected20.png"];
    UIImage *unSelectedBtn  =[UIImage imageNamed:@"unSelected20.png"];
    
    _nxwL2 = [NSNumber numberWithInt:kCN];
    
    
    [_cnSelectBtn setImage:selectedBtn forState:UIControlStateNormal];
    
    [_deSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_enSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_esSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    
    [_frSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_itSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_jpSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_krSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] setObject:kLCN
                                              forKey:kSecondLangChoice];
    
}


- (IBAction)deSelect:(id)sender {
    UIImage *selectedBtn    =[UIImage imageNamed:@"selected20.png"];
    UIImage *unSelectedBtn  =[UIImage imageNamed:@"unSelected20.png"];
    [_deSelectBtn setImage:selectedBtn forState:UIControlStateNormal];

    _nxwL2 = [NSNumber numberWithInt:kDE];

    [_enSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_cnSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_esSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];

    [_frSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_itSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_jpSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_krSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] setObject:kLDE
                                              forKey:kSecondLangChoice];
    
    
}

//- (IBAction)deSelect:(id)sender {
//
//    UIImage *selectedBtn    =[UIImage imageNamed:@"selected20.png"];
//    UIImage *unSelectedBtn  =[UIImage imageNamed:@"unSelected20.png"];
//    [_deSelectBtn setImage:selectedBtn forState:UIControlStateNormal];
//    
//    _nxwL2 = [NSNumber numberWithInt:kDE];
//    
//    [_enSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//    [_cnSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//    [_esSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//    
//    [_frSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//    [_itSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//    [_jpSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//    [_krSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//    [[NSUserDefaults standardUserDefaults] setObject:kLDE
//                                              forKey:kSecondLangChoice];
//    
//}

///////////////  EN SELECT/
//
//
///    UIImage *selectedBtn    =[UIImage imageNamed:@"selected20.png"];
//UIImage *unSelectedBtn  =[UIImage imageNamed:@"unSelected20.png"];
//[_enSelectBtn setImage:selectedBtn forState:UIControlStateNormal];
//
//_nxwL2 = [NSNumber numberWithInt:kEN];
//
//[_deSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//[_cnSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//[_esSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//
//[_frSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//[_itSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//[_jpSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//[_krSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//[[NSUserDefaults standardUserDefaults] setObject:kLEN
//                                          forKey:kSecondLangChoice];//
//
/////////// END EN SELECT

- (IBAction)es2Select:(id)sender {
    
    UIImage *selectedBtn    =[UIImage imageNamed:@"selected20.png"];
    UIImage *unSelectedBtn  =[UIImage imageNamed:@"unSelected20.png"];
    [_esSelectBtn setImage:selectedBtn forState:UIControlStateNormal];

    _nxwL2 = [NSNumber numberWithInt:kES];

    [_deSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_cnSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_enSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];

    [_frSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_itSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_jpSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_krSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] setObject:kLES
                                              forKey:kSecondLangChoice];
    
    
}
//- (IBAction)es2Select:(id)sender {
//
//    
//}
//
//- (IBAction)esSelect:(id)sender {
//    
//    UIImage *selectedBtn    =[UIImage imageNamed:@"selected20.png"];
//    UIImage *unSelectedBtn  =[UIImage imageNamed:@"unSelected20.png"];
//    [_esSelectBtn setImage:selectedBtn forState:UIControlStateNormal];
//    
//    _nxwL2 = [NSNumber numberWithInt:kES];
//    
//    [_deSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//    [_cnSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//    [_enSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//    
//    [_frSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//    [_itSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//    [_jpSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//    [_krSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//    [[NSUserDefaults standardUserDefaults] setObject:kLES
//                                              forKey:kSecondLangChoice];
//    
//}

- (IBAction)frSelect:(id)sender {
    
    UIImage *selectedBtn    =[UIImage imageNamed:@"selected20.png"];
    UIImage *unSelectedBtn  =[UIImage imageNamed:@"unSelected20.png"];
    [_frSelectBtn setImage:selectedBtn forState:UIControlStateNormal];
    
    _nxwL2 = [NSNumber numberWithInt:kFR];
    
    [_deSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_cnSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_esSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    
    [_enSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_itSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_jpSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_krSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] setObject:kLFR
                                              forKey:kSecondLangChoice];
}

- (IBAction)itSelect:(id)sender {
    
    UIImage *selectedBtn    =[UIImage imageNamed:@"selected20.png"];
    UIImage *unSelectedBtn  =[UIImage imageNamed:@"unSelected20.png"];
    [_itSelectBtn setImage:selectedBtn forState:UIControlStateNormal];
    
    _nxwL2 = [NSNumber numberWithInt:kIT];
    
    [_deSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_cnSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_esSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    
    [_frSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_enSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_jpSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_krSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] setObject:kLIT
                                              forKey:kSecondLangChoice];
}

- (IBAction)jpSelect:(id)sender {
    
    UIImage *selectedBtn    =[UIImage imageNamed:@"selected20.png"];
    UIImage *unSelectedBtn  =[UIImage imageNamed:@"unSelected20.png"];
    [_jpSelectBtn setImage:selectedBtn forState:UIControlStateNormal];
    
    _nxwL2 = [NSNumber numberWithInt:kJP];
    
    [_deSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_cnSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_esSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    
    [_frSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_itSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_enSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_krSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] setObject:kLJP
                                              forKey:kSecondLangChoice];
}

- (IBAction)krSelect:(id)sender {
    
    UIImage *selectedBtn    =[UIImage imageNamed:@"selected20.png"];
    UIImage *unSelectedBtn  =[UIImage imageNamed:@"unSelected20.png"];
    [_krSelectBtn setImage:selectedBtn forState:UIControlStateNormal];
    
    _nxwL2 = [NSNumber numberWithInt:kKR];
    
    [_deSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_cnSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_esSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    
    [_frSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_itSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_jpSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [_enSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] setObject:kLKR
                                              forKey:kSecondLangChoice];
}

- (IBAction)romSelect:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];    
    
    UIImage *selectedBtn    =[UIImage imageNamed:@"selected20.png"];
    UIImage *unSelectedBtn  =[UIImage imageNamed:@"unSelected20.png"];
    
    // again, get current ROML2 setting
    // flip setting, flip button, store back into NSobject romanBOOLasNSNINT
    
    BOOL bL2R;
    int bL2RsettingINT;

//    bL2R   = [[NSUserDefaults standardUserDefaults] boolForKey:kL2RomanizationChoice]; // get ROM setting
    
    bL2R = [defaults boolForKey:kL2RomanizationChoice];
    
//    if (bL2R) {
//        NSLog(@"bL2R found to be YES");
//    } else {
//        NSLog(@"bL2R found to be No");
//    }
//    
    
    if (bL2R) { // flop it
//        NSLog(@"Flop bL2R to NO");
        bL2R = NO;
        bL2RsettingINT = 0;
        [_pinyinSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
        [defaults setBool:NO forKey:kL2RomanizationChoice];
        //        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kL2RomanizationChoice];
//        NSLog(@"turn off L2ROM");
        _romanBOOLasNSNINT = [NSNumber numberWithInt:0];
        
    } else {
        bL2R = YES;
//        NSLog(@"Flop bL2R to NO");
        bL2RsettingINT = 1;
        [_pinyinSelectBtn setImage:selectedBtn forState:UIControlStateNormal];
        [defaults setBool:YES forKey:kL2RomanizationChoice];
        //        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kL2RomanizationChoice];
//        NSLog(@"turn on L2ROM");
        _romanBOOLasNSNINT = [NSNumber numberWithInt:1];
        
    }
    
//    if (bL2R)   {
//        bL2RsettingINT = 1;
//        [_pinyinSelectBtn setImage:selectedBtn forState:UIControlStateNormal];
//        [defaults setBool:YES forKey:kL2RomanizationChoice];
////        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kL2RomanizationChoice];
//        NSLog(@"turn on L2ROM");
//        _romanBOOLasNSNINT = [NSNumber numberWithInt:1];
//    }
//    else {
//        bL2RsettingINT = 0;
//        [_pinyinSelectBtn setImage:unSelectedBtn forState:UIControlStateNormal];
//        [defaults setBool:NO forKey:kL2RomanizationChoice];
////        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kL2RomanizationChoice];
//        NSLog(@"turn off L2ROM");
//        _romanBOOLasNSNINT = [NSNumber numberWithInt:0];
//    }
    
    [defaults synchronize];

    // have to write this one back out... done above... 
    
    
    
}




- (IBAction)done:(id)sender {
    
    // get integer from _nxwL2 NSNumber
    // store as kL2Choice in NSUSerDefaults
    
//    int L2int;
//    L2int = (int)[_nxwL2 doubleValue];
//    
//    if (L2int == kCN) {
//        [[NSUserDefaults standardUserDefaults] setObject:kLCN
//                                                  forKey:kSecondLangChoice];
//    } else if (L2int == kEN) {
//        [[NSUserDefaults standardUserDefaults] setObject:kLEN
//                                                  forKey:kSecondLangChoice];
//    } else if (L2int == kDE) {
//        [[NSUserDefaults standardUserDefaults] setObject:kLDE
//                                                  forKey:kSecondLangChoice];
//    } else if (L2int == kES) {
//        [[NSUserDefaults standardUserDefaults] setObject:kLES
//                                                  forKey:kSecondLangChoice];
//    } else if (L2int == kFR) {
//        [[NSUserDefaults standardUserDefaults] setObject:kLFR
//                                                  forKey:kSecondLangChoice];
//    } else if (L2int == kIT) {
//        [[NSUserDefaults standardUserDefaults] setObject:kLIT
//                                                  forKey:kSecondLangChoice];
//    } else if (L2int == kJP) {
//        [[NSUserDefaults standardUserDefaults] setObject:kLJP
//                                                  forKey:kSecondLangChoice];
//    } else if (L2int == kKR) {
//        [[NSUserDefaults standardUserDefaults] setObject:kLKR
//                                                  forKey:kSecondLangChoice];
//    } else  {
//        [[NSUserDefaults standardUserDefaults] setObject:kLEN
//                                                  forKey:kSecondLangChoice];
//    }
    
}
- (void)viewDidUnload {
    [self setColorStrip:nil];
    [super viewDidUnload];
}
@end
