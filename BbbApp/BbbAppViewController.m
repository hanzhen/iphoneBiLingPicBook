//
//  BbbAppViewController.m
//  BbbApp
//
//  Created by Harry Layman on 10/20/12.
//  Copyright (c) 2012 Harry Layman. All rights reserved.
//
/*
 
 todo: 121029  add romanization for KR and JP.
 
 in content view,  use color. check color code here.
 
 fix APP at portrait; go to two lines of display for each word.
 
 =========
 
 one solution here is to create a single NSArray with one row per word.
 
 The array contents could be an NSString with a colon for separator (or piple, etc)
 
 the string would look like this:  tileid:tileNM-EN:tileTxt:TileNM-CN:tileTxt-CN: etc...
 
 but then i alsoneed set names,, and the image file names..
 
 maybe i can make the standard WTiles, WSets arrays "global" and available to indexed access by my new content pages??
 
 YES -- this might work need to understand datasource better. just a couple variables here: 
 
 
 1)  pageStrings is an NSMutable Array of NSStrings containing HTML (called contentString each time)
 
 2)  _pageContent is the NSArray initialized with the NSMutableArray "pageStrings"
 
    (allows to use getter and setter self.pageContent to rrefer to the array...
 
 
 can i have several of these arrays?
 
 dataViewController is created as a ContentViewController, and given 
 
 dataViewController.dataObject = _pageContent[index];

 note: header file declares pageContent as NSAarray.
 
 need to add all the other content arrays there. 
 
 the dataViewController is given a .dataobject of..
 
 i should just build my arrays here in this view controller object, and the use the "index" value to populate the ui areas.. oh but that is in the content view controller? 
 
 hmm..but we pass a data object to ContentViewController -- so if "self" (this view controller is the data object, it is getting all my arrays? check...
 
 
 -- see where dataObject is mapped to content strings 
 
 */

// #import "SoundEffect.h"


#import "BbbAppViewController.h"
#import "Constants.h"
#define TILES_PERPAGE  4  // put in implementation file. also in header file.


@interface BbbAppViewController ()

@end

@implementation BbbAppViewController

- (void)updateCurrentIndex
{
	ContentViewController *theCurrentViewController = (ContentViewController *)[self.pageController.viewControllers objectAtIndex:0];
	_currentIndex = [self indexOfViewController:theCurrentViewController];
    
//    NSLog(@"updateCurrentIndex, no currentIndex of %d", _currentIndex);     
}

- (void)backwardTap:(id)sender
{
//    NSLog(@"in backwardTap, with currentIndex of %d", _currentIndex);
    
	if (_currentIndex == 0) {
		return; // do nothing
	} else if (_currentIndex < 6) {
		_currentIndex = 0;
	} else {
		_currentIndex -= 5;
	}
	
	ContentViewController *toViewController = (ContentViewController *)[self viewControllerAtIndex:_currentIndex];
	[_pageController setViewControllers:[NSArray arrayWithObject:toViewController] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}

- (void)prevTap:(id)sender
{
    //    NSLog(@"in preevTap, with currentIndex of %d", _currentIndex);
    
	if (_currentIndex == 0) {
		return; // do nothing
	} else {
		_currentIndex -= 1;
	}
	
	ContentViewController *toViewController = (ContentViewController *)[self viewControllerAtIndex:_currentIndex];
	[_pageController setViewControllers:[NSArray arrayWithObject:toViewController] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}


- (void) forwardTap:(id)sender
{
//    NSLog(@"in forwardTap, with currentIndex of %d", _currentIndex);
    
	if (_currentIndex == ([self.pageContent count] - 1) ) {
		return;
	} else if (_currentIndex > ([self.pageContent count] - 6) ) {
		_currentIndex++;
	} else {
		_currentIndex += 5;
	}
	
	ContentViewController *toViewController = (ContentViewController *)[self viewControllerAtIndex:_currentIndex];
	[_pageController setViewControllers:[NSArray arrayWithObject:toViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void) nextTap:(id)sender
{
    //    NSLog(@"in forwardTap, with currentIndex of %d", _currentIndex);
    
	if (_currentIndex == ([self.pageContent count] - 1) ) {
		return;
	} else {
		_currentIndex += 1;
	}
	
	ContentViewController *toViewController = (ContentViewController *)[self viewControllerAtIndex:_currentIndex];
	[_pageController setViewControllers:[NSArray arrayWithObject:toViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}




// end of new
//- (void) createContentPages2
//{
//    NSMutableArray *pageStrings2 = [[NSMutableArray alloc] init];
//    for (int i = 1; i < 11; i++)
//    {
//        NSString *contentString2 = [[NSString alloc] initWithFormat:@"<html><head></head><body><h1>Chapter %d</h1><p>This is the page %d of content displayed using UIPageViewController in iOS 6.</p></body></html>", i, i];
//        [pageStrings2 addObject:contentString2]; }
//    
//    _pageContent2 = [[NSArray alloc] initWithArray:pageStrings2];
//}

@synthesize L1String_Setting, L2String_Setting;


#pragma mark -
#pragma mark FIrst time settings load

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    [self performSegueWithIdentifier: @"toSettingsPopover" sender: self];
//    
////    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
////    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SettingsPopoverViewController"];
////    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
////    
////    [self presentModalViewController:vc animated:NO];
//}


#pragma mark -
#pragma mark Game Setup -- Init data

-(void)initializeData {
    /*
 	 NSLog(@"start initializeData ... once per game ? ... ");
	 NSLog(@"%s %d %s %s", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__);
     */

if (!hasLoadedDB) { // onlye do once
    
	sqlite3 *database;

//    NSLog(@"In init data, one time routine....");
    // do easy thing first: get set names in 8 arrays and set ID's in one array
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        // Setup the SQL Statement and compile it for faster access
        const char *sqlStatement = "select setID, setNM_CN, setNM_DE, setNM_EN, setNM_ES, setNM_FR, setNM_IT, setNM_JP, setNM_KR from WSetsV4 where SetStatus = 'A' order by setID "; // identify active sets
        sqlite3_stmt *compiledStatement0;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement0, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            int mm = 1;
//            			NSLog(@"Now getting set %d...", mm);
            
            while(sqlite3_step(compiledStatement0) == SQLITE_ROW) {
                // Read the data from the result row
                
                setID[mm] = sqlite3_column_int(compiledStatement0, 0);
                
                setNM_CN[mm] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement0,1)];
                setNM_DE[mm] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement0,2)];
                setNM_EN[mm] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement0,3)];
                setNM_ES[mm] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement0,4)];
                
                setNM_FR[mm] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement0,5)];
                setNM_IT[mm] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement0,6)];
                setNM_JP[mm] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement0,7)];
                setNM_KR[mm] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement0,8)];
                
                //				NSLog(@"We got for idx %d =======>\ncol1: %d \tcol2: %@\n\n", mm, setID[mm], setNM[mm]);
              
                // halprog
//                NSLog(@"set name for CN is %@<", setNM_CN[mm]);
//                NSLog(@"set name for DE is %@<", setNM_DE[mm]);
                mm++;
                
                // Add the animal object to the animals Array
                //[animals addObject:animal];
                // [animal release];
            }
             mm--;  // started counting with zero, so max set is 16
            
