//
//  LMLItemEqualityTest.m
//  lml
//
//  Created by Jeremy Gray on 10-06-23.
//  Copyright 2010 twopointzero Solutions. All rights reserved.
//

#import <GHUnit/GHUnit.h>
#import "LMLItem.h"

@interface LMLItemEqualityTest : GHTestCase { }
@end

@implementation LMLItemEqualityTest

- (LMLItem *)createUnpopulatedItem {
	LMLItem *item = [[[LMLItem alloc] initWithArtist:NULL
											   title:NULL
											  rating:NULL
										   dateAdded:NULL
										   playCount:NULL
										  lastPlayed:NULL
											   genre:NULL
											location:NULL
											duration:NULL] autorelease];
    GHAssertNotNULL(item, nil);
	
	return item;
}

- (LMLItem *)createPopulatedItemWithDateAdded:(NSDate *)dateAdded {
	NSString *artist = @"Artist";
	NSString *title = @"Title";
	double rating = 0.42;
	int playCount = 42;
	NSDate *lastPlayed = [[NSDate alloc] initWithTimeInterval:69 sinceDate:dateAdded];
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
    GHAssertNotNULL(item, nil);
	
	[lastPlayed release];
	
	return item;
}

- (void)assertEqualityOf:(LMLItem *)item1 and:(LMLItem *)item2 {
	GHAssertTrue(item1 != item2, nil);
	GHAssertTrue([item1 isEqual:item2], nil);
	GHAssertTrue([item2 isEqual:item1], nil);
	GHAssertTrue([item1 hash] == [item2 hash], nil);
}

- (void)assertInequalityOf:(LMLItem *)item1 and:(LMLItem *)item2 {
	GHAssertTrue(item1 != item2, nil);
	GHAssertFalse([item1 isEqual:item2], nil);
	GHAssertFalse([item2 isEqual:item1], nil);
}

- (void)testInequalityOfTheUnpopulatedExampleAndNULL {
	GHAssertFalse([[self createUnpopulatedItem] isEqual:NULL], nil);
}

- (void)testInequalityOfThePopulatedExampleAndNULL {
	GHAssertFalse([[self createPopulatedItemWithDateAdded:[NSDate date]] isEqual:NULL], nil);
}

- (void)testInequalityOfTheUnpopulatedExampleAndANonLMLItem {
	GHAssertFalse([[self createUnpopulatedItem] isEqual:@"A string"], nil);
}

- (void)testInequalityOfThePopulatedExampleAndANonLMLItem {
	GHAssertFalse([[self createPopulatedItemWithDateAdded:[NSDate date]] isEqual:@"A string"], nil);
}

- (void)testEqualityOfTwoUnpopulatedItems {
	[self assertEqualityOf:[self createUnpopulatedItem]
					   and:[self createUnpopulatedItem]];
}

- (void)testEqualityOfTwoPopulatedItems {
	NSDate *dateAdded = [NSDate date];
	[self assertEqualityOf:[self createPopulatedItemWithDateAdded:dateAdded]
					   and:[self createPopulatedItemWithDateAdded:dateAdded]];
}

- (void)testInequalityOfTheExampleAndAnUnpopulatedItem {
	[self assertInequalityOf:[self createPopulatedItemWithDateAdded:[NSDate date]]
						 and:[self createUnpopulatedItem]];
}

