class AddColumnToCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :golf_course_name, :string
    add_column :courses, :address, :string
    add_column :courses, :latitude, :integer
    add_column :courses, :longitude, :integer
    add_column :courses, :golf_course_id, :integer
    add_column :courses, :golf_course_image, :string
  end
end
