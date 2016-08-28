# DERelativeDateFormatter
Custom formatter for converting an NSDate to a String (See below).

## Example
Included is an example app that utilizes a table view to displays dates with a custom header.

To use in your project, all that is needed is to add DERelativeDateFormatter.swift then:

```
let dateFormatter = DERelativeDateFormatter()
let date = NSDate()

let dateString = dateFormatter.stringFromDate(date)
```

## Screenshot
![alt text](https://github.com/deisterhold/DERelativeDateFormatter/raw/master/Screenshot.png "Screenshot")
