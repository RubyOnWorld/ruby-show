# frozen_string_literal: true

class AddApprovedToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :approved, :boolean, default: false, null: false
  end
end
