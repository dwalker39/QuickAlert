//
//  QuickAlert.m
//
//  Created by Derrick Walker on 1/31/14.
//
//

#import "QuickAlert.h"

@interface QuickAlertManager : NSObject

@property (nonatomic, strong) NSMutableArray *alertContainer;

@end

@implementation QuickAlertManager

#pragma mark - Public Methods

- (void)addQuickAlertInstance:(QuickAlert *)apAlertInstance {
    assert(apAlertInstance);
    [_alertContainer addObject:apAlertInstance];
}

- (void)removeQuickAlertInstance:(QuickAlert *)apAlertInstance {
    assert(apAlertInstance);
    [_alertContainer removeObject:apAlertInstance];
}

#pragma mark - Singleton

+ (QuickAlertManager *)defaultManager {
    static QuickAlertManager *gcpQuickAlertManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gcpQuickAlertManager = [[QuickAlertManager alloc] init];
    });
    
    return gcpQuickAlertManager;
}

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.alertContainer = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end

// ---------------------------------------------------------------------------------------

@interface QuickAlert ()
{
    // Blocks
    void (^ mActionBlock1)(void);
    void (^ mActionBlock2)(void);
    void (^ mActionBlock3)(void);
    void (^ mActionBlock4)(void);
    void (^ mCancelBlock)(void);
}

@property (nonatomic, strong) UIAlertView *alertView;

@end

@implementation QuickAlert

@synthesize alertView = mpAlertView;

#pragma mark -
#pragma mark Public Methods

+ (void)showMessage:(NSString *)apMessage {
    [QuickAlert showMessage:apMessage
                  withTitle:nil
               buttonCancel:@"OK"
                    button1:nil
                    button2:nil
                    button3:nil
                    button4:nil
                cancelBlock:nil
               action1Block:nil
               action2Block:nil
               action3Block:nil
               action4Block:nil];
}

+ (void)showMessage:(NSString *)apMessage withTitle:(NSString *)apTitle {
    [QuickAlert showMessage:apMessage
                  withTitle:apTitle
               buttonCancel:@"OK"
                    button1:nil
                    button2:nil
                    button3:nil
                    button4:nil
                cancelBlock:nil
               action1Block:nil
               action2Block:nil
               action3Block:nil
               action4Block:nil];
}

+ (void)showMessage:(NSString *)apMessage
          withTitle:(NSString *)apTitle
       buttonText:(NSString *)apButtonText
        actionBlock:(void (^)(void))aActionBlock {
    [QuickAlert showMessage:apMessage
                  withTitle:apTitle
                    buttonCancel:apButtonText
                    button1:nil
                    button2:nil
                    button3:nil
                    button4:nil
                cancelBlock:aActionBlock
               action1Block:nil
               action2Block:nil
               action3Block:nil
               action4Block:nil];
}

+ (void)showMessage:(NSString *)apMessage
          withTitle:(NSString *)apTitle
       buttonCancel:(NSString *)apCancelText
            button1:(NSString *)apButton1Text
        cancelBlock:(void (^)(void))aCancelBlock
        actionBlock:(void (^)(void))aActionBlock; {
    [QuickAlert showMessage:apMessage
                  withTitle:apTitle
                buttonCancel:apCancelText
                    button1:apButton1Text
                    button2:nil
                    button3:nil
                    button4:nil
                cancelBlock:aCancelBlock
               action1Block:aActionBlock
               action2Block:nil
               action3Block:nil
               action4Block:nil];
}

+ (void)showMessage:(NSString *)apMessage
          withTitle:(NSString *)apTitle
       buttonCancel:(NSString *)apCancelText
            button1:(NSString *)apButton1Text
            button2:(NSString *)apButton2Text
        cancelBlock:(void (^)(void))aCancelBlock
       action1Block:(void (^)(void))aAction1Block
       action2Block:(void (^)(void))aAction2Block {
    [QuickAlert showMessage:apMessage
                  withTitle:apTitle
               buttonCancel:apCancelText
                    button1:apButton1Text
                    button2:apButton2Text
                    button3:nil
                    button4:nil
                cancelBlock:aCancelBlock
               action1Block:aAction1Block
               action2Block:aAction2Block
               action3Block:nil
               action4Block:nil];
}

