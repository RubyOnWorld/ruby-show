class AddGraduateToComment < ActiveRecord::Migration
  def change
    add_column :comments, :graduate, :boolean, default: false
  end
end
