//
//  LMLLibrary.h
//  lml
//
//  Created by Jeremy Gray on 10-06-23.
//  Copyright 2010 twopointzero Solutions. All rights reserved.
//


@interface LMLLibrary : NSObject {
	NSArray *items;
	NSString *sourceType;
	NSString *version;
}

@property (readonly) NSArray *items;
@property (readonly) NSString *sourceType;
@property (readonly) NSString *version;

- (id)initWithItems:(NSArray *)someItems
			version:(NSString *)aVersion
		 sourceType:(NSString *)aSourceType;

@end
