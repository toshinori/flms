require 'spec_helper'

describe GamesController do

  describe "GET 'edit_result'" do
    it "returns http success" do
      get 'edit_result'
      response.should be_success
    end
  end

  describe "GET 'show_result'" do
    it "returns http success" do
      get 'show_result'
      response.should be_success
    end
  end

  describe "GET 'update_result'" do
    it "returns http success" do
      get 'update_result'
      response.should be_success
    end
  end

end
