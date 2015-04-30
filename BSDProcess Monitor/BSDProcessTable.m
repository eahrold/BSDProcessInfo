//
//  BSDProcessTable.m
//  fads
//
//  Created by Eldon on 5/2/15.
//  Copyright (c) 2015 Eldon Ahrold. All rights reserved.
//

#import "BSDProcessTable.h"
#import "BSDProcessInfo.h"

@interface BSDProcessTable ()
@property (copy, nonatomic) NSMutableArray *bsdProcessList;
@end

@implementation BSDProcessTable {
    NSArray *_currentSortDescriptor;
    NSPredicate *_currentPredicate;
}

- (void)refreshProcesses:(NSTimer *)timer {
    _bsdProcessList = [[BSDProcessInfo allProcesses] mutableCopy];
    [self reloadData];
}

- (void)reloadData {
    if (!_bsdProcessList) {
        _bsdProcessList = [[BSDProcessInfo allProcesses] mutableCopy];

        self.delegate = self;
        self.dataSource = self;
        NSTimer *timer =
            [NSTimer timerWithTimeInterval:3.0
                                    target:self
                                  selector:@selector(refreshProcesses:)
                                  userInfo:nil
                                   repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer
                                     forMode:NSRunLoopCommonModes];
    }

    if (_currentPredicate) {
        [_bsdProcessList filterUsingPredicate:_currentPredicate];
    }

    if (_currentSortDescriptor) {
        [_bsdProcessList sortUsingDescriptors:_currentSortDescriptor];
    }

    [super reloadData];
}

- (BOOL)killSelectedProcess:(NSError *__autoreleasing *)aError {
    BSDProcessInfo *info = _bsdProcessList[self.selectedRow];
    NSString *errMessage = nil;

    int err = -1;
    if (info.pid > 100) {
        err = [info kill:SIGTERM];
        if (err == 0) {
            [_bsdProcessList removeObject:info];
            [self reloadData];
        } else {
            errMessage =
                [NSString stringWithFormat:@"[ERROR %d] Could not kill %@.",
                                           err,
                                           info.name];
        }
    } else {
        errMessage =
            [NSString stringWithFormat:
                          @"[ERROR -1] Will not kill %@, pid is less than 100.",
                          info.name];
    }
    if (aError && errMessage) {
        *aError = [NSError
            errorWithDomain:@"BSDProcess Monitor"
                       code:err
                   userInfo:@{
                       NSLocalizedDescriptionKey : @"Error Killing Process",
                       NSLocalizedRecoverySuggestionErrorKey : errMessage
                   }];
    }
    return (err == 0);
}

- (void)filterWithString:(NSString *)string {
    if (string.length) {
        // Set up predicate
        _currentPredicate = [NSPredicate
            predicateWithFormat:@"(%K CONTAINS[CD] %@) OR (%K CONTAINS[CD] %@) "
                                @"OR (%K CONTAINS[CD] %@)",
                                NSStringFromSelector(@selector(name)),
                                string,
                                NSStringFromSelector(@selector(effectiveUser)),
                                string,
                                NSStringFromSelector(@selector(argumentString)),
                                string];
    } else {
        _currentPredicate = nil;
    }
    [self reloadData];
}

#pragma mark - Table view delegate
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _bsdProcessList.count;
}

- (id)tableView:(NSTableView *)tableView
    objectValueForTableColumn:(NSTableColumn *)tableColumn
                          row:(NSInteger)row {
    id res = [_bsdProcessList[row] valueForKey:tableColumn.identifier];
    return res;
}

- (void)tableView:(NSTableView *)tableView
    sortDescriptorsDidChange:(NSArray *)oldDescriptors {
    _currentSortDescriptor = [tableView sortDescriptors];
    [self reloadData];
}

@end
