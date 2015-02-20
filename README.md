QuickAlert
==================
This is a Swift UIViewController extension class that works as a is a wrapper for UIAlertView and UIAlertController, it includes block handlers as supports all iOS versions. The class will use UIAlertView if the device is iOS 7 or below, and uses the new UIAlertController if iOS 8 or greater. Provides a simple interface for easily creating alerts with blocks.

Installation
==================
Add QuickAlert.h/.m and UIViewController+QuickAlert.swift files to your project. Make sure to import "QuickAlert.h" into your project's Bridging-Header (if your project doesn't have one you'll need to create one).

After you add UIViewController+QuickAlert.swift to your project (or any swift file to an Objective-C project) Xcode will create a "<YourProjectName>-Swift.h" that exposes swift files to Objective-C. Make sure to import this somewhere in your project to be able to use QuickAlert on any of your UIViewControllers

Example usage
==================
On any UIViewController simply call:
```objective-c
    [self showMessage:@"And boom goes the dynamite"
                title:@"Warning"];
```

Using block handlers look like this:
```objective-c
    [self showMessage:@"This action cannot be undone, are you sure you wish to delete everything?"
                title:@"Warning"
     buttonCancelText:@"No"
           buttonText:@"Yes"
   buttonCancelAction:^{
       NSLog(@"User tapped cancel");
   }
         buttonAction:^{
              NSLog(@"Delete everything the user holds dear");   
          }];
```
