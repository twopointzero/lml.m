//
//  LMLAppleITunesXmlImporter.m
//  lml
//
//  Created by Jeremy Gray on 10-06-25.
//  Copyright 2010 twopointzero Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMLAppleITunesXmlImporter.h"
#import "LMLConstants.h"
#import "LMLItem.h"
#import "LMLLibrary.h"


@implementation LMLAppleITunesXmlImporter

- (BOOL)isBoolPresentAndTrue:(NSDictionary *)dictionary forKey:(NSString *)key {
	id valueId = [dictionary objectForKey:key];
	return valueId != nil && [valueId boolValue];
}

- (BOOL)shouldImport:(NSDictionary *)track {
	return (![self isBoolPresentAndTrue:track forKey:@"Movie"] &&
			![self isBoolPresentAndTrue:track forKey:@"Podcast"]);
}

- (NSString *)prepareTitle:(NSString *)title withArtist:(NSString *)artist {
	if (title == nil || artist == nil)
		return title;
	
	//  remove artist from the beginning or end of the name value, if necessary
	NSString *artistSuffix = [@" - " stringByAppendingString:artist];
	if ([title hasSuffix:artistSuffix])
		return [title substringToIndex:[title length] - [artistSuffix length]];
	
	NSString *artistPrefix = [artist stringByAppendingString:@" - "];
	if ([title hasPrefix:artistPrefix])
		return [title substringFromIndex:[artistPrefix length]];
	
	return title;
}

- (LMLItem *)importTrack:(NSDictionary *)track {
	NSString *artist = [track objectForKey:@"Artist"];
	
	NSString *title = [self prepareTitle:[track objectForKey:@"Name"] withArtist:artist];
	
	double ratingValue = 0;
	double *rating = NULL;
	id ratingId = [track objectForKey:@"Rating"];
	if (ratingId != nil) {
		ratingValue = [ratingId intValue] / 100.0;
		rating = &ratingValue;
	}
	
	NSDate *dateAdded = [track objectForKey:@"Date Added"];
	
	int playCountValue = 0;
	int *playCount = NULL;
	id playCountId = [track objectForKey:@"Play Count"];
	if (playCountId != nil) {
		playCountValue = [playCountId intValue];
		playCount = &playCountValue;
	}
	
	NSDate *lastPlayed = [track objectForKey:@"Play Date UTC"];
	
	NSString *genre = [track objectForKey:@"Genre"];
	
	NSString *location = [track objectForKey:@"Location"];
	
	NSTimeInterval durationValue = 0;
	NSTimeInterval *duration = NULL;
	id durationId = [track objectForKey:@"Total Time"];
	if (durationId != nil) {
		durationValue = [durationId intValue] / 1000.0;
		duration = &durationValue;
	}
	
	LMLItem *item = [[LMLItem alloc] initWithArtist:artist
											  title:title
											 rating:rating
										  dateAdded:dateAdded
										  playCount:playCount
										 lastPlayed:lastPlayed
											  genre:genre
										   location:location
										   duration:duration];
	return [item autorelease];
}

- (void)importTracks:(NSDictionary *)tracks into:(NSMutableArray *)items {
	NSEnumerator *enumerator = [tracks objectEnumerator];
	NSDictionary *track;
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	while ((track = [enumerator nextObject])) {
		if ([self shouldImport:track])
			[items addObject:[self importTrack:track]];
	}
	
	[pool drain];
}

- (LMLLibrary *)import:(NSString *)path error:(NSError **)error {
	if (path == nil) {
		if (error != nil) {
			*error = [[[NSError alloc] initWithDomain:LMLErrorDomain
												 code:LMLERRORCODE_ARGUMENTNIL
											 userInfo:nil] autorelease];
		}
		return nil;
	}
	
	NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
	if (dictionary == nil) {
		if (error != nil) {
			*error = [[[NSError alloc] initWithDomain:LMLErrorDomain
												 code:LMLERRORCODE_PLISTDICTIONARYLOAD
											 userInfo:nil] autorelease];
		}
		return nil;
	}
	
	NSString *applicationVersion = [dictionary objectForKey:@"Application Version"];
	if (applicationVersion == nil) {
		if (error != nil) {
			*error = [[[NSError alloc] initWithDomain:LMLErrorDomain
												 code:LMLERRORCODE_PLISTSTRUCTURE
											 userInfo:nil] autorelease];
		}
		return nil;
	}
	
	NSString *sourceTypePrefix = @"iTunes ";
	NSString *sourceType = [sourceTypePrefix stringByAppendingString:applicationVersion];
	
	NSDictionary *tracks = [dictionary objectForKey:@"Tracks"];
	if (tracks == nil) {
		if (error != nil) {
			*error = [[[NSError alloc] initWithDomain:LMLErrorDomain
												 code:LMLERRORCODE_PLISTSTRUCTURE
											 userInfo:nil] autorelease];
		}
		return nil;
	}	
	NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:1];
	[self importTracks:tracks into:items];
	
	LMLLibrary *library = [[LMLLibrary alloc] initWithItems:items
													version:@"1.0"
												 sourceType:sourceType];
	
	[items release];
	return [library autorelease];
}

@end
