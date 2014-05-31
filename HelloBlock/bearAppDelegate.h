//
//  bearAppDelegate.h
//  HelloBlock
//
//  Created by Bear on 2014/5/31.
//  Copyright (c) 2014年 TakoBear. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MainWindowController;

@interface bearAppDelegate : NSObject <NSApplicationDelegate>

// Main.xib 的視窗
@property (assign) IBOutlet NSWindow *window;

// MainWindowController
@property (nonatomic, strong) MainWindowController *mainWindowController;

// 進度條
@property (weak) IBOutlet NSLevelIndicator *levelIndicator;

// 自定 Block 變數形態
typedef void(^CompleteLoadedBlock)();

@end
