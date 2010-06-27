require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::AffiliatesController do
  fixtures :users, :affiliates

  context "when logged in as a non-affiliate admin user" do
    before do
      activate_authlogic
      UserSession.create(:email=> users("non_affiliate_admin").email, :password => "admin")
    end

    it "should redirect to the usasearch home page" do
      get :index
      response.should redirect_to(home_page_url)
    end
  end

  context "when not logged in" do
    it "should redirect to the login page" do
      get :index
      response.should redirect_to(new_user_session_path)
    end
  end
  
  describe "#analytics" do
    context "when logged in as an affiliate admin" do
      before do
        activate_authlogic
        UserSession.create(:email => users("affiliate_admin").email, :password => "admin")
        @affiliate = affiliates("basic_affiliate")
      end
    
      it "should redirect to the affiliate analytics page for the affiliate id passed" do
        get :analytics, :id => @affiliate.id
        response.should redirect_to affiliate_analytics_home_page_path(:id => @affiliate.id)
      end
    end
  end
end
