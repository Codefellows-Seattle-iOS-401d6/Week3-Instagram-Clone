#Week 3 - Class 3
##Homework
* Add a UITabBarController to your project.
* Create a GalleryViewController with a collection view designed to show a bunch of photos.
* Add a collection view to the interface.
* Build a simple collection view layout.
* Build a call to CloudKit to get all images uploaded yesterday and populate the collection view.
* Use property observers to set collection view cell's imageViews, when downloaded (lazy load images)
* Refactor your Filters class to be a singleton.
	* This new singleton should also on have 1 instance of the context that we will reuse for each filter.
* **Code Challenge:**
	* Write a function that computes the list of the first 100 Fibonacci numbers.
* **Bonus:**
	* Fetch records individually instead of all at once.

###Reading:
* Apple Documentation:
	* [UIGestureRecognizer](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIGestureRecognizer_Class/index.html#//apple_ref/occ/cl/UIGestureRecognizer)
	* UIPinchGestureRecogizer
	* [Photos Framework](https://developer.apple.com/library/ios/documentation/Photos/Reference/Photos_Framework/index.html)
	* [SLComposeController](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Reference/SLComposeViewController_Class/index.html)

##Other Resources
* [Reading Assignments](../../Resources/ra-grading-standard/)
* [Grading Rubrics](../../Resources/)
* [Lecture Resources](lecture/)
* [Lecture Slides](https://www.icloud.com/keynote/000m4LBd0MejMf8HT5gD5aU3g#Week3_Day3)

#INTERVIEW QUESTION:  find a loop in a linked list

# is a binary tree a binary search tree, or how can you tell

Stacks.
First in last out.

STACK IS A GREAT DATA STRUCTURE FOR DO AND UNDO... RESETs.

MAGIC numbersCOLLECTIONVIEWS
DRY
Event Patterns/Delegation/Custom Protocols

MAGIC NUMBERS:
Greatily improves readability: if you run across a magic number in someone else's code it is very hard to figure out why that number was chosen, and what it's being used for.

Easier to maintain: oftein times numbers you use will need to be used in multiple place, you can just use a variable.

UICollection view

A collection view is a way to present an ordered set of data items using flexibld layout.

Collection views provide the same general function as table views except a collection view is able t support more than single column layout.

Most commonly used to present items in grid like arrangement.  Items to collection views are as rows to table views.

Creating custom layouts allow the possibiliy of many different layouts (grid, circular layouts, stacks, dynamic, etc)

Emplly the same recycle program that table views do

Cells - presents the content of a single items
Supplementary views - headers and footers

Decoration views - wholly owned by the layout object and not tied to any data fro your data source
Collection view imposes no styles on your reusable views, they are the most part blank cnavases for you to wokr on (unlike table views)

Workflow
You provide the data (datasource pattern)
Provide layout object (placement information)
Collection view merges the two pieces together to achieve the final appearance

DRY

DRY is another principle oaiming to reduce repetitive code.
Simplifying maintenece.

It has counterpart, called rule of 3, which provides a nice balance.  rule of 3 is a refactoring rule of thumb that states a piece of code can be copied once, but once that code is used 3 times, its time to extrat a new procedure instead of having so many duplicates.

REetroactively applying DRY and the rule of 3 also takes time, so you should keep these things in mind as you write code, not after you write the code.

	\Notable Patterns
	Delegation: one to one, great for when you want tp communicate information back to another object (think about passing info back from a view controller)

	Callback blocks/closures - one to one, great for keeping related code close together (inline)

	Notification center - one to many, great because you can emit a notification and many listeners can receeit it

	Key Value Observing - one to many, if  a property is Key Value Coding compliant, any object can observe it for changes.

	Delegation methods should begin with the name of object doing the delegating - application, control, controller, etc

	The name is thehen followed by a verb of what just occurred - willSelet, didSelect, opeNFile, etc

	Once your protocol is setup, you need to add a delegate property to whatever clas sis going to use the delegate

	protocol ImageDownloaderDelegate: class{
		func ImageDownloaderDidFinsih(success: Bool)
	}

	class ImageViewController: ImageDownloaderDelegate
	{
		weak var delegate: ImageDownloaderDelegate?

		func ImageDownloaderDidFinish(success: Bool)
		{
			print(success)
		}
	}

	Retain cycle

	A delegate property should always be weak.
	Delegator should never ownt he delegate, because if it does, it might end up cauing

	BY DEFAULT: POINTERS (ARC doesn't deal with value types, it ONLY works with reference types)
	BY DEFAULT POINTERS ARE STRONG REFERENCES

	Class works

	var name: NSString = "Michael"
	var name? = name

	#INTERVIEW IS ARC COMPILE TIME OR RUN TIME?

	ARC IS COMPILE TIME.

	if 2 objects are pointing at each other, you msut talk about retain cycle.

	delegate, datasource, and layer view need to be set in collection view.

	CONVERT FILTERS TO BE SINGLETON class

	static let shared = Filters()

	private let context: CIContext

	private init()
	{

	}


Filters -> singleton

func GET(completion: (posts: [Posts]?) -> ())
{
	let query = CKQuery(recordType: "Post", predicate: NSPredicate(value: true))
self.database.performQuery(query, inZoneWithID: nil) { (records, erorr) in
if let records = records {

	var posts = [Post]()
	for record in records {
		guard let asset = record["image"] as? CKAsset else { return }
		guard let path = asset.fileURL.path else { return }
		guard let image = UIImage(contentsOfFile: path)

		post.append(Post(image: image))
	}
	NSOperationQueue(.mainQueue().addOperationWithBlock)
	}}
}
2.
WRITE GET POST FUNCTION on API

3. Add navigation to gallery.

BAR BUTTON itemSystem Item: Bookmarks

create new viewControllers
Add view
create segue to new view called GalleryViewController

NEW COCOA TOUCH swift

ADD COLLECTION VIEW TO viewControllers

Setting up constraints

each cell should have its own class

create

let columns: int

COLLECTIONVIEW CELL

SELECT IMAGE view
Highlight Collcetion View CELL

wowoow

Create custom-- ImageColelctionViewCell subclass.

select mainstoryboard

func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
{
	let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.id(), forIndexPath: index) as! ImageCollectionViewCell
	return cell
}
}

collectionviewDataSource
ConnectionViewOutlet

Any IBoutlet needs to have an outlet to the storyboard.