- (LMLItem *)initItemUsing:(NSArray *)artists
					titles:(NSArray *)titles
				   ratings:(NSArray *)ratings
				datesAdded:(NSArray *)datesAdded
				playCounts:(NSArray *)playCounts
			   lastPlayeds:(NSArray *)lastPlayeds
					genres:(NSArray *)genres
				 locations:(NSArray *)locations
				 durations:(NSArray *)durations
			   artistIndex:(NSUInteger)artistIndex
				titleIndex:(NSUInteger)titleIndex
			   ratingIndex:(NSUInteger)ratingIndex
			dateAddedIndex:(NSUInteger)dateAddedIndex
			playCountIndex:(NSUInteger)playCountIndex
		   lastPlayedIndex:(NSUInteger)lastPlayedIndex
				genreIndex:(NSUInteger)genreIndex
			 locationIndex:(NSUInteger)locationIndex
			 durationIndex:(NSUInteger)durationIndex {
	
	NSString *artist = artistIndex == 0 ? NULL : [artists objectAtIndex:artistIndex - 1];
	
	NSString *title = titleIndex == 0 ? NULL : [titles objectAtIndex:titleIndex - 1];
	
	double ratingValue = ratingIndex == 0 ? 0 : [[ratings objectAtIndex:ratingIndex - 1] doubleValue];
	double* rating = ratingIndex == 0 ? NULL : &ratingValue;
	
	NSDate *dateAdded = dateAddedIndex == 0 ? NULL : [datesAdded objectAtIndex:dateAddedIndex - 1];
	
	int playCountValue = playCountIndex == 0 ? 0 : [[playCounts objectAtIndex:playCountIndex - 1] integerValue];
	int* playCount = playCountIndex == 0 ? NULL : &playCountValue;
	
	NSDate *lastPlayed = lastPlayedIndex == 0 ? NULL : [lastPlayeds objectAtIndex:lastPlayedIndex - 1];
	
	NSString *genre = genreIndex == 0 ? NULL : [genres objectAtIndex:genreIndex - 1];
	
	NSString *location = locationIndex == 0 ? NULL : [locations objectAtIndex:locationIndex - 1];
	
	NSTimeInterval durationValue = durationIndex == 0 ? 0 : [[durations objectAtIndex:durationIndex - 1] doubleValue];
	NSTimeInterval* duration = durationIndex == 0 ? NULL : &durationValue;
	
	LMLItem *item = [[LMLItem alloc] initWithArtist:artist
											  title:title
											 rating:rating
										  dateAdded:dateAdded
										  playCount:playCount
										 lastPlayed:lastPlayed
											  genre:genre
										   location:location
										   duration:duration];
	
    GHAssertNotNULL(item, nil);
	
	return item;
}

- (BOOL)expectedEqualityOfString:(NSString *)value1 and:(NSString *)value2 {
	return (value1 == NULL && value2 == NULL) ||
	(value1 != NULL && value2 != NULL && [value1 isEqualToString:value2]);
}

- (BOOL)expectedEqualityOfOptionalDouble:(double *)value1 and:(double *)value2 {
	return (value1 == NULL && value2 == NULL) ||
	(value1 != NULL && value2 != NULL && *value1 == *value2);
}

- (BOOL)expectedEqualityOfDate:(NSDate *)value1 and:(NSDate *)value2 {
	return (value1 == NULL && value2 == NULL) ||
	(value1 != NULL && value2 != NULL && [value1 isEqualToDate:value2]);
}

- (BOOL)expectedEqualityOfOptionalInt:(int *)value1 and:(int *)value2 {
	return (value1 == NULL && value2 == NULL) ||
	(value1 != NULL && value2 != NULL && *value1 == *value2);
}

- (BOOL)expectedEqualityOfOptionalTimeInterval:(NSTimeInterval *)value1 and:(NSTimeInterval *)value2 {
	return (value1 == NULL && value2 == NULL) ||
	(value1 != NULL && value2 != NULL && *value1 == *value2);
}

