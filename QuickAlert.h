//
//  QuickAlert.h
//
//  Created by Derrick Walker on 1/31/14.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface QuickAlert : NSObject <UIAlertViewDelegate>

// Public Methods
+ (void)showMessage:(NSString *)apMessage;

+ (void)showMessage:(NSString *)apMessage
          withTitle:(NSString *)apTitle;

+ (void)showMessage:(NSString *)apMessage
          withTitle:(NSString *)apTitle
         buttonText:(NSString *)apButtonText
        actionBlock:(void (^)(void))aActionBlock;

+ (void)showMessage:(NSString *)apMessage
          withTitle:(NSString *)apTitle
       buttonCancel:(NSString *)apCancelText
            button1:(NSString *)apButton1Text
        cancelBlock:(void (^)(void))aCancelBlock
        actionBlock:(void (^)(void))aActionBlock;

+ (void)showMessage:(NSString *)apMessage
          withTitle:(NSString *)apTitle
       buttonCancel:(NSString *)apCancelText
            button1:(NSString *)apButton1Text
            button2:(NSString *)apButton2Text
        cancelBlock:(void (^)(void))aCancelBlock
       action1Block:(void (^)(void))aAction1Block
       action2Block:(void (^)(void))aAction2Block;

+ (void)showMessage:(NSString *)apMessage
          withTitle:(NSString *)apTitle
       buttonCancel:(NSString *)apCancelText
            button1:(NSString *)apButton1Text
            button2:(NSString *)apButton2Text
            button3:(NSString *)apButton3Text
        cancelBlock:(void (^)(void))aCancelBlock
       action1Block:(void (^)(void))aAction1Block
       action2Block:(void (^)(void))aAction2Block
       action3Block:(void (^)(void))aAction3Block;

+ (void)showMessage:(NSString *)apMessage
          withTitle:(NSString *)apTitle
       buttonCancel:(NSString *)apCancelText
            button1:(NSString *)apButton1Text
            button2:(NSString *)apButton2Text
            button3:(NSString *)apButton3Text
            button4:(NSString *)apButton4Text
        cancelBlock:(void (^)(void))aCancelBlock
       action1Block:(void (^)(void))aAction1Block
       action2Block:(void (^)(void))aAction2Block
       action3Block:(void (^)(void))aAction3Block
       action4Block:(void (^)(void))aAction4Block;

@end