//            NSLog(@"finished with jj - found %d sets.", mm); // 100911 store number of setz !
            gMaxSet = mm ;         // note was mm was corrected
        }
        else {
//            NSLog(@"Error with preparing select statement to get set names.");
            
        }
        
        // Release the compiled statement from memory
        sqlite3_finalize(compiledStatement0);
        
    }
    else {
        NSLog(@"Could not open database!. ");
        
    }
    
    // Now get tile data and load image file name, tileNM, TileTXT and color_XX arrays... 
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        // Setup the SQL Statement and compile it for faster access
        const char *sqlStatement3 = "select tileID, setID, tileWordPicImageNM, tileNM_CN, tileTXT_CN, tileTXT_DE, tileColor_DE, tileTXT_EN, tileTXT_ES, tileColor_ES, tileTXT_FR, tileColor_FR, tileTXT_IT, tileColor_IT, tileNM_JP, tileTXT_JP, tileNM_KR, tileTXT_KR from  WTilesV4 where tileStatus = 1 order by setID, tileID;"; // identify active tiles by set in order
        sqlite3_stmt *compiledStatement2;
        if(sqlite3_prepare_v2(database, sqlStatement3, -1, &compiledStatement2, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            int mm = 0;  tileCNT = 1;
//            NSLog(@"Now getting set %d...", mm);
            
            while(sqlite3_step(compiledStatement2) == SQLITE_ROW) {
                // Read the data from the result row

                tileID_db[mm]    = sqlite3_column_int(compiledStatement2, 0);
                tileSetID_db[mm] = sqlite3_column_int(compiledStatement2, 1);
                
                tilePicPicImageNM_db[mm] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement2,2)];
                tileNM_cn[mm]  = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement2,3)];
                tileTXT_cn[mm] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement2,4)];
                tileTXT_de[mm] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement2,5)];
                color_de[mm] =   [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement2,6)];
                tileTXT_en[mm] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement2,7)];
                tileTXT_es[mm] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement2,8)];
                color_es[mm]   = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement2,9)];
                tileTXT_fr[mm] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement2,10)];
                color_fr[mm]   = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement2,11)];
                tileTXT_it[mm] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement2,12)];
                color_it[mm]   = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement2,13)];
                tileNM_jp [mm]  = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement2,14)];
                tileTXT_jp[mm]  = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement2,15)];
                tileNM_kr [mm]  = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement2,16)];
                tileTXT_kr[mm]  = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatement2,17)];
                

                             
                //				NSLog(@"We got for idx %d =======>\ncol1: %d \tcol2: %@\n\n", mm, setID[mm], setNM[mm]);
                
                // halprog
//                if (mm < 35) {
//                    NSLog(@"tile number %d:", mm);
//                    NSLog(@"tileID_db value is:%d<",tileID_db[mm]);
//                    NSLog(@"tileSetID_db value is:%d<",tileSetID_db[mm]);
//                    
//                NSLog(@"tile TXT for CN is %@<", tileTXT_cn[mm]);
//                NSLog(@"tile TXT for DE is %@<", tileTXT_de[mm]);
//                NSLog(@"tile NM for CN is %@<", tileNM_cn[mm]);
//                NSLog(@"tile color for DE is %@<", color_de[mm]);
//                    
//                    
//                    
//                }
                mm++;
                tileCNT++;
                
                // Add the animal object to the animals Array
                //[animals addObject:animal];
                // [animal release];
            }
            mm--;  // started counting with zero, so max set is 16
            tileCNT--;
            
//            NSLog(@"finished with jj - found %d tiles.", tileCNT); //
            gMaxSet = mm ;         // note was mm was corrected
        }
        else {
            NSLog(@"Error with preparing select statement to get set names.");
            
        }
        
        // Release the compiled statement from memory
        sqlite3_finalize(compiledStatement2);
        
    }
    else {
        NSLog(@"Could not open database!. ");
        
    }


    // Tile INFO loaded in all arrays.

    //  now get language names -- load 8 sets of names for 8 languages.
    // do easy thing first: get set names in 8 arrays and set ID's in one array
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        // Setup the SQL Statement and compile it for faster access
        const char *sqlStatementLc = "select langID, cnNM, deNM, enNM, esNM, frNM, itNM, jpNM, krNM from WLangV4 where langStatus = 1 order by langID "; // identify active languages
        sqlite3_stmt *compiledStatementLL;
        if(sqlite3_prepare_v2(database, sqlStatementLc, -1, &compiledStatementLL, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            int nn = 0;
            //            			NSLog(@"Now getting set %d...", mm);
            // note row zero of all arrays will have language phrase for "second language".
            
            while(sqlite3_step(compiledStatementLL) == SQLITE_ROW) {
                // Read the data from the result row
                
                langID[nn] = sqlite3_column_int(compiledStatementLL, 0);
                
                langNM_CN[nn] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatementLL,1)];
                langNM_DE[nn] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatementLL,2)];
                langNM_EN[nn] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatementLL,3)];
                langNM_ES[nn] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatementLL,4)];
                
                langNM_FR[nn] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatementLL,5)];
                langNM_IT[nn] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatementLL,6)];
                langNM_JP[nn] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatementLL,7)];
                langNM_KR[nn] = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatementLL,8)];
                
//	debug			NSLog(@"We got for idx %d =======>\nlangID[nn]: %d \tlangNM_EN[nn]: %@\n\n", nn, langID[nn], langNM_EN[nn]);
                
                // halprog
                //                NSLog(@"set name for CN is %@<", setNM_CN[mm]);
                //                NSLog(@"set name for DE is %@<", setNM_DE[mm]);
                nn++;
                
                // Add the animal object to the animals Array
                //[animals addObject:animal];
                // [animal release];
            }
            nn--;  // started counting with zero, so max set is 16
            
            //            NSLog(@"finished with jj - found %d sets.", mm); // 100911 store number of setz !
            gMaxLang = nn ;         // note was mm was corrected
        }
        else {
            //            NSLog(@"Error with preparing select statement to get set names.");
            
        }
        
        // Release the compiled statement from memory
        sqlite3_finalize(compiledStatementLL);
        
    }
    else {
        NSLog(@"Could not open database!. ");
        
    }
    //  end of getting language names
    
    // get version data
    
    // READ IN ALL THE Version info from the database ========START  ===============100916=========>>>>>>>>>>>>>>>>>
    
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatementVc = "select BbwbVNMB, BbwbVModifiedDT, BbwbVComment from BbwbV "; // identify active sets
		sqlite3_stmt *compiledStatementVV;
		if(sqlite3_prepare_v2(database, sqlStatementVc, -1, &compiledStatementVV, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			int mm = 1;
            //			NSLog(@"Now getting set %d...", mm);
			
			while(sqlite3_step(compiledStatementVV) == SQLITE_ROW) {
				// Read the data from the result row
				
				NSString *wVNMB, *wDBDT, *wVCM; // *dbVersionString;
				
				wVNMB = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatementVV,0)];
				wDBDT = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatementVV,1)];
				wVCM  = [[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(compiledStatementVV,2)];
				
//     			NSLog(@"We got for dbVer =======>\ncol1: %@ \tcol2: %@ \tcol3: %@\n", wVNMB, wDBDT, wVCM);    // debug
				mm++;
				
//				NSString *dbVersionString = [NSString stringWithFormat:@"%@|%@|%@|", wVNMB, wDBDT, wVCM];
				NSString *dbVersionString = [NSString stringWithFormat:@"%@|%@|", wVNMB, wDBDT];
				
				[[NSUserDefaults standardUserDefaults] setObject:dbVersionString forKey:kDatabaseVersion];
				
                //				NSLog(@"\tWrote out databaseVersion as: %@", dbVersionString);
//				[wVNMB release];
//                [wDBDT release];
//                [wVCM  release];
				
				
				// Add the animal object to the animals Array
				//[animals addObject:animal];
				// [animal release];
			}
			mm--;
            //			NSLog(@"finished with jj - found %d V recs.", mm); //
			
			// save in perfs for future use.
			
            
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatementVV);
		
	}
	
	
    // READ IN ALL THE Version info from the database ========END    ===============100916=========>>>>>>>>>>>>>>>>>
    
    
    
    
    // end of getting version data
    
} // end of (!hasLoadedDB) condition - one time database load
    
}

- (void) setupDatabase {
    //	NSLog(@"In setupDatabase routine.... ");
	hasLoadedDB = NO;

	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	
	// Execute the "checkAndCreateDatabase" function
	[self checkAndCreateDatabase];
	
}  // setupDatabase

