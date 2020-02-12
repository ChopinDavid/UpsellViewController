<p align="center">
<img src="https://raw.githubusercontent.com/ChopinDavid/UpsellViewController/master/upsellLogo.png" alt="Icon"/>
</p>

[![GitHub license](https://img.shields.io/cocoapods/l/UpsellViewController.svg)](https://github.com/ChopinDavid/UpsellViewController/blob/master/LICENSE)
[![Pod version](https://img.shields.io/cocoapods/v/UpsellViewController.svg?style=flat)](https://github.com/ChopinDavid/UpsellViewController)

One of the most important parts of building a free app is converting dedicated users into paying customers. Most successful apps dedicate time to making a great pitch to the user, all in one view.
<p align="center">
<img src="https://raw.githubusercontent.com/ChopinDavid/UpsellViewController/master/hinge.png" width=50% alt="Hinge"/><img src="https://raw.githubusercontent.com/ChopinDavid/UpsellViewController/master/picsArt.png" width=50% alt="Icon"/>
</p>

**UpsellViewController** is a library that lets you create customizable alert view controllers that pitch products to your app's users. The library is inspired in part by [PMAlertController](https://github.com/pmusolino/PMAlertController).

<p align="center">
<img src="https://raw.githubusercontent.com/ChopinDavid/UpsellViewController/master/screenshot1.png" width=50% alt="Icon"/><img src="https://raw.githubusercontent.com/ChopinDavid/UpsellViewController/master/screenshot2.png" width=50% alt="Icon"/>
</p>

## Features
- [x] Custom title and subtitle

- [x] Custom paginated scroll view with unlimited pages
- [x] Autoscroll capable
- [x] Adaptive action buttons
- [x] Cocoapods
## Requirements

- iOS 11.0+

- Xcode 10+
- Knowledge of creating views via XIB files

  

## CocoaPods
[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:
```bash
$ gem install cocoapods
```
To integrate `UpsellViewController` into your Xcode project using CocoaPods, specify it in your `Podfile`:
```ruby
target 'MyApp' do
pod 'UpsellViewController', '~> 1.0.2'
end
```
Then, run the following command:
```bash
$ pod install
```
## Usage
UpsellViewController is extremely easy to use, but requires knowledge of creating custom `UIView`s with XIB files. As a developer, it is your job to create a custom `UIView` as an XIB. This custom `UIView` displays the content you want your user to be able to scroll through. Ideally, this view will display all of the features included in a premium subscription to your application.

It is important to space out the contents of this custom `UIView` based on how many pages you want to paginate in your `UpsellViewController`. For example, if you are initializing your `UpsellViewController` with **five pages**, you will want each focal point of your custom `UIView` to only take up **20%** of your custom view. Similarly, a **three-paged** `UpsellViewController` should make sure each focal point of your custom `UIView` only takes up **33.33%** of your custom view, and so  on.

#### Show an UpsellViewController with 5 pages of content
```swift
//This code works with Swift 5

//Get all views in the custom view's xib file
let allViewsInXibArray = Bundle.main.loadNibNamed("PromoView1", owner: self, options: nil)

//Grab the view in the xib's array of items
let promoView = allViewsInXibArray!.first as! UIView

//Initialize your UpsellViewController
let upsellVC = UpsellViewController(title: "Refer a Friend and You'll Both Get Bandmate Plus, for Life!", subtitle: "With Plus, you can...", promoView: promoView, numberOfPages: 5)

//Create some actions for your user to interact with the UpsellViewController
let cancel = UpsellAction(title: "Cancel", style: .cancel)
upsellVC.addAction(learnMore)

let doSomeAction = UpsellAction(title: "Do Something", style: .default) {
    print("Did something")
}
upsellVC.addAction(referAFriend)

//Present our UpsellViewController
present(upsellVC, animated: false, completion: nil)
```

#### Customize your UpsellViewController

```swift
//Initialize your UpsellViewController
let upsellVC = UpsellViewController(title: "Some title", subtitle: "Some subtitle", promoView: promoView, numberOfPages: 3)

//Toggle autoscroll...
upsellVC.isAutoScrollEnabled = false
upsellVC.isAutoScrollEnabled = true

//...or change the speed at which your UpsellViewController autoscrolls
//upsellVC.autoScrollBuffer is the amount of time, in seconds, the UpsellViewController will wait between autoscrolling the content view. Lower = faster
upsellVC.autoScrollBuffer = 5

//upsellVC.autoScrollSpeed is the amount of time, in seconds, the UpsellViewController takes to animate the autoscrolling of the content view. Lower = faster
upsellVC.autoScrollSpeed = 0.3

//Change the page control tint colors
upsellVC.pageIndicatorTintColor = .blue
upsellVC.currentPageIndicatorTintColor = .green

//Then go ahead and add your actions for your user to interact with your UpsellViewController
```

## Contributing

- If you **need help** or you'd like to **ask a general question**, open an issue.

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Acknowledgements
**Made by  [David Chopin](https://github.com/ChopinDavid)**.

**_Check out my:_**

#### 💼 [Linkedin](https://www.linkedin.com/in/david-chopin-505689121/)

#### 💻 [StackOverflow](https://stackoverflow.com/users/8023531/david-chopin?tab=profile)

**I will be graduating college in May 2020 and am currently looking for a job! :)**

## MIT License
UpsellViewController is available under the MIT license. See the LICENSE file for more info.