- (void)assertEqualityUsing:(NSArray *)artists
					 titles:(NSArray *)titles
					ratings:(NSArray *)ratings
				 datesAdded:(NSArray *)datesAdded
				 playCounts:(NSArray *)playCounts
				lastPlayeds:(NSArray *)lastPlayeds
					 genres:(NSArray *)genres
				  locations:(NSArray *)locations
				  durations:(NSArray *)durations
			   artist1Index:(NSUInteger)artist1Index
				title1Index:(NSUInteger)title1Index
			   rating1Index:(NSUInteger)rating1Index
			dateAdded1Index:(NSUInteger)dateAdded1Index
			playCount1Index:(NSUInteger)playCount1Index
		   lastPlayed1Index:(NSUInteger)lastPlayed1Index
				genre1Index:(NSUInteger)genre1Index
			 location1Index:(NSUInteger)location1Index
			 duration1Index:(NSUInteger)duration1Index
			   artist2Index:(NSUInteger)artist2Index
				title2Index:(NSUInteger)title2Index
			   rating2Index:(NSUInteger)rating2Index
			dateAdded2Index:(NSUInteger)dateAdded2Index
			playCount2Index:(NSUInteger)playCount2Index
		   lastPlayed2Index:(NSUInteger)lastPlayed2Index
				genre2Index:(NSUInteger)genre2Index
			 location2Index:(NSUInteger)location2Index
			 duration2Index:(NSUInteger)duration2Index {
	
	LMLItem *item1 = [self initItemUsing:artists
								  titles:titles
								 ratings:ratings
							  datesAdded:datesAdded
							  playCounts:playCounts
							 lastPlayeds:lastPlayeds
								  genres:genres
							   locations:locations
							   durations:durations
							 artistIndex:artist1Index
							  titleIndex:title1Index
							 ratingIndex:rating1Index
						  dateAddedIndex:dateAdded1Index
						  playCountIndex:playCount1Index
						 lastPlayedIndex:lastPlayed1Index
							  genreIndex:genre1Index
						   locationIndex:location1Index
						   durationIndex:duration1Index];
	
	LMLItem *item2 = [self initItemUsing:artists
								  titles:titles
								 ratings:ratings
							  datesAdded:datesAdded
							  playCounts:playCounts
							 lastPlayeds:lastPlayeds
								  genres:genres
							   locations:locations
							   durations:durations
							 artistIndex:artist2Index
							  titleIndex:title2Index
							 ratingIndex:rating2Index
						  dateAddedIndex:dateAdded2Index
						  playCountIndex:playCount2Index
						 lastPlayedIndex:lastPlayed2Index
							  genreIndex:genre2Index
						   locationIndex:location2Index
						   durationIndex:duration2Index];
	
	BOOL expectedArtistEquality = [self expectedEqualityOfString:[item1 artist] and:[item2 artist]];
	BOOL expectedTitleEquality = [self expectedEqualityOfString:[item1 title] and:[item2 title]];
	BOOL expectedRatingEquality = [self expectedEqualityOfOptionalDouble:[item1 rating] and:[item2 rating]];
	BOOL expectedDateAddedEquality = [self expectedEqualityOfDate:[item1 dateAdded] and:[item2 dateAdded]];
	BOOL expectedPlayCountEquality = [self expectedEqualityOfOptionalInt:[item1 playCount] and:[item2 playCount]];
	BOOL expectedLastPlayedEquality = [self expectedEqualityOfDate:[item1 lastPlayed] and:[item2 lastPlayed]];
	BOOL expectedGenreEquality = [self expectedEqualityOfString:[item1 genre] and:[item2 genre]];
	BOOL expectedLocationEquality = [self expectedEqualityOfString:[item1 location] and:[item2 location]];
	BOOL expectedDurationEquality = [self expectedEqualityOfOptionalTimeInterval:[item1 duration] and:[item2 duration]];
	
	BOOL expectedEquality = expectedArtistEquality && expectedTitleEquality && expectedRatingEquality &&
	expectedDateAddedEquality && expectedPlayCountEquality && expectedLastPlayedEquality &&
	expectedGenreEquality && expectedLocationEquality && expectedDurationEquality;
	
	BOOL actualEquality = [item1 isEqual:item2];
	
	GHAssertTrue(expectedEquality == actualEquality,
				 @"Expected Equality:%d Actual Equality:%d Artist:%d/%d Title:%d/%d Rating:%d/%d Date Added:%d/%d Play Count:%d/%d Last Played:%d/%d Genre:%d/%d Location:%d/%d Duration:%d/%d",
				 expectedEquality, actualEquality,
				 artist1Index, artist2Index,
				 title1Index, title2Index,
				 rating1Index, rating2Index,
				 dateAdded1Index, dateAdded2Index,
				 playCount1Index, playCount2Index,
				 lastPlayed1Index, lastPlayed2Index,
				 genre1Index, genre2Index,
				 location1Index, location2Index,
				 duration1Index, duration2Index);
	
	//	Calculate one of the hashes even if we aren't always going to check them for equality.
	//	Why? Just to make sure we can generate every hash without error.
	//	Why not both hashes? Because that would generate every hash permutation twice.
	NSUInteger item1Hash = [item1 hash];
	
	if (expectedEquality) {
		GHAssertEquals(item1Hash, [item2 hash], @"Hash codes should be equal for equal items.");
	}
	
	[item1 release];
	[item2 release];
}

