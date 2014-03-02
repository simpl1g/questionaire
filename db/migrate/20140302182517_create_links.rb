class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.belongs_to :user, index: true
      t.boolean :private
      t.text :description

      t.timestamps
    end
  end
end
