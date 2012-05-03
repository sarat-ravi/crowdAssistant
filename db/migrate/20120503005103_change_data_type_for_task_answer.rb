class ChangeDataTypeForTaskAnswer < ActiveRecord::Migration
  def self.up
  	change_table :tasks do |t|
  		t.change :answer, :text
  	end
  end

  def self.down
  	change_table :tasks do |t|
  		t.change :answer, :string
  	end
  end
end
