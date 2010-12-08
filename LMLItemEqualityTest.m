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
	LMLItem *item = [[[LMLItem alloc] initWithArtist:nil
											   album:nil
											   title:nil
											  rating:NULL
										   dateAdded:nil
										   playCount:NULL
										  lastPlayed:nil
											   genre:nil
											location:nil
											duration:NULL
									   bitsPerSecond:NULL] autorelease];
    GHAssertNotNil(item, nil);
	
	return item;
}

- (LMLItem *)createPopulatedItemWithDateAdded:(NSDate *)dateAdded {
	NSString *artist = @"Artist";
	NSString *album = @"Album";
	NSString *title = @"Title";
	double rating = 0.42;
	int playCount = 42;
	NSDate *lastPlayed = [[NSDate alloc] initWithTimeInterval:69 sinceDate:dateAdded];
	NSString *genre = @"Genre";
	NSString *location = @"Location";
	NSTimeInterval duration = 14269;
	int bitsPerSecond = 324269;
	
	LMLItem *item = [[[LMLItem alloc] initWithArtist:artist
											   album:album
											   title:title
											  rating:&rating
										   dateAdded:dateAdded
										   playCount:&playCount
										  lastPlayed:lastPlayed
											   genre:genre
											location:location
											duration:&duration
									   bitsPerSecond:&bitsPerSecond] autorelease];
    GHAssertNotNil(item, nil);
	
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

- (void)testInequalityOfTheUnpopulatedExampleAndNil {
	GHAssertFalse([[self createUnpopulatedItem] isEqual:nil], nil);
}

- (void)testInequalityOfThePopulatedExampleAndNil {
	GHAssertFalse([[self createPopulatedItemWithDateAdded:[NSDate date]] isEqual:nil], nil);
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
					albums:(NSArray *)albums
					titles:(NSArray *)titles
				   ratings:(NSArray *)ratings
				datesAdded:(NSArray *)datesAdded
				playCounts:(NSArray *)playCounts
			   lastPlayeds:(NSArray *)lastPlayeds
					genres:(NSArray *)genres
				 locations:(NSArray *)locations
				 durations:(NSArray *)durations
			bitsPerSeconds:(NSArray *)bitsPerSeconds
			   artistIndex:(NSUInteger)artistIndex
				albumIndex:(NSUInteger)albumIndex
				titleIndex:(NSUInteger)titleIndex
			   ratingIndex:(NSUInteger)ratingIndex
			dateAddedIndex:(NSUInteger)dateAddedIndex
			playCountIndex:(NSUInteger)playCountIndex
		   lastPlayedIndex:(NSUInteger)lastPlayedIndex
				genreIndex:(NSUInteger)genreIndex
			 locationIndex:(NSUInteger)locationIndex
			 durationIndex:(NSUInteger)durationIndex
		bitsPerSecondIndex:(NSUInteger)bitsPerSecondIndex {
	
	NSString *artist = artistIndex == 0 ? nil : [artists objectAtIndex:artistIndex - 1];

	NSString *album = albumIndex == 0 ? nil : [albums objectAtIndex:albumIndex - 1];

	NSString *title = titleIndex == 0 ? nil : [titles objectAtIndex:titleIndex - 1];
	
	double ratingValue = ratingIndex == 0 ? 0 : [[ratings objectAtIndex:ratingIndex - 1] doubleValue];
	double* rating = ratingIndex == 0 ? NULL : &ratingValue;
	
	NSDate *dateAdded = dateAddedIndex == 0 ? nil : [datesAdded objectAtIndex:dateAddedIndex - 1];
	
	int playCountValue = playCountIndex == 0 ? 0 : [[playCounts objectAtIndex:playCountIndex - 1] integerValue];
	int* playCount = playCountIndex == 0 ? NULL : &playCountValue;
	
	NSDate *lastPlayed = lastPlayedIndex == 0 ? nil : [lastPlayeds objectAtIndex:lastPlayedIndex - 1];
	
	NSString *genre = genreIndex == 0 ? nil : [genres objectAtIndex:genreIndex - 1];
	
	NSString *location = locationIndex == 0 ? nil : [locations objectAtIndex:locationIndex - 1];
	
	NSTimeInterval durationValue = durationIndex == 0 ? 0 : [[durations objectAtIndex:durationIndex - 1] doubleValue];
	NSTimeInterval* duration = durationIndex == 0 ? NULL : &durationValue;

	int bitsPerSecondValue = bitsPerSecondIndex == 0 ? 0 : [[bitsPerSeconds objectAtIndex:bitsPerSecondIndex - 1] integerValue];
	int* bitsPerSecond = bitsPerSecondIndex == 0 ? NULL : &bitsPerSecondValue;

	LMLItem *item = [[LMLItem alloc] initWithArtist:artist
											  album:album
											  title:title
											 rating:rating
										  dateAdded:dateAdded
										  playCount:playCount
										 lastPlayed:lastPlayed
											  genre:genre
										   location:location
										   duration:duration
									  bitsPerSecond:bitsPerSecond];
	
    GHAssertNotNil(item, nil);
	
	return item;
}

- (BOOL)expectedEqualityOfString:(NSString *)value1 and:(NSString *)value2 {
	return (value1 == nil && value2 == nil) ||
	(value1 != nil && value2 != nil && [value1 isEqualToString:value2]);
}

- (BOOL)expectedEqualityOfOptionalDouble:(double *)value1 and:(double *)value2 {
	return (value1 == NULL && value2 == NULL) ||
	(value1 != NULL && value2 != NULL && *value1 == *value2);
}

- (BOOL)expectedEqualityOfDate:(NSDate *)value1 and:(NSDate *)value2 {
	return (value1 == nil && value2 == nil) ||
	(value1 != nil && value2 != nil && [value1 isEqualToDate:value2]);
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
					 albums:(NSArray *)albums
					 titles:(NSArray *)titles
					ratings:(NSArray *)ratings
				 datesAdded:(NSArray *)datesAdded
				 playCounts:(NSArray *)playCounts
				lastPlayeds:(NSArray *)lastPlayeds
					 genres:(NSArray *)genres
				  locations:(NSArray *)locations
				  durations:(NSArray *)durations
			 bitsPerSeconds:(NSArray *)bitsPerSeconds
			   artist1Index:(NSUInteger)artist1Index
				album1Index:(NSUInteger)album1Index
				title1Index:(NSUInteger)title1Index
			   rating1Index:(NSUInteger)rating1Index
			dateAdded1Index:(NSUInteger)dateAdded1Index
			playCount1Index:(NSUInteger)playCount1Index
		   lastPlayed1Index:(NSUInteger)lastPlayed1Index
				genre1Index:(NSUInteger)genre1Index
			 location1Index:(NSUInteger)location1Index
			 duration1Index:(NSUInteger)duration1Index
		bitsPerSecond1Index:(NSUInteger)bitsPerSecond1Index
			   artist2Index:(NSUInteger)artist2Index
				album2Index:(NSUInteger)album2Index
				title2Index:(NSUInteger)title2Index
			   rating2Index:(NSUInteger)rating2Index
			dateAdded2Index:(NSUInteger)dateAdded2Index
			playCount2Index:(NSUInteger)playCount2Index
		   lastPlayed2Index:(NSUInteger)lastPlayed2Index
				genre2Index:(NSUInteger)genre2Index
			 location2Index:(NSUInteger)location2Index
			 duration2Index:(NSUInteger)duration2Index
		bitsPerSecond2Index:(NSUInteger)bitsPerSecond2Index {
	
	LMLItem *item1 = [self initItemUsing:artists
								  albums:albums
								  titles:titles
								 ratings:ratings
							  datesAdded:datesAdded
							  playCounts:playCounts
							 lastPlayeds:lastPlayeds
								  genres:genres
							   locations:locations
							   durations:durations
						  bitsPerSeconds:bitsPerSeconds
							 artistIndex:artist1Index
							  albumIndex:album1Index
							  titleIndex:title1Index
							 ratingIndex:rating1Index
						  dateAddedIndex:dateAdded1Index
						  playCountIndex:playCount1Index
						 lastPlayedIndex:lastPlayed1Index
							  genreIndex:genre1Index
						   locationIndex:location1Index
						   durationIndex:duration1Index
					  bitsPerSecondIndex:bitsPerSecond1Index];
	
	LMLItem *item2 = [self initItemUsing:artists
								  albums:albums
								  titles:titles
								 ratings:ratings
							  datesAdded:datesAdded
							  playCounts:playCounts
							 lastPlayeds:lastPlayeds
								  genres:genres
							   locations:locations
							   durations:durations
						  bitsPerSeconds:bitsPerSeconds
							 artistIndex:artist2Index
							  albumIndex:album2Index
							  titleIndex:title2Index
							 ratingIndex:rating2Index
						  dateAddedIndex:dateAdded2Index
						  playCountIndex:playCount2Index
						 lastPlayedIndex:lastPlayed2Index
							  genreIndex:genre2Index
						   locationIndex:location2Index
						   durationIndex:duration2Index
					  bitsPerSecondIndex:bitsPerSecond2Index];
	
	BOOL expectedArtistEquality = [self expectedEqualityOfString:[item1 artist] and:[item2 artist]];
	BOOL expectedAlbumEquality = [self expectedEqualityOfString:[item1 album] and:[item2 album]];
	BOOL expectedTitleEquality = [self expectedEqualityOfString:[item1 title] and:[item2 title]];
	BOOL expectedRatingEquality = [self expectedEqualityOfOptionalDouble:[item1 rating] and:[item2 rating]];
	BOOL expectedDateAddedEquality = [self expectedEqualityOfDate:[item1 dateAdded] and:[item2 dateAdded]];
	BOOL expectedPlayCountEquality = [self expectedEqualityOfOptionalInt:[item1 playCount] and:[item2 playCount]];
	BOOL expectedLastPlayedEquality = [self expectedEqualityOfDate:[item1 lastPlayed] and:[item2 lastPlayed]];
	BOOL expectedGenreEquality = [self expectedEqualityOfString:[item1 genre] and:[item2 genre]];
	BOOL expectedLocationEquality = [self expectedEqualityOfString:[item1 location] and:[item2 location]];
	BOOL expectedDurationEquality = [self expectedEqualityOfOptionalTimeInterval:[item1 duration] and:[item2 duration]];
	BOOL expectedBitsPerSecondEquality = [self expectedEqualityOfOptionalInt:[item1 bitsPerSecond] and:[item2 bitsPerSecond]];
	
	BOOL expectedEquality = expectedArtistEquality && expectedAlbumEquality && expectedTitleEquality && expectedRatingEquality &&
	expectedDateAddedEquality && expectedPlayCountEquality && expectedLastPlayedEquality &&
	expectedGenreEquality && expectedLocationEquality && expectedDurationEquality && expectedBitsPerSecondEquality;
	
	BOOL actualEquality = [item1 isEqual:item2];
	
	GHAssertTrue(expectedEquality == actualEquality,
				 @"Expected Equality:%d Actual Equality:%d Artist:%d/%d Album:%d/%d Title:%d/%d Rating:%d/%d Date Added:%d/%d Play Count:%d/%d Last Played:%d/%d Genre:%d/%d Location:%d/%d Duration:%d/%d Bits Per Second:%d/%d",
				 expectedEquality, actualEquality,
				 artist1Index, artist2Index,
				 album1Index, album2Index,
				 title1Index, title2Index,
				 rating1Index, rating2Index,
				 dateAdded1Index, dateAdded2Index,
				 playCount1Index, playCount2Index,
				 lastPlayed1Index, lastPlayed2Index,
				 genre1Index, genre2Index,
				 location1Index, location2Index,
				 duration1Index, duration2Index,
				 bitsPerSecond1Index, bitsPerSecond2Index);
	
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

- (void)testPermutations {
	//	To exhaustively test the equality behavior permutations across the LMLItem properties,
	//	set both increments to 1. To test a subset, set the increments to neighbouring primes,
	//	as in the case below which brings testPermutations under one second on my dev box.
	const int outerIncrement = 313;
	const int innerIncrement = 317;
	
	NSArray *artists = [NSArray arrayWithObjects: @"Artist 1", @"Artist 2", nil];
	NSArray *albums = [NSArray arrayWithObjects: @"Album 1", @"Album 2", nil];
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
	NSArray *bitsPerSeconds = [NSArray arrayWithObjects:
							   [NSNumber numberWithInt:192496],
							   [NSNumber numberWithInt:324269],
							   nil];
	
	// Eleven dimensions * three choices each as two bits each = 22 bits
	for (NSUInteger i = 0; i < (1 << 22); i += outerIncrement)
	{
		NSUInteger artist1Index = i & 3;
		NSUInteger album1Index = (i >> 2) & 3;
		NSUInteger title1Index = (i >> 4) & 3;
		NSUInteger rating1Index = (i >> 6) & 3;
		NSUInteger dateAdded1Index = (i >> 8) & 3;
		NSUInteger playCount1Index = (i >> 10) & 3;
		NSUInteger lastPlayed1Index = (i >> 12) & 3;
		NSUInteger genre1Index = (i >> 14) & 3;
		NSUInteger location1Index = (i >> 16) & 3;
		NSUInteger duration1Index = (i >> 18) & 3;
		NSUInteger bitsPerSecond1Index = (i >> 20) & 3;

		//	Since we only have three options for each but used two bits for each,
		//  skip when any would try to use the fourth
		if (artist1Index == 3 || album1Index == 3 || title1Index == 3 || rating1Index == 3 ||
			dateAdded1Index == 3 || playCount1Index == 3 || lastPlayed1Index == 3 ||
			genre1Index == 3 || location1Index == 3 || duration1Index == 3 || bitsPerSecond1Index == 3)
			continue;
		
		if (i % 10 == 0)
			NSLog(@"i: %d", i);
		
		for (NSUInteger j = 0; j < (1 << 22); j += innerIncrement)
		{
			NSUInteger artist2Index = j & 3;
			NSUInteger album2Index = (j >> 2) & 3;
			NSUInteger title2Index = (j >> 4) & 3;
			NSUInteger rating2Index = (j >> 6) & 3;
			NSUInteger dateAdded2Index = (j >> 8) & 3;
			NSUInteger playCount2Index = (j >> 10) & 3;
			NSUInteger lastPlayed2Index = (j >> 12) & 3;
			NSUInteger genre2Index = (j >> 14) & 3;
			NSUInteger location2Index = (j >> 16) & 3;
			NSUInteger duration2Index = (j >> 18) & 3;
			NSUInteger bitsPerSecond2Index = (j >> 20) & 3;
			
			//	Since we only have three options for each but used two bits for each,
			//  skip when any would try to use the fourth
			if (artist2Index == 3 || album2Index == 3 || title2Index == 3 || rating2Index == 3 ||
				dateAdded2Index == 3 || playCount2Index == 3 || lastPlayed2Index == 3 ||
				genre2Index == 3 || location2Index == 3 || duration2Index == 3 || bitsPerSecond2Index == 3)
				continue;
			
			[self assertEqualityUsing:artists
							   albums:albums
							   titles:titles
							  ratings:ratings
						   datesAdded:datesAdded
						   playCounts:playCounts
						  lastPlayeds:lastPlayeds
							   genres:genres
							locations:locations
							durations:durations
					   bitsPerSeconds:bitsPerSeconds
						 artist1Index:artist1Index
						  album1Index:album1Index
						  title1Index:title1Index
						 rating1Index:rating1Index
					  dateAdded1Index:dateAdded1Index
					  playCount1Index:playCount1Index
					 lastPlayed1Index:lastPlayed1Index
						  genre1Index:genre1Index
					   location1Index:location1Index
					   duration1Index:duration1Index
				  bitsPerSecond1Index:bitsPerSecond1Index
						 artist2Index:artist2Index
						  album2Index:album2Index
						  title2Index:title2Index
						 rating2Index:rating2Index
					  dateAdded2Index:dateAdded2Index
					  playCount2Index:playCount2Index
					 lastPlayed2Index:lastPlayed2Index
						  genre2Index:genre2Index
					   location2Index:location2Index
					   duration2Index:duration2Index
				  bitsPerSecond2Index:bitsPerSecond2Index];
		}
	}
}

@end
