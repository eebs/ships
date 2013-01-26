require 'spec_helper'

describe "The application's" do

  let(:base_title) { "Koprulu Sector" }

  describe "Home page" do
    
    it "should have the content 'Koprulu Sector'" do
      visit '/'
      page.should have_content('Koprulu Sector')
    end

    it "should have the content 'Home'" do
      visit '/'
      page.should have_content('Home')
    end

    it "should have the right title" do
      visit '/'
      page.should have_title("#{base_title}")
    end
  end

  describe "Sign In page" do
    
    it "should have the right title" do
      visit '/characters/sign_in'
      page.should have_title("#{base_title} | Sign In")
    end

    it "should have the content 'Sign In'" do
      visit '/characters/sign_in'
      page.should have_content('Sign In')
    end
  end
end