- (void) checkAndCreateDatabase {
	// Check if the SQL database has already been saved to the users phone, if not then copy it over
	BOOL success;
    //	NSLog(@"In checkAndCreateDatabase routine.... ");
    
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
    //	NSLog(@"\n\ncopy of db in documents folder is at %@\n==\n", databasePath);
	
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:databasePath];
	// success = FALSE; // force new copy +++++++++++>>>> sest back debug change!!!
	
	// If the database already exists then return without doing anything
	// we could check the version and overwrite it if it is old!!! 100905 hal
	if(success) return;
	
	// If not then proceed to copy the database from the application to the users filesystem
	
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    
    //	NSLog(@"\n\ncopy of db at source in bundel is at %@\n===\n", databasePathFromApp);
    
	// Copy the database from the package to the users filesystem
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
	
    //	[fileManager release];
	
    //	NSLog(@"leaving checkAndCreateDatabase...");
    
    
    
    
}
-(void)appendCurrentSetName:(NSMutableString *)stringToAppend
                        set:(int) setIDX
                       lang:(int)langIDX   {
    
    if (langIDX == kCN) {
        [stringToAppend appendString:setNM_CN[setIDX]];
    } else if (langIDX == kDE) {
        [stringToAppend appendString:setNM_DE[setIDX]];
    } else if (langIDX == kEN) {
        [stringToAppend appendString:setNM_EN[setIDX]];
    } else if (langIDX == kES) {
        [stringToAppend appendString:setNM_ES[setIDX]];
    } else if (langIDX == kFR) {
        [stringToAppend appendString:setNM_FR[setIDX]];
    } else if (langIDX == kIT) {
        [stringToAppend appendString:setNM_IT[setIDX]];
    } else if (langIDX == kJP) {
        [stringToAppend appendString:setNM_JP[setIDX]];
    } else if (langIDX == kKR) {
        [stringToAppend appendString:setNM_KR[setIDX]];
    } else {
        [stringToAppend appendString:setNM_EN[setIDX]];
    }
    
}

-(void)appendCurrentTileInfo:(NSMutableString *)stringToAppend
                        tile:(int) tileIDX
                       lang1:(int)lang1IDX
                       lang2:(int)lang2IDX
{
    
//    NSLog(@"in appendCurrentTileInfo: this is current string :%@<", stringToAppend );

    
    
// for each  tile, add: L1Text:COLOR:L2Text:COLOR:Image11-filename:
    
// two cases, one for each text needed; space only if kl2 is kl1.
    
// L1 wordTXT

    
    if (lang1IDX == kCN) {
//            [stringToAppend appendFormat:@"%@:%@:", tileTXT_cn[tileIDX], @"K"];
        if (bL1R) {
            [stringToAppend appendFormat:@"%@%@%@%@:%@:", tileTXT_cn[tileIDX], @" - (", tileNM_cn[tileIDX], @")", @"K"];
        } else {
            [stringToAppend appendFormat:@"%@:%@:", tileTXT_cn[tileIDX], @"K"];
        }
        
    } else if (lang1IDX == kDE) {
        [stringToAppend appendFormat:@"%@:%@:", tileTXT_de[tileIDX], color_de[tileIDX]];
    } else if (lang1IDX == kEN) {
        [stringToAppend appendFormat:@"%@:%@:", tileTXT_en[tileIDX], @"K"];
    } else if (lang1IDX == kES) {
        [stringToAppend appendFormat:@"%@:%@:", tileTXT_es[tileIDX], color_es[tileIDX]];
    } else if (lang1IDX == kFR) {
        [stringToAppend appendFormat:@"%@:%@:", tileTXT_fr[tileIDX], color_fr[tileIDX]];
    } else if (lang1IDX == kIT) {
        [stringToAppend appendFormat:@"%@:%@:", tileTXT_it[tileIDX], color_it[tileIDX]];
    } else if (lang1IDX == kJP) {
        
//        [stringToAppend appendFormat:@"%@:%@:", tileTXT_jp[tileIDX], @"K"];
        if (bL1R) {
            [stringToAppend appendFormat:@"%@%@%@%@:%@:", tileTXT_jp[tileIDX], @" - (", tileNM_jp[tileIDX], @")", @"K"];
        } else {
            [stringToAppend appendFormat:@"%@:%@:", tileTXT_jp[tileIDX], @"K"];
        }

    } else if (lang1IDX == kKR) {
        
//        [stringToAppend appendFormat:@"%@:%@:", tileTXT_kr[tileIDX], @"K"];
        if (bL1R) {
            [stringToAppend appendFormat:@"%@%@%@%@:%@:", tileTXT_kr[tileIDX], @" - (", tileNM_kr[tileIDX], @")", @"K"];
        } else {
            [stringToAppend appendFormat:@"%@:%@:", tileTXT_kr[tileIDX], @"K"];
        }

        
    } else {
        [stringToAppend appendFormat:@"%@:%@:", tileTXT_en[tileIDX], @"K"];
    }
    
    // L2 wordTXT

    if (lang1IDX == lang2IDX) {
        // then show blank for L2
        [stringToAppend appendFormat:@"%@:%@:", @" ", @"K"];
    } else {
//
        if (lang2IDX == kCN) {
//                        [stringToAppend appendFormat:@"%@:%@:", tileTXT_cn[tileIDX], @"K"];
            if (bL2R) {
                [stringToAppend appendFormat:@"%@%@%@%@:%@:", tileTXT_cn[tileIDX], @" - (", tileNM_cn[tileIDX], @")", @"K"];
            } else {
                [stringToAppend appendFormat:@"%@:%@:", tileTXT_cn[tileIDX], @"K"];
            }
        } else if (lang2IDX == kDE) {
            [stringToAppend appendFormat:@"%@:%@:", tileTXT_de[tileIDX], color_de[tileIDX]];
        } else if (lang2IDX == kEN) {
            [stringToAppend appendFormat:@"%@:%@:", tileTXT_en[tileIDX], @"K"];
        } else if (lang2IDX == kES) {
            [stringToAppend appendFormat:@"%@:%@:", tileTXT_es[tileIDX], color_es[tileIDX]];
        } else if (lang2IDX == kFR) {
            [stringToAppend appendFormat:@"%@:%@:", tileTXT_fr[tileIDX], color_fr[tileIDX]];
        } else if (lang2IDX == kIT) {
            [stringToAppend appendFormat:@"%@:%@:", tileTXT_it[tileIDX], color_it[tileIDX]];
        } else if (lang2IDX == kJP) {
//            [stringToAppend appendFormat:@"%@:%@:", tileTXT_jp[tileIDX], @"K"];
            if (bL2R) {
                [stringToAppend appendFormat:@"%@%@%@%@:%@:", tileTXT_jp[tileIDX], @" - (", tileNM_jp[tileIDX], @")", @"K"];
            } else {
                [stringToAppend appendFormat:@"%@:%@:", tileTXT_jp[tileIDX], @"K"];
            }
        } else if (lang2IDX == kKR) {
            
//            [stringToAppend appendFormat:@"%@:%@:", tileTXT_kr[tileIDX], @"K"];
            if (bL2R) {
                [stringToAppend appendFormat:@"%@%@%@%@:%@:", tileTXT_kr[tileIDX], @" - (", tileNM_kr[tileIDX], @")", @"K"];
            } else {
                [stringToAppend appendFormat:@"%@:%@:", tileTXT_kr[tileIDX], @"K"];
            }
        } else {
            [stringToAppend appendFormat:@"%@:%@:", tileTXT_en[tileIDX], @"K"];
        }
      
//
    }
    // finally, add tile's image file name
    
    [stringToAppend appendFormat:@"%@:", tilePicPicImageNM_db[tileIDX]];

//    NSLog(@"result, wiht new tile:%@<", stringToAppend );
    
    
}  // end of appendCurrentTileInfo for tileIDX kK1, kL2


