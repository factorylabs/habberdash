require 'spec_helper'
require 'habberdash/redis'

module Habberdash

  module Persistence

    describe Redis do

      before { Persistence::Redis.client.del(Persistence::Redis::REDIS_KEY) }

      it "has a redis client to work with" do
        Persistence::Redis.client.should be_instance_of ::Redis
      end

      describe '#get' do

        context "when a record exists" do

          it 'fetches the data using redis' do
            redis_mock = mock
            redis_mock.should_receive(:get).with(Persistence::Redis::REDIS_KEY)

            Persistence::Redis.stub(:client).and_return(redis_mock)
            subject.get
          end

        end

        context "when a record doesn't exist" do

          it 'returns nil' do
            subject.get.should == nil
          end

        end

      end

      describe '#update' do

        let(:json) { '{"foo":"bar"}' }

        context 'when the data is saved successfully' do

          it 'updates the dashboard configuration' do
            expect {
              subject.update(json)
            }.to change { subject.get }.to(json)
          end

          it 'returns true' do
            subject.update(json).should be_true
          end

        end

        context 'when the data could not be saved' do
          before do
            redis_stub = stub
            redis_stub.stub(:set).and_raise(Exception)
            Persistence::Redis.stub(:client).and_return(redis_stub)
          end

          it 'returns false' do
            subject.update(json).should be_false
          end

          it 'adds an error to the errors collection' do
            expect {
              subject.update(json)
            }.to change { subject.errors.count }.by(1)
          end

        end

      end

    end

  end

end
