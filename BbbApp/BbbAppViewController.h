//
//  BbbAppViewController.h
//  BbbApp
//
//  Created by Harry Layman on 10/20/12.
//  Copyright (c) 2012 Harry Layman. All rights reserved.
//
//
/*
 
 NSArray pageContent will provide an ordered list of NSStrings, one per page in the book.
 
 Thie pageContent array will be (re-)built from scratch each time the game loads; it will not run in the background. it could be built each time the settings are changed (to a new second language, for example).
 
 GLOBAL Data:
 
 a)  user language - use constant to provide 0 to 7 values -- from phone, but can override with settings.
 b)  second language -- one of remaining 7 languages (or none).  User selects on about screen, or set in settings. try for about screen like current apps.  default to CN for now.
 c)  show Romanization setting. only meaningful for second Language, only if KR/JP/CN
 
 and some base arrays loaded from database. these are loaded only once. 
 
 the page content array is built from these three arrays.
 
 
 Array:  Tiles
 
 288 tiles with PicPicImageNM for each tile's picture, plus 8 tileTXT fields and tileNM for CN, JP and KR/ txt and 3  fields, on for each language.
 
 
     these values are the index in to the tile image pic name, and txt value for L1 and L2, plus genderColor (0 for back; 1 red 2 blue 3 green)
 
 
 
 Array:  Sets
 
 16 sets with names in each of 8 languages.
 
 
 Array:  Version
 
 1 record.  used on about page to get global database version var
 
 in view did load, we do onetime load of database (with switch to prevent reloading).
 
 then in createPageContent we build that NSArray from the global database table loaded arrays.
 
 
 */

#import <UIKit/UIKit.h>
#import "ContentViewController.h"

#import <sqlite3.h> // 100905 import sqlite framework

//@class SoundEffect;

@interface BbbAppViewController : UIViewController
<UIPageViewControllerDataSource, UIPageViewControllerDelegate, PageControlDelegate> {

    NSString *k_L2;  // used with NSDefaults;
    NSString *k_L1;  // also settable....
    
    NSString *L1String_Setting;
    NSString *L2String_Setting;
    
    BOOL bL1R;
    BOOL bL2R; // append romanization if JP, CN, KR for L1 and L2 -- settings.
    
    NSString *databaseName, *databasePath;	//100905
    
    int userLangIDX, secondLangIDX;
    int kL1, kL2;   // values of user language, 2nd language
    int tileCNT;
    
    // used with NSDefaults
    

    
    BOOL bShowRomanization;
    BOOL hasLoadedDB;
    
#define TILESTBLSIZE 288
#define TILES_PERPAGE  4  // put in implementation file.
   
//  ARRAYs TO HOLD SETNAME

    NSString *setNM_CN[20], *setNM_DE[20], *setNM_EN[20], *setNM_ES[20];
    NSString *setNM_FR[20], *setNM_IT[20], *setNM_JP[20], *setNM_KR[20];
    
    
//  ARRAYs TO HOLD language NAMEs    
    NSString *langNM_CN[20], *langNM_DE[20], *langNM_EN[20], *langNM_ES[20];
    NSString *langNM_FR[20], *langNM_IT[20], *langNM_JP[20], *langNM_KR[20];
    NSString *secondLang[20];
    
    NSMutableString *settingsLabelDelimitedStringHolder;
    
// alloc NSMutableString in m file for this puprose...
    // make single string, tack onto end of NSArray, send to content view controller --
    //      hich will pass it to settingsPopoverViewcontroller if called....
    
    
    NSMutableString *setNMPart1, *txtWordL1, *txtWordL2;
//    NSMutableString *currentContentPageString;
    
    NSString *pageWordString;
    

    int      setID[20];  // should just hold 1 to 16 -- in element zero to 15.
    
    int     langID[20];  // should hold first 8 values for active languages 1 to 8.
    
    int gMaxSet, gMaxLang; // plan for 0 through 15
    int tilesPerPage; //  = TILES_PERPAGE;
    

    
    
    NSString *tilePicPicImageNM_db[TILESTBLSIZE]; // picture representing the word
    int tileSetID_db[TILESTBLSIZE];         // set containing this word
    int tileID_db[TILESTBLSIZE];
    

    
	NSString *tileTXT_cn[TILESTBLSIZE];     //
    NSString *tileTXT_de[TILESTBLSIZE];     //
    NSString *tileTXT_en[TILESTBLSIZE];     //
    NSString *tileTXT_es[TILESTBLSIZE];     //

    NSString *tileTXT_fr[TILESTBLSIZE];     //
    NSString *tileTXT_it[TILESTBLSIZE];     //
    NSString *tileTXT_jp[TILESTBLSIZE];     //
    NSString *tileTXT_kr[TILESTBLSIZE];     //

	NSString *tileNM_cn[TILESTBLSIZE];     //
    NSString *tileNM_jp[TILESTBLSIZE];     //
    NSString *tileNM_kr[TILESTBLSIZE];     //

    

    NSString *color_de[TILESTBLSIZE];     //
    NSString *color_es[TILESTBLSIZE];     //    
    NSString *color_fr[TILESTBLSIZE];     //
    NSString *color_it[TILESTBLSIZE];     //
    
    
    
    }



@property (strong, nonatomic) NSString *L2String_Setting;
@property (strong, nonatomic) NSString *L1String_Setting;

@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) NSArray *pageContent;
@property (readwrite, nonatomic) NSUInteger currentIndex;

// @property (strong, nonatomic) NSArray *pageContent2;
// this pageContent2 will be image file names and lable text -- now using the original array (name)with new string of my values..

- (void) updateCurrentIndex;
- (void) backwardTap:(id)sender;
- (void) forwardTap:(id)sender;
- (void) prevTap:(id)sender;
- (void) nextTap:(id)sender;


@end
