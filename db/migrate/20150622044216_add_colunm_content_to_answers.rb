class AddColunmContentToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :content, :string
  end
end
