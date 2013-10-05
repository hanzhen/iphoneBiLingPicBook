//
//  ContentViewController.m
//  BbbApp
//
//  Created by Harry Layman on 10/20/12.
//  Copyright (c) 2012 Harry Layman. All rights reserved.
//

#import "ContentViewController.h"
#import "Constants.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

//@synthesize textL111 =_textL111;
//@synthesize textL112 =_textL112;
//@synthesize textL121 =_textL121;
//@synthesize textL122 =_textL122;
//
//@synthesize textL211 =_textL211;
//@synthesize textL212 =_textL212;
//@synthesize textL221 =_textL221;
//@synthesize textL222 =_textL222;

//@synthesize imageView11 = _imageView11;
//@synthesize imageView12 = _imageView12;
//@synthesize imageView21 = _imageView21;
//@synthesize imageView22 = _imageView22;


//    _textL211.textColor = [UIColor redColor];

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
    

    
//    if (![colorSTR isEqualToString:kBlackSTR]) {
//        if        ([colorSTR isEqualToString:kBlueSTR]) {
//            labelToUpdate.textColor = [UIColor blueColor];
//        } else if ([colorSTR isEqualToString:kRedSTR]) {
//            labelToUpdate.textColor = [UIColor redColor];
//        } else if ([colorSTR isEqualToString:kGreenSTR]) {
//            labelToUpdate.textColor = [UIColor colorWithRed:rd green:gr blue:bl alpha:1.0];
//            
//            // [UIColor colorWithHexString:@"228B22"];; hex for 22 = 34, 8b = 139 , 22 is 34,
//            
//            // [UIColor colorWithHexString:@"228B22"]; forest green --- greenColor to florescent...
//        } else {
//            // leave black;
//        }
//    }
//    // leave black
    






