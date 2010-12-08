//
//  LMLItem.h
//  lml
//
//  Created by Jeremy Gray on 10-06-23.
//  Copyright 2010 twopointzero Solutions. All rights reserved.
//


@interface LMLItem : NSObject {
	NSString *album;
	NSString *artist;
	int *bitsPerSecond;
	int bitsPerSecondValue;
	NSDate *dateAdded;
	NSTimeInterval *duration;
	NSTimeInterval durationValue;
	NSString *genre;
	NSDate *lastPlayed;
	NSString *location;
	int *playCount;
	int playCountValue;
	double *rating;
	double ratingValue;
	NSString *title;
}

@property(readonly) NSString *album;
@property(readonly) NSString *artist;
@property(readonly) int *bitsPerSecond;
@property(readonly) NSDate *dateAdded;
@property(readonly) NSTimeInterval *duration;
@property(readonly) NSString *genre;
@property(readonly) NSDate *lastPlayed;
@property(readonly) NSString *location;
@property(readonly) int *playCount;
@property(readonly) double *rating;
@property(readonly) NSString *title;

- (id)initWithArtist:(NSString *)anArtist
			   album:(NSString *)anAlbum
			   title:(NSString *)aTitle
			  rating:(double *)aRating
		   dateAdded:(NSDate *)aDateAdded
		   playCount:(int *)aPlayCount
		  lastPlayed:(NSDate *)aLastPlayed
			   genre:(NSString *)aGenre
			location:(NSString *)aLocation
			duration:(NSTimeInterval *)aDuration
	   bitsPerSecond:(int *)aBitsPerSecond;

@end
