# ICNDbKit

Swift library for fetching data from the [Internet Chuck Norris Database](http://www.icndb.com/api/).

## Requirements
* iOS 8.0
* Xcode 8.2

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