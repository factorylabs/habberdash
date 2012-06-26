require 'spec_helper'

describe Habberdash::DashboardsController do

  describe 'a GET to :widgets' do

    before { Habberdash.widget_types = [:foo] }
    after  { Habberdash.widget_types = [] }

    it 'returns widget names known to Habberdash' do
      get '/widgets.json'
      last_response.body.should == { widgets: [:foo] }.to_json
    end

  end

  describe 'configuration resource methods' do

    let!(:adapter) { Habberdash::DataAdapter.new }

    before { Habberdash::DataAdapter.stub(:new).and_return(adapter) }

    describe 'a PUT to :update' do

      let(:json)     { '{"foo":"bar"}' }

      before { adapter.stub(errors: nil, update: true) }

      it "saves the data through the data adapter" do
        adapter.should_receive(:update).with(json)
        put '/configuration.json', json, "CONTENT_TYPE" => "application/json"
      end

      context "when the data is saved successfully" do

        before do
          put '/configuration.json', json, "CONTENT_TYPE" => "application/json"
        end

        specify { last_response.status.should == 200 }

      end

      context "when the data has not been saved" do

        let(:errors) { "errors" }

        before do
          adapter.stub(update: false, errors: errors)
          put '/configuration.json', json, "CONTENT_TYPE" => "application/json"
        end

        specify { last_response.status.should == 422 }

        it 'renders errors as json' do
          last_response.body.should == '{"errors":"errors"}'
        end

      end

    end

    describe 'a GET to :show' do

      let(:dashboard_json) { '{"data":"stuff"}' }

      it "returns the dashboard data" do
        adapter.stub(:to_json).and_return(dashboard_json)
        get '/configuration.json'
        last_response.body.should == dashboard_json
      end

    end

  end

end
