class CreateColleges < ActiveRecord::Migration
  def change
    create_table :colleges do |t|
      t.string :code
      t.string :name
      t.string :administrative
      t.string :address
      t.string :telephone
      t.string :home_page
      t.string :category

      t.timestamps
    end
  end
end
