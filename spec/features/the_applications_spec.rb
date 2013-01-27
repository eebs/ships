require 'spec_helper'
include ApplicationHelper

describe "The application's" do

  subject { page }

  let(:base_title) { "Koprulu Sector" }

  shared_examples_for "all pages" do
    it { should have_title full_title(page_title) }
    it { should have_content(heading) }
    it {should have_selector('a', :text => 'Home')}
    it {should have_selector('a', :text => 'Koprulu Sector')}
  end

  describe "Home page" do

    before { visit root_path }
    let(:page_title) {""}
    let(:heading) {"Home"}

    it_should_behave_like "all pages"

    it { should have_selector('h3', :text => 'Needs Attention') }
    it { should have_selector('h3', :text => 'In Progress') }
    it { should have_selector('h3', :text => 'Sold') }
    it { should_not have_title(" | Home") }

    describe "with runs needing attention" do
      it "should have content 'Notes'" do
        pending
      end
    end
  end

  describe "Sign In page" do

    let(:page_title) {"Sign In"}
    let(:heading) {"Sign In"}

    before { visit new_character_session_path }

    it_should_behave_like "all pages"
    
    it { should have_title("#{base_title} | Sign In") }
    it { should have_content('Sign In') }
  end

  describe "Sign Up page" do

    let(:page_title) {"Sign Up"}
    let(:heading) {"Sign Up"}

    before { visit new_character_registration_path }

    it_should_behave_like "all pages"
    
    it { should have_title("#{base_title} | Sign Up") }
    it { should have_content('Sign Up') }
  end
end
