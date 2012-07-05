require 'spec_helper'

module Habberdash

  describe DataAdapter do

    before do
      subject.stub(:persistence).and_return(stub(get: nil, update: nil, errors: nil))
    end

    shared_examples_for :safe_delegator do

      it "ensures a persistence strategy" do
        subject.should_receive :ensure_persistence_strategy
        subject.send(delegate_method, *args)
      end

      it "delegates #errors to the persistence strategy instance" do
        persistence_mock = mock
        persistence_mock.should_receive(delegate_method)
        subject.stub(:persistence).and_return(persistence_mock)

        subject.send(delegate_method, *args)
      end

    end

    describe "#errors" do

      let(:delegate_method) { :errors }
      let(:args) { [] }

      it_should_behave_like :safe_delegator

    end

    describe "#get" do

      let(:delegate_method) { :get }
      let(:args) { [] }

      it_should_behave_like :safe_delegator

    end

    describe "#update" do

      let(:delegate_method) { :update }
      let(:args) { ["{}"] }

      it_should_behave_like :safe_delegator

    end

    describe "#to_json" do

      it  "wraps the dashboard configuration" do
        subject.stub(:get).and_return('{"foo":"barbifbaz"}')
        subject.to_json.should == '[{"id":"habberdash","readonly":false,"dashboards":{"foo":"barbifbaz"}}]'
      end

    end

    describe "#ensure_persistence_strategy" do

      context "when a persistence is set" do

        it "doesn't raise an error" do
          subject.stub(:persistence).and_return "something"
          expect {
            subject.send(:ensure_persistence_strategy)
          }.not_to raise_error
        end

      end

      context "when a persistence is absent" do

        it "raises an error" do
          subject.stub(:persistence).and_return nil
          expect {
            subject.send(:ensure_persistence_strategy)
          }.to raise_error /no persistence strategy/i
        end

      end

    end

  end

end
