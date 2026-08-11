#include <Geode/Geode.hpp>

#if defined(GEODE_IS_IOS)
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <GLKit/GLKit.h>
#import <objc/runtime.h>
#endif

using namespace geode::prelude;

#if defined(GEODE_IS_IOS)

namespace {

constexpr NSInteger TARGET_FPS = 120;

NSInteger supportedFPS() {
    UIScreen* screen = UIScreen.mainScreen;
    if (!screen) return TARGET_FPS;

    // Never request a rate higher than the physical display supports.
    return MIN(TARGET_FPS, screen.maximumFramesPerSecond);
}

void apply120FPS() {
    const auto fps = supportedFPS();

    // Geometry Dash's Cocos2d game loop.
    if (auto* director = CCDirector::sharedDirector()) {
        director->setAnimationInterval(1.0 / static_cast<double>(fps));
    }

    UIApplication* app = UIApplication.sharedApplication;
    if (!app) return;

    // Geode/iOS versions can expose the game through different controller
    // hierarchies, so inspect every current window.
    for (UIWindow* window in app.windows) {
        UIViewController* controller = window.rootViewController;
        while (controller.presentedViewController) {
            controller = controller.presentedViewController;
        }

        if (!controller) continue;

        // Older Cocos2d/iOS setups commonly use GLKViewController.
        if ([controller isKindOfClass:[GLKViewController class]]) {
            auto* glk = (GLKViewController*)controller;
            glk.preferredFramesPerSecond = fps;
        }
    }
}

} // namespace

$execute {
    // Run after the app/game has created its iOS windows.
    geode::queueInMainThread([] {
        apply120FPS();

        // Re-apply once shortly after startup because the game may recreate
        // its rendering controller after Geode loads.
        dispatch_after(
            dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)),
            dispatch_get_main_queue(),
            ^{
                apply120FPS();
            }
        );
    });
}

#else

$execute {
    log::warn("120 FPS Unlock is an iOS-only mod.");
}

#endif
