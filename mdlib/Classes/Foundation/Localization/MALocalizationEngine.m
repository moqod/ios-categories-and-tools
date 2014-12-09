//
//  MALocalizationEngine.m
//  
//
//  Created by ako on 14.12.11.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import "MALocalizationEngine.h"

// file names
NSString *const MALocalizableFileName											= @"Localizable";

// notifications
NSString *const MALocalizationDidChangeNotification								= @"MALocalizationDidChangeNotification";

@interface MALocalizationEngine () {
#if defined (DEV_VERSION) || (DEBUG)
	NSMutableDictionary			*_allLocalizationDictionaries;
#endif
}

@property (nonatomic, retain) NSBundle				*localizationBundle;

// Contains localizable strings file content.
@property (nonatomic, retain) NSDictionary			*currentLocalizationDictionary;

// Returns previous language code or native development region.
@property (nonatomic, readonly) NSString			*previousLanguageCode;

// Uses for storing actual value in NSUserDefaults.
@property (nonatomic, readonly) NSString			*languageCodeKey;

@end


@implementation MALocalizationEngine

+ (instancetype)engineForBundle:(NSBundle *)bundle {
	NSString *bundlePath = bundle.bundlePath;
	if (nil == bundlePath) {
		return nil;
	} else {
		static NSMutableDictionary *enginesDictionary = nil;
		if (!enginesDictionary) {
			enginesDictionary = [[NSMutableDictionary alloc] init];
		}
		id engine = [enginesDictionary objectForKey:bundlePath];
		if (nil == engine) {
			@synchronized(self) {
				engine = [[self alloc] initWithBundle:bundle];
				[enginesDictionary setValue:engine forKey:bundlePath];
			}
		}
		return engine;
	}
}

+ (instancetype)mainEngine {
	return [self engineForBundle:[NSBundle mainBundle]];
}

#pragma mark - initialization

- (id)initWithBundle:(NSBundle *)bundle {
    if (self = [super init]) {
		self.localizationBundle = bundle;
		assert(self.localizationBundle.localizations.count > 0);
		self.currentLanguageCode = self.previousLanguageCode;
		assert(self.currentLanguageCode != nil);
#if defined (DEV_VERSION) || (DEBUG)
		_allLocalizationDictionaries = [NSMutableDictionary new];
		[self supportedLocalizations];
#endif
		self.handlesMainLocalizationChanges = YES;
		
    }
    return self;
}

- (void)dealloc {
#if !__has_feature(objc_arc)
    [_currentLanguageCode release];
	[_currentLocalizationDictionary release];
	[_localizationBundle release];
#if defined (DEV_VERSION) || (DEBUG)
	[_allLocalizationDictionaries release];
#endif
    [super dealloc];
#endif
}

#pragma mark - private

- (NSString *)languageCodeKey {
	BOOL isMainBundle = self.localizationBundle == [NSBundle mainBundle];
	return [NSString stringWithFormat:@"MACurrentLocalizationKey_%@", isMainBundle ? @"Main" : [self.localizationBundle.bundlePath lastPathComponent]];
}

- (NSString *)nativeDevelopmentLanguageCode {
	NSString *nativeDevelopmentLanguageCode = [[self.localizationBundle localizations] objectAtIndex:0];
	NSArray *preferredLocalizations = [self.localizationBundle preferredLocalizations];
	if (preferredLocalizations.count) {
		nativeDevelopmentLanguageCode = [preferredLocalizations objectAtIndex:0];
	}
    return nativeDevelopmentLanguageCode;
}

- (NSString *)previousLanguageCode {
	NSString *previousLanguageCode = [[NSUserDefaults standardUserDefaults] objectForKey:self.languageCodeKey];
	if (nil == previousLanguageCode) {
		previousLanguageCode = self.nativeDevelopmentLanguageCode;
	}
	return previousLanguageCode;
}

- (NSDictionary *)englishLocalizationDictionary {
#if defined (DEV_VERSION) || (DEBUG)
	return [_allLocalizationDictionaries objectForKey:@"en"];
#else
	return nil;
#endif
}

#pragma mark - public

- (NSBundle *)resourcesBundle {
	return self.localizationBundle;
}

