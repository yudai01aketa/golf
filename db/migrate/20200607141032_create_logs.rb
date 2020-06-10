class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.integer :course_id
      t.text :content

      t.timestamps
    end
    add_index :logs, :course_id
  end
end