- (void) createSettingsLables {    // working here -- need to do this each time kL1 is changed... or each execution... 
//    NSLog(@"in create settings labels...  current lang is %d", kL1);
    // need to populate settingsLabelDelimitedStringHolder
    
    if (kL1 == kCN) {
        settingsLabelDelimitedStringHolder =  [[NSMutableString alloc] initWithFormat: @"%d:%d:%@:", kL1, kL2, langNM_CN[0]];
        for (int r = 1; r<9; r++) {
                      [settingsLabelDelimitedStringHolder  appendFormat:@"%@:", langNM_CN[r]];
        }
    } else if (kL1 == kDE) {
        settingsLabelDelimitedStringHolder =  [[NSMutableString alloc] initWithFormat: @"%d:%d:%@:", kL1, kL2, langNM_DE[0]];
        for (int r = 1; r<9; r++) {
            [settingsLabelDelimitedStringHolder  appendFormat:@"%@:", langNM_DE[r]];
        }
    } else if (kL1 == kEN) {
        settingsLabelDelimitedStringHolder =  [[NSMutableString alloc] initWithFormat: @"%d:%d:%@:", kL1, kL2, langNM_EN[0]];
        for (int r = 1; r<9; r++) {
            [settingsLabelDelimitedStringHolder  appendFormat:@"%@:", langNM_EN[r]];
        }
    } else if (kL1 == kES) {
        settingsLabelDelimitedStringHolder =  [[NSMutableString alloc] initWithFormat: @"%d:%d:%@:", kL1, kL2, langNM_ES[0]];
        for (int r = 1; r<9; r++) {
            [settingsLabelDelimitedStringHolder  appendFormat:@"%@:", langNM_ES[r]];
        }
    } else if (kL1 == kFR) {
        settingsLabelDelimitedStringHolder =  [[NSMutableString alloc] initWithFormat: @"%d:%d:%@:", kL1, kL2, langNM_FR[0]];
        for (int r = 1; r<9; r++) {
            [settingsLabelDelimitedStringHolder  appendFormat:@"%@:", langNM_FR[r]];
        }
    } else if (kL1 == kIT) {
        settingsLabelDelimitedStringHolder =  [[NSMutableString alloc] initWithFormat: @"%d:%d:%@:", kL1, kL2, langNM_IT[0]];
        for (int r = 1; r<9; r++) {
            [settingsLabelDelimitedStringHolder  appendFormat:@"%@:", langNM_IT[r]];
        }
    } else if (kL1 == kJP) {
        settingsLabelDelimitedStringHolder =  [[NSMutableString alloc] initWithFormat: @"%d:%d:%@:", kL1, kL2, langNM_JP[0]];
        for (int r = 1; r<9; r++) {
            [settingsLabelDelimitedStringHolder  appendFormat:@"%@:", langNM_JP[r]];
        }
    } else if (kL1 == kKR) {
        settingsLabelDelimitedStringHolder =  [[NSMutableString alloc] initWithFormat: @"%d:%d:%@:", kL1, kL2, langNM_KR[0]];
        for (int r = 1; r<9; r++) {
            [settingsLabelDelimitedStringHolder  appendFormat:@"%@:", langNM_KR[r]];
        }
    } else  {   // shouldn't get here but if so use English
        settingsLabelDelimitedStringHolder =  [[NSMutableString alloc] initWithFormat: @"%d:%d:%@:", kL1, kL2, langNM_EN[0]];
        for (int r = 1; r<9; r++) {
            [settingsLabelDelimitedStringHolder  appendFormat:@"%@:", langNM_EN[r]];
        }
    }
    
//    NSLog( @"String is ready as>%@<", settingsLabelDelimitedStringHolder);
    
//    	[[NSUserDefaults standardUserDefaults] setObject:dbVersionString forKey:kDatabaseVersion];

     NSString *dbLangLabelString = [NSString stringWithFormat:@"%@", settingsLabelDelimitedStringHolder];

    
    [[NSUserDefaults standardUserDefaults] setObject:dbLangLabelString forKey:kLanguageLabels];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void) createContentPages
{   // arrays of info for word images and labels...
    
    NSMutableArray *pageStrings = [[NSMutableArray alloc] init];
    
    NSMutableString *workingPageString[TILESTBLSIZE + 1];  // add lables as finale string.
    
    
//    currentContentPageString = [[NSMutableString alloc] init]; // hold pageString content as being built
    
    setNMPart1 = [[NSMutableString alloc] init]; // hold set name for creation of one page.
    txtWordL1  = [[NSMutableString alloc] init]; // hold L1 word text for each word on the page; used four times per page.
    txtWordL2  = [[NSMutableString alloc] init]; // hold L2 word text for each word on the page; used four times per page.
    
    
    int tileNO, currentPageNO, currentSetNO, currentTileNbrOnPage;
    
    tilesPerPage = TILES_PERPAGE; // 4 now; could be 2 for iphone.
    
   
    
//      for (int i = 1; i < 2; i++)
//    {
//        NSString *contentString = [[NSString alloc] initWithFormat:@"<html><head></head><body><h1>Chapter %d</h1><p>This is the page %d of content displayed using UIPageViewController in iOS 6.</p></body></html>", i, i];
//        [pageStrings addObject:contentString]; }
    
    // should initial value of string be 0, 1 or 1, 2. i think latter but checking
    // either way first element of NSarry is sub-0

//    NSString *contentString = [[NSString alloc] initWithFormat:@"%d:%d:%d:%d:1:2:3:4:1:On The Go:boat:K:船 - chuan2:K:boat_chuan2_pic100.png:car:K:汽车 - che1:K:car_che1_pic100.png:truck:K:卡车 - ka3che1:K:truck_ka3che1_pic100.png:plane:K:飞机 - fei1ji1:K:plane_fei1ji1_pic100.png:", 1, kEN, kCN, 4];
//        [pageStrings addObject:contentString];
//
//    NSString *contentString3 = [[NSString alloc] initWithFormat:@"%d:%d:%d:%d:5:6:7:8:1:On The Go:bicycle:K:自行车 - zi4xing2che1:K:bike_zi4xing2che1_pic100.png:ambulance:K:救护车 - jiu4hu4che1:K:ambulance_jiuhuche_pic100.png:iceskates:K:冰刀 - bing1dao1:K:ice_skates_bingdao_pic100.png:canoe:K:独木舟 - du2mu4zhou3:K:canoe_dumuzhou_pic100.png:", 2, kEN, kCN, 4];
//    
//    THis is where we set up the first page level entries for the pageContent NSString object:
//    
//        first 10 values: pageno,
//        
//        Each page will be encoded into a string, for language pair L1L2, as follows:
//            
//            1:L1:L2:4:1:2:3:4:N:Set Name:
//            L111-Text:COLOR:L211-Text:COLOR:Image11-filename:     (continues)
//            L112-Text:COLOR:L212-Text:COLOR:Image12-filename:     (continues)
//            L121-Text:COLOR:L221-Text:COLOR:Image21-filename:     (continues)
//            L122-Text:COLOR:L222-Text:COLOR:Image22-filename:     (continues)
//            
//            meaning of string:
//            first value is page number
//            L1 code (kCN, kEN, etc or 0 thru 7 for 8 languages)
//            L2 code (kCN, kEN, etc or 9 thru 8 for 8 languages)  (if dupe of L1, L2 is not processed)
//            4: number of items on this page, between 1 and 4
//            N: set number (1 to 16)
//            Name of the current set (as page title)
//            1:2:3:4:  these are the (up to) 4 tile IDs for this page; zero means no tile
//    
//    so these first 10 fields are for documentations -- although the first one tells you which page you are one.
    

    
//    
//    
//        [pageStrings addObject:contentString3];
    
//    
//    
//    NSLog(@"pageStrings 1 :%@<<", pageStrings[0]);
//    
//    NSLog(@"pageStrings 2 :%@<<", pageStrings[1]);
    

    
// first tile process.
    
    
    tileNO = tileID_db[0];
    currentPageNO = 1; currentTileNbrOnPage = 1;
    
//    NSLog(@"process first tile...  %d, current tileNbrOnPage is %d<", tileNO, currentTileNbrOnPage);  // trackhal
    
    //  get current tile number.
    currentSetNO = tileSetID_db[0];  // first tile's set.
    /// halprog note:  hardcoded 4 as number on page, and tileno's 1/2/3/4 -- not using these values for now 121027 ver 1.04
    
    
     workingPageString[1] =  [[NSMutableString alloc] initWithFormat: @"%d:%d:%d:%d:1:2:3:4:%d:", currentPageNO, kL1, kL2, 4, currentSetNO];
    
    
    [self appendCurrentSetName:workingPageString[1] set:currentSetNO lang:kL1];
    
    [workingPageString[1]  appendFormat:@" - %@ %d:",pageWordString, currentPageNO];  // aaa
    
    [self appendCurrentTileInfo:workingPageString[1] tile:0 lang1:kL1 lang2:kL2];
    
//    NSLog(@"Finished first tile...");
    
    

//   add first tile to currentCOntentPageString
    
     
     //    meaning of string:
     //    first value is page number
     //    L1 code (kCN, kEN, etc or 0 thru 7 for 8 languages)
     //    L2 code (kCN, kEN, etc or 9 thru 8 for 8 languages)  (if dupe of L1, L2 is not processed)
     //    4: number of items on this page, between 1 and N: set number (1 to 16)
     //    Name of the current set (as page title)
     //    1:2:3:4:  these are the (up to) 4 tile IDs for this page; zero means no tile
     //
     //    so these first 10 fields are for documentations -- although the first one tells you which page you are one.
    
//      for (int i = 0; i < tileCNT; i=i+3)
//    {
//        // for which language, get set name, tileTXT-lable, and (if ES/DE/FR/IT/ get color and set others to black) and
//        //  if CN/JP/KR, append tileNM to tileTXT-label value
//        
//        NSLog(@"For tile i = %d.", i);
//        
    
/***********************************************
 
 re-plan: just one loop for all tiles, increment by 1
 
 read first, then process tile.
 
 in process tile, have mini-loop to deal with last tile on page.

 at end, process page if partial page remains. 
 
 goal: work for 2 or 4 tiles-per-page.
 
 
 Process first tile. meaning:
 
 init new mutable string currentContentPageString.
 init new mutable string currentTilePageContentString.
 
 Store currentSetNo, get setname for set for L1.
 
 store tileNo.
 
 set tileNoOnPage = 1.  set currentPageNo = 1.
 
 Add first 10 lelements to currentContentPageString
 
 create and append first tile element (as currentTilePageContentString) to currentTilePageContentString.
 
 then process remaining tiles.
 
 (process tile zero, then tiles 1 to N-1. --> skipping tile zoer.
 
 
 for i = 1 to tileCNT - 1 do:
 
 
 process one tile, which means:
 

 Is new setNo? if so startNewSetPage. 
        [ move currentContentPageString to pageContent Array of NSStrings.
        [ increment currentPageNo, set tileNoOnPage = 1, 
        [ store TileNo, currentSetNo using this tile.
        [ init new currentContentPageString; init first 10 elements.
        [ create and append first tile element to page.
        [ continue;
 
 // not new set.  increment tileNoOnPage.
 
 
 Is first tile of new page?  (e.g. is tileNoOnPage > tiles-per-page? if yes do:
         [ move currentContentPageString to pageContent Array of NSStrings.
         [ increment currentPageNo, set tileNoOnPage = 1,
         [ store TileNo, currentSetNo using this tile.
         [ init new currentContentPageString; init first 10 elements.
         [ create and append first tile element to page.
         [ continue;
         
 // not new page or new set -- add tile to existing page.
 
 create and append this tile element (as currentTilePageContentString) to currentTilePageContentString.
 
 
 Is Last tile?  (e.g. i = tileCNT)?    if yes do:
        [ move currentContentPageString to pageContent Array of NSStrings.
 
 DONE!
 
  
 
 
***********************************************/
        
//
//        NSLog(@"i is %d and tileSetID_db[i] is %d and does setNM_EN(1) have content and is it accessible?", i, tileSetID_db[i]);
//        NSLog(@" see tileSetID_db[i] is %d and setNM_EN[1] is %@< and setNM_EN[tileSetID_db[i]] is %@<", tileSetID_db[i], setNM_EN[1], setNM_EN[tileSetID_db[i]]);
   
//        NSLog(@"kL1 is language number   %d and kEN is  %d", kL1, kEN);
    
//    NSLog(@"going to proceess tiles from 1 to %d", tileCNT - 1);
    

//        currentTileNbrOnPage++;  // account for first tile processed -- make sure unique to very first, not new sets etc.
    
// -----================================================================  create all the tile specific strings for the page content array
    
        for (int i = 1; i < tileCNT; i++)
        {

//    NSLog(@"process tile i=> %d, current tileNbrOnPage is %d<", i, currentTileNbrOnPage);  // trackhal
//    NSLog(@"process first tile...  %d, current tileNbrOnPage is %d<", tileNO, currentTileNbrOnPage);  // trackhal
            
//    cases:   new set, new page, all others (just another item)
//    check for new set first, then full page, then end of tiles.
            
//            case: new set
//            Is new setNo? if so startNewSetPage.
//                [ move currentContentPageString to pageContent Array of NSStrings.
//                 [ increment currentPageNo, set tileNoOnPage = 1,
//                  [ store TileNo, currentSetNo using this tile.
//                   [ init new currentContentPageString; init first 10 elements.
//                    [ create and append first tile element to page.
//                     [ continue;

            
            

            
            if (!(currentSetNO == tileSetID_db[i])) { // we have a new set.
                
//                NSLog(@"process new set. >>>>>>>>>>>>>>>>>>>  Old vars:  i= %d, tileNO>%d", i, tileNO);  // trackhal
//                NSLog(@"transition from %@< to %@<  XXYXX.", setNM_EN[currentSetNO], setNM_EN[tileSetID_db[i]] );
                
                [pageStrings addObject:workingPageString[currentPageNO]]; // halprog xxx 
                
//                NSLog(@"Just added NSString to pageString >>>>>>>>>>>>>>> %d<", currentPageNO);
                currentPageNO++;
                currentSetNO = tileSetID_db[i];
                tileNO = tileID_db[i];

                currentTileNbrOnPage = 1;
                
// currentPageNO

//                workingPageString[1] =  [[NSMutableString alloc] initWithFormat: @"%d:%d:%d:%d:1:2:3:4:%d:", currentPageNO, kL1, kL2, 4, currentSetNO];
                
//                NSMutableString *currentContentPageString =  [[NSMutableString alloc] initWithFormat: @"%d:%d:%d:%d:1:2:3:4:%d:", tileNO, kL1, kL2, 4, currentSetNO];
                
//                [currentContentPageString initWithFormat: @"%d:%d:%d:%d:1:2:3:4:%d:", tileNO, kL1, kL2, 4, currentSetNO];
                
//                NSLog(@"key data: tileNo %d, currentPageNO %d, currentTileNbrOnPage %d", tileNO, currentPageNO, currentTileNbrOnPage);
                
                workingPageString[currentPageNO] = [[NSMutableString alloc] initWithFormat: @"%d:%d:%d:%d:1:2:3:4:%d:", currentPageNO, kL1, kL2, 4, currentSetNO];
                
//                NSMutableString *currentContentPageString =  [[NSMutableString alloc] initWithFormat: @"%d:%d:%d:%d:1:2:3:4:%d:", currentPageNO, kL1, kL2, 4, currentSetNO];
                
                [self appendCurrentSetName:workingPageString[currentPageNO] set:currentSetNO lang:kL1];
                
                [workingPageString[currentPageNO]  appendFormat:@" - %@ %d:",pageWordString, currentPageNO]; // bbb
                
                [self appendCurrentTileInfo:workingPageString[currentPageNO] tile:i lang1:kL1 lang2:kL2];  // eye-th array element -- not TileNO
                
                
//                NSLog(@"AAA currentContentPageSTring is now:%@", workingPageString[currentPageNO]); // debug
                
                

                continue; // does next iteration of i , next tile!

                
            };
    
//          case: new page
//          Is first tile of new page?  (e.g. is tileNoOnPage > tiles-per-page? if yes do:
//                                         [ move currentContentPageString to pageContent Array of NSStrings.
//                                          [ increment currentPageNo, set tileNoOnPage = 1,
//                                           [ store TileNo, currentSetNo using this tile.
//                                            [ init new currentContentPageString; init first 10 elements.
//                                             [ create and append first tile element to page.
//                                              [ continue;

    
            if (currentTileNbrOnPage == tilesPerPage)  { // we have a new page
                
//                NSLog(@"process new page.>>>> O ld vars:  i= %d, tileNO>%d", i, tileNO);  // trackhal
                
                
                [pageStrings addObject:workingPageString[currentPageNO]];
                
//                NSLog(@"Just added NSString to pageString >>>>>>>>>>>>>>> %d<", currentPageNO);                
                
                currentTileNbrOnPage = 1;
                currentPageNO++;
                currentSetNO = tileSetID_db[i];
                tileNO = tileID_db[i];
                
                //                NSMutableString *currentContentPageString =  [[NSMutableString alloc] initWithFormat: @"%d:%d:%d:%d:1:2:3:4:%d:", currentPageNO, kL1, kL2, 4, currentSetNO];
                
//                [currentContentPageString initWithFormat: @"%d:%d:%d:%d:1:2:3:4:%d:", tileNO, kL1, kL2, 4, currentSetNO];
                workingPageString[currentPageNO] = [[NSMutableString alloc] initWithFormat: @"%d:%d:%d:%d:1:2:3:4:%d:", currentPageNO, kL1, kL2, 4, currentSetNO];

                //                NSMutableString *currentContentPageString =  [[NSMutableString alloc] initWithFormat: @"%d:%d:%d:%d:1:2:3:4:%d:", currentPageNO, kL1, kL2, 4, currentSetNO];
                
//                NSLog(@"BBB currentContentPageSTring is now:%@", workingPageString[currentPageNO]); // debug
                
                [self appendCurrentSetName:workingPageString[currentPageNO] set:currentSetNO lang:kL1];
                
                [workingPageString[currentPageNO]  appendFormat:@" - %@ %d:",pageWordString, currentPageNO]; // ccc
                
                [self appendCurrentTileInfo:workingPageString[currentPageNO] tile:i lang1:kL1 lang2:kL2];

                

                continue; // does next iteration of i , next tile!
            
            }
            

//          case:  just add tile to current page

            if (!(i == tileCNT - 1)) { //   not final tile;
                
//                NSLog(@"process tile  old vars:  i= %d, prior tileNO>%d", i, tileNO);  // trackhal
                
            
                tileNO = tileID_db[i];
            
                [self appendCurrentTileInfo:workingPageString[currentPageNO] tile:i lang1:kL1 lang2:kL2];
                currentTileNbrOnPage++;
                continue; // does next iteration of i , next tile
                
            
            //          case:  last tile
            }
            else {
                tileNO = tileID_db[i];

//                NSLog(@"process final  tile  old vars:  i= %d, tileNO>%d", i, tileNO);  // trackhal
                
                
                [self appendCurrentTileInfo:workingPageString[currentPageNO] tile:i lang1:kL1 lang2:kL2];
                currentTileNbrOnPage++;

                [pageStrings addObject:workingPageString[currentPageNO]];  // add final NSString to pageContent  arry
                
            }

            
            
/***********************************************            
            

 
 
 here we add L1 text (set color, ad romanization if needed); and if L2 is different language, add text, color and perhaps romiznations.
 
 if L2 is same as L1, set two text strings to a single blank. color black,
 
 
 
***********************************************/
            
// code to add up to four tiles -- watch out for new set? or skip this for now. assume boundaries dealt with in data.
//            
//
//        if (kL1 == kCN) {
//            // kL1 = kCN;
//            NSString *setNMPart = [[NSString alloc] initWithFormat:@"%@", setNM_CN[tileSetID_db[i]]];
//            setNMPart1 = [NSMutableString stringWithString: setNMPart];
////            
////            NSLog(@"We are using CN; creating setNMPart string... ");
////            NSLog(@"A: set name is %@ for tile %d.", setNMPart1, i);
//            
//        } else if (kL1 == kDE) {
//            // kL1 = kDE;
//            NSString *setNMPart = [[NSString alloc] initWithFormat:@"%@", setNM_DE[tileSetID_db[i]]];
//            setNMPart1 = [NSMutableString stringWithString: setNMPart];
//        } else if (kL1 == kEN) {
//            // kL1 = kEN;
////            NSLog(@"We are using EN; creating setNMPart string... ");
////            NSLog(@"tileSetID_db[i] is %d, and setNM_EN[tileSetID_db[i]] is %@.", tileSetID_db[i],setNM_EN[tileSetID_db[i]] );
////            NSLog(@"ns se also setNM_EN[1] is %@.",setNM_EN[1]);
////            [setNMPart1 setString:(setNMPart1)];
//            NSString *setNMPart = [[NSString alloc] initWithFormat:@"%@", setNM_EN[tileSetID_db[i]]];
//            setNMPart1 = [NSMutableString stringWithString: setNMPart];
//            
////            NSLog(@"A: set name is %@ for tile %d.", setNMPart1, i);
//            
//            
//        } else if (kL1 == kES) {
//            // kL1 = kES;
//            NSString *setNMPart = [[NSString alloc] initWithFormat:@"%@", setNM_ES[tileSetID_db[i]]];
//            setNMPart1 = [NSMutableString stringWithString: setNMPart];
//            
////         NSLog(@"A: set name is %@ for tile %d.", setNMPart1, i);
//            
//        } else if (kL1 == kFR) {
//            // kL1 = kFR;
//            NSString *setNMPart = [[NSString alloc] initWithFormat:@"%@", setNM_FR[tileSetID_db[i]]];
//            setNMPart1 = [NSMutableString stringWithString: setNMPart];
//        } else if (kL1 == kIT) {
//            // kL1 = kIT;
//            NSString *setNMPart = [[NSString alloc] initWithFormat:@"%@", setNM_IT[tileSetID_db[i]]];
//            setNMPart1 = [NSMutableString stringWithString: setNMPart];
//        } else if (kL1 == kJP) {
//            // kL1 = kJP;
//            NSString *setNMPart = [[NSString alloc] initWithFormat:@"%@", setNM_JP[tileSetID_db[i]]];
//            setNMPart1 = [NSMutableString stringWithString: setNMPart];
//        } else if (kL1 == kKR) {
//            // kL1 = kKR;
//            NSString *setNMPart = [[NSString alloc] initWithFormat:@"%@", setNM_KR[tileSetID_db[i]]];
//            setNMPart1 = [NSMutableString stringWithString: setNMPart];
//        } else  {
////            kL1 = kEN;  // treat as EN -- nonexistant case.
//            NSString *setNMPart = [[NSString alloc] initWithFormat:@"%@", setNM_EN[tileSetID_db[i]]];
//            setNMPart1 = [NSMutableString stringWithString: setNMPart];
//            
//        }
        
//         NSLog(@"B: set name is %@ for tile %d.", setNMPart1, i);
            
//            i = i + 1;
//    }  // end of j = 1 to 4
//
//        
//        NSString *contentString = [[NSString alloc] initWithFormat:@"%d:%d:%d:%d:%d:%d:%d:%d:%@", tileID_db[i],kL1,kL2,tilesPerPage,0,0,0,0,setNMPart1];
//        
//        [pageStrings addObject:contentString];
//  }  // end of i = 1 to 288
    
    
    
    
    
/*
  
    these 10 values are followed by (up to) four tuples of 5 values 
        (depending on value of parameter 4).  they are
        a) Value of text to put in lable.  (note, for CN/JP/KR, may be tileTxt + 3 spaces + romanization, if romanization is set to on)
        b) Value of color for each lable for this tile (l1 and perhaps L2 otherwise space).
        c) Value if image file name for this tile.
 
    so perhaps 30 values in each string!
 
    and up to 72 pages (72 * 4 = 288) or strings.  
 
    I will hand craft the first 4 for a specific language pair (EN / CN + pinyin)
 
 
 
    
*/
            
        } // end of i = 1 to 288
    
// -----================================================================  end of create all the tile specific strings for the page content array

    
    
    _pageContent = [[NSArray alloc] initWithArray:pageStrings];

//    NSLog(@"Created pageContent as NSArray...." );
     
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *phoneLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    tilesPerPage = TILES_PERPAGE;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults synchronize]; // probably supurflous....

    
//    enableSwipes  = [defaults boolForKey:@"enableSwipes"];
    

