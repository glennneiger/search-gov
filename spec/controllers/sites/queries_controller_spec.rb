require 'spec_helper'

describe Sites::QueriesController do
  fixtures :users, :affiliates, :memberships
  before { activate_authlogic }
  let(:rtu_queries_request) { mock(RtuQueriesRequest) }

  describe '#new' do
    it_should_behave_like 'restricted to approved user', :get, :new

    context 'when logged in as affiliate' do
      include_context 'approved user logged in to a site'

      before do
        RtuQueriesRequest.should_receive(:new).with(site: site, filter_bots: current_user.sees_filtered_totals?).and_return rtu_queries_request
        rtu_queries_request.should_receive(:save)
        get :new, id: site.id
      end

      it { should assign_to(:queries_request).with(rtu_queries_request) }
    end
  end

  describe '#create' do
    it_should_behave_like 'restricted to approved user', :get, :create

    context 'when logged in as affiliate' do
      include_context 'approved user logged in to a site'

      before do
        params = { "start_date"=>"05/01/2014", "end_date"=>"05/26/2014", "query"=>"foo", "site"=> site, "filter_bots"=> current_user.sees_filtered_totals?}
        RtuQueriesRequest.should_receive(:new).with(params).and_return rtu_queries_request
        rtu_queries_request.should_receive(:save)
        post :create, id: site.id, rtu_queries_request: { start_date: "05/01/2014", end_date: "05/26/2014", query: "foo" }
      end

      it { should assign_to(:queries_request).with(rtu_queries_request) }
      it { should render_template(:new) }
    end
  end

end