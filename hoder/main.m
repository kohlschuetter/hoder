//
//  main.m
//  hoder
//
//  Created by Christian Kohlschütter on 15.01.23.
//

#import <Foundation/Foundation.h>
#include <CoreGraphics/CGDirectDisplay.h>

// SkyLight.framework (PrivateFrameworks)
// hat tip to https://github.com/joevt/AllRez
CGError SLSDisplaySetHDRModeEnabled(CGDirectDisplayID display, bool enable, int, int)  __attribute__((weak_import));
bool SLSDisplayIsHDRModeEnabled(CGDirectDisplayID display) __attribute__((weak_import));
bool SLSDisplaySupportsHDRMode(CGDirectDisplayID display) __attribute__((weak_import));

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        CGDirectDisplayID displays[4];
        uint32_t numDisplays;
        CGGetOnlineDisplayList(4, displays, &numDisplays);

        for(uint32_t i = 1 /* skip internal display */; i<numDisplays; i++) {
            CGDirectDisplayID display = displays[i];
            if(SLSDisplaySupportsHDRMode(display) && !SLSDisplayIsHDRModeEnabled(display)) {
                NSLog(@"Enabling HDR on external display %i\n", i);
                SLSDisplaySetHDRModeEnabled(display, true, 0, 0);
            }
        }
    }
    return 0;
}
