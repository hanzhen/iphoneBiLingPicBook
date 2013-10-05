//
//  constants.h
//  BbbApp
//
//  Created by Harry Layman on 10/21/12.
//  Copyright (c) 2012 Harry Layman. All rights reserved.
//

#ifndef BbbApp_constants_h
#define BbbApp_constants_h

// status for 1.36:  fixing
// other lang buttons work?

// fixed EN/DE intertwining by re-creating enBtn stuff.. storyboad issue.
// romanization won't change -- popover doesn't effect nsuserdefaults as it should (next! 1.37)
// tested in ehnchgils.  get "rom l2 turned off" in popover. but on boot -- not found and set to ...

// only remaining functionality is a) back and forth (move buttons?) and next / prev chapter!!!
//   oh -- and about page!



//  secondLangPref
#define kFirstLangChoice    @"L1Choice" //
#define	kSecondLangChoice	@"L2Choice"	//

#define kL1RomanizationChoice   @"L1RChoice"    //
#define	kL2RomanizationChoice	@"L2RChoice"	//


#define	kLanguageLabels	@"K1LangLabels"	//  -- set in NSUserDefaults by view did load for kL1
// database file name only here
#define kSoftwareVersion @"version 2.00" //  121102 1247PM // shown on about page
#define kDatabaseVersion @"databaseVersionKey" //
// shown on about page

#define kWLURL  @"http://www.wordzlianxi.com"

#define kDatabaseNameLW @"BBWBV404M.sl3"   //


#define kCN 0
#define kDE 1
#define kEN 2
#define kES 3
#define kFR 4
#define kIT 5
#define kJP 6
#define kKR 7
#define kRU 8
#define kPT 9

#define kBlack 0  // K
#define kRed 1    // R
#define kBlue 2   // U
#define kGreen 3  // G

#define kBlackSTR @"K"  // 0
#define kRedSTR @"R"    // 1
#define kBlueSTR @"U"   // 2
#define kGreenSTR @"G"  // 3


#define	kLES	@"ES"

#define	kLEN	@"EN"

#define	kLCN	@"CN" // fix! 121102

#define	kLIT	@"IT"

#define	kLDE	@"DE"

#define	kLFR 	@"FR"

#define	kLKR 	@"KR"

#define	kLJP 	@"JP"



#endif
