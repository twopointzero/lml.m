//
//  LMLAppleITunesXmlImporterTest.m
//  lml
//
//  Created by Jeremy Gray on 10-06-25.
//  Copyright 2010 twopointzero Solutions. All rights reserved.
//

#import <GHUnit/GHUnit.h>
#import "LMLConstants.h"
#import "LMLItem.h"
#import "LMLLibrary.h"
#import "LMLAppleITunesXmlImporter.h"

@interface LMLAppleITunesXmlImporterTest : GHTestCase { }
@end

@implementation LMLAppleITunesXmlImporterTest

- (LMLLibrary *)import:(NSString *)filename error:(NSError **)error {
	NSString *path = filename == nil ? nil : filename;
	LMLAppleITunesXmlImporter *importer = [[LMLAppleITunesXmlImporter alloc] init];
	LMLLibrary *library = [importer import:path error:error];
	[importer release];
	return library;
}

- (void)testGivenNilWithNilErrorShouldReturnNilAndNoError {
	GHAssertNil([self import:nil error:nil], nil);
}

- (void)testGivenNilWithAnErrorAddressShouldReturnNilAndTheError {
	NSError *error = nil;
	GHAssertNil([self import:nil error:&error], nil);
	GHAssertNotNil(error, nil);
	GHAssertEquals(LMLERRORCODE_ARGUMENTNIL, [error code], nil);
}

- (void)testGivenBadPathWithNilErrorShouldReturnNilAndNoError {
	GHAssertNil([self import:@"foo.xml" error:nil], nil);
}

- (void)testGivenBadPathWithAnErrorAddressShouldReturnNilAndTheError {
	NSError *error = nil;
	GHAssertNil([self import:@"foo.xml" error:&error], nil);
	GHAssertNotNil(error, nil);
	GHAssertEquals(LMLERRORCODE_PLISTDICTIONARYLOAD, [error code], nil);
}

- (void)assertExpectedItemIn:(NSArray *)items
					  artist:(NSString *)artist
					   title:(NSString *)title
					  rating:(double *)rating
				   dateAdded:(NSDate *)dateAdded
				   playCount:(int *)playCount
				  lastPlayed:(NSDate *)lastPlayed
					   genre:(NSString *)genre
					location:(NSString *)location
					duration:(NSTimeInterval)duration {
	LMLItem *item = [[LMLItem alloc] initWithArtist:artist
											  title:title
											 rating:rating
										  dateAdded:dateAdded
										  playCount:playCount
										 lastPlayed:lastPlayed
											  genre:genre
										   location:location
										   duration:&duration];
	GHAssertTrue([items containsObject:item], @"Expected: %@ - %@", [item artist], [item title]);
	[item release];
}

- (void)assertExpectedItems:(NSArray *)items {
	[self assertExpectedItemIn:items
						artist:@"Nine Inch Nails"
						 title:@"999,999"
						rating:NULL
					 dateAdded:[NSDate dateWithString:@"2010-03-23 19:56:22 +0000"]
					 playCount:NULL
					lastPlayed:nil
						 genre:nil
					  location:@"file://localhost/Users/jeremygray/Music/iTunes/iTunes%20Media/Music/Nine%20Inch%20Nails/The%20Slip/1-01%20999,999.m4a"
					  duration:85159 / 1000.0];
	
	double rating = 1;
	[self assertExpectedItemIn:items
						artist:@"Depeche Mode"
						 title:@"Love, In Itself"
						rating:&rating
					 dateAdded:[NSDate dateWithString:@"2010-03-23 19:56:22 +0000"]
					 playCount:NULL
					lastPlayed:nil
						 genre:nil
					  location:@"file://localhost/Users/jeremygray/Music/iTunes/iTunes%20Media/Music/Depeche%20Mode/Construction%20Time%20Again/01%20Love,%20In%20Itself.m4a"
					  duration:269840 / 1000.0];
	
	[self assertExpectedItemIn:items
						artist:@"Vitalic"
						 title:@"See The Sea (Red)"
						rating:NULL
					 dateAdded:[NSDate dateWithString:@"2010-03-23 19:56:22 +0000"]
					 playCount:NULL
					lastPlayed:nil
						 genre:@"Electro"
					  location:@"file://localhost/Users/jeremygray/Music/iTunes/iTunes%20Media/Music/Vitalic/Flashmob/01%20See%20The%20Sea%20(Red).m4a"
					  duration:244666 / 1000.0];
	
	[self assertExpectedItemIn:items
						artist:@"Nine Inch Nails"
						 title:@"1,000,000"
						rating:NULL
					 dateAdded:[NSDate dateWithString:@"2010-03-23 19:56:22 +0000"]
					 playCount:NULL
					lastPlayed:nil
						 genre:nil
					  location:@"file://localhost/Users/jeremygray/Music/iTunes/iTunes%20Media/Music/Nine%20Inch%20Nails/The%20Slip/1-02%201,000,000.m4a"
					  duration:236197 / 1000.0];
	
	[self assertExpectedItemIn:items
						artist:@"Depeche Mode"
						 title:@"More Than A Party"
						rating:NULL
					 dateAdded:[NSDate dateWithString:@"2010-03-23 19:56:22 +0000"]
					 playCount:NULL
					lastPlayed:nil
						 genre:nil
					  location:@"file://localhost/Users/jeremygray/Music/iTunes/iTunes%20Media/Music/Depeche%20Mode/Construction%20Time%20Again/02%20More%20Than%20A%20Party.m4a"
					  duration:285453 / 1000.0];
	
	int playCount = 1;
	[self assertExpectedItemIn:items
						artist:@"Vitalic"
						 title:@"Poison Lips"
						rating:NULL
					 dateAdded:[NSDate dateWithString:@"2010-03-23 19:56:22 +0000"]
					 playCount:&playCount
					lastPlayed:[NSDate dateWithString:@"2010-03-23 20:54:50 +0000"]
						 genre:@"Electro"
					  location:@"file://localhost/Users/jeremygray/Music/iTunes/iTunes%20Media/Music/Vitalic/Flashmob/02%20Poison%20Lips.m4a"
					  duration:232240 / 1000.0];
}

