//
//  AppDelegate.h
//  BSDProcess Monitor
//
//  Created by Eldon on 5/2/15.
//
//

#import <Cocoa/Cocoa.h>
#import "BSDProcessTable.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (strong, nonatomic) IBOutlet BSDProcessTable *processTable;

@end
