require 'spec_helper'

describe FacebookSessionsController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "should be successful" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "should be successful" do
      get 'destroy'
      response.should be_success
    end
  end

  describe "GET 'callback'" do
    it "should be successful" do
      get 'callback'
      response.should be_success
    end
  end

end
