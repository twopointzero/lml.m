//
//  LMLItemTest.m
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

- (void)testInitWithNullItemsShouldReturnNil {
	NSArray *items = NULL;
	NSString *version = @"Version";
	NSString *sourceType = @"sourceType";
	LMLLibrary *library = [[LMLLibrary alloc] initWithItems:items
													version:version
												 sourceType:sourceType];
	GHAssertNil(library, nil);
}

- (void)testInitWithNullVersionShouldReturnNil {
	NSArray *items = [NSArray array];
	NSString *version = NULL;
	NSString *sourceType = @"sourceType";
	LMLLibrary *library = [[LMLLibrary alloc] initWithItems:items
													version:version
												 sourceType:sourceType];
	GHAssertNil(library, nil);
}

- (void)testInitWithEmptyVersionShouldReturnNil {
	NSArray *items = [NSArray array];
	NSString *version = @"";
	NSString *sourceType = @"sourceType";
	LMLLibrary *library = [[LMLLibrary alloc] initWithItems:items
													version:version
												 sourceType:sourceType];
	GHAssertNil(library, nil);
}

- (void)testInitWithNullSourceTypeShouldReturnNil {
	NSArray *items = [NSArray array];
	NSString *version = @"Version";
	NSString *sourceType = NULL;
	LMLLibrary *library = [[LMLLibrary alloc] initWithItems:items
													version:version
												 sourceType:sourceType];
	GHAssertNil(library, nil);
}

- (void)testInitWithEmptySourceTypeShouldReturnNil {
	NSArray *items = [NSArray array];
	NSString *version = @"Version";
	NSString *sourceType = @"";
	LMLLibrary *library = [[LMLLibrary alloc] initWithItems:items
													version:version
												 sourceType:sourceType];
	GHAssertNil(library, nil);
}

- (void)testInitWithAllValuesShouldReturnALibraryWithAllExpectedPropertyValues {
	NSArray *items = [NSArray array];
	NSString *version = @"Version";
	NSString *sourceType = @"sourceType";
	LMLLibrary *library = [[LMLLibrary alloc] initWithItems:items
													version:version
												 sourceType:sourceType];
	GHAssertNotNULL(library, nil);
	
	GHAssertNotNULL([library items], nil);
	GHAssertTrue(items == [library items], nil);
	
	NSString *libraryVersion = [library version];
	GHAssertNotNULL(libraryVersion, nil);
	GHAssertEqualStrings(version, libraryVersion, nil);
	
	NSString *librarySourceType = [library sourceType];
	GHAssertNotNULL(librarySourceType, nil);
	GHAssertEqualStrings(sourceType, librarySourceType, nil);
}

@end