- (NSArray *)supportedLocalizations {
	static NSMutableArray *array = nil;
	// TODO: should we check for localization dictionaries?
	// looks like yes...
	if (nil == array) {
		array = [[NSMutableArray alloc] init];
		for (NSString *code in [self.localizationBundle localizations]) {
			NSString *filePath  = [self.localizationBundle pathForResource:MALocalizableFileName ofType:@"strings" inDirectory:nil forLocalization:code];
			if (YES == [[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
				[array addObject:code];
#if defined (DEV_VERSION) || (DEBUG)
				// debug purposes
				NSDictionary *localizationDictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
				[_allLocalizationDictionaries setValue:localizationDictionary forKey:code];
#endif
			}
		}
	}
	return array;
}

- (NSString *)localizationDidChangeNotificationName {
	// MALocalizationDidChangeNotification
	BOOL isMainBundle = self.localizationBundle == [NSBundle mainBundle];
	if (YES == isMainBundle) {
		return MALocalizationDidChangeNotification;
	} else {
		return [NSString stringWithFormat:@"%@_%@", MALocalizationDidChangeNotification, self.localizationBundle.bundlePath];
	}
}

- (void)setHandlesMainLocalizationChanges:(BOOL)handlesMainLocalizationChanges {
	BOOL isMainBundle = self.localizationBundle == [NSBundle mainBundle];
	if (NO == isMainBundle && _handlesMainLocalizationChanges != handlesMainLocalizationChanges) {
		_handlesMainLocalizationChanges = handlesMainLocalizationChanges;
		if (YES == _handlesMainLocalizationChanges) {
			[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainLocalizationChangedNotification:) name:MALocalizationDidChangeNotification object:nil];
		} else {
			[[NSNotificationCenter defaultCenter] removeObserver:self name:MALocalizationDidChangeNotification object:nil];
		}
	}
}

- (void)mainLocalizationChangedNotification:(NSNotification *)notification {
	MALocalizationEngine *mainEngine = notification.object;
	if (NSNotFound != [self.supportedLocalizations indexOfObject:mainEngine.currentLanguageCode]) {
		self.currentLanguageCode = mainEngine.currentLanguageCode;
	}
}

- (NSString *)languageDisplayName:(NSString *)languageCode {
	NSLocale *locale = [NSLocale localeWithLocaleIdentifier:languageCode];
	NSString *countryName = [locale displayNameForKey:NSLocaleLanguageCode value:languageCode];
	return [countryName capitalizedString];
}

- (void)setCurrentLanguageCode:(NSString *)currentLanguageCode {
	if (nil != currentLanguageCode && NO == [_currentLanguageCode isEqualToString:currentLanguageCode]) {
		BOOL wasNil = (_currentLanguageCode == nil);
#if !__has_feature(objc_arc)
		[_currentLanguageCode autorelease];
		_currentLanguageCode = [currentLanguageCode retain];
#else
		_currentLanguageCode = currentLanguageCode;
#endif
		
		// save user's choice
		[[NSUserDefaults standardUserDefaults] setValue:_currentLanguageCode forKey:self.languageCodeKey];
		[[NSUserDefaults standardUserDefaults] synchronize];

		// reload localization dictionary
		NSString *filePath  = [self.localizationBundle pathForResource:MALocalizableFileName ofType:@"strings" inDirectory:nil forLocalization:_currentLanguageCode];
		NSDictionary *localizationDictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
		NSAssert(localizationDictionary != nil, @"code == %@, fileName == %@", self.currentLanguageCode, [filePath lastPathComponent]);
		self.currentLocalizationDictionary = localizationDictionary;
		
		// notify UI
		if (NO == wasNil) {
			[[NSNotificationCenter defaultCenter] postNotificationName:self.localizationDidChangeNotificationName object:self userInfo:nil];
		}
	}
}

- (NSString *)stringForKey:(NSString *)key {
	NSString *localizedString = [self.currentLocalizationDictionary objectForKey:key];
	
#if defined (DEV_VERSION) || (DEBUG)
	if (0 == localizedString.length && (NO == [self.currentLanguageCode isEqualToString:@"en"])) {
		NSString *englishLocalizedString = [[self englishLocalizationDictionary] objectForKey:key];
		localizedString = [NSString stringWithFormat:@"%@_%@", [self.currentLanguageCode uppercaseString], englishLocalizedString ? englishLocalizedString : [NSString stringWithFormat:@"<%@>", key]];
	}
#endif
	return localizedString;
}

@end
