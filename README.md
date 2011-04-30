# Movies

*Movies* is the bridge between IMDb's Unofficial API; [IMDb API](http://imdbapi.com/) and Ruby.

Follow me on [Twitter](http://twitter.com/linusoleander) for more info and updates.

## How to use

### Search for a title

```` ruby
Movies.find_by_title("The dark night")
````

### Find movie based on an IMDb id

```` ruby
Movies.find_by_id("tt0337978")
````

### Find by release name

```` ruby
Movies.find_by_release_name("Heartbreaker.2010.LIMITED.DVDRip.XviD-SUBMERGE")
````

## Params to pass

You can pass arguments if you for example want to search for a particular year.

```` ruby
Movies.find_by_title("The dark night", {
  y: "2010"
})
````

These params are supported.

- **y** (*Any number*) Year of the movie.
- **plot** (*short, full*) Short or extended plot (short default).
- **tomatoes** (*Boolean*) Adds rotten tomatoes data.

## Rottentomatoes

If you pass the `tomatoes` param then this accessors will be available for you.


```` ruby
movie = Movies.find_by_title("Die Hard 4.0", {
  tomatoes: "true"
})

movie.tomato.meter
# => 82
movie.tomato.image
# => "certified"
movie.tomato.rating
# => 6.8
movie.tomato.reviews
# => 198
movie.tomato.fresh
# => 162
movie.tomato.rotten
# => 36
````

## Data to work with

These accessors are available for the object that is being returned from `find_by_*`

- **year** (*Fixnum*) Year of the movie.
- **released** (*Date*) Release date.
- **writers** (*Array < String >*) Writers.
- **actors** (*Array < String>*) Actors.
- **rating** (*Float*) Rating from 1.0 to 10.0.
- **votes** (*Float*) Number of votes.
- **runtime** (*Fixnum*) Run time in seconds.

## How to install

    [sudo] gem install movies

## Requirements

*Movies* is tested in *OS X 10.6.7* using Ruby *1.9.2*.

## License

*Movies* is released under the *MIT license*.