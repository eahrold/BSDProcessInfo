//
//  AppDelegate.m
//  BSDProcess Monitor
//
//  Created by Eldon on 5/2/15.
//
//

#import "AppDelegate.h"

@interface AppDelegate () <NSTextFieldDelegate>

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [_processTable reloadData];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:
            (NSApplication *)sender {
    return YES;
}

- (void)refreshTable:(NSTimer *)timer {
    [_processTable reloadData];
}

- (IBAction)kill:(id)sender {
    NSError *error;
    if (![_processTable killSelectedProcess:&error]) {
        [NSApp presentError:error];
    }
}

#pragma mark - Text field delegate
- (void)controlTextDidChange:(NSNotification *)notification {
    [_processTable filterWithString:[[notification object] stringValue]];
}

@end
