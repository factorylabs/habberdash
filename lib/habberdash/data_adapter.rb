module Habberdash

  class DataAdapter

    def get
      %Q{[{"id":"foo","title":"foo","color":"#DDD","backgroundColor":"#FFF","image":"standard-light.jpg","centerImage":true,"widgets":[{"type":"twitter","title":"widget1","endpoint":"/something/"},{"type":"twitter","title":"widget2","endpoint":"/something/"}]},{"id":"bar","title":"bar","color":"#333","backgroundColor":"#111","image":"standard-dark.jpg","centerImage":true,"widgets":[]}]}
      #raise 'Abstract method called!: :get. You need to include the appropriate persistence adapter!'
    end

    def set(*args)
      raise 'Abstract method called!: :set. You need to include the appropriate persistence adapter!'
    end

    def to_json(options = {})
      %Q{[{"id": "habberdash", "readonly": false, "dashboards": #{get}}]}
    end
  end

end
