iOS Categories and Tools
========================

This project provides set of useful categories and classes for iOS, most of them developed by Moqod.
We have tried to separate categories into logical pieces. Please, keep in mind that it's better to include only needed categories, not all of them.

#Todo
- Add ARC support to all categories. Most of them support ARC now, but `UIImage+MALoading` and other maybe other don't.

# Categories

## User Interface

### UIView+MAUserInfo
Assigns any object as user info to `UIView`.
Standart `tag` property is good, but not suitable in some cases.
This category can be used in any `UIView` subclass - such as `UIAlertView`, `UIActionSheet`, `UIControl`.
Lovely, ha?!
``` objc
@property (nonatomic, retain) id		maUserInfo;
```
### UIImage+MALoading
This category provides a set of methods for easy images loading.
The main one is `maImageWithContentsOfFile` - this method adds smart caching for loaded images.
It's like `imageNamed`, but a little bit smarter - it kills images when they not needed anymore.
For example, you can use same image in different views, but want to release it when these views are deallocated.
Other methods are intended for loading background images and some syntax sugar.
``` objc
+ (UIImage *)maImageWithContentsOfFile:(NSString *)filePath;
- (instancetype)maInitWithContentsOfFile:(NSString *)filePath;

// These methods are used for loading background images (for example, set of `Default.png` images) with one line of code.
// Adds needed modifiers and then return an image using `+ (UIImage *)maImageNamed:bundle:` method.
// Modifiers: <basename><usage_specific_modifiers><scale_modifier><device_modifier>.png
+ (UIImage *)maBackgroundImageNamed:(NSString *)imageFileName;
+ (UIImage *)maBackgroundImageNamed:(NSString *)imageFileName bundle:(NSBundle *)bundle;

// Constructs file path using NSBundle's '- (NSString *)pathForResource:ofType:' method.
// Mostly is syntax sugar for developers, but this method also uses `-(UIImage *)maImageWithContentsOfFile:` for smart caching.
+ (UIImage *)maImageNamed:(NSString *)imageFileName;
+ (UIImage *)maImageNamed:(NSString *)imageFileName bundle:(NSBundle *)bundle;
```

### UIColor+MATools
Helpful additional methods for UIColor class.
``` objc
+ (UIColor *)maRandomColor;

// Example: [UIColor maColorFromRGB:0x023593]
+ (UIColor *)maColorFromRGB:(unsigned int)rgb;
+ (UIColor *)maColorFromRGB:(unsigned int)rgb alpha:(CGFloat)alpha;

// Example: [UIColor intColorWithRed:255 gree:255 blue:255 alpha:255] returns white color.
+ (UIColor *)maIntColorWithRed:(unsigned int)red green:(unsigned int)green blue:(unsigned int)blue alpha:(unsigned int)alpha;

// These methods return color compoments.
@property (nonatomic, readonly) CGFloat		maRed;
@property (nonatomic, readonly) CGFloat		maGreen;
@property (nonatomic, readonly) CGFloat		maBlue;
@property (nonatomic, readonly) CGFloat		maAlpha;
```

### UIAlertView+MABlocks
Adds completition block to UIAlertView.
Uses NSObject+MAKeyValue.h.
``` objc
typedef void (^UIAlertViewMACompletionBlock)(UIAlertView *alertView, NSUInteger buttonIndex);

- (id)initWithTitle:(NSString *)title message:(NSString *)message completitionBlock:(UIAlertViewMACompletionBlock)block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
```

### UIFont+MATools
UIFont category.
``` objc
// Returns rounded line height.
@property (nonatomic, readonly) CGFloat		maLineHeight;
```

### UIView+MALibrary
Some cool methods for UIView.
Our favorite method `- (BOOL)maFindAndResignFirstResponder`.
``` objc
- (UIImage *)maShapshot;
- (BOOL)maFindAndResignFirstResponder;
- (void)maRemoveAllSubviews;
```

