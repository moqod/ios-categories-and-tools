//
//  NSError+ErrorDescription.h
//  
//
//  Created by Andrew Kopanev on 8/23/13.
//  Copyright (c) 2013 Moqod. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *	Category for localizing errors. Easy.
 */

@interface NSError (MAErrorDescription)

/**
 *	Creates error object with domain, code and localized description (NSLocalizedDescriptionKey).
 *
 *	@param	domain					Domain of the error.
 *	@param	code					Code of the error.
 *	@param	localizedDescription	Localized description of the error.
 *
 *	@return	NSError object.
 */
+ (instancetype)maErrorWithDomain:(NSString *)domain code:(NSInteger)code localizedDescription:(NSString *)localizedDescription;

/**
 *	If localized description is not nil then it would create error with same domain and error code, but it will add localized description to new error object.
 *
 *	@param	localizedDescription	Localized description string for new error object.
 *
 *	@return	New error object if localized description is not nil, otherwise self.
 */

- (instancetype)maErrorByAddingLocalizedDescription:(NSString *)localizedDescription;

/**
 *	Adds localized description to current error object.
 *
 *	@param	localizedDescription	String for localized description.
 */
- (void)maSetLocalizedDescription:(NSString *)localizedDescription;

@end
