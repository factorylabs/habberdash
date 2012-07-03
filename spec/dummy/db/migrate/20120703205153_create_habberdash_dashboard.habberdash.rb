# This migration comes from habberdash (originally 20120703204302)
class CreateHabberdashDashboard < ActiveRecord::Migration
  def change
    create_table :habberdash_dashboard do |t|
      t.text :configuration
      t.timestamps
    end
  end
end
