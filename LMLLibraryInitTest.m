//
//  LMLLibraryInitTest.m
//  lml
//
//  Created by Jeremy Gray on 10-06-23.
//  Copyright 2010 twopointzero Solutions. All rights reserved.
//

#import <GHUnit/GHUnit.h>
#import "LMLLibrary.h"

@interface LMLLibraryInitTest : GHTestCase { }
@end

@implementation LMLLibraryInitTest

- (void)testInitWithNilItemsShouldReturnNil {
	NSArray *items = nil;
	NSString *version = @"Version";
	NSString *sourceType = @"sourceType";
	LMLLibrary *library = [[[LMLLibrary alloc] initWithItems:items
													 version:version
												  sourceType:sourceType] autorelease];
	GHAssertNil(library, nil);
}

- (void)testInitWithNilVersionShouldReturnNil {
	NSArray *items = [NSArray array];
	NSString *version = nil;
	NSString *sourceType = @"sourceType";
	LMLLibrary *library = [[[LMLLibrary alloc] initWithItems:items
													 version:version
												  sourceType:sourceType] autorelease];
	GHAssertNil(library, nil);
}

- (void)testInitWithEmptyVersionShouldReturnNil {
	NSArray *items = [NSArray array];
	NSString *version = @"";
	NSString *sourceType = @"sourceType";
	LMLLibrary *library = [[[LMLLibrary alloc] initWithItems:items
													 version:version
												  sourceType:sourceType] autorelease];
	GHAssertNil(library, nil);
}

- (void)testInitWithNilSourceTypeShouldReturnNil {
	NSArray *items = [NSArray array];
	NSString *version = @"Version";
	NSString *sourceType = nil;
	LMLLibrary *library = [[[LMLLibrary alloc] initWithItems:items
													 version:version
												  sourceType:sourceType] autorelease];
	GHAssertNil(library, nil);
}

- (void)testInitWithEmptySourceTypeShouldReturnNil {
	NSArray *items = [NSArray array];
	NSString *version = @"Version";
	NSString *sourceType = @"";
	LMLLibrary *library = [[[LMLLibrary alloc] initWithItems:items
													 version:version
												  sourceType:sourceType] autorelease];
	GHAssertNil(library, nil);
}

- (void)testInitWithAllValuesShouldReturnALibraryWithAllExpectedPropertyValues {
	NSArray *items = [NSArray array];
	NSString *version = @"Version";
	NSString *sourceType = @"sourceType";
	LMLLibrary *library = [[[LMLLibrary alloc] initWithItems:items
													 version:version
												  sourceType:sourceType] autorelease];
	GHAssertNotNil(library, nil);
	
	GHAssertNotNil([library items], nil);
	GHAssertTrue(items == [library items], nil);
	
	NSString *libraryVersion = [library version];
	GHAssertNotNil(libraryVersion, nil);
	GHAssertEqualStrings(version, libraryVersion, nil);
	
	NSString *librarySourceType = [library sourceType];
	GHAssertNotNil(librarySourceType, nil);
	GHAssertEqualStrings(sourceType, librarySourceType, nil);
}

@end
