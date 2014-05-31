//
//  bearAppDelegate.m
//  HelloBlock
//
//  Created by Bear on 2014/5/31.
//  Copyright (c) 2014年 TakoBear. All rights reserved.
//

#import "bearAppDelegate.h"
#import "MainWindowController.h"

@implementation bearAppDelegate

/*
 * 程式執行
 */
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // 建立 block 變數
    CompleteLoadedBlock blockVar = ^{
        [self.window close];
        [self.mainWindowController showWindow:self];
    };
    
    // 由於模擬讀取進度條會佔據長時間的操作
    // 所以建立一個 operation queue 在背景模擬讀取
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        [self timelock:blockVar];
    }];
    
}

/*
 * 關閉最後一個視窗就結束程式
 */
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

/*
 * 取得 mainWindowController
 */
- (MainWindowController *)mainWindowController
{
    if (_mainWindowController == nil) {
        _mainWindowController = [[MainWindowController alloc] initWithWindowNibName:@"MainWindowController"];
    }
    return _mainWindowController;
}

/*
 * 模擬讀取
 */
- (void)timelock:(CompleteLoadedBlock)lastblock {
    
    for (int i=0; i<=10; i++) {
        // 當有 UI 需要改變時，要切換到 MainOperationQueue 做操作
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.levelIndicator setIntValue:i];
        }];
        
        // 停一秒以模擬讀取
        [NSThread sleepForTimeInterval:1];
    }
    
    // 當有 UI 需要改變時，要切換到 MainOperationQueue 做操作
    [[NSOperationQueue mainQueue] addOperationWithBlock:lastblock];
}

@end
