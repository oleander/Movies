require "spec_helper"

describe MovieFilter do
  it "should be possible to add title" do
    MovieFilter.new(title: "Title").title.should eq("Title")
  end
  
  it "should have a year" do
    MovieFilter.new(year: 1988).year.should eq(1988)
  end
  
  it "should have able to convert filter to param" do
    MovieFilter.new(title: "Title", year: 2011).to_param.should eq({year: 2011})
  end
  
  context "#cleaner" do
    it "should not contain 'EXTENDED'" do
      MovieFilter.new(title: "The Town 2010 EXTENDED 720p BRRip XviD AC3-Rx").title.should_not match(/extended/i)
    end
    
    it "should not contain 'XviD'" do
      MovieFilter.new(title: "The Town 2010 EXTENDED 720p BRRip XviD AC3-Rx").title.should_not match(/xvid/i)
    end

    it "should not contain '720p'" do
      MovieFilter.new(title: "The Town 2010 EXTENDED 720p BRRip XviD AC3-Rx").title.should_not match(/720p/i)
    end

    it "should not contain '1080p'" do
      MovieFilter.new(title: "The Town 2010 EXTENDED 1080p BRRip XviD AC3-Rx").title.should_not match(/1080p/i)
    end

    it "should not contain 'BRRip'" do
      MovieFilter.new(title: "The Town 2010 EXTENDED 1080p BRRip XviD AC3-Rx").title.should_not match(/BRRip/i)
    end

    it "should not contain 'CAM'" do
      MovieFilter.new(title: "Paul 2011 CAM XViD-UNDEAD").title.should_not match(/cam/i)
    end

    it "should not contain 'TELESYNC'" do
      MovieFilter.new(title: "Easy A TELESYNC XviD-TWiZTED").title.should_not match(/telesync/i)
    end

    it "should not contain 'TELECINE'" do
      MovieFilter.new(title: "Easy A TELECINE XviD-TWiZTED").title.should_not match(/telecine/i)
    end

    it "should not contain 'RX'" do
      MovieFilter.new(title: "The Company Men 2010 DVDRip XviD-Rx").title.should_not match(/rx/i)
    end

    it "should not contain 'DVDSCR'" do
      MovieFilter.new(title: "Black Swan (2010) DVDSCR Xvid-Nogrp").title.should_not match(/dvdscr/)
    end

    it "should not contain 'Screener'" do
      MovieFilter.new(title: "Devil 2010 Screener Xvid AC3 LKRG").title.should_not match(/screener/i)
    end

    it "should not contain 'HDTV'" do
      MovieFilter.new(title: "Bones S06E19 HDTV XviD-LOL").title.should_not match(/hdtv/i)
    end

    it "should not contain 'DVDRip'" do
      MovieFilter.new(title: "The Company Men 2010 DVDRip XviD-Rx").title.should_not match(/dvdrip/i)
    end

    it "should not contain 'WorkPrint'" do
      MovieFilter.new(title: "Elephant White 2011 WorkPrint XviD AC3-ViSiON").title.should_not match(/workprint/i)
    end

    it "should not contain 'Bluray'" do
      MovieFilter.new(title: "Last Night 2010 Bluray 720p Bluray DTS x264-CHD").title.should_not match(/bluray/i)
    end

    it "should not contain 'Blu-ray'" do
      MovieFilter.new(title: "Big Mommas Like Father Like Son 2011 Blu-ray RE 720 DTS Mysilu").title.should_not match(/blu-ray/i)
    end

    it "should not contain 'MDVDR'" do
      MovieFilter.new(title: "Exposed DVD Tupac Breaking The Oath 2010 NTSC MDVDR-C4DV").title.should_not match(/mdvdr/i)
    end

    it "should not contain 'NTSC'" do
      MovieFilter.new(title: "Exposed DVD Tupac Breaking The Oath 2010 NTSC MDVDR-C4DV").title.should_not match(/ntsc/i)
    end

    it "should not contain 'DVD-R'" do
      MovieFilter.new(title: "Lawrence Of Arabia 1962 iNTERNAL DVDRiP XviD-DVD-R").title.should_not match(/dvd-r/i)
    end

    it "should not contain 'x264-SFM'" do
      MovieFilter.new(title: "Great British Food Revival S01E04 720p HDTV x264-SFM").title.should_not match(/x264-sfm|sfm/i)
    end

    it "should not contain 'UNRATED'" do
      MovieFilter.new(title: "The Other Guys 2010 UNRATED DVDRip XviD AC3-YeFsTe").title.should_not match(/unrated/i)
    end

    it "should not contain 'IMAGiNE'" do
      MovieFilter.new(title: "Hop 2011 TS READNFO XViD - IMAGiNE").title.should_not match(/imagine/i)
    end

    it "should not contain 'SCR'" do
      MovieFilter.new(title: "The Last Exorcism SCR XViD - IMAGiNE").title.should_not match(/scr/i)
    end

    it "should not contain 'AC3-*'" do
      MovieFilter.new(title: "Biutiful 2010 DVDRip XviD AC3-TiMPE").title.should_not match(/ac3-timpe|ac3/i)
    end

    it "should not contain 'LIMITED'" do
      MovieFilter.new(title: "Stone LIMITED BDRip XviD-SAPHiRE").title.should_not match(/limited/i)
    end

    it "should not contain 'SWESUB'" do
      MovieFilter.new(title: "Sex And The City 2 2010 SWESUB DVDRip XviD AC3-Rx").title.should_not match(/swesub/i)
    end

    it "should not contain 'SUB'" do
      MovieFilter.new(title: "Sex And The City 2 2010 SUB DVDRip XviD AC3-Rx").title.should_not match(/sub/i)
    end

    it "should not contain 'NTSC'" do
      MovieFilter.new(title: "Piranha 2010 NTSC DVDR-TWiZTED").title.should_not match(/ntsc/i)
    end

    it "should not contain 'PAL'" do
      MovieFilter.new(title: "Sex And The City 2 2010 SUB PAL DVDRip XviD AC3-Rx").title.should_not match(/pal/i)
    end

    it "should not contain a year" do
      MovieFilter.new(title: "VC Arcade 1942 Wii-LaKiTu").title.should_not match(/1942/)
    end

    it "should not contain dots" do
      MovieFilter.new(title: "Sex.And.The.City.2.2010.SUB.DVDRip.XviD.AC3-Rx").title.should_not match(/\./)
    end

    it "should not contain dash" do
      MovieFilter.new(title: "Sex.And.The.City.2.2010.SUB.DVDRip.XviD.AC3-Rx").title.should_not match(/-/)
    end

    it "should not contain to much whitespace" do
      MovieFilter.new(title: "A     B").title.should eq("A B")
    end

    it "should strip ingoing params" do
      MovieFilter.new(title: " A B ").title.should eq("A B")
    end

    it "should remove TV related data" do
      MovieFilter.new(title: "Bones S06E19 HDTV XviD-LOL").title.should_not match(/s06e19/i)
    end

    it "should not contain 'R5'" do
      MovieFilter.new(title: "Just Go With It R5 LiNE XviD-Rx").title.should_not match(/r5/i)
    end

    it "should not contain 'R6'" do
      MovieFilter.new(title: "Just Go With It R6 LiNE XviD-Rx").title.should_not match(/r6/i)
    end
    
    it "should be able to parse the year" do
      MovieFilter.new(title: "Sex.And.The.City.2.2010.SUB.DVDRip.XviD.AC3-Rx").year.should eq(2010)
      MovieFilter.new(title: "VC Arcade 1942 Wii-LaKiTu").year.should eq(1942)
      MovieFilter.new(title: "VC Arcade 1942 Wii-LaKiTu", year: 1920).year.should eq(1920)
    end
  end
end