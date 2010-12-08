//
//  LMLXmlSerializer.m
//  lml
//
//  Created by Jeremy Gray on 10-06-27.
//  Copyright 2010 twopointzero Solutions. All rights reserved.
//

#import "LMLXmlSerializer.h"


@implementation LMLXmlSerializer

- (id)init {
	if (![super init])
		return nil;

	dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	[dateFormatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ss'Z'"];

	numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setFormat:@"0.###"];

	return self;
}

- (NSXMLElement *)elementFromLibrary:(LMLLibrary *)library {
	if (library == nil)
		return nil;

	NSArray *libraryItems = [library items];

	NSMutableArray *items = [NSMutableArray arrayWithCapacity:[libraryItems count]];

	NSEnumerator *enumerator = [libraryItems objectEnumerator];
	LMLItem *item;

	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	while ((item = [enumerator nextObject])) {
		[items addObject:[self elementFromItem:item]];
	}

	[pool drain];

	NSArray *attributes = [NSArray arrayWithObjects:
						   [NSXMLNode attributeWithName:@"v" stringValue:[library version]],
						   [NSXMLNode attributeWithName:@"st" stringValue:[library sourceType]],
						   nil];
	return [NSXMLNode elementWithName:@"l"
							 children:items
						   attributes:attributes];
}

- (void)addAttributeIfNotNilOrEmpty:(NSXMLElement *)element
					  attributeName:(NSString *)attributeName
						stringValue:(NSString *)stringValue {
	if (stringValue != nil && [stringValue length] != 0)
		[element addAttribute:[NSXMLNode attributeWithName:attributeName stringValue:stringValue]];
}

- (void)addAttributeIfNotNil:(NSXMLElement *)element
			   attributeName:(NSString *)attributeName
				   dateValue:(NSDate *)date {
	if (date == nil)
		return;
	
	NSString *dateString = [dateFormatter stringFromDate: date];
	
	[element addAttribute:[NSXMLNode attributeWithName:attributeName stringValue:dateString]];
}

- (void)addAttributeIfNotNull:(NSXMLElement *)element
				attributeName:(NSString *)attributeName
				doublePointer:(double *)doublePointer {
	if (doublePointer == NULL)
		return;
	
	NSNumber *number = [NSNumber numberWithDouble:*doublePointer];
	NSString *stringValue = [numberFormatter stringFromNumber:number];
	[element addAttribute:[NSXMLNode attributeWithName:attributeName stringValue:stringValue]];
}

- (NSXMLElement *)elementFromItem:(LMLItem *)item {
	if (item == nil)
		return nil;
	
	NSXMLElement *element = [NSXMLNode elementWithName:@"i"];
	
	[self addAttributeIfNotNilOrEmpty:element attributeName:@"a" stringValue:[item artist]];

	[self addAttributeIfNotNilOrEmpty:element attributeName:@"al" stringValue:[item album]];
	
	[self addAttributeIfNotNilOrEmpty:element attributeName:@"t" stringValue:[item title]];
	
	[self addAttributeIfNotNull:element
				  attributeName:@"r"
				  doublePointer:[item rating]];
	
	[self addAttributeIfNotNil:element attributeName:@"da" dateValue:[item dateAdded]];
	
	if ([item playCount] != NULL) {
		int playCount = *[item playCount];
		NSString *playCountString = [NSString stringWithFormat:@"%d", playCount];
		[element addAttribute:[NSXMLNode attributeWithName:@"pc" stringValue:playCountString]];
	}
	
	[self addAttributeIfNotNil:element attributeName:@"lp" dateValue:[item lastPlayed]];
	
	[self addAttributeIfNotNilOrEmpty:element attributeName:@"g" stringValue:[item genre]];
	
	[self addAttributeIfNotNilOrEmpty:element attributeName:@"l" stringValue:[item location]];
	
	[self addAttributeIfNotNull:element
				  attributeName:@"ds"
				  doublePointer:[item duration]];
	
	if ([item bitsPerSecond] != NULL) {
		int bitsPerSecond = *[item bitsPerSecond];
		NSString *bitsPerSecondString = [NSString stringWithFormat:@"%d", bitsPerSecond];
		[element addAttribute:[NSXMLNode attributeWithName:@"bps" stringValue:bitsPerSecondString]];
	}
	
	return element;
}

- (void)dealloc
{
	[dateFormatter release];
	[numberFormatter release];

	[super dealloc];
}

@end
