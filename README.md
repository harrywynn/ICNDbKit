# ICNDbKit

Swift library for fetching data from the [Internet Chuck Norris Database](http://www.icndb.com/api/).

## Requirements
* iOS 8.0
* Xcode 8.2

## Installation

### CocoaPods

1. Add a pod entry for ICNDbKit to your Podfile `pod 'ICNDbKit', '~> 1.0.0'`
2. Install the pod(s) by running `pod install`
3. Include ICNDbKit wherever you need it with `import ICNDbKit `

### Carthage

1. Add ICNDbKit to your Cartfile, `github "harrywynn/ICNDbKit" ~> 1.0.0`
2. Run `carthage update`
3. Follow the rest of the [standard Carthage installation instructions](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) to add ICNDbKit to your project
4. Include ICNDbKit wherever you need it with `import ICNDbKit `

### Source files

Add `ICNDbKit.swift` to your project directly.

## Usage

```
// fetch a random joke
ICNDbKit.fetchRandomJoke(completion: { (jokes) in

})
```


```
// fetch a specific joke
ICNDbKit.fetchJoke(id: 15, completion: { (jokes) in

})
```

```
// fetch the number of availabe jokes
ICNDbKit.fetchJokeCount(completion: { (count) in

})
```


```
// fetch the available categories 
ICNDbKit.fetchJokeCategories(completion: { (categories) in

})
```