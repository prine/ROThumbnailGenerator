# ROThumbnailGenerator
Create thumbnail images by a given URL (supports at the moment PDF, Images and Videos).

## Installation

ROThumbnailGenerator is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ROThumbnailGenerator"
```

## How to use
The ROThumbnail class is responsible for creating thumbnails by a given URL. The method `getThumbnail(url:NSURL)` does internally check the supported file types and uses the corresponding implementation of ROThumbnailGenerator.

At the moment there are the following file types supported:
 * PDF (.pdf)
 * IMAGE (.png, .jpg, .jpeg)
 * VIDEO (.mov, .m4a)

You can retrieve the thumbnail of a given URL like that:
```swift
var thumbnailImage = ROThumbnail.sharedInstance.getThumbnail(fileUrl)
```

If you want to add a new implementation of the ROThumbnailGenerator you can do this by implementing the ROThumbnailGenerator class and define your supported file extensions you are going to handle with this implementation.

Here is a small example:

```swift
class ImageThumbnailGenerator : ROThumbnailGenerator {

    var supportedExtensions:Array<String> = ["png", "jpg", "jpeg"]

    func getThumbnail(url:NSURL) -> UIImage {
        return UIImage(data: NSData(contentsOfURL: url)!) ?? UIImage(named: "Piktogramm_IMAGE")!
    }
}
```

You can add your implementation with the following call:
```swift
ROThumbnail.sharedInstance.addThumbnailGenerator(yourThumbnailGenerator)
```


## License

```
The MIT License (MIT)

Copyright (c) 2015 Robin Oster (http://prine.ch)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```

## Author

Robin Oster, robin.oster@rascor.com