+ (void)showMessage:(NSString *)apMessage
          withTitle:(NSString *)apTitle
       buttonCancel:(NSString *)apCancelText
            button1:(NSString *)apButton1Text
            button2:(NSString *)apButton2Text
            button3:(NSString *)apButton3Text
        cancelBlock:(void (^)(void))aCancelBlock
       action1Block:(void (^)(void))aAction1Block
       action2Block:(void (^)(void))aAction2Block
       action3Block:(void (^)(void))aAction3Block {
    [QuickAlert showMessage:apMessage
                  withTitle:apTitle
               buttonCancel:apCancelText
                    button1:apButton1Text
                    button2:apButton2Text
                    button3:apButton3Text
                    button4:nil
                cancelBlock:aCancelBlock
               action1Block:aAction1Block
               action2Block:aAction2Block
               action3Block:aAction3Block
               action4Block:nil];
}

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
       action4Block:(void (^)(void))aAction4Block {
    QuickAlert *vpMessageInstance = [[QuickAlert alloc] init];
    
#if __has_feature(objc_arc)
    [[QuickAlertManager defaultManager] addQuickAlertInstance:vpMessageInstance];
#endif
    
    if (apCancelText == nil) {
        apCancelText = @"OK";
    }
    
    vpMessageInstance.alertView = [[UIAlertView alloc] initWithTitle:apTitle
                                                             message:apMessage
                                                            delegate:vpMessageInstance
                                                   cancelButtonTitle:apCancelText
                                                   otherButtonTitles:apButton1Text, apButton2Text, apButton3Text, apButton4Text, nil];

    // copy blocks to the heap
    vpMessageInstance->mActionBlock1 = [aAction1Block copy];
    vpMessageInstance->mActionBlock2 = [aAction2Block copy];
    vpMessageInstance->mActionBlock3 = [aAction3Block copy];
    vpMessageInstance->mActionBlock4 = [aAction4Block copy];
    vpMessageInstance->mCancelBlock = [aCancelBlock copy];
    
#if ! __has_feature(objc_arc)
    Block_release(aAction1Block);
    Block_release(aAction2Block);
    Block_release(aAction3Block);
    Block_release(aAction4Block);
    Block_release(aCancelBlock);
#endif
    
    if ([NSThread isMainThread] == NO) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [ vpMessageInstance.alertView show ];
        });
    } else {
        [vpMessageInstance.alertView show];
    }
}

#pragma mark - UIAlertViewDelegate 

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    assert([alertView.delegate isKindOfClass:[QuickAlert class]]);
    switch (buttonIndex) {
        case 1:
            if (mActionBlock1) {
                mActionBlock1();
            }
            break;
            
        case 2:
            if (mActionBlock2) {
                mActionBlock2();
            }
            break;
            
        case 3:
            if (mActionBlock3) {
                mActionBlock3();
            }
            break;
            
        case 4:
            if (mActionBlock4) {
                mActionBlock4();
            }
            break;
            
        default:
            if (mCancelBlock) {
                mCancelBlock();
            }
            break;
    }
    
#if __has_feature(objc_arc)
    [[QuickAlertManager defaultManager] removeQuickAlertInstance:self];
#else
    [mpAlertView release];
    [self release];
#endif
}

#pragma mark - Lifecycle

#if ! __has_feature(objc_arc)
- (void)dealloc {
    Block_release(mActionBlock1);
    Block_release(mActionBlock2);
    Block_release(mActionBlock3);
    Block_release(mActionBlock4);
    Block_release(mCancelBlock);
    
    [super dealloc];
}
#endif

@end
