require 'spec_helper'

describe "The application's" do

  describe "Home page" do
    
    it "should have the content 'Koprulu Sector'" do
      visit '/'
      page.should have_content('Koprulu Sector')
    end

    it "should have the content 'Home'" do
      visit '/'
      page.should have_content('Home')
    end
  end
end
