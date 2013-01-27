require 'spec_helper'

describe "The application's" do

  subject { page }

  let(:base_title) { "Koprulu Sector" }

  describe "Home page" do

    before { visit root_path } 
    
    it { should have_content 'Koprulu Sector' }
    it { should have_content('Home') }
    it { should have_title("#{base_title}") }
    it { should_not have_title(" | Home") }
  end

  describe "Sign In page" do

    before { visit new_character_session_path }
    
    it { should have_title("#{base_title} | Sign In") }
    it { should have_content('Sign In') }
  end

  describe "Sign Up page" do

    before { visit new_character_registration_path }
    
    it { should have_title("#{base_title} | Sign Up") }
    it { should have_content('Sign Up') }
  end
end
