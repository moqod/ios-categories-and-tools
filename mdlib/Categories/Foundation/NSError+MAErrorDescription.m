//
//  NSError+ErrorDescription.m
//  
//
//  Created by Andrew Kopanev on 8/23/13.
//  Copyright (c) 2013 Moqod. All rights reserved.
//

#import "NSError+MAErrorDescription.h"

@implementation NSError (MAErrorDescription)

+ (NSError *)maErrorWithDomain:(NSString *)domain code:(NSInteger)code localizedDescription:(NSString *)localizedDescription {
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	[dictionary setValue:localizedDescription forKey:NSLocalizedDescriptionKey];
	return [NSError errorWithDomain:domain code:code userInfo:dictionary];
}

- (NSError *)maErrorByAddingLocalizedDescription:(NSString *)localizedDescription {
	if (localizedDescription) {
		NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:[self userInfo]];
		[userInfo setValue:localizedDescription forKey:NSLocalizedDescriptionKey];
		return [NSError errorWithDomain:self.domain code:self.code userInfo:userInfo];
	}
	return self;
}

- (void)maSetLocalizedDescription:(NSString *)localizedDescription {
	if (localizedDescription) {
		NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:self.userInfo];
		[userInfo setValue:localizedDescription forKey:NSLocalizedDescriptionKey];
		[self setValue:userInfo forKey:@"userInfo"];
	}
}

@end
