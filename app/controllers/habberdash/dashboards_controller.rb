class Habberdash::DashboardsController < ActionController::Base
  protect_from_forgery

  before_filter :assign_adapter

  respond_to :json
  respond_to :html, only: [ :show ]

  def show
    respond_with @adapter do |format|
      format.html { render nothing: true, layout: 'habberdash' }
    end
  end

  def widgets
    respond_with({ widgets: Habberdash.widget_types })
  end

  def update
    if @adapter.update(request.body.read)
      head :ok
    else
      respond_with @adapter
    end
  end

  private

  def assign_adapter
    @adapter = Habberdash::DataAdapter.new
  end

end
