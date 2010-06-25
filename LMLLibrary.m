//
//  LMLLibrary.m
//  lml
//
//  Created by Jeremy Gray on 10-06-23.
//  Copyright 2010 twopointzero Solutions. All rights reserved.
//

#import "LMLLibrary.h"


@implementation LMLLibrary

@synthesize items;
@synthesize sourceType;
@synthesize version;

- (id)initWithItems:(NSArray *)someItems
			version:(NSString *)aVersion
		 sourceType:(NSString *)aSourceType {
	if (![super init])
		return nil;
	
	if (someItems == nil || aVersion == nil || aSourceType == nil ||
		[aVersion length] == 0 || [aSourceType length] == 0)
	{
		[self release];
		return nil;
	}
	
	[someItems retain];
	items = someItems;
	
	[aVersion retain];
	version = aVersion;
	
	[aSourceType retain];
	sourceType = aSourceType;
	
	return self;
}

- (void)dealloc
{
	[items release];
	[version release];
	[sourceType release];
	
	[super dealloc];
}

@end
