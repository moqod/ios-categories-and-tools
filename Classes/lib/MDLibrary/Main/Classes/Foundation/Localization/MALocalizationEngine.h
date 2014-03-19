//
//  MALocalizationEngine.h
//  
//
//  Created by ako on 14.12.11.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *	Supports 'Localizable' table only.
 */

// useful macroses
#define MALocalizationEngineI							[MALocalizationEngine mainEngine]
#define NSLS(x)											[MALocalizationEngineI stringForKey:x]

#define NSLS_TMPL(key, templateString, replaceString)	[NSLS(key) stringByReplacingOccurrencesOfString:templateString withString:replaceString]

@interface MALocalizationEngine : NSObject

// Returns a pointer to localization engine for given bundle (singleton)
+ (instancetype)engineForBundle:(NSBundle *)bundle;

// Returns a pointer to localization engine for main bundle (singleton).
+ (instancetype)mainEngine;

// Returns an array of strings with ISO codes (en, de, etc).
// Array is NOT ordered.
@property (nonatomic, readonly) NSArray				*supportedLocalizations;

// Returns native development region code (info from plist file).
@property (nonatomic, readonly) NSString			*nativeDevelopmentLanguageCode;

// Retunrs current language code.
@property (nonatomic, retain) NSString				*currentLanguageCode;

// Returns resources bundle.
@property (nonatomic, readonly) NSBundle			*resourcesBundle;

// Default is YES.
@property (nonatomic, assign) BOOL					handlesMainLocalizationChanges;

// Notification name.
// MALocalizationEngine sends NSNotification with this name when localization changed.
@property (nonatomic, readonly) NSString			*localizationDidChangeNotificationName;

// Returns country name for given language code.
// Sample: for 'en' language code string 'English' will be returned.
- (NSString *)languageDisplayName:(NSString *)languageCode;

// Returns localized string for given key.
- (NSString *)stringForKey:(NSString *)key;

@end