//
//  LMLItemInitTest.m
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

- (void)testInitWithAllMissingShouldReturnAnItemWithAllPropertiesMissing {
	LMLItem *item = [[[LMLItem alloc] initWithArtist:nil
											   title:nil
											  rating:NULL
										   dateAdded:nil
										   playCount:NULL
										  lastPlayed:nil
											   genre:nil
											location:nil
											duration:NULL] autorelease];
    GHAssertNotNil(item, nil);
	GHAssertNil([item artist], nil);
	GHAssertNil([item title], nil);
	GHAssertNULL([item rating], nil);
	GHAssertNil([item dateAdded], nil);
	GHAssertNULL([item playCount], nil);
	GHAssertNil([item lastPlayed], nil);
	GHAssertNil([item genre], nil);
	GHAssertNil([item location], nil);
	GHAssertNULL([item duration], nil);
}

- (void)testInitWithAllValuesShouldReturnAnItemWithAllExpectedPropertyValues {
	NSString *artist = @"Artist";
	NSString *title = @"Title";
	double rating = 0.42;
	NSDate *dateAdded = [NSDate date];
	int playCount = 42;
	NSDate *lastPlayed = [[[NSDate alloc] initWithTimeInterval:69 sinceDate:dateAdded] autorelease];
	NSString *genre = @"Genre";
	NSString *location = @"Location";
	NSTimeInterval duration = 14269;
	
	LMLItem *item = [[[LMLItem alloc] initWithArtist:artist
											   title:title
											  rating:&rating
										   dateAdded:dateAdded
										   playCount:&playCount
										  lastPlayed:lastPlayed
											   genre:genre
											location:location
											duration:&duration] autorelease];
	
    GHAssertNotNil(item, nil);
	
	GHAssertNotNil([item artist], nil);
	GHAssertEqualStrings(artist, [item artist], nil);
	
	GHAssertNotNil([item title], nil);
	GHAssertEqualStrings(title, [item title], nil);
	
	double *itemRating = [item rating];
	GHAssertNotNULL(itemRating, nil);
	GHAssertEquals(rating, *itemRating, nil);
	
	GHAssertNotNil([item dateAdded], nil);
	GHAssertEqualObjects(dateAdded, [item dateAdded], nil);
	
	int *itemPlayCount = [item playCount];
	GHAssertNotNULL(itemPlayCount, nil);
	GHAssertEquals(playCount, *itemPlayCount, nil);
	
	GHAssertNotNil([item lastPlayed], nil);
	GHAssertEqualObjects(lastPlayed, [item lastPlayed], nil);
	
	GHAssertNotNil([item genre], nil);
	GHAssertEqualStrings(genre, [item genre], nil);
	
	GHAssertNotNil([item location], nil);
	GHAssertEqualStrings(location, [item location], nil);
	
	NSTimeInterval *itemDuration = [item duration];
	GHAssertNotNULL(itemDuration, nil);
	GHAssertEquals(duration, *itemDuration, nil);
}

@end
