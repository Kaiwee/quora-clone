class CreateAnswers < ActiveRecord::Migration[5.0]
	def change
		create_table :answers do |t|
			t.belongs_to :user, index: true
			t.belongs_to :question, index: true
			t.text :description
			t.timestamps
		end
	end
end
