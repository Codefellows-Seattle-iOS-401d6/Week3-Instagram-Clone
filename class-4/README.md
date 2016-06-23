##Week 3 - Class 4
##Homework
* Implement collection view on a new FiltersPreviewViewController to display all available filters already pre-applied to the image.
* Show / Hide FiltersPreviewViewController in place of ActionSheetController.
* Selecting a filtered image applies that filter to the current Image in the primary image view.
* Add a pinch gesture recognizer to the GalleryViewController, which decreases/increases the item size upon pinching (use the scale property of the recognizer). Change layout interactively.
* Create a custom protocol and delegate in order to communicate back image selection from GalleryViewController to the HomeViewControllerfor editing.

###Reading Assignment:
* Cracking the coding Interview/Programming Interviews Exposed:
  * Stacks & Queues


##Other Resources
* [Reading Assignments](../../Resources/ra-grading-standard/)
* [Grading Rubrics](../../Resources/)
* [Lecture Resources](lecture/)
* [Lecture Slides](https://www.icloud.com/keynote/000Jb3jQrKlkMaoFiZ5Nrlk8g#Week3_Day4)

lookup building a cache.

GESTURE RECOGNIZER!
CollectionView Layout!
Photos frameowkr!
Social sharing!

Gesture recognizer convert low level event handling code into higher level actions.

Can be added programmatically or interface buildiner.

Gesture recognizers are attached to views.

The target is usually the view's view controller.

Guestures if detected on the view notify target by means of sending a message (selector)

UIKit has a good amount of predefined gesture recognizer that you should always use when possible.
UIKit supports custom gestures recognizers.

Gestures are either discrete or continuous.

Discrete - taps.  you tap, it fires.

Continuous - pinch, it happens over a longer period fo time because of velocity., pan too.

Gesture Recognizers transition frmo one state to another in a predefined way.

Gesture recognizers can move to one of several possible next states based on whether they meet certain conditions: possible, failed, recognized, began, changed, cancelled

Create and conifugre a gesture recognizer isntance.  Etiehr a code or in storyboard.  If its storyboard, this includes step 2

Attach the gesture recognizer to a view

inside the handleTapGesture IBAction outlet.

@IBAction func handleTapGesture(sender: UITapGestureRecognizer)
{
  print("tap happened")
}

CHECK USER INTERACTION ENABLED on IMAGE view

Select Tap Gesture Recognizer and you can update the number of taps required (double tap)

control drag from image view to view controller.

in viewControllers

call self.setupGestureRecognizer() in viewDidLoad
func setupGestureRecognizer()
{
  let tapGesure = UITapGestureRecognizer(target: self, action:"handleTapGestureRecognizer" )
  self.imageView.addGestureRecognizer(tapGesture)
}

func handleTapGestureRecognizer(tap: UITapGestureRecognizer)
{
  if tap.state == .Began {

  }

  if tap.state == ....
  print("Tap in code happened")
}

COLELECTIONVIEW FLOWLAYOUT

Computes layout attributes as needed for: cells, supplementary views, decoratoin views.

Every collectionv iew usesa  alayout object to determine when each view it manages hould be placed and behave on screen.

Apple provides a concrete subclass of UICOlectionViewLayout called UICollectionViewFlowLayout that gives us a line based layout that can use right out of the box.

UICOllectionViewLayout is more customiazable.. You can create 100% custom layout.
HCircle.  Half a circle.  WHATEVER UICOLLECTIONVIEWLAYOUT WILL LET YOU DO THIS.

FLOWLAYOUT will give you lots and lots of squares.

Flow layout is a line-oriented layout.  The layout object places cells on a linear path.

Item Size, Line Spacing, INter Cell spacing, scrolling direction, header and footer size, section inset.

Supports customization of each property either globally with its single property or througha  delegate.
