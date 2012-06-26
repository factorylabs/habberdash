module Habberdash

  class DataAdapter

    def self.get
      raise 'Abstract method called!: :get. You need to include the appropriate persistence adapter!'
    end

    def self.set(*args)
      raise 'Abstract method called!: :set. You need to include the appropriate persistence adapter!'
    end

  end

end