### UIView+MARoundedCorner
Adds custom rounded corners. You can specify any of them - top left, bottom right, etc.

### UIDevice+MATools
UIDevice category.
``` objc
// Returns unique identfier.
// This identifier generates once when the app is installed.
// After deleting the app from the device a new identifier is generated.
// This value is excluded from backup.
@property (nonatomic, readonly) NSString			*maUniqueIdentifier;

// Detects if current device can vibrate or not.
// Simply checks device type.
// On 16 Feb 2014 only iPhone can vibrate :)
@property (nonatomic, readonly) BOOL				maCanVibrate;
@property (nonatomic, readonly) BOOL				maCanCall;

// type of the device
@property (nonatomic, readonly) BOOL				maIsPad;
```

### UIScreen+MATools
UIScreen category.
``` objc
// Returns YES if screen scale > 1.0
@property (nonatomic, readonly) BOOL				maHasRetinaDisplay;

// Returns YES if screen height is 568 points. Thanks, Cap!
@property (nonatomic, readonly) BOOL				maHas568PointsHeight;
```

## Foundation

### NSObject+MAKeyValue
Adds any property to any object in runtime using objc associated objects feature.
For example, you can add `userInfo` property to `UIAlertView` class, or even to `NSArray`.
See `UIView+MAUserInfo` for more information.
``` objc
- (void)maSetValue:(id)value forKey:(NSString *)key;
- (void)maSetValue:(id)value forKey:(NSString *)key associationPolicy:(objc_AssociationPolicy)associationPolicy;
- (id)maValueForKey:(NSString *)key;
```

### NSError+MAErrorDescription
Category for localizing errors. Easy.
``` objc
+ (instancetype)maErrorWithDomain:(NSString *)domain code:(NSInteger)code localizedDescription:(NSString *)localizedDescription;
- (instancetype)maErrorByAddingLocalizedDescription:(NSString *)localizedDescription;
- (void)maSetLocalizedDescription:(NSString *)localizedDescription;
```

### NSFileManager+MATools
Category adds useful methods to `NSFileManager`.
Some of methods are listed below:
``` objc
- (NSString *)maDocumentsDirectory;
- (NSString *)maCachesDirectory;
- (NSString *)maTemporaryDirectory;
- (double)maSizeOfDirectoryAtPath:(NSString *)filePath;
- (BOOL)maAddSkipBackupAttributeToItemAtPath:(NSString *)filePath;
- (BOOL)maRemoveSkipBackupAttributeFromItemAtPath:(NSString *)filePath;
```

### NSMutableArray+MATools
Category adds two methods, one for adding any objects (incapsulates nil-checking) and one for removing objects.
``` objc
- (void)maAddObject:(id)object;
- (void)maRemoveObjectsEqualTo:(id)object;
```

### NSNotificationCenter+MAKeys
Simplifies results handling. Most of operations have result or error and maybe userInfo.
Uses `NSNotification` userInfo property (`NSDictionary`) as container for packing parameters.
Sample: data engine sends notification when network request is done (succeed or failed) and observers can obtain result, error or userInfo using macros.
``` objc
#define NTF_ERROR(x)                [[x userInfo] objectForKey:NSNotificationCenterKeys_Error]
#define NTF_RESULT(x)               [[x userInfo] objectForKey:NSNotificationCenterKeys_Result]
#define NTF_USERINFO(x)							[[x userInfo] objectForKey:NSNotificationCenterKeys_UserInfo]

- (void)maSendNotificationNamed:(NSString *)notificationName object:(id)object result:(id)result error:(NSError *)error userInfo:(id)userInfo;
```

# Classes

## Foundation

### MALocalizationEngine
This class manages and uses localizations supported in the app.
Sometimes standart method `NSLocalizableString` is not suitable because user can choose custom language from the app.
This can work with different bundles, supports `Localizable` table only.
See implementation for more details.
