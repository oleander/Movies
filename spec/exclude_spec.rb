require "spec_helper"

describe "exclude.yaml" do
  it "should not contain 'EXTENDED'" do
    Movies.cleaner("The Town 2010 EXTENDED 720p BRRip XviD AC3-Rx").should_not match(/extended/i)
  end
  
  it "should not contain 'XviD'" do
    Movies.cleaner("The Town 2010 EXTENDED 720p BRRip XviD AC3-Rx").should_not match(/xvid/i)
  end
  
  it "should not contain '720p'" do
    Movies.cleaner("The Town 2010 EXTENDED 720p BRRip XviD AC3-Rx").should_not match(/720p/i)
  end
  
  it "should not contain '1080p'" do
    Movies.cleaner("The Town 2010 EXTENDED 1080p BRRip XviD AC3-Rx").should_not match(/1080p/i)
  end
  
  it "should not contain 'BRRip'" do
    Movies.cleaner("The Town 2010 EXTENDED 1080p BRRip XviD AC3-Rx").should_not match(/BRRip/i)
  end
  
  it "should not contain 'CAM'" do
    Movies.cleaner("Paul 2011 CAM XViD-UNDEAD").should_not match(/cam/i)
  end
  
  it "should not contain 'TELESYNC'" do
    Movies.cleaner("Easy A TELESYNC XviD-TWiZTED").should_not match(/telesync/i)
  end
  
  it "should not contain 'TELECINE'" do
    Movies.cleaner("Easy A TELECINE XviD-TWiZTED").should_not match(/telecine/i)
  end
  
  it "should not contain 'RX'" do
    Movies.cleaner("The Company Men 2010 DVDRip XviD-Rx").should_not match(/rx/i)
  end
  
  it "should not contain 'DVDSCR'" do
    Movies.cleaner("Black Swan (2010) DVDSCR Xvid-Nogrp").should_not match(/dvdscr/)
  end
  
  it "should not contain 'Screener'" do
    Movies.cleaner("Devil 2010 Screener Xvid AC3 LKRG").should_not match(/screener/i)
  end
  
  it "should not contain 'HDTV'" do
    Movies.cleaner("Bones S06E19 HDTV XviD-LOL").should_not match(/hdtv/i)
  end
  
  it "should not contain 'DVDRip'" do
    Movies.cleaner("The Company Men 2010 DVDRip XviD-Rx").should_not match(/dvdrip/i)
  end
  
  it "should not contain 'WorkPrint'" do
    Movies.cleaner("Elephant White 2011 WorkPrint XviD AC3-ViSiON").should_not match(/workprint/i)
  end
  
  it "should not contain 'Bluray'" do
    Movies.cleaner("Last Night 2010 Bluray 720p Bluray DTS x264-CHD").should_not match(/bluray/i)
  end
  
  it "should not contain 'Blu-ray'" do
    Movies.cleaner("Big Mommas Like Father Like Son 2011 Blu-ray RE 720 DTS Mysilu").should_not match(/blu-ray/i)
  end
  
  it "should not contain 'MDVDR'" do
    Movies.cleaner("Exposed DVD Tupac Breaking The Oath 2010 NTSC MDVDR-C4DV").should_not match(/mdvdr/i)
  end
  
  it "should not contain 'NTSC'" do
    Movies.cleaner("Exposed DVD Tupac Breaking The Oath 2010 NTSC MDVDR-C4DV").should_not match(/ntsc/i)
  end
  
  it "should not contain 'DVD-R'" do
    Movies.cleaner("Lawrence Of Arabia 1962 iNTERNAL DVDRiP XviD-DVD-R").should_not match(/dvd-r/i)
  end
  
  it "should not contain 'x264-SFM'" do
    Movies.cleaner("Great British Food Revival S01E04 720p HDTV x264-SFM").should_not match(/x264-sfm|sfm/i)
  end
  
  it "should not contain 'UNRATED'" do
    Movies.cleaner("The Other Guys 2010 UNRATED DVDRip XviD AC3-YeFsTe").should_not match(/unrated/i)
  end
  
  it "should not contain 'IMAGiNE'" do
    Movies.cleaner("Hop 2011 TS READNFO XViD - IMAGiNE").should_not match(/imagine/i)
  end
  
  it "should not contain 'SCR'" do
    Movies.cleaner("The Last Exorcism SCR XViD - IMAGiNE").should_not match(/scr/i)
  end
  
  it "should not contain 'AC3-*'" do
    Movies.cleaner("Biutiful 2010 DVDRip XviD AC3-TiMPE").should_not match(/ac3-timpe|ac3/i)
  end
  
  it "should not contain 'LIMITED'" do
    Movies.cleaner("Stone LIMITED BDRip XviD-SAPHiRE").should_not match(/limited/i)
  end
  
  it "should not contain 'SWESUB'" do
    Movies.cleaner("Sex And The City 2 2010 SWESUB DVDRip XviD AC3-Rx").should_not match(/swesub/i)
  end
  
  it "should not contain 'SUB'" do
    Movies.cleaner("Sex And The City 2 2010 SUB DVDRip XviD AC3-Rx").should_not match(/sub/i)
  end
  
  it "should not contain 'NTSC'" do
    Movies.cleaner("Piranha 2010 NTSC DVDR-TWiZTED").should_not match(/ntsc/i)
  end
  
  it "should not contain 'PAL'" do
    Movies.cleaner("1942 PAL VC Arcade Wii-LaKiTu").should_not match(/pal/i)
  end
  
  it "should not contain a year" do
    Movies.cleaner("1942 PAL VC Arcade Wii-LaKiTu").should_not match(/1942/)
  end
  
  it "should not contain dots" do
    Movies.cleaner("Sex.And.The.City.2.2010.SUB.DVDRip.XviD.AC3-Rx").should_not match(/\./)
  end
  
  it "should not contain dash" do
    Movies.cleaner("Sex.And.The.City.2.2010.SUB.DVDRip.XviD.AC3-Rx").should_not match(/-/)
  end
  
  it "should not contain to much whitespace" do
    Movies.cleaner("A     B").should eq("A B")
  end
  
  it "should strip ingoing params" do
    Movies.cleaner(" A B ").should eq("A B")
  end
end