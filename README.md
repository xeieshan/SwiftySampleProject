# README #

_Just like software, this document will rot unless we take care of it. We encourage everyone to help us on that – just open an issue or send a pull request!_

## Why?

Getting on board with iOS can be intimidating. Neither Swift nor Objective-C are widely used elsewhere, the platform has its own names for almost everything, and it's a bumpy road for your code to actually make it onto a physical device. This living document is here to help you, whether you're taking your first steps in Cocoaland or you're curious about doing things "the right way". Everything below is just suggestions, so if you have a good reason to do something differently, by all means go for it!

### Project Setup

A common question when beginning an iOS project is whether to write all views in code or use Interface Builder with Storyboards or XIB files. Both are known to occasionally result in working software. However, there are a few considerations:

### Xcode Setup
Please follow the url [macbook-for-developers]
[macbook-for-developers]:http://martiancraft.com/blog/2015/08/macbook-for-developers/

#### Why code?
* Storyboards are more prone to version conflicts due to their complex XML structure. This makes merging much harder than with code.
* It's easier to structure and reuse views in code, thereby keeping your codebase [DRY][dry].

[dry]: http://en.wikipedia.org/wiki/Don%27t_repeat_yourself

#### Why Storyboards?
* For the less technically inclined, Storyboards can be a great way to contribute to the project directly, e.g. by tweaking colors or layout constraints. However, this requires a working project setup and some time to learn the basics.
* Iteration is often faster since you can preview certain changes without building the project.
* In Xcode 6, custom fonts and UI elements are finally represented visually in Storyboards, giving you a much better idea of the final appearance while designing.

### Project Structure 

To keep all those hundreds of source files ending up in the same directory, it's a good idea to set up some folder structure depending on your architecture. For instance, you can use the following:

* ├─ Classes
* ├─── Application Delegate
* ├─── Category
* ├─── Constant
* ├─── Models
* ├─── Network Manager
* ├─── Shared Manager
* ├─── Utility Function
* ├─── Shared Manager
* ├─── View Controller
* 
* ├─ Views
* ├─── StoryBoard.storyboard
* ├─── LaunchScreen.xib
* 
* ├─ Resources
* ├─── Slices
* ├─── Fonts
* ├─── Sounds


First, create them as groups (little yellow "folders") within the group with your project's name in Xcode's Project Navigator. Then, for each of the groups, link them to an actual directory in your project path by opening their File Inspector on the right, hitting the little gray folder icon, and creating a new subfolder with the name of the group in your project directory.

### CocoaPods

If you're planning on including external dependencies (e.g. third-party libraries) in your project, [CocoaPods][cocoapods] offers easy and fast integration. Install it like so:

    sudo gem install cocoapods

To get started, move inside your iOS project folder and run

    pod init

This creates a Podfile, which will hold all your dependencies in one place. After adding your dependencies to the Podfile, you run

    pod install

to install the libraries and include them as part of a workspace which also holds your own project. It is generally [recommended to commit the installed dependencies to your own repo][committing-pods], instead of relying on having each developer running `pod install` after a fresh checkout.

Note that from now on, you'll need to open the `.xcworkspace` file instead of `.xcproject`, or your code will not compile. The command

    pod update

will update all pods to the newest versions permitted by the Podfile. You can use a wealth of [operators][cocoapods-pod-syntax] to specify your exact version requirements.

[cocoapods]: http://www.cocoapods.org
[cocoapods-pod-syntax]: http://guides.cocoapods.org/syntax/podfile.html#pod
[committing-pods]: https://www.dzombak.com/blog/2014/03/including-pods-in-source-control.html

#### Constants

Keep app-wide constants in a `Constants.h` file that is included in the prefix header.

Instead of preprocessor macro definitions (via `#define`), use actual constants:

    static CGFloat const kBrandingFontSizeSmall = 12.0f;
    static NSString * const kAwesomenessDeliveredNotificationName = @"foo";

Actual constants are type-safe, have more explicit scope (they’re not available in all imported/included files until undefined), cannot be redefined or undefined in later parts of the code, and are available in the debugger.

### “Event” Patterns

These are the idiomatic ways for components to notify others about things:

* __Delegation:__ _(one-to-one)_ Apple uses this a lot (some would say, too much). Use when you want to communicate stuff back e.g. from a modal view.
* __Callback blocks:__ _(one-to-one)_ Allow for a more loose coupling, while keeping related code sections close to each other. Also scales better than delegation when there are many senders.
* __Notification Center:__ _(one-to-many)_ Possibly the most common way for objects to emit “events” to multiple observers. Very loose coupling — notifications can even be observed globally without reference to the dispatching object.
* __Key-Value Observing (KVO):__ _(one-to-many)_ Does not require the observed object to explicitly “emit events” as long as it is _Key-Value Coding (KVC)_ compliant for the observed keys (properties). Usually not recommended due to its implicit nature and the cumbersome standard library API.