- (void)__longRunning__testPermutations {
	NSArray *artists = [NSArray arrayWithObjects: @"Artist 1", @"Artist 2", nil];
	NSArray *titles = [NSArray arrayWithObjects: @"Title 1", @"Title 2", nil];
	NSArray *ratings = [NSArray arrayWithObjects:
						[NSNumber numberWithDouble:0.42],
						[NSNumber numberWithDouble:0.69],
						nil];
	NSDate *exampleDate = [NSDate date];
	NSArray *datesAdded = [NSArray arrayWithObjects:
						   [[[NSDate alloc] initWithTimeInterval:10 sinceDate:exampleDate] autorelease],
						   [[[NSDate alloc] initWithTimeInterval:20 sinceDate:exampleDate] autorelease],
						   nil];
	NSArray *playCounts = [NSArray arrayWithObjects:
						   [NSNumber numberWithInt:43],
						   [NSNumber numberWithInt:70],
						   nil];
	NSArray *lastPlayeds = [NSArray arrayWithObjects:
							[[[NSDate alloc] initWithTimeInterval:30 sinceDate:exampleDate] autorelease],
							[[[NSDate alloc] initWithTimeInterval:40 sinceDate:exampleDate] autorelease],
							nil];
	NSArray *genres = [NSArray arrayWithObjects: @"Genre 1", @"Genre 2", nil];
	NSArray *locations = [NSArray arrayWithObjects: @"Location 1", @"Location 2", nil];
	NSArray *durations = [NSArray arrayWithObjects: [NSNumber numberWithInt:4269], [NSNumber numberWithInt:6942], nil];
	
	// Nine dimensions * three choices each as two bits each = 18 bits
	for (NSUInteger i = 0; i < (1 << 18); i++)
	{
		NSUInteger artist1Index = i & 3;
		NSUInteger title1Index = (i >> 2) & 3;
		NSUInteger rating1Index = (i >> 4) & 3;
		NSUInteger dateAdded1Index = (i >> 6) & 3;
		NSUInteger playCount1Index = (i >> 8) & 3;
		NSUInteger lastPlayed1Index = (i >> 10) & 3;
		NSUInteger genre1Index = (i >> 12) & 3;
		NSUInteger location1Index = (i >> 14) & 3;
		NSUInteger duration1Index = (i >> 16) & 3;
		
		//	Since we only have three options for each but used two bits for each,
		//  skip when any would try to use the fourth
		if (artist1Index == 3 || title1Index == 3 || rating1Index == 3 ||
			dateAdded1Index == 3 || playCount1Index == 3 || lastPlayed1Index == 3 ||
			genre1Index == 3 || location1Index == 3 || duration1Index == 3)
			continue;
		
		if (i % 10 == 0)
			NSLog(@"i: %d", i);
		
		for (NSUInteger j = 0; j < (1 << 18); j++)
		{
			NSUInteger artist2Index = j & 3;
			NSUInteger title2Index = (j >> 2) & 3;
			NSUInteger rating2Index = (j >> 4) & 3;
			NSUInteger dateAdded2Index = (j >> 6) & 3;
			NSUInteger playCount2Index = (j >> 8) & 3;
			NSUInteger lastPlayed2Index = (j >> 10) & 3;
			NSUInteger genre2Index = (j >> 12) & 3;
			NSUInteger location2Index = (j >> 14) & 3;
			NSUInteger duration2Index = (j >> 16) & 3;
			
			//	Since we only have three options for each but used two bits for each,
			//  skip when any would try to use the fourth
			if (artist2Index == 3 || title2Index == 3 || rating2Index == 3 ||
				dateAdded2Index == 3 || playCount2Index == 3 || lastPlayed2Index == 3 ||
				genre2Index == 3 || location2Index == 3 || duration2Index == 3)
				continue;
			
			[self assertEqualityUsing:artists
							   titles:titles
							  ratings:ratings
						   datesAdded:datesAdded
						   playCounts:playCounts
						  lastPlayeds:lastPlayeds
							   genres:genres
							locations:locations
							durations:durations
						 artist1Index:artist1Index
						  title1Index:title1Index
						 rating1Index:rating1Index
					  dateAdded1Index:dateAdded1Index
					  playCount1Index:playCount1Index
					 lastPlayed1Index:lastPlayed1Index
						  genre1Index:genre1Index
					   location1Index:location1Index
					   duration1Index:duration1Index
						 artist2Index:artist2Index
						  title2Index:title2Index
						 rating2Index:rating2Index
					  dateAdded2Index:dateAdded2Index
					  playCount2Index:playCount2Index
					 lastPlayed2Index:lastPlayed2Index
						  genre2Index:genre2Index
					   location2Index:location2Index
					   duration2Index:duration2Index];
		}
	}
}

@end
