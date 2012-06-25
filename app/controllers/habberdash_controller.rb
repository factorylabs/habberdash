class HabberdashController < ActionController::Base
  protect_from_forgery

  def dashboard
    render nothing: true, layout: 'habberdash'
  end

end
