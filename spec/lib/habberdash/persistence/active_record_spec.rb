require 'spec_helper'
require 'habberdash/active_record'

module Habberdash

  module Persistence

    describe ActiveRecord do

      describe '#get' do

        context "when a record exists" do
          it 'fetches the data using ActiveRecord' do
            Habberdash::Persistence::ActiveRecord::Dashboard.create! configuration: "{}"
            subject.get.should == "{}"
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

          context "and when the record exists" do

            let!(:model_instance) { Habberdash::Persistence::ActiveRecord::Dashboard.create! configuration: '{}' }

            it 'updates the existing record' do
              expect {
                subject.update(json)
              }.to change { model_instance.tap(&:reload).configuration }.to(json)
            end

            it 'returns true' do
              subject.update(json).should be_true
            end

          end

          context "and when the record doesn't exist" do

            it 'creates a new record' do
              expect {
                subject.update(json)
              }.to change { Habberdash::Persistence::ActiveRecord::Dashboard.count }.by(1)
            end

            it 'assigns the data correctly' do
              subject.update(json)
              Habberdash::Persistence::ActiveRecord::Dashboard.first.configuration.should == json
            end

            it 'returns true' do
              subject.update(json).should be_true
            end
          end

        end

        context 'when the data could not be saved' do
          before do
            subject.stub(:record).and_return(stub.tap { |s| s.stub(:update_attributes!).and_raise(Exception) })
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
