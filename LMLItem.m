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
	
	if (anArtist != NULL) {
		[anArtist retain];
		artist = anArtist;
	}
	if (aTitle != NULL) {
		[aTitle retain];
		title = aTitle;
	}
	if (aRating != NULL) {
		ratingValue = *aRating;
		rating = &ratingValue;
	}
	if (aDateAdded != NULL) {
		[aDateAdded retain];
		dateAdded = aDateAdded;
	}
	if (aPlayCount != NULL) {
		playCountValue = *aPlayCount;
		playCount = &playCountValue;
	}
	if (aLastPlayed != NULL) {
		[aLastPlayed retain];
		lastPlayed = aLastPlayed;
	}
	if (aGenre != NULL) {
		[aGenre retain];
		genre = aGenre;
	}
	if (aLocation != NULL) {
		[aLocation retain];
		location = aLocation;
	}
	if (aDuration != NULL) {
		durationValue = *aDuration;
		duration = &durationValue;
	}
	
	return self;
}

- (void)dealloc {
	if (artist != NULL)
		[artist release];
	if (title != NULL)
		[title release];
	if (dateAdded != NULL)
		[dateAdded release];
	if (lastPlayed != NULL)
		[lastPlayed release];
	if (genre != NULL)
		[genre release];
	if (location != NULL)
		[location release];
	
	[super dealloc];
}
@end
