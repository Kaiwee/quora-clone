class CreateQuestions < ActiveRecord::Migration[5.0]
	def change
		create_table :questions do |t|
			t.belongs_to :user, index: true
			t.string :title
			t.text :description
			t.timestamps
		end
	end
end