//    L2String_Setting = [[NSUserDefaults standardUserDefaults] defaults stringForKey:kSecondLangChoice]];
//    L2String_Setting = [defaults stringForKey:kSecondLangChoice];
//    k_L2 = L2String_Setting;
//    
//    bL1R  = [defaults boolForKey:@"bL1R"];  now use L1RChoice for string... or kL1RomanizationChoice
//    bL2R  = [defaults boolForKey:@"bL2R"];  now use L2RChoice for string... or kL2RomanizationChoice

    
//    bL1R = NO;
//    bL2R = YES; //  not working? 
//    
 
    pageWordString = NSLocalizedString(@"PAGE", nil);
    
    
    
    databaseName = kDatabaseNameLW;
    
//halprog
//    NSLog(@"Device currently set to language >%@<.", phoneLanguage);
    
    if ([phoneLanguage isEqualToString: @"en"]) {
        //        NSLog(@"We have ENGLISH...");
//        databaseName = kDatabaseNameL24EN;
        
        k_L1 = @"EN";

    }
    else if ([phoneLanguage isEqualToString: @"es"]) {
        //        NSLog(@"We have SPANISH...");
//        databaseName = kDatabaseNameL24ES;
        k_L1 = @"ES";
    }
    else if ([phoneLanguage isEqualToString: @"zh-Hans"]) {
        //        NSLog(@"We have CHINESE...");
//        databaseName = kDatabaseNameL24CN;
        k_L1 = @"CN";
    }
    else if ([phoneLanguage isEqualToString: @"zh-Hant"]) {
        //        NSLog(@"We have CHINESE...");
//        databaseName = kDatabaseNameL24CN;
        k_L1 = @"CN";
        // this is not yet avail
        // put up alert saying "not yet done; using english UI"
    }
    else if ([phoneLanguage isEqualToString: @"de"]) {
        //        NSLog(@"We have GERMAN...");
//        databaseName = kDatabaseNameL24DE;
        //        [k_L1 initWithString:@"DE"];        wrong :-)
        k_L1  = @"DE";
    }
    
    else if ([phoneLanguage isEqualToString: @"fr"]) {
        //        NSLog(@"We have FRENCH...");
//        databaseName = kDatabaseNameL24FR;
        k_L1 = @"FR";
    }
    //
    else if ([phoneLanguage isEqualToString: @"ko"]) {
        //        NSLog(@"We have FRENCH...");
//        databaseName = kDatabaseNameL24KR;
        k_L1 = @"KR";
    }
    //
    else if ([phoneLanguage isEqualToString: @"ja"]) {     // Japanese is ja :-)
        //        NSLog(@"We have japanese...");
//        databaseName = kDatabaseNameL24JP;
        k_L1  = @"JP";
    }
    else if ([phoneLanguage isEqualToString: @"it"]) {
        //        NSLog(@"We have ITALIAN...");
//        databaseName = kDatabaseNameL24IT;
        k_L1 = @"IT";
        
    }
    else {
        //        NSLog(@"Unknown language %@ found.", language);
//        databaseName = kDatabaseNameL24EN;
        k_L1 = @"EN";
        
        // put up alert saying
        //        "unknown language; only DE, ES, CN, IT supported -- using english"
    }
    
