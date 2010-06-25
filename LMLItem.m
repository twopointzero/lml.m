//
//  LMLItem.m
//  lml
//
//  Created by Jeremy Gray on 10-06-23.
//  Copyright 2010 twopointzero Solutions. All rights reserved.
//

#import "LMLItem.h"


@implementation LMLItem

@synthesize artist;
@synthesize dateAdded;
@synthesize duration;
@synthesize genre;
@synthesize lastPlayed;
@synthesize location;
@synthesize playCount;
@synthesize rating;
@synthesize title;

- (id)initWithArtist:(NSString *)anArtist
			   title:(NSString *)aTitle
			  rating:(double *)aRating
		   dateAdded:(NSDate *)aDateAdded
		   playCount:(int *)aPlayCount
		  lastPlayed:(NSDate *)aLastPlayed
			   genre:(NSString *)aGenre
			location:(NSString *)aLocation
			duration:(NSTimeInterval *)aDuration {
	if (![super init])
		return nil;
	
	if (anArtist != nil) {
		[anArtist retain];
		artist = anArtist;
	}
	if (aTitle != nil) {
		[aTitle retain];
		title = aTitle;
	}
	if (aRating != NULL) {
		ratingValue = *aRating;
		rating = &ratingValue;
	}
	if (aDateAdded != nil) {
		[aDateAdded retain];
		dateAdded = aDateAdded;
	}
	if (aPlayCount != NULL) {
		playCountValue = *aPlayCount;
		playCount = &playCountValue;
	}
	if (aLastPlayed != nil) {
		[aLastPlayed retain];
		lastPlayed = aLastPlayed;
	}
	if (aGenre != nil) {
		[aGenre retain];
		genre = aGenre;
	}
	if (aLocation != nil) {
		[aLocation retain];
		location = aLocation;
	}
	if (aDuration != NULL) {
		durationValue = *aDuration;
		duration = &durationValue;
	}
	
	return self;
}

- (NSUInteger)hash {
	NSUInteger hash = 0;
	
	if (artist != nil)
		hash ^= [artist hash];
	
	if (dateAdded != nil)
		hash ^= [dateAdded hash];
	
	if (duration != NULL)
		hash ^= (NSUInteger)durationValue;
	
	if (genre != nil)
		hash ^= [genre hash];
	
	if (lastPlayed != nil)
		hash ^= [lastPlayed hash];
	
	if (location != nil)
		hash ^= [location hash];
	
	if (playCount != NULL)
		hash ^= (NSUInteger)playCountValue;
	
	if (rating != NULL)
		hash ^= (NSUInteger)ratingValue;
	
	if (title != nil)
		hash ^= [title hash];
	
	return hash;
}

- (BOOL)equalityOfString:(NSString *)value1 and:(NSString *)value2 {
	return (value1 == nil && value2 == nil) ||
	(value1 != nil && value2 != nil && [value1 isEqualToString:value2]);
}

- (BOOL)equalityOfOptionalDouble:(double *)value1 and:(double *)value2 {
	return (value1 == NULL && value2 == NULL) ||
	(value1 != NULL && value2 != NULL && *value1 == *value2);
}

- (BOOL)equalityOfDate:(NSDate *)value1 and:(NSDate *)value2 {
	return (value1 == nil && value2 == nil) ||
	(value1 != nil && value2 != nil && [value1 isEqualToDate:value2]);
}

- (BOOL)equalityOfOptionalInt:(int *)value1 and:(int *)value2 {
	return (value1 == NULL && value2 == NULL) ||
	(value1 != NULL && value2 != NULL && *value1 == *value2);
}

- (BOOL)equalityOfOptionalTimeInterval:(NSTimeInterval *)value1 and:(NSTimeInterval *)value2 {
	return (value1 == NULL && value2 == NULL) ||
	(value1 != NULL && value2 != NULL && *value1 == *value2);
}

- (BOOL)isEqual:(id)other {
	if (other == nil)
		return NO;
	if (other == self)
		return YES;
	if (!other || ![other isKindOfClass:[self class]])
        return NO;
	
	LMLItem *otherItem = other;
	
	if (![self equalityOfString:artist and:[otherItem artist]])
		return NO;
	
	if (![self equalityOfString:title and:[otherItem title]])
		return NO;
	
	if (![self equalityOfOptionalDouble:rating and:[otherItem rating]])
		return NO;
	
	if (![self equalityOfDate:dateAdded and:[otherItem dateAdded]])
		return NO;
	
	if (![self equalityOfOptionalInt:playCount and:[otherItem playCount]])
		return NO;
	
	if (![self equalityOfDate:lastPlayed and:[otherItem lastPlayed]])
		return NO;
	
	if (![self equalityOfString:genre and:[otherItem genre]])
		return NO;
	
	if (![self equalityOfString:location and:[otherItem location]])
		return NO;
	
	if (![self equalityOfOptionalTimeInterval:duration and:[otherItem duration]])
		return NO;
	
	return YES;
}

- (void)dealloc {
	if (artist != nil)
		[artist release];
	if (title != nil)
		[title release];
	if (dateAdded != nil)
		[dateAdded release];
	if (lastPlayed != nil)
		[lastPlayed release];
	if (genre != nil)
		[genre release];
	if (location != nil)
		[location release];
	
	[super dealloc];
}
@end
