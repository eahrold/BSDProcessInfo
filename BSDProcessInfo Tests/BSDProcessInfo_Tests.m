//
//  BSDProcessInfo_Tests.m
//  BSDProcessInfo Tests
//
//  Created by Eldon on 4/30/15.
//
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "BSDProcessInfo.h"

@interface BSDProcessInfo_Tests : XCTestCase

@end

@implementation BSDProcessInfo_Tests

- (void)testInitWithPid {
    BSDProcessInfo *info;
    info = [[BSDProcessInfo alloc] initWithPid:1];
    XCTAssertNotNil(info, @"Could not init launchd by pid");

    info = [BSDProcessInfo processWithPid:0];
    XCTAssertNotNil(info, @"Could not init kern_task by pid");
}

- (void)testRunningProcessWithArgs {
    NSArray *argsMatch = @[ @"-s", @"MDSImporterWorker" ];
    BSDProcessInfo *info = [BSDProcessInfo processWithName:@"mdworker" matchingArguments:argsMatch];

    XCTAssertNotNil(info, @"No matching process");

    if (info) {
        XCTAssertTrue(info.isRunning, @"LaunchD This should be running");
        XCTAssertNotNil(info.arguments, @"No args found for mdworker");
        NSLog(@"%@", info);
    }
}

- (void)testAllProcs {
    NSArray *processes;

    processes = [BSDProcessInfo allProcesses];
    NSInteger procCount1 = processes.count;

    XCTAssert(processes.count, @"No matching process");
    NSLog(@"All Proc count: %lu", (unsigned long)processes.count);

    processes = [BSDProcessInfo allUserProcesses];
    NSInteger procCount2 = processes.count;

    XCTAssert(processes.count, @"No matching process");
    NSLog(@"User Proc count: %lu", (unsigned long)processes.count);

    XCTAssertGreaterThan(procCount1, procCount2, @"User processes should be less");

    processes = [BSDProcessInfo allProcessesWithName:@"launchd"];
    procCount1 = processes.count;

    XCTAssert(processes.count, @"No matching process");
    NSLog(@"LaunchD by name count: %lu", (unsigned long)processes.count);

    processes = [BSDProcessInfo allProcessesWithExecutablePath:@"/sbin/launchd"];
    procCount2 = processes.count;
    XCTAssert(processes.count, @"No matching process");
    NSLog(@"LaunchD buy executable count: %lu", (unsigned long)processes.count);

    XCTAssertEqual(procCount1, procCount2, @"Should find launchd both ways.");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
                          // Put the code you want to measure the time of here.
                       }];
}

@end
