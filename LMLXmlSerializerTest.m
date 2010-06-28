//
//  LMLItemInitTest.m
//  lml
//
//  Created by Jeremy Gray on 10-06-23.
//  Copyright 2010 twopointzero Solutions. All rights reserved.
//

#import <GHUnit/GHUnit.h>
#import "LMLItem.h"
#import "LMLLibrary.h"
#import "LMLXmlSerializer.h"

@interface LMLXmlSerializerTest : GHTestCase { }
@end

@implementation LMLXmlSerializerTest

- (void)assertEqualCanonicalXMLForSerializedItem:(LMLItem *)item andNode:(NSXMLNode *)node {
	LMLXmlSerializer *serializer = [[LMLXmlSerializer alloc] init];
	NSXMLElement *actual = [serializer elementFromItem:item];
	
	[serializer release];
	
	NSString *canonicalExpected = [node canonicalXMLStringPreservingComments:YES];
	NSString *canonicalActual = [actual canonicalXMLStringPreservingComments:YES];
	
	GHAssertEqualStrings(canonicalExpected, canonicalActual, nil);
}

- (void)assertEqualCanonicalXMLForSerializedLibrary:(LMLLibrary *)library andNode:(NSXMLNode *)node {
	LMLXmlSerializer *serializer = [[LMLXmlSerializer alloc] init];
	NSXMLElement *actual = [serializer elementFromLibrary:library];
	
	[serializer release];
	
	NSString *canonicalExpected = [node canonicalXMLStringPreservingComments:YES];
	NSString *canonicalActual = [actual canonicalXMLStringPreservingComments:YES];
	
	GHAssertEqualStrings(canonicalExpected, canonicalActual, nil);
}

- (void)testElementFromLibraryGivenEmptyLibraryShouldProduceExpectedResult {
	LMLLibrary *library = [[LMLLibrary alloc] initWithItems:[NSArray array]
													version:@"1.0"
												 sourceType:@"Unit Tests"];
	
	NSArray *libraryAttributes = [NSArray arrayWithObjects:
								  [NSXMLNode attributeWithName:@"v" stringValue:@"1.0"],
								  [NSXMLNode attributeWithName:@"st" stringValue:@"Unit Tests"],
								  nil];
	NSXMLElement *expected = [NSXMLNode elementWithName:@"l"
											   children:nil
											 attributes:libraryAttributes];
	
	[self assertEqualCanonicalXMLForSerializedLibrary:library andNode:expected];
	
	[library release];
}

- (void)addAttributeIfNotNilOrEmpty:(NSXMLElement *)element
					  attributeName:(NSString *)attributeName
						stringValue:(NSString *)stringValue {
	if (stringValue != nil && [stringValue length] != 0)
		[element addAttribute:[NSXMLNode attributeWithName:attributeName stringValue:stringValue]];
}

- (NSXMLElement *)itemElementWith:(NSString *)artist
							title:(NSString *)title
						   rating:(NSString *)rating
						dateAdded:(NSString *)dateAdded
						playCount:(NSString *)playCount
					   lastPlayed:(NSString *)lastPlayed
							genre:(NSString *)genre
						 location:(NSString *)location
						 duration:(NSString *)duration {
	NSXMLElement *element = [NSXMLNode elementWithName:@"i"];
	[self addAttributeIfNotNilOrEmpty:element attributeName:@"a" stringValue:artist];
	[self addAttributeIfNotNilOrEmpty:element attributeName:@"t" stringValue:title];
	[self addAttributeIfNotNilOrEmpty:element attributeName:@"r" stringValue:rating];
	[self addAttributeIfNotNilOrEmpty:element attributeName:@"da" stringValue:dateAdded];
	[self addAttributeIfNotNilOrEmpty:element attributeName:@"pc" stringValue:playCount];
	[self addAttributeIfNotNilOrEmpty:element attributeName:@"lp" stringValue:lastPlayed];
	[self addAttributeIfNotNilOrEmpty:element attributeName:@"g" stringValue:genre];
	[self addAttributeIfNotNilOrEmpty:element attributeName:@"l" stringValue:location];
	[self addAttributeIfNotNilOrEmpty:element attributeName:@"ds" stringValue:duration];
	return element;
}

- (void)testElementFromItemShouldProduceExpectedResult {
	double rating = 0.42;
	int playCount = 69;
	NSTimeInterval duration = 74.001;
	LMLItem *item = [[LMLItem alloc] initWithArtist:@"Artist"
											  title:@"Title"
											 rating:&rating
										  dateAdded:[NSDate dateWithString:@"2009-01-01 00:00:00 +0000"]
										  playCount:&playCount
										 lastPlayed:[NSDate dateWithString:@"2010-01-01 00:00:00 +0000"]
											  genre:@"Genre"
										   location:@"C:\\path\\file.ext"
										   duration:&duration];
	
	NSXMLElement *expected = [self itemElementWith:@"Artist"
											 title:@"Title"
											rating:@"0.42"
										 dateAdded:@"2009-01-01T00:00:00Z"
										 playCount:@"69"
										lastPlayed:@"2010-01-01T00:00:00Z"
											 genre:@"Genre"
										  location:@"C:\\path\\file.ext"
										  duration:@"74.001"];
	
	[self assertEqualCanonicalXMLForSerializedItem:item andNode:expected];
	
	[item release];
}

