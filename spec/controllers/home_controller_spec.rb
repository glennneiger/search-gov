require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HomeController do

  it "should assign a search object" do
    get :index
    assigns[:search].should_not be_nil
  end

  context "when no locale is specified" do
    it "should use default locale" do
      get :index
      I18n.locale.should == I18n.default_locale
    end
  end

  context "when valid locale is specified" do
    it "should assign a locale" do
      get :index, :locale=> "es"
      I18n.locale.should == :es
    end
  end

  context "when locale is specified" do
    context "that is invalid" do
      before do
        get :index, :locale=> "hp:webinspect..file*test"
      end
      it "should set locale to :en" do
        I18n.locale.should == :en
      end
    end

    context "that is malicious" do
      before do
        get :index, :locale=> "\0"
      end
      it "should set locale to :en" do
        I18n.locale.should == :en
      end
    end

    context "that is erroneous" do
      before do
        get :index, :locale=> "fr"
      end
      it "should set locale to :en" do
        I18n.locale.should == :en
      end
    end
  end

end
