class AddGradeTypeToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :grade_type, :string, default: "up"
  end
end
