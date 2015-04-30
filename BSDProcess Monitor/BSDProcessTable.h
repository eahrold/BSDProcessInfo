//
//  BSDProcessTable.h
//  fads
//
//  Created by Eldon on 5/2/15.
//  Copyright (c) 2015 Eldon Ahrold. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@interface BSDProcessTable
    : NSTableView <NSTableViewDataSource, NSTableViewDelegate>

- (BOOL)killSelectedProcess:(NSError *__autoreleasing *)error;
- (void)filterWithString:(NSString *)string;
@end