static NSString *fileName_9_0_3 = @"../../mac iTML 9_0_3 - simple names.xml";

- (void)testGivenTheMac_9_0_3_FileShouldProduceTheExpectedItems {
	NSError *error = nil;
	LMLLibrary *library = [self import:fileName_9_0_3 error:&error];
	
	GHAssertNil(error, nil);
	[self assertExpectedItems:[library items]];
}

- (void)testGivenTheMac_9_0_3_FileShouldProduceTheExpectedLibrarySourceType {
	NSError *error = nil;
	LMLLibrary *library = [self import:fileName_9_0_3 error:&error];
	
	GHAssertNil(error, nil);
	GHAssertEqualStrings(@"iTunes 9.0.3", [library sourceType], nil);
}

- (void)testGivenTheMac_9_0_3_FileShouldProduceTheExpectedLibraryVersion {
	NSError *error = nil;
	LMLLibrary *library = [self import:fileName_9_0_3 error:&error];
	
	GHAssertNil(error, nil);
	GHAssertEqualStrings(@"1.0", [library version], nil);
}

- (void)testGivenTheMac_9_0_3_FileShouldProduceTheExpectedNumberOfItems {
	NSError *error = nil;
	LMLLibrary *library = [self import:fileName_9_0_3 error:&error];
	
	GHAssertNil(error, nil);
	GHAssertEquals((NSUInteger)6, [[library items] count], nil);
}

static NSString *fileName_9_1_1 = @"../../mac iTML 9_1_1 - artist suffixes.xml";

- (void)testGivenTheMac_9_1_1_FileShouldProduceTheExpectedItems {
	NSError *error = nil;
	LMLLibrary *library = [self import:fileName_9_1_1 error:&error];
	
	GHAssertNil(error, nil);
	[self assertExpectedItems:[library items]];
}

- (void)testGivenTheMac_9_1_1_FileShouldProduceTheExpectedLibrarySourceType {
	NSError *error = nil;
	LMLLibrary *library = [self import:fileName_9_1_1 error:&error];
	
	GHAssertNil(error, nil);
	GHAssertEqualStrings(@"iTunes 9.1.1", [library sourceType], nil);
}

- (void)testGivenTheMac_9_1_1_FileShouldProduceTheExpectedLibraryVersion {
	NSError *error = nil;
	LMLLibrary *library = [self import:fileName_9_1_1 error:&error];
	
	GHAssertNil(error, nil);
	GHAssertEqualStrings(@"1.0", [library version], nil);
}

- (void)testGivenTheMac_9_1_1_FileShouldProduceTheExpectedNumberOfItems {
	NSError *error = nil;
	LMLLibrary *library = [self import:fileName_9_1_1 error:&error];
	
	GHAssertNil(error, nil);
	GHAssertEquals((NSUInteger)6, [[library items] count], nil);
}

@end