require "spec_helper"

describe Movies do
  
  context "#find_by_id" do
    it "should raise an error if wrong params is being passed" do
      ["aa123", "tt123", "123", nil, ""].each do |id|
        lambda { 
          Movies.find_by_id(id) 
        }.should raise_error(ArgumentError, "The id is not valid.")
      end
    end
  end
  
  context "#find_by_title" do
    it "should raise an error if wrong params is being passed" do
      [nil, ""].each do |title|
        lambda { 
          Movies.find_by_title(title) 
        }.should raise_error(ArgumentError, "Title can not be blank.")
      end
    end
  end
  
  context "#find_by_release_name" do
    it "should raise an error if wrong params is being passed" do
      [nil, ""].each do |title|
        lambda { 
          Movies.find_by_release_name(title) 
        }.should raise_error(ArgumentError, "Title can not be blank.")
      end
    end
    
    context "true-grit-1969" do
      use_vcr_cassette "true-grit-1969"
      
      it "should be possible to search for a release name containg a year" do
        Movies.find_by_release_name("True.Grit.DVDRip.1969.XviD-AMIABLE").year.should eq(1969) 
      end
      
      after(:each) do
        a_request(:get, "http://www.imdbapi.com/?t=True%20Grit&y=1969").should have_been_made.once
      end
    end
    
    context "true-grit-2010" do
      use_vcr_cassette "true-grit-2010"
      
      it "should be possible to search for a release name containg a year" do
        Movies.find_by_release_name("True.Grit.DVDRip.2010.XviD-AMIABLE").year.should eq(2010) 
      end
      
      after(:each) do
        a_request(:get, "http://www.imdbapi.com/?t=True%20Grit&y=2010").should have_been_made.once
      end
    end
  end
  
  it "should not be possible to pass the callback option" do
    lambda {
      Movies.new("http://www.imdbapi.com/?i=tt1285016", {
        callback: "random"
      })
    }.should raise_error(ArgumentError, "Passing the callback option makes not sense.")
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
      movie.director.should eq("David Fincher")
      movie.href.should eq("http://www.imdb.com/title/tt1285016/")
      
      movie.genres.each do |genre|
        genre.should eq(genre.strip)
      end
      
      movie.actors.each do |actor|
        actor.should eq(actor.strip)
      end
      
      movie.writers.each do |writer|
        writer.should eq(writer.strip)
      end
    end
  end
  
  context "tt0066026" do
    use_vcr_cassette "tt0066026"
    it "should be possible to pass params" do
      Movies.new("http://www.imdbapi.com/?i=tt0066026", {
        y: "1970"
      }).prepare
    end
    
    after(:each) do
      a_request(:get, "http://www.imdbapi.com/?i=tt0066026&y=1970").should have_been_made.once
    end
  end
  
  context "not_found" do
    use_vcr_cassette "not_found"
    it "should be set to not found" do
      Movies.new("http://www.imdbapi.com/?i=ttrandom").prepare.should_not be_found
    end
    
    after(:each) do
      a_request(:get, "http://www.imdbapi.com/?i=ttrandom").should have_been_made.once
    end
  end
  
  context "bug1" do
    use_vcr_cassette "bug1"
    it "should not raise an error when date is invalid" do
      lambda { 
        Movies.new("http://www.imdbapi.com/?t=Consinsual&y=2010").prepare.released.should be_nil 
      }.should_not raise_error
    end
    
    after(:each) do
      a_request(:get, "http://www.imdbapi.com/?t=Consinsual&y=2010").should have_been_made.once
    end
  end
  
  context "bug2" do
    use_vcr_cassette "bug2"
    it "should not raise an error when date is invalid" do
      lambda { 
        Movies.new("http://www.imdbapi.com/?i=tt0988120").prepare.released.should be_nil 
      }.should_not raise_error
    end
    
    after(:each) do
      a_request(:get, "http://www.imdbapi.com/?i=tt0988120").should have_been_made.once
    end
  end
  
  context "bug3" do
    use_vcr_cassette "bug3"
    it "should contain the correct length" do
      Movies.new("http://www.imdbapi.com/?i=tt0058371").prepare.runtime.should eq(118)
    end
    
    after(:each) do
      a_request(:get, "http://www.imdbapi.com/?i=tt0058371").should have_been_made.once
    end
  end
  
  context "N/A" do
    use_vcr_cassette "n-a-tt1570337"
    it "Fields that contains N/A should be nil or zero" do
      movie = Movies.new("http://www.imdbapi.com/?i=tt1570337").prepare
      
      movie.runtime.should eq(0)
      movie.plot.should be_empty
      movie.rated.should be_empty
      
      a_request(:get, "http://www.imdbapi.com/?i=tt1570337").should have_been_made.once
    end
  end
  
  context "tomatoes" do
    use_vcr_cassette "tt0337978"
    
    it "should be possible to fetch tomatoes specific data" do
      movie = Movies.new("http://www.imdbapi.com/?i=tt0337978", {
        tomatoes: "true"
      }).prepare

      movie.tomato.meter.should eq(82)
      movie.tomato.image.should eq("certified")
      movie.tomato.rating.should eq(6.8)
      movie.tomato.reviews.should eq(198)
      movie.tomato.fresh.should eq(162)
      movie.tomato.rotten.should eq(36)
    end
    
    it "should raise an error if trying to fetch tomato data without passing the tomato option" do
      lambda {
        Movies.new("http://www.imdbapi.com/?i=tt0337978").prepare.tomato
      }.should raise_error(ArgumentError, "You have to set 'tomatoes' to true to get this data.")
    end
  end
end