//halprog
//    NSLog(@"k_L1 value is found from phoneLanguage to be: %@<<", k_L1);
    
    
//     We have value of phone language (or EN). Now check to see if overridden by settings.
//      if not DEFAULT and valid value, replace k_L1 with its choice.
    
// 1. get L1 value from settings; set to DEFAULT  if no value (but DEFAULT is DEFAULT)

    if (![defaults objectForKey:kFirstLangChoice])
        [defaults setObject:@"DEFAULT" forKey:kFirstLangChoice];
    
    L1String_Setting = [defaults objectForKey:kFirstLangChoice];
    
//    if (![[NSUserDefaults standardUserDefaults]
//          objectForKey:kFirstLangChoice]) {
//        [[NSUserDefaults standardUserDefaults]
//         setObject:@"DEFAULT"
//         forKey:kFirstLangChoice];
//        L1String_Setting = @"DEFAULT";
//        NSLog(@"No value found for first lang choice, set to DEFAULT.");
//        
//    }
//    else {
//        L1String_Setting  = [[NSUserDefaults standardUserDefaults]
//                             stringForKey:kFirstLangChoice];
//    }

    
// kSecondLangChoice

    if (![defaults objectForKey:kSecondLangChoice])
        [defaults setObject:@"DEFAULT" forKey:kSecondLangChoice];
    
    L2String_Setting = [defaults objectForKey:kSecondLangChoice];
    
//    if (![[NSUserDefaults standardUserDefaults]
//          objectForKey:kSecondLangChoice]) {
//        [[NSUserDefaults standardUserDefaults]
//         setObject:@"DEFAULT"
//         forKey:kSecondLangChoice];
//        L2String_Setting = @"DEFAULT";
//        NSLog(@"second lang string not found, set to DEFAULT.");
//    }
//    else {
//        L2String_Setting  = [[NSUserDefaults standardUserDefaults]
//                             stringForKey:kSecondLangChoice];
//    }
    
    ///////////// set / get bL1R
    
    
// kL1RomanizationChoice    
    
    if (![defaults boolForKey:kL1RomanizationChoice]) {
//        NSLog(@"no kL1Romanization set; make NO");
        [defaults setBool:NO forKey:kL1RomanizationChoice];
    }
    
    bL1R = [defaults boolForKey:kL1RomanizationChoice];
    
//    if (![[NSUserDefaults standardUserDefaults]
//          boolForKey:kL1RomanizationChoice]) {
//        [[NSUserDefaults standardUserDefaults]
//         setBool:NO
//          forKey:kL1RomanizationChoice];
//        NSLog(@"L1Rom not found, set to NO.");
//        bL1R = NO;
//    }
//    else {
//        bL1R   = [[NSUserDefaults standardUserDefaults]
//                  boolForKey:kL1RomanizationChoice];
//        NSLog(@"L1Rom found.");
//        if (bL1R) {
//            NSLog(@"L1Rom found to be YES.");
//        }
//    }
    

    if (![defaults boolForKey:kL2RomanizationChoice])
//        NSLog(@"no kL2Romanization set; make YES");
    
        [defaults setBool:YES forKey:kL2RomanizationChoice];
    
    bL2R = [defaults boolForKey:kL2RomanizationChoice];
    
    
    //////////// set / get bL2R
    if (![[NSUserDefaults standardUserDefaults]
          boolForKey:kL2RomanizationChoice]) {
        [[NSUserDefaults standardUserDefaults]
         setBool:YES
         forKey:kL2RomanizationChoice];
        bL2R = YES;
//        NSLog(@"L2Rom not found, set to YES.");
    }
    else {
        bL2R   = [[NSUserDefaults standardUserDefaults]
                  boolForKey:kL2RomanizationChoice];
//        NSLog(@"L2Rom found.");
        if (bL2R) {
//            NSLog(@"L2Rom found to be YES.");
        }
        
    }
    
    
    
//    NSLog(@"standardUserDefaults for string L1 found to be: %@", L1String_Setting);

//    NSLog(@"standardUserDefaults for string L2 found to be: %@", L2String_Setting);
    
//    if (bL1R) {
//        NSLog(@"standardUserDefaults for bL1R is: YES");
//    } else {
//        NSLog(@"standardUserDefaults for bL1R is: NO");
//    }
//    
//    if (bL2R) {
//        NSLog(@"standardUserDefaults for bL2R is: YES");
//    }else {
//        NSLog(@"standardUserDefaults for bL2R is: NO");
//    }
//    
    

    //halprog
