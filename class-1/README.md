#Week 3 - Class 1
##Homework
* Setup a new project, disable landscape.
* Layout an Image view in the center of the screen using Auto Layout.
* Layout: centerX, centerY + 10, width 0.94, height 0.82
* Use the UIImagePickerController and its delegate to use the camera to set the image view’s image.
* Add a toolbar with "+" button to your navigation controller that brings up ActionController if the device supports Camera and Photo Library, if not, simply present Photo library.
* Start planning out your process, and developing a game plan, for building your Personal Projects for Week 5 project week.
* **Code Challenge:**
	* Write a function that determines how many words there are in a sentence
* **Bonus:**
	* Post action in the action controller that successfully uploads the current ImageView’s image up to your CloudKit backend.

###Readings:
* Apple Documentation:
	* [Core Image Programming Guide](https://developer.apple.com/library/ios/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_intro/ci_intro.html)
	* [CloudKit Refresh](https://developer.apple.com/library/ios/documentation/General/Conceptual/iCloudDesignGuide/DesigningforCloudKit/DesigningforCloudKit.html) - Refresh
	* [UITabBarController](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITabBarController_Class/index.html)
* General Concepts
	* Animating Constraints

##Other Resources
* [Reading Assignments](../../Resources/ra-grading-standard/)
* [Grading Rubrics](../../Resources/)
* [Lecture Resources](lecture/)
* [Lecture Slides](https://www.icloud.com/keynote/000zQVxi0EIEUbwpmakSgmxwA#Week3_Day1)

QUEUES ARE FIFO
STACKS ARE LIFO

#INTERVIEW QUESTION
Swift generics - cache

#INTERVIEW
Talking about NSDates or keeping track of the oldest elements in the data structure.

CLOUDKIT!
creates containers that can hold databases (public or private)

public counts against the app's storage space
private counts against user's storage space

CloudKit provides a way to store data as records in a databsase that users of your app can share

Service for moving data to and from iClou d and sharing between users of your app

Does not replace model objects in your app and should not be used for storing objects locally

Requires a conversion of model objects to records that app to icloud CloudKit

With CloudKit you decide when to move data from your app to icloud to occur and from iCloud to your app

cloudKit provides facilities tokeep you infomredw hen changes occur.

Cloudkit organizes uses containers.  Represents iCloud storage.

Allows to perform tasks against a specific consider using a CKContainer object
Provides support for puhblicand private databases (privaet database is visible to the current user and is stored in that's user iCloud acccounts.  Data written to the public database is visible toa ll users of the app and si stored in iCloud)

CKContainer = a container is like a sandbox, an application can only use the resources inside its container.  You can allow apps to access your container by configuring CloudKit Dashboard.

CKDatabase = lives inside a container, a database where you put your data.  There are two different kinds, private and public.  Private stores sensitive data, public is shared data.

CKRecord = a record is a piece of data inside your database.  Stored as a key-value pair.

CKRecoordZone = records are not stored scattered in databse, they're located in record zones.  Every app ahs a default record zone, and you can have your own custom record zones (only available to private databses)

CKRecordIdentifier = unique label for a record, used for a particular record

CKReferences = relationship between different objects

CKAsset = assets are resources, binary files or bulkk data.  User's pictures should be stored as asset.


--
UIImagePickerController manages customizible, user interfaces for taking pictures na dmovies on supported evices.

UIImagePickerController: manages user interactions and delivers those interactions to a delegate object

AVFoundatoin Framework -one of several frameowkrs that you can use to play and create time.

Workflow...
Check if device has camera.  If your app absolutely relies on a camera, add UIRequiredDevicesCapabilities key in info.plist.  Use the isSourceTypeAvailable class method on UIImagePickerController to check if camera is available.
Instantiate UIImagePickerController
Set desired prpoperties such as sourceType, allowsEditing, delegate, videoQuality, mediaTYpes etc.

Conform to the UIImagePickerControllerDelegate and UINavigationCtonrollerDelegate

Present UIImagePickerController to the user.

imagePickerControllerDidcancel - tells delegate that user cancelled pick operation.

imagePickerController:didFinishPickingMediaWithInfo - tells delegate that the user picked a still img or movie.

UIAlertController - object displays an alert message to the user

to present alert controller, you cann presentViewcOntroller:animated:completion: on the parent view controller.

on iPad you have to tell the alert controller where to present from, sicne its going to be a pop out menu.  You can do this by setting the osourceView and sourceRect on the alert controller's popoverPresentationController

Size Classes!

enables storyboard or xib file to work with all avaiable size classe.s
by default, storyboard supports size classes.

3 types of size classes:  REGULAR, COMPACT, ANY
works together with displayScale and userInterfaceIdiom make up a trait collection.

Everything on ascreen has a trait collection, including the screen itself, and view controllers as well.  Most often you carea bout the view controllers trait collection

The storyboard uses a view controller's trait collection to figure out which alyout should be currently displayed byt eh user.

Size classes allow you to have different constraints and layouts for each congfiguring on the storyboard.

By default, every size class configuartion will pull from the base configurion, which is wAny hAny

If you change your storyboard's configuration, certain changes you make will only apply when your app is running in that specifi cclass.


supported configuration changes:
constraint constants, font and font sizes, turning constraints on and off turning view on and off

This is the "base" size class.

Apple recommends you do your initia layout in this size class.

If you need to specialize it for different deices, you can change the size class after laying it out here and making any changes/additions.

Regular width regular height is for iPads in both landscape and portrait.
Currently, there is no way to tell if the iPad is in landscape or portrati.

Compact:Any - all iPhones except 6+ in landscape.
Any:Compact - all iPhones in landscape
Regular:Compact - iPhone 6+in landscape -SPECIAL GUY MUST BE NICE.

ipad.

developing for ipad is 99% same as iphone

consider ipad layout development before anything else.  it is much easier to design "down" than to design "up" and trying to fill in blank space

consider multiple storyboard files / separate storyboard fir phone and ipad

Identifying ipad

For one of the properties of UITraitCollection is called userInterfaceIdiom.  It's type isUIIuserInterfaceIdiomn, which is an enum:  Unspecified, phone, or pad

There is a class called UIDevice, which gives you a singleton that represents the current device.  That singleton has a property that is also userInterfaceIdiom

1. check device capabilities
2.  actionsheet with selections, camera and library
3. create imagepicker - set delegates
4. listen for selection + set img view to that img

imgviewcontroller\

class ImageViewController: UIViewController, Setup, UIImagePickerControlelrDelegate, UINavigationControllerDelegate

lazy var imagePicker = UIImagePickerController()

inside viewdidload()
{
self.viewDidLoad()
self.setup()
self.setupAppearance()
}

func setupAppearance()
{
  self.imageView.layer.cornerRadius = 3.0
}

fun setup()
{
 self.navigationItem.title = "INSTGRM"
}

func presentActionSheet()
{
let actionSheet = UIAlertController(title: "Source", message "select the source type", preferredStyle: .ActionSheet)
let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) in
  self.presentImagePicker(.Camera)
}
let photosAction = UIAlertAction(title: "photos", style: .Default) { (action) in
  self.presentImagePicker(.PhotoLibrary)
}
let cancelAction = UIAlertAction(title: "cancel", style: .Cancel, handler: nil)
actionSheet.addAction(cameraAction)
actionSheet.addAction(photosAction)
actionSheet.addAction(cancelAction)
self.presentViewController(actionSheet, animated: true, completion: nil)
}

func presentImagePicker(sourceType: UIImagePickerControllerSourceType)
{
self.imagePicker.delegate = self
self.imagePicker.sourceType = sourceType
self.presentViewController(self.imagePicker, animated: true, completion: nil)
}

--create a new swift file called Setup (in app global)

protocol setup
{
func setupAppearance()
func setup()
}
------

inside addbuttonselected
{
if UIImagePickerController.isSourceTypeAvailable(.Camera)
{
self.presentActionSheet()
} else {
self.presentImagePicker(.PhotoLibrary)
}
}

func imagePickerControllerDidcancel(picker: UIImagePickerController)
{
self.dismissViewControllerAnimated(true, completion: nil)
}

func ImagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String: Any Object]?)
{
self.imageView.image = image
self.dismissViewController(true, completion: nil)
}

GO TO STORYBOARD AND CLICK "clip subviews" on the Image View (attributes inspector)
