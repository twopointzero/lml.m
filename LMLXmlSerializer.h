//
//  LMLXmlSerializer.h
//  lml
//
//  Created by Jeremy Gray on 10-06-27.
//  Copyright 2010 twopointzero Solutions. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LMLItem.h"
#import "LMLLibrary.h"

@interface LMLXmlSerializer : NSObject {
}

- (NSXMLElement *)elementFromLibrary:(LMLLibrary *)library;
- (NSXMLElement *)elementFromItem:(LMLItem *)item;

@end
