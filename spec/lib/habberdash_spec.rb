require 'spec_helper'

describe Habberdash do

  describe '#widget_types' do

    it 'is an array of widget types' do
      Habberdash.widget_types = [:hibberdish]
      Habberdash.widget_types.should == [:hibberdish]
    end

  end

end