-(void) setLabelColor:(UILabel *)labelToUpdate
              toColor:(NSString *)colorSTR {
    
    float rd = 34.00/255.00;
    float gr = 139.00/255.00;
    float bl = 34.00/255.00;
    
    if (![colorSTR isEqualToString:kBlackSTR]) {
        if        ([colorSTR isEqualToString:kBlueSTR]) {
            labelToUpdate.textColor = [UIColor blueColor];
        } else if ([colorSTR isEqualToString:kRedSTR]) {
            labelToUpdate.textColor = [UIColor redColor];
        } else if ([colorSTR isEqualToString:kGreenSTR]) {
            labelToUpdate.textColor = [UIColor colorWithRed:rd green:gr blue:bl alpha:1.0];
            
            // [UIColor colorWithHexString:@"228B22"];; hex for 22 = 34, 8b = 139 , 22 is 34, 
            
            // [UIColor colorWithHexString:@"228B22"]; forest green --- greenColor to florescent...
        } else {
            // leave black;
        }
    }
    // leave black
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

int extractInteger (NSNumber *someObject) {
    
    double doubleNumb = [someObject doubleValue];
    int returnValue =  (int) doubleNumb;
    return returnValue;
}



- (void)viewWillAppear:(BOOL)animated
{
    
    // this is where the code is added to poplate the new page with the labels and images
    //   _dataObject is an NSString? not nsarray? need to work on this. 121024
    
//    [super viewWillAppear:animated]; [_webView loadHTMLString:_dataObject
//                                                      baseURL:[NSURL URLWithString:@""]];
//    

    [super viewWillAppear:animated];

    
//    NSLog(@"what is my current page string? here->%@.", _dataObject);
    
      NSString *thisFrameString =  [[NSString alloc] initWithFormat:@"%@", _dataObject];

      NSArray *listItems = [thisFrameString componentsSeparatedByString:@":"];
// itterate through array (check number of items for page) and set all variables right here....
    
/*
 
    array items in order:  pageno, kL1, kL2, NoItems, a, b, c, d, SetNumber, SetName  (a-d are tileIDs; ignore but log.
        the for i = one ti NoItems:
            textL111, color, textL211, color, image11;
                then X12, X21, X222
        done...
 
 
 switch colors to integers:  0/1/2/3/ for black, red, blue/ green
 
 
 */
    
    int pageno = extractInteger(listItems[0]);
//    NSLog(@"pageno is %d", pageno);
    
    int l1Val =  extractInteger(listItems[1]);
//    NSLog(@"l1Val is %d", l1Val);
    int l2Val =  extractInteger(listItems[2]);
//        NSLog(@"l2Val is %d", l2Val);
    int noItems = extractInteger(listItems[3]);
//    NSLog(@"noItems is %d", noItems);
    int setNumber = extractInteger(listItems[8]);
//    NSLog(@"setNumber is %d", setNumber);
    
//    NSString *pageHeading = [[NSString alloc] initWithFormat:@"%@  - Page %d.", listItems[9], pageno];
    
    NSString *pageHeading = [[NSString alloc] initWithFormat:@"%@", listItems[9]];    

    _textSetNameEtc.text = pageHeading;
    
    // set color for L1 lanuage l1Val -- ,backgroundcolor...
    
    [self setLabelBGColor:(_textSetNameEtc) toColorIDX:l1Val];
    
    
    // test for max number of items.
    
    int arrayCount;
//    int tilesFound;
    

    arrayCount = (int)[listItems count];
//    NSLog(@"arrayCount os %d", arrayCount);
    
//    NSLog(@"We got %d items in the string.", arrayCount); // get 31 items in array for 4 tiles; 21 items for 2 tiles, so 26 items for 3 tiles, and 16 items for one image.
    
    
    
    
    
  
    
// do for four pics now;  add logic based on noItems...
    
// pic11
    _textL111.text =  listItems[10];
    _textL211.text  = listItems[12];
    
    NSString *colorL111 = [[NSString alloc] initWithFormat:@"%@", listItems[11]];
    NSString *colorL211 = [[NSString alloc] initWithFormat:@"%@", listItems[13]];
    
    
    [ self setLabelColor:_textL111 toColor:colorL111];
    [ self setLabelColor:_textL211 toColor:colorL211];
    
    if (l1Val == kCN) {
        
//        NSLog(@"Set Chinese font - L1");
//        [self.textL111 setFont:[UIFont fontWithName:@"Heiti SC"]];
//        _textL111.font = [UIFont ]
//     myLabel.font = [UIFont fontWithName:@"Georgia" size:15];

        
//  [_textL111 setFont: [UIFont fontWithName:@"Heiti SC"]];
//  STHeitiSC-Medium
        
        //   [ self setLabelColor:_textL111 toColor:colorL111];
        //    labelToUpdate.textColor = [UIColor redColor];

        
    }  else {
        // reset to system font.
    }
    
    
//    change to integer values then use below... with case statement..
//    NSLog(@"First color is %@<",  colorL111);
    
    
//    _textL211.textColor = [UIColor redColor];
    
    UIImage *image11 =[UIImage imageNamed:listItems[14]];
//    NSLog(@"image name is %@<",listItems[14] );
    [_imageView11 initWithImage:image11];

    
    if (arrayCount > 16) {
    // pic12
    _textL112.text =  listItems[15];
    _textL212.text  = listItems[17];

        NSString *colorL112 = [[NSString alloc] initWithFormat:@"%@", listItems[16]];
        NSString *colorL212 = [[NSString alloc] initWithFormat:@"%@", listItems[18]];
        [ self setLabelColor:_textL112 toColor:colorL112];
        [ self setLabelColor:_textL212 toColor:colorL212];
        
        
        
    UIImage *image12 =[UIImage imageNamed:listItems[19]];
    [_imageView12 initWithImage:image12];
        
    } else {
        _textL112.text =  @" ";
        _textL212.text  = @" ";    
    }


    if (arrayCount > 21) {
    // pic21
    _textL121.text =  listItems[20];
    _textL221.text  = listItems[22];
        
        NSString *colorL121 = [[NSString alloc] initWithFormat:@"%@", listItems[21]];
        NSString *colorL221 = [[NSString alloc] initWithFormat:@"%@", listItems[23]];
        [ self setLabelColor:_textL121 toColor:colorL121];
        [ self setLabelColor:_textL221 toColor:colorL221];
        
        
    
    UIImage *image21 =[UIImage imageNamed:listItems[24]];
    [_imageView21 initWithImage:image21];
    }
    else {
        _textL121.text =  @" ";
        _textL221.text  = @" ";
    }
    
    
    if (arrayCount > 26) {
    // pic22
    _textL122.text =  listItems[25];
    _textL222.text  = listItems[27];
    
        NSString *colorL122 = [[NSString alloc] initWithFormat:@"%@", listItems[26]];
        NSString *colorL222 = [[NSString alloc] initWithFormat:@"%@", listItems[28]];
        [ self setLabelColor:_textL122 toColor:colorL122];
        [ self setLabelColor:_textL222 toColor:colorL222];
        
        
        
        
    UIImage *image22 =[UIImage imageNamed:listItems[29]];
    [_imageView22 initWithImage:image22];
    } else {
        _textL122.text =  @" ";
        _textL222.text  = @" ";        
    }
    
    
    
    
//    [NSString someNSTring om
    
    
//    [_webView loadHTMLString:_dataObject baseURL:[NSURL URLWithString:@""]];
    //
    // boat_chuan2_pic100.png
    
//    UIImage *image11 =[UIImage imageNamed:@"boat_chuan2_pic100.png"];
    
           

    

    [_imageView11 initWithImage:image11];
    
//    _textL111.text =  @"L111-test";     
//    _textL112.text =  @"L112-test";
//    _textL211.text  = @"chinese L211";
    
//    
//    [_textL112.text "L111-test"];
//    [_textL121.text "L111-test"];
//    [_textL122.text "L111-test"];
//    
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
// get langlabels in the event of call to settings popover
    
// [_settingsLabelDelimitedStringHolder.text = [[NSUserDefaults standardUserDefaults] defaults stringForKey:kLanguageLabels]];

/*
 
 // don't need to pass this data to popover; have view did load get the string from NSDefault...
    
    if (![[NSUserDefaults standardUserDefaults]
          objectForKey:kLanguageLabels]) {
        [[NSUserDefaults standardUserDefaults]
         setObject:@"Second Language:Romanization?:Chinese:German:English:Spanish:French:Italian:Japanese:Korean:"
         forKey:kLanguageLabels];
        _settingsLabelDelimitedStringHolder.text = @"Second Language:Romanization?:Chinese:German:English:Spanish:French:Italian:Japanese:Korean:";
        NSLog(@"ERROR!  No language labels found in contentViewCongtroller view did load... ");
    }
    else {
        _settingsLabelDelimitedStringHolder.text  = [[NSUserDefaults standardUserDefaults]
                             stringForKey:kLanguageLabels];
        NSLog(@"Found defaut language labels for popover... %@", _settingsLabelDelimitedStringHolder.text);

    }
  
    // value written during main window startup after setting up kL1, kL2 values...
    
    
}
 

*/

    _settingsLabelDelimitedStringHolder.text = @" "; // can't be nill or error??'
    // getting string from NSUSerdefaults now, so don't set and pass this value.
    
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    SettingsPopoverViewController *destination =
//    [segue destinationViewController];
//    destination.labelText = @"Arrived from main view controller]";
//    
//
}

//  ???halprog errors as of 121102 1235 am...

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    SettingsPopoverViewController *destination =
//    [segue destinationViewController];
////   destination.labelText = @"Arrived from main view controller]";
////     destination.labelText = _settingsLabelDelimitedStringHolder.text;
//    
//    // not using this transfer any longer... stored string in NSdefaults in original view did load, where popover view did load gets it...
//    
//    NSLog(@"Prepare for seque: %@<", _settingsLabelDelimitedStringHolder.text);
//    
//        
//}
//


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)returned:(UIStoryboardSegue *)seque {

//    NSLog(@"Got back from about page ...");
}

    

- (IBAction)doAbout:(id)sender {
    
//    NSLog(@"Now we get to doAbout!!!");
}

- (IBAction)doSettings:(id)sender {

//    NSLog(@"Now we get to doSettings....");
    
    
    /*  here in dosettings we need to:
     
     
     just let seque open settings modal popover.
     
     
     
    */
    
    
    
    
    
}

- (IBAction)skipAhead:(id)sender {
    // send the tap on to the delegate
//    NSLog(@" in CVC skipAhead... calling delegate....");
    
	[[self delegate] forwardTap:sender];
}

- (IBAction)skipNext:(id)sender {
    [[self delegate] nextTap:sender];
}

- (IBAction)skipBackward:(id)sender {
    // send the tap on to the delegate
//    NSLog(@" in CVC skipBackward... calling delegate....");        
	[[self delegate] backwardTap:sender];

}

- (IBAction)skipPrev:(id)sender {
    [[self delegate] prevTap:sender];
}

@end