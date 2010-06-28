//
//  LMLXmlSerializer.m
//  lml
//
//  Created by Jeremy Gray on 10-06-27.
//  Copyright 2010 twopointzero Solutions. All rights reserved.
//

#import "LMLXmlSerializer.h"


@implementation LMLXmlSerializer

- (NSXMLElement *)elementFromLibrary:(LMLLibrary *)library {
	if (library == nil)
		return nil;
	
	NSMutableArray *items = [NSMutableArray array];
	
	NSEnumerator *enumerator = [[library items] objectEnumerator];
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
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	[dateFormatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ss'Z'"];
	NSString *dateString = [dateFormatter stringFromDate: date];
	[dateFormatter release];
	
	[element addAttribute:[NSXMLNode attributeWithName:attributeName stringValue:dateString]];
}

- (void)addAttributeIfNotNull:(NSXMLElement *)element
				attributeName:(NSString *)attributeName
				doublePointer:(double *)doublePointer
				 formatString:(NSString *)formatString {
	if (doublePointer == NULL)
		return;
	
	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setFormat:formatString];
	NSNumber *number = [NSNumber numberWithDouble:*doublePointer];
	NSString *stringValue = [numberFormatter stringFromNumber:number];
	[numberFormatter release];
	[element addAttribute:[NSXMLNode attributeWithName:attributeName stringValue:stringValue]];
}

- (NSXMLElement *)elementFromItem:(LMLItem *)item {
	if (item == nil)
		return nil;
	
	NSXMLElement *element = [NSXMLNode elementWithName:@"i"];
	
	[self addAttributeIfNotNilOrEmpty:element attributeName:@"a" stringValue:[item artist]];
	
	[self addAttributeIfNotNilOrEmpty:element attributeName:@"t" stringValue:[item title]];
	
	[self addAttributeIfNotNull:element
				  attributeName:@"r"
				  doublePointer:[item rating]
				   formatString:@"0.###"];
	
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
				  doublePointer:[item duration]
				   formatString:@"0.###"];
	
	return element;
}

@end
