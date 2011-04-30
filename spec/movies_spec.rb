require "spec_helper"

describe "subject" do
  it "should raise an error if wrong params is being passed" do
    ["aa123", "tt123", "123", nil, ""].each do |id|
      lambda { 
        Movies.find_by_id(id) 
      }.should raise_error(ArgumentError, "The id is not valid")
    end
  end
  
  context "tt1285016" do
    use_vcr_cassette "tt1285016"
  
    it "should contain the right content" do
           
      movie = Movies.new("http://www.imdbapi.com/?i=tt1285016").prepare
      movie.year.should eq(2010)
      movie.rated.should eq("PG-13")
      movie.released.should eq(Date.parse("1 Oct 2010"))
      movie.should have(3).genres
      movie.genres.should include("Biography")
      movie.should have(2).writers
      movie.writers.should include("Aaron Sorkin")
      movie.should have(4).actors
      movie.actors.should include("Andrew Garfield")
      movie.plot.should_not be_empty
      movie.poster.should match(URI.regexp)
      movie.runtime.should eq(120)
      movie.rating.should eq(8.1)
      movie.votes.should eq(109863)
      movie.id.should eq("tt1285016")
      movie.href.should eq("http://www.imdb.com/title/tt1285016/")
    end
  end
  
  context "tt0066026" do
    use_vcr_cassette "tt0066026"
   it "should be possible to pass params" do
      Movies.new("http://www.imdbapi.com/?i=tt0066026", {
        y: "1970"
      }).prepare

      a_request(:get, "http://www.imdbapi.com/?i=tt0066026&y=1970").should have_been_made.once
    end
  end
end