#Week 3 - Class 2
##Homework
* Create an extension on UIImage that resizes an image to specified (passed in) parameters.
* Create Filters class and implement at least 3 filters.
* To find out what filters are available, use this:
	`for name in CIFilter.filterNamesInCategories(nil){            
	print(name)
	}`
* Create the ability to reset applied filter to the default image.
* Implement Save image to the Library (edited image).
* Implement upload of an image to CloudKit.
* **Code Challenge:**
* Write a function that returns all the odd elements of an array
* **Bonus:**
* Add two extra filters
* Build model object to house image and metadata to create CloudKit object when the user hits publish.
* In your coding challenge playground, take a guess at who in class is a Snapchat POWER USER!(1 bonus point).

###Reading Assignment:
* [UICollectionView](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UICollectionView_class/index.html)
* [UICollectionViewFlowLayout](https://developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UICollectionViewFlowLayout_class/)

##Other Resources
* [Reading Assignments](../../Resources/ra-grading-standard/)
* [Grading Rubrics](../../Resources/)
* [Lecture Resources](lecture/)
* [Lecture Slides](https://www.icloud.com/keynote/000itEApKaUNewFvchS4Z7Vcw#Week3_Day2)

Private, public, and shared database (CKShare) is a subclass of CKRecord.  You can share otherwise private information and communication can happen.


#INTERVIEW QUESTION
given a sentence, provide all the words. (count) with double spaces.

-know big O analysis.
-why would you use a linked list over an array.

Core Image!

Image processing and analysis tech designed to provide near real-time processing for still and video images.

Core Image hides the details of low-level graphic processing.  you don't need to know the details of OpenGL/ ES to leverage the power of the GPU (for speed, we want GPU.)

Can use either the GPU or Conceptual
Access to built in image processing filter (90 on iOS)

feature detection capability (Snapchat)

Support for automatic image enhacenmetn (auto enhence)

The ability to chain multiple filters together to create custom effects

Support for creating custom filters that run on a GPU
Feedback-based iage processing capabilities

CIImage

immutable object that represents the receipt for imageCan represent a file from disk or the output of a CIFilterCan be initialized from Raw bytes, NSData, CGImage, PixelBuffers, etc

//declaring a CIImage

let imiage = CIImage(contentsOfURL: url)
let image = CIImage(image: UIImage())

CIFilter
Mutable object that represents a filter (not thread safe)
WHAT IS THREADSAFE?
==don' thave to worry about race conditions(two or more objects trying to change the same object in memory at the same time).
Produces an output image based on the input

Each filter supports a different set of inputKey's you can modify to alter the effect of the filter

You can query for all the inputs of a filter with the .inputKeys property on an instance of CIFilter

//setting values for keys

let image = ..
var filter = CIFilter(name: "CISepiaTone")
filter?.setValue(image, forKey: kCIInputImageKey) //input key
filter?.setValue(0.8, forKey: "inputIntensity") //setting a specific filter

CIContext
An object through which Core Image draws results
Can be based on CPU or GPU
Always use GPU because it yields a better performance over CPU. All iOS 8 supporting devices support GPU context.

let options = [kCIContextOutputColorSpace: NSNull()] //key value pairing, passed into the context....

let eAGLContext = EAGLContext(API: .OpenGLES2) //uses and access the GPU.

let context = CIContext(EAGLContext: eAGLContext, options: options)

UIImage becomes a CIImage, CIImage is passed into a filter and a CIFilter will pass out a CIImage, which will pass out a UIImage


CloudKit POST!

func POST(post: Post, completion: APICompletion)
{
	do {
		if let record = try Post.recordWith(post) {
			self.database.saveRecord(record, completionHandler: { (record, error) -> Void in
				if error == nil && record != nil {
					completion(success: true)
					}
					})
		}
	} catch let error {print(error)}
}

Animated Constraints!

Constraints created programmatically or in interface builder can be easily Animated
Get a pointer to the constraint you want to Animated
Change teh constant of the constraint to a new values
In your animation block, call layoutIfNeeded() on the view containing the constraint.

let constraint = ..

constraint.constant = 20

UIView.animatedWithDuration(0.4) {
	self.view.layoutIfNeeded()
}

Tab bar controller is a container view controller.

Tab bar is a container for other view controllers.

Container view controller that you use to divide your app into two or more distinct modes of operations

The tab bar has multiple tabs, each representing a child view controller (most you can have 5 tabs display, the rest will be hidden)

Selecting a tab causes the tab container to display the associated view controller's view on screen.

Can be instantiated inc ode or storyboard

Every UIViewController has a property called tabBarController, which points to the bar controller it is in IF it is actually in the tab bar controller (just like the navigationController property).  If it is not in the tabBarController property)

UITabBarController has a property call viewControllers which is an array of the view controllers it is managing.  They are ordered from left to right.

By default, the labe l for each "item" in the tab bar is the title of the view controller it contains.

UITabBar Item-every view controller has a UITabBarItem proeprty called tabBarItem.  This item dictates how the view controller is representened in the tab bar.

If you want to provide custom images as the tab icons, use the UITabBarItem initializer that takes in a title, image and selectedImage.

Custom icons for the tba bar have to be alpha channels only.  Don't include words in the image.  Provide two verions: one for unselected and one for selected(selected version should be a "filled in" version of the unselected)

CloudKit Post

add an extension to UIImage, to scale it.
Working with CKAssets

Create with model extension to convert the post into the CKRecord.
Create filters class with the helper methods that will have 3 little access for each filter.

We'll have model, we'll ahve extension, we'll have filters, and then we will build our API to built to CloudKit

class Post {
	let image : UIImage
	init(image: UIImage)
	{
		self.image = image
	}
}

import UIKit instead of Foundation

extension UIImage {

	class func resize(image: UIImage, size: CGSize) -> UIImage
	{
		UIGraphicsBeginImageContext(size)
		image.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))

let resizedImage = UIGraphicsGetImageFromCurrentImageContext()

UIGraphicsEndImageContext()

return resizedImage
	}
}