//    NSLog(@"L1String_Setting value is found from phoneLanguage to be: %@<<", L1String_Setting);
    
    
// 2.  if not DEFAULT, cheac and use if valid.
// 2a. if not valid or DEFAULT, set to DEFAULT
    
    if (([L1String_Setting isEqualToString: @"EN"]) ||
        ([L1String_Setting isEqualToString: @"ES"]) ||
//        ([L1String_Setting isEqualToString: @"ZH"]) ||
        ([L1String_Setting isEqualToString: @"CN"]) ||
        ([L1String_Setting isEqualToString: @"KR"]) ||
        
        ([L1String_Setting isEqualToString: @"JP"]) ||
        ([L1String_Setting isEqualToString: @"DE"]) ||
        ([L1String_Setting isEqualToString: @"FR"]) ||
        ([L1String_Setting isEqualToString: @"IT"]) ||
        
        ([L1String_Setting isEqualToString: @"DEFAULT"]))
    {
        // NSLog value -- this is a valid value
        
    } else {;
        NSLog(@"INVALID L1 value, set to default...");
        L1String_Setting = @"DEFAULT";
    }

// 2b.  if now not default, replace k_L1.
    
    if ([L1String_Setting isEqualToString: @"DEFAULT"]){
        // leave k_L1 unchanged.
    } else { // override with settings value
        k_L1 = L1String_Setting;
    }

    
    //halprog
//    NSLog(@"k_L1 value is finally set as: %@<<", k_L1);
    
    if ([k_L1 isEqualToString: kLCN]) {
        kL1 = kCN;
    } else if ([k_L1 isEqualToString: kLDE]) {
        kL1 = kDE;
    } else if ([k_L1 isEqualToString: kLEN]) {
        kL1 = kEN;
    } else if ([k_L1 isEqualToString: kLES]) {
        kL1 = kES;
    } else if ([k_L1 isEqualToString: kLFR]) {
        kL1 = kFR;
    } else if ([k_L1 isEqualToString: kLIT]) {
        kL1 = kIT;
    } else if ([k_L1 isEqualToString: kLJP]) {
        kL1 = kJP;
    } else if ([k_L1 isEqualToString: kLKR]) {
        kL1 = kKR;
    } else  {
        kL1 = kEN;
    }

    
//    NSLog(@"Reminder: k_L2 value was: %@<<", k_L2);
    
    k_L2 = L2String_Setting;
    // if kL2 = DEFAULT, trigger request for L2? for now set K_L2 to K_L1
    
    if ([k_L2 isEqualToString:@"DEFAULT"]) {
        k_L2 = k_L1;
        kL2 = kL1;
    }

//    NSLog(@"Reminder: k_L2 value is: %@<<", k_L2);
    
    // if L2





    
// END OF k_L1 setting
    
    
    // check if second language is set; if not, set to first language.
    // can be set in settings, or set in app
    // l1 is phone language or if not avail, EN -- unless settings for this app overrides to other value.
    // nsUserDefaults only for second language choice.
    
    // l2 values are EN, CN, DEFAULT, etc.
    
    
//    if (![[NSUserDefaults standardUserDefaults]
//          objectForKey:@"L2"]) {
//        [[NSUserDefaults standardUserDefaults]
//         setObject:k_L1
//         forKey:@"L2"];
//        
//        //halprog
//        NSLog(@"k_L2 not set so now has k_L1: %@<<", k_L1);
//        
//        L2String_Setting = k_L1;
//        k_L2 = L2String_Setting;
//    }
//    else {
//        L2String_Setting  = [[NSUserDefaults standardUserDefaults]
//                             stringForKey:@"L2"];
//        //halprog
//        NSLog(@"k_L2 found to be: %@<<", k_L2);   // You can check if [string length] == 0
//
//        if (k_L2.length == 0) { // fix is nil or zero length
//            k_L2 = k_L1;
//                    NSLog(@"k_L2 now: %@<<", k_L2);   // You can check if [string length] == 0
//        }
//    }
    
    
    
    
    if ([k_L2 isEqualToString: kLCN]) {
        kL2 = kCN;
    } else if ([k_L2 isEqualToString: kLDE]) {
        kL2 = kDE;
    } else if ([k_L2 isEqualToString: kLEN]) {
        kL2 = kEN;
    } else if ([k_L2 isEqualToString: kLES]) {
        kL2 = kES;
    } else if ([k_L2 isEqualToString: kLFR]) {
        kL2 = kFR;
    } else if ([k_L2 isEqualToString: kLIT]) {
        kL2 = kIT;
    } else if ([k_L2 isEqualToString: kLJP]) {
        kL2 = kJP;
    } else if ([k_L2 isEqualToString: kLKR]) {
        kL2 = kKR;
    } else  {
        kL2 = kEN;
    }

    
    
    
    //halprog
//    NSLog(@"k_L1 and k_L2 are then >>%@<< and >>%@<<, abd kL1 is %d and kL2 is %d", k_L1, k_L2, kL1, kL2);
    
//    [defaults synchronize]; // probably supurflous....

    [self setupDatabase]; // establish database file and access.

    
    [self initializeData]; // load database into set, tile and version arrays

    [self createSettingsLables]; // createSettingsLables -> store them, for language kL1, in NSUserDefaults...
    
    [self createContentPages];  // using k_L1 and k_L2
    
    
    
//    [self createContentPages2];
    
    NSDictionary *options = [NSDictionary dictionaryWithObject:
                             [NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                  forKey: UIPageViewControllerOptionSpineLocationKey];
    
    _pageController = [[UIPageViewController alloc]
                       initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                       navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                       options: options];
        
//    for (UIGestureRecognizer *recognizer in _pageController.gestureRecognizers) {
//        if ([recognizer isKindOfClass:[UITapGestureRecognizer class]]) {
//            recognizer.enabled = NO;
//        }
//    }
//    
    // tapRecognizer.cancelsTouchesInView = NO; -> do this on 
    
    // end of gesture recognizer disableing code...

    _pageController.delegate = self; // added to support delegate!!  121104
    _pageController.dataSource = self;
    [[_pageController view] setFrame:[[self view] bounds]]; // change to test 121031 ha
    
    // so now do i have the page contents?
    
    
    ContentViewController *initialViewController = [self viewControllerAtIndex:0];
    
//    NSLog(@"I have info as follows: pageContent at index index: %@", initialViewController.dataObject); // test
    
    
    NSArray *viewControllers =
    [NSArray arrayWithObject:initialViewController];
    
    // Halprogram -- no NSArray??? here 
    [_pageController setViewControllers:viewControllers
                              direction:UIPageViewControllerNavigationDirectionForward
                               animated:NO
                             completion:nil];
    
    [self addChildViewController:_pageController];
    [[self view] addSubview:[_pageController view]];
    [_pageController didMoveToParentViewController:self];
    
}  /////////////////////////  END OF viewDidLoad

- (ContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    // Return the data view controller for the given index.
    if (([self.pageContent count] == 0) ||
      (index >= [self.pageContent count])) {
        return nil;
    }
    // Create a new view controller and pass suitable data.
    /*
     ContentViewController *dataViewController =
     [[ContentViewController alloc] init];
     */
    
    UIStoryboard *storyboard =
    [UIStoryboard storyboardWithName:@"MainStoryboard"
                              bundle:[NSBundle mainBundle]];
    
    ContentViewController *dataViewController =
    [storyboard
     instantiateViewControllerWithIdentifier:@"contentView"];
    
    dataViewController.dataObject = _pageContent[index];
	dataViewController.delegate = self;  // added 121104
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(ContentViewController *)viewController
{
    return [_pageContent indexOfObject:viewController.dataObject];
}

- (UIViewController *)pageViewController: (UIPageViewController *)pageViewController
      viewControllerBeforeViewController: (UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:
                        (ContentViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil; }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController: (UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:
                        (ContentViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pageContent count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
	if (completed) {
		[self updateCurrentIndex];
	}
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
