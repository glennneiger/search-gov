class AddOasisImageModule < ActiveRecord::Migration
  def up
    SearchModule.create(tag: 'OASIS', display_name: 'OASIS image')
  end

  def down
    SearchModule.delete_all("tag = 'OASIS'")
  end
end
