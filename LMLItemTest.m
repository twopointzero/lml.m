//
//  LMLItemTest.m
//  lml
//
//  Created by Jeremy Gray on 10-06-23.
//  Copyright 2010 twopointzero Solutions. All rights reserved.
//

#import <GHUnit/GHUnit.h>

@interface LMLItemTest : GHTestCase { }
@end

@implementation LMLItemTest

- (void)testGHUnit {
	GHTestLog(@"In testGHUnit.");
    GHAssertEquals(1, 1, nil);
}

@end
