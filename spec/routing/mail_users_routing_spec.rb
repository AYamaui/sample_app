require "spec_helper"

describe MailUsersController do
  describe "routing" do

    it "routes to #index" do
      get("/mail_users").should route_to("mail_users#index")
    end

    it "routes to #new" do
      get("/mail_users/new").should route_to("mail_users#new")
    end

    it "routes to #show" do
      get("/mail_users/1").should route_to("mail_users#show", :id => "1")
    end

    it "routes to #edit" do
      get("/mail_users/1/edit").should route_to("mail_users#edit", :id => "1")
    end

    it "routes to #create" do
      post("/mail_users").should route_to("mail_users#create")
    end

    it "routes to #update" do
      put("/mail_users/1").should route_to("mail_users#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/mail_users/1").should route_to("mail_users#destroy", :id => "1")
    end

  end
end