## Assets

[Asset catalogs][asset-catalogs] are the best way to manage all your project's visual assets. They can hold both universal and device-specific (iPhone 4-inch, iPhone Retina, iPad, etc.) assets and will automatically serve the correct ones for a given name. Teaching your designer(s) how to add and commit things there (Xcode has its own built-in Git client) can save a lot of time that would otherwise be spent copying stuff from emails or other channels to the codebase. It also allows them to instantly try out their changes and iterate if needed.

[asset-catalogs]: https://developer.apple.com/library/ios/recipes/xcode_help-image_catalog-1.0/Recipe.html

### Using Bitmap Images

Asset catalogs expose only the names of image sets, abstracting away the actual file names within the set. This nicely prevents asset name conflicts, as files such as `button_large@2x.png` are now namespaced inside their image sets. However, some discipline when naming assets can make life easier:

<!--```objective-c-->
<!--IconCheckmarkHighlighted.png // Universal, non-Retina-->
<!--IconCheckmarkHighlighted@2x.png // Universal @2x, Retina-->
<!--IconCheckmarkHighlighted@3x.png // Universal @3x, Retina (@3x is only on iPhone as of now!)-->
<!--IconCheckmarkHighlighted~iphone.png // iPhone, non-Retina-->
<!--IconCheckmarkHighlighted@2x~iphone.png // iPhone, Retina-->
<!--IconCheckmarkHighlighted-568h@2x~iphone.png // iPhone, Retina, 4-inch-->
<!--IconCheckmarkHighlighted~ipad.png // iPad, non-Retina-->
<!--IconCheckmarkHighlighted@2x~ipad.png // iPad, Retina-->
<!--```-->

The modifiers `-568h`, `@2x`, `~iphone` and `~ipad` are not required per se, but having them in the file name when dragging the file to an image set will automatically place them in the right "slot", thereby preventing assignment mistakes that can be hard to hunt down.

### Using Vector Images

You can include the original [vector graphics (PDFs)][vector-assets] produced by designers into the asset catalogs, and have Xcode automatically generate the bitmaps from that. This reduces the complexity of your project (the number of files to manage.)

[vector-assets]: http://martiancraft.com/blog/2014/09/vector-images-xcode6/

## Coding Style

### Naming

Apple pays great attention to keeping naming consistent, if sometimes a bit verbose, throughout their APIs. When developing for Cocoa, you make it much easier for new people to join the project if you follow [Apple's naming conventions][cocoa-coding-guidelines].

[cocoa-coding-guidelines]: https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CodingGuidelines/CodingGuidelines.html

Here are some basic takeaways you can start using right away:

A method beginning with a _verb_ indicates that it performs some side effects, but won't return anything:
`- (void)loadView;`
`- (void)startAnimating;`

Any method starting with a _noun_, however, returns that object and should do so without side effects:
`- (UINavigationItem *)navigationItem;`
`+ (UILabel *)labelWithText:(NSString *)text;`

It pays off to keep these two as separated as possible, i.e. not perform side effects when you transform data, and vice versa. That will keep your side effects contained to smaller sections of the code, which makes it more understandable and facilitates debugging.

## Building

### Build Configurations

Even simple apps can be built in different ways. The most basic separation that Xcode gives you is that between _debug_ and _release_ builds. For the latter, there is a lot more optimization going on at compile time, at the expense of debugging possibilities. Apple suggests that you use the _debug_ build configuration for development, and create your App Store packages using the _release_ build configuration. This is codified in the default scheme (the dropdown next to the Play and Stop buttons in Xcode), which commands that _debug_ be used for Run and _release_ for Archive.

However, this is a bit too simple for real-world applications. You might – no, [_should!_][futurice-environments] – have different environments for testing, staging and other activities related to your service. Each might have its own base URL, log level, bundle identifier (so you can install them side-by-side), provisioning profile and so on. Therefore a simple debug/release distinction won't cut it. You can add more build configurations on the "Info" tab of your project settings in Xcode.

[futurice-environments]: https://blog.futurice.com/five-environments-you-cannot-develop-without

#### `xcconfig` files for build settings

Typically build settings are specified in the Xcode GUI, but you can also use _configuration settings files_ (“`.xcconfig` files”) for them. The benefits of using these are:

- You can add comments to explain things
- You can `#include` other build settings files, which helps you avoid repeating yourself:
    - If you have some settings that apply to all build configurations, add a `Common.xcconfig` and `#include` it in all the other files
    - If you e.g. want to have a “Debug” build configuration that enables compiler optimizations, you can just `#include "MyApp_Debug.xcconfig"` and override one of the settings
- Conflict resolution and merging becomes easier

Find more information about this topic in [these presentation slides][xcconfig-slides].

[xcconfig-slides]: https://speakerdeck.com/hasseg/xcode-configuration-files

### Targets

A target resides conceptually below the project level, i.e. a project can have several targets that may override its project settings. Roughly, each target corresponds to "an app" within the context of your codebase. For instance, you could have country-specific apps (built from the same codebase) for different countries' App Stores. Each of these will need development/staging/release builds, so it's better to handle those through build configurations, not targets. It's not uncommon at all for an app to only have a single target.

### Schemes

Schemes tell Xcode what should happen when you hit the Run, Test, Profile, Analyze or Archive action. Basically, they map each of these actions to a target and a build configuration. You can also pass launch arguments, such as the language the app should run in (handy for testing your localizations!) or set some diagnostic flags for debugging.

A suggested naming convention for schemes is `MyApp (<Language>) [Environment]`:

    MyApp (English) [Development]
    MyApp (German) [Development]
    MyApp [Testing]
    MyApp [Staging]
    MyApp [App Store]

For most environments the language is not needed, as the app will probably be installed through other means than Xcode, e.g. TestFlight, and the launch argument thus be ignored anyway. In that case, the device language should be set manually to test localization.

## Deployment

Deploying software on iOS devices isn't exactly straightforward. That being said, here are some central concepts that, once understood, will help you tremendously with it.

### Signing

Whenever you want to run software on an actual device (as opposed to the simulator), you will need to sign your build with a __certificate__ issued by Apple. Each certificate is linked to a private/public keypair, the private half of which resides in your Mac's Keychain. There are two types of certificates:

* __Development certificate:__ Every developer on a team has their own, and it is generated upon request. Xcode might do this for you, but it's better not to press the magic "Fix issue" button and understand what is actually going on. This certificate is needed to deploy development builds to devices. 
__Naming Convention : CERT_DEV_XXX.p12__

* __Distribution certificate:__ There can be several, but it's best to keep it to one per organization, and share its associated key through some internal channel. This certificate is needed to ship to the App Store, or your organization's internal "enterprise app store".
__Naming Convention : CERT_DIST_XXX.p12__
### Provisioning

Besides certificates, there are also __provisioning profiles__, which are basically the missing link between devices and certificates. Again, there are two types to distinguish between development and distribution purposes:

* __Development provisioning profile:__ It contains a list of all devices that are authorized to install and run the software. It is also linked to one or more development certificates, one for each developer that is allowed to use the profile. The profile can be tied to a specific app or use a wildcard App ID (*). The latter is [discouraged][jared-sinclair-signing-tips], because Xcode is notoriously bad at picking the correct files for signing unless guided in the right direction. Also, certain capabilities like Push Notifications or App Groups require an explicit App ID.
__Naming Convention : PP_DEV_XXX.provisioningprofile__

* __Distribution provisioning profile:__ There are three different ways of distribution, each for a different use case. Each distribution profile is linked to a distribution certificate, and will be invalid when the certificate expires.
    * __Ad-Hoc:__ Just like development profiles, it contains a whitelist of devices the app can be installed to. This type of profile can be used for beta testing on 100 devices per year. For a smoother experience and up to 1000 distinct users, you can use Apple's newly acquired [TestFlight][testflight] service. Supertop offers a good [summary of its advantages and issues][testflight-discussion].
    * __App Store:__ This profile has no list of allowed devices, as anyone can install it through Apple's official distribution channel. This profile is required for all App Store releases.
    * __Enterprise:__ Just like App Store, there is no device whitelist, and the app can be installed by anyone with access to the enterprise's internal "app store", which can be just a website with links. This profile is available only on Enterprise accounts.
__Naming Convention : PP_DIST_XXX.provisioningprofile__

[jared-sinclair-signing-tips]: http://blog.jaredsinclair.com/post/116436789850/
[testflight]: https://developer.apple.com/testflight/
[testflight-discussion]: http://blog.supertop.co/post/108759935377/app-developer-friends-try-testflight

To sync all certificates and profiles to your machine, go to Accounts in Xcode's Preferences, add your Apple ID if needed, and double-click your team name. There is a refresh button at the bottom, but sometimes you just need to restart Xcode to make everything show up.

#### Debugging Provisioning

Sometimes you need to debug a provisioning issue. For instance, Xcode may refuse to install the build to an attached device, because the latter is not on the (development or ad-hoc) profile's device list. In those cases, you can use Craig Hockenberry's excellent [Provisioning][provisioning] plugin by browsing to `~/Library/MobileDevice/Provisioning Profiles`, selecting a `.mobileprovision` file and hitting Space to launch Finder's Quick Look feature. It will show you a wealth of information such as devices, entitlements, certificates, and the App ID.
[Use iPhone Configuration Utility][ConfigurationUtility]

[provisioning]: https://github.com/chockenberry/Provisioning
[ConfigurationUtility]: http://www.macupdate.com/app/mac/27986/apple-iphone-configuration-utility

### Uploading

[iTunes Connect][itunes-connect] is Apple's portal for managing your apps on the App Store. To upload a build, Xcode 6 requires an Apple ID that is part of the developer account used for signing. This can make things tricky when you are part of several developer accounts and want to upload their apps, as for mysterious reasons _any given Apple ID can only be associated with a single iTunes Connect account_. One workaround is to create a new Apple ID for each iTunes Connect account you need to be part of, and use Application Loader instead of Xcode to upload the builds. That effectively decouples the building and signing process from the upload of the resulting `.app` file.

After uploading the build, be patient as it can take up to an hour for it to show up under the Builds section of your app version. When it appears, you can link it to the app version and submit your app for review.

[itunes-connect]: https://itunesconnect.apple.com

### Making iPA From Xcode project

Use following steps to make a signed ipa :

* __Select Target:__ Select your SampleProject in your xcode(left-hand side as shown) Then select Product option, in which you could select Archive option. Click it.
* __Select Archive:__ It will take you to Window > Organizer You can see your recent Archive files. Select your archive file and right click > Click Show in finder. You can now get the location of archive file
* __Terminal cd:__ Open Terminal and change your directory to current xcodeArchive folder __cd /Users/macpro/Library/Developer/Xcode/Archives/2015-07-22/__
* __Export Archive:__ Now run this command : __xcodebuild -exportArchive -exportFormat ipa -archivePath "SampleProject.xcarchive" -exportPath "SampleProject_22July.ipa" -exportProvisioningProfile "<#Project Name#> Development Profile"__
* __Get Exported ipa:__ If Export is succeeded then you will have an IPA in /Users/macpro/Library/Developer/Xcode/Archives/2015-07-22/ folder.
OR
[Use Xcode ipa export plugin][Xcode-Plugin-Export-IPA]
[Xcode-Plugin-Export-IPA]: https://github.com/rajeshbeats/Xcode-Plugin-Export-IPA


### Xcode Plugins : 
Following are the plugins that I suggest you to use :
* __Alcatraz__ : Alcatraz is an open-source package manager for Xcode 5+. It lets you discover and install plugins, templates and color schemes without the need for manually cloning or copying files. It installs itself as a part of Xcode and it feels like home. [alcatraz]
[alcatraz]: https://github.com/supermarin/Alcatraz

### New Xcode Plugin support : 
To Give plugin support to any new Xcode version you need to know its application name. Follow these steps and you can enable all plugins on the new Xcode version. Write this command in terminal and tell me.
    * find ~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins -name Info.plist -maxdepth 3 | xargs -I{} defaults write {} DVTPlugInCompatibilityUUIDs -array-add `defaults read /Applications/Xcode.app/Contents/Info DVTPlugInCompatibilityUUID`


### Step by step SWIFT integration for Xcode Objc-based project:
Following the link [StackOverFlow]

* 1: Create new *.swift file (in Xcode) or add it by using Finder
* 2: Add swift bridging empty header if Xcode have not done this before (see 4 below)
* 3: Implement your Swift class by using @ objc attribute: #import UIKit
@ objc class Hello : NSObject {
func sayHello () {
println("Hi there!")
}
}
* 4 :Open Build Settings and check this parameters:
    * Product Module Name : myproject
    * Defines Module : YES
    * Embedded Content Contains Swift : YES
    * Install Objective-C Compatibility Header : YES
    * Objective-C Bridging Header : $(SRCROOT)/Sources/SwiftBridging.h
* 5: Import header (which is auto generated by Xcode) in your *.m file (#import "myproject-Swift.h")
* 6: Clean and rebuild your Xcode project
* 7: Profit!

[StackOverFlow]: http://stackoverflow.com/questions/24206732/cant-use-swift-classes-inside-objective-c

### Change Project name,Class Prefix and Organization Name :

* On the left side expand Targets
* Click on SampleProject in left pane and Edit it.
* Double click on your target and then select build tab in the newly opened window
* on the top right under Identity & Type - edit - Project Name
* on the top right under Project document edit - Organisation and Class Prefix
* Change it and clean rebuild, your new app name should be changed by now.
