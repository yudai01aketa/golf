class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.text :reference
      t.text :memo
      t.integer :recommend
      t.integer :score
      t.text :tips
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :courses, [:user_id, :created_at]
  end
end
