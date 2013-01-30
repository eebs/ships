require 'spec_helper'

describe Character do
  before {
    @user = Character.new(
      name: "Example User",
      characterid: '11111111',
      password: 'secret',
      password_confirmation: 'secret'
    )
  }

  subject { @user }

  it { should respond_to :name }
  it { should respond_to :characterid }
  it { should respond_to :password }
  it { should respond_to :admin }
  it { should respond_to :notify }
  it { should respond_to :unread_notifications }

  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = "" }
    it { should_not be_valid }
  end

  describe "when name is already taken" do
    before do
      user_with_same_name = @user.dup
      user_with_same_name.name = @user.name.upcase
      user_with_same_name.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should be_valid }
  end
end