- (void)testElementFromItemGivenItemWithEmptyPropertiesShouldProduceExpectedResult {
	LMLItem *item = [[LMLItem alloc] initWithArtist:@""
											  title:@""
											 rating:NULL
										  dateAdded:nil
										  playCount:NULL
										 lastPlayed:nil
											  genre:@""
										   location:@""
										   duration:NULL];
	
	NSXMLElement *expected = [NSXMLNode elementWithName:@"i"];
	
	[self assertEqualCanonicalXMLForSerializedItem:item andNode:expected];
	
	[item release];
}

- (void)testElementFromItemGivenItemWithNullNilPropertiesShouldProduceExpectedResult {
	LMLItem *item = [[LMLItem alloc] initWithArtist:nil
											  title:nil
											 rating:NULL
										  dateAdded:nil
										  playCount:NULL
										 lastPlayed:nil
											  genre:nil
										   location:nil
										   duration:NULL];
	
	NSXMLElement *expected = [NSXMLNode elementWithName:@"i"];
	
	[self assertEqualCanonicalXMLForSerializedItem:item andNode:expected];
	
	[item release];
}

- (void)testElementFromLibraryGivenPopulatedLibraryShouldProduceExpectedResult {
	double rating = 0.421;
	int playCount = 691;
	NSTimeInterval duration = 741;
	LMLItem *item1 = [[LMLItem alloc] initWithArtist:@"Artist1"
											   title:@"Title1"
											  rating:&rating
										   dateAdded:[NSDate dateWithString:@"2009-01-11 00:00:00 +0000"]
										   playCount:&playCount
										  lastPlayed:[NSDate dateWithString:@"2010-01-11 00:00:00 +0000"]
											   genre:@"Genre1"
											location:@"C:\\path\\file1.ext"
											duration:&duration];
	
	rating = 0.422;
	playCount = 692;
	duration = 742;
	LMLItem *item2 = [[LMLItem alloc] initWithArtist:@"Artist2"
											   title:@"Title2"
											  rating:&rating
										   dateAdded:[NSDate dateWithString:@"2009-01-12 00:00:00 +0000"]
										   playCount:&playCount
										  lastPlayed:[NSDate dateWithString:@"2010-01-12 00:00:00 +0000"]
											   genre:@"Genre2"
											location:@"C:\\path\\file2.ext"
											duration:&duration];
	
	rating = 0.423;
	playCount = 693;
	duration = 743;
	LMLItem *item3 = [[LMLItem alloc] initWithArtist:@"Artist3"
											   title:@"Title3"
											  rating:&rating
										   dateAdded:[NSDate dateWithString:@"2009-01-13 00:00:00 +0000"]
										   playCount:&playCount
										  lastPlayed:[NSDate dateWithString:@"2010-01-13 00:00:00 +0000"]
											   genre:@"Genre3"
											location:@"C:\\path\\file3.ext"
											duration:&duration];
	
	LMLLibrary *library = [[LMLLibrary alloc] initWithItems:[NSArray arrayWithObjects:item1, item2, item3, nil]
													version:@"1.0"
												 sourceType:@"Unit Tests"];
	
	NSXMLElement *expectedItem1 = [self itemElementWith:@"Artist1"
												  title:@"Title1"
												 rating:@"0.421"
											  dateAdded:@"2009-01-11T00:00:00Z"
											  playCount:@"691"
											 lastPlayed:@"2010-01-11T00:00:00Z"
												  genre:@"Genre1"
											   location:@"C:\\path\\file1.ext"
											   duration:@"741.0"];
	
	NSXMLElement *expectedItem2 = [self itemElementWith:@"Artist2"
												  title:@"Title2"
												 rating:@"0.422"
											  dateAdded:@"2009-01-12T00:00:00Z"
											  playCount:@"692"
											 lastPlayed:@"2010-01-12T00:00:00Z"
												  genre:@"Genre2"
											   location:@"C:\\path\\file2.ext"
											   duration:@"742.0"];
	
	NSXMLElement *expectedItem3 = [self itemElementWith:@"Artist3"
												  title:@"Title3"
												 rating:@"0.423"
											  dateAdded:@"2009-01-13T00:00:00Z"
											  playCount:@"693"
											 lastPlayed:@"2010-01-13T00:00:00Z"
												  genre:@"Genre3"
											   location:@"C:\\path\\file3.ext"
											   duration:@"743.0"];
	
	NSArray *libraryAttributes = [NSArray arrayWithObjects:
								  [NSXMLNode attributeWithName:@"v" stringValue:@"1.0"],
								  [NSXMLNode attributeWithName:@"st" stringValue:@"Unit Tests"],
								  nil];
	NSXMLElement *expected = [NSXMLNode elementWithName:@"l"
											   children:[NSArray arrayWithObjects:expectedItem1, expectedItem2, expectedItem3, nil]
											 attributes:libraryAttributes];
	
	[self assertEqualCanonicalXMLForSerializedLibrary:library andNode:expected];
	
	[library release];
	[item1 release];
	[item2 release];
	[item3 release];
}

- (void)testElementFromItemGivenNilShouldReturnNil {
	LMLXmlSerializer *serializer = [[LMLXmlSerializer alloc] init];
	GHAssertNil([serializer elementFromItem:nil], nil);
	[serializer release];
}

- (void)testElementFromLibraryGivenNilShouldReturnNil {
	LMLXmlSerializer *serializer = [[LMLXmlSerializer alloc] init];
	GHAssertNil([serializer elementFromLibrary:nil], nil);
	[serializer release];
}

@end
