//
//  LMLAppleITunesXmlImporter.h
//  lml
//
//  Created by Jeremy Gray on 10-06-25.
//  Copyright 2010 twopointzero Solutions. All rights reserved.
//

#import "LMLLibrary.h"

@interface LMLAppleITunesXmlImporter : NSObject {
}

- (LMLLibrary *)import:(NSString *)path error:(NSError **)error;

@end
