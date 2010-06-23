//
//  LMLItemTest.m
//  lml
//
//  Created by Jeremy Gray on 10-06-23.
//  Copyright 2010 twopointzero Solutions. All rights reserved.
//

#import <GHUnit/GHUnit.h>
#import "LMLItem.h"

@interface LMLItemInitTest : GHTestCase { }
@end

@implementation LMLItemInitTest

- (void)testInitWithAllNULLShouldReturnAnItemWithAllPropertiesNULL {
	LMLItem *item = [[LMLItem alloc] initWithArtist:NULL
											  title:NULL
											 rating:NULL
										  dateAdded:NULL
										  playCount:NULL
										 lastPlayed:NULL
											  genre:NULL
										   location:NULL
										   duration:NULL];
    GHAssertNotNULL(item, nil);
	GHAssertNULL([item artist], nil);
	GHAssertNULL([item title], nil);
	GHAssertNULL([item rating], nil);
	GHAssertNULL([item dateAdded], nil);
	GHAssertNULL([item playCount], nil);
	GHAssertNULL([item lastPlayed], nil);
	GHAssertNULL([item genre], nil);
	GHAssertNULL([item location], nil);
	GHAssertNULL([item duration], nil);
}

- (void)testInitWithAllValuesShouldReturnAnItemWithAllExpectedPropertyValues {
	NSString *artist = @"Artist";
	NSString *title = @"Title";
	double rating = 0.42;
	NSDate *dateAdded = [NSDate date];
	int playCount = 42;
	NSDate *lastPlayed = [[NSDate alloc] initWithTimeInterval:69 sinceDate:dateAdded];
	NSString *genre = @"Genre";
	NSString *location = @"Location";
	NSTimeInterval duration = 14269;
	
	LMLItem *item = [[LMLItem alloc] initWithArtist:artist
											  title:title
											 rating:&rating
										  dateAdded:dateAdded
										  playCount:&playCount
										 lastPlayed:lastPlayed
											  genre:genre
										   location:location
										   duration:&duration];
    GHAssertNotNULL(item, nil);
	
	GHAssertNotNULL([item artist], nil);
	GHAssertEqualStrings(artist, [item artist], nil);
	
	GHAssertNotNULL([item title], nil);
	GHAssertEqualStrings(title, [item title], nil);
	
	double *itemRating = [item rating];
	GHAssertNotNULL(itemRating, nil);
	GHAssertEquals(rating, *itemRating, nil);
	
	GHAssertNotNULL([item dateAdded], nil);
	GHAssertEqualObjects(dateAdded, [item dateAdded], nil);
	
	int *itemPlayCount = [item playCount];
	GHAssertNotNULL(itemPlayCount, nil);
	GHAssertEquals(playCount, *itemPlayCount, nil);
	
	GHAssertNotNULL([item lastPlayed], nil);
	GHAssertEqualObjects(lastPlayed, [item lastPlayed], nil);
	
	GHAssertNotNULL([item genre], nil);
	GHAssertEqualStrings(genre, [item genre], nil);
	
	GHAssertNotNULL([item location], nil);
	GHAssertEqualStrings(location, [item location], nil);
	
	NSTimeInterval *itemDuration = [item duration];
	GHAssertNotNULL(itemDuration, nil);
	GHAssertEquals(duration, *itemDuration, nil);
}
@end
