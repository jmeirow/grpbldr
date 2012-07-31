class CreateAgreements < ActiveRecord::Migration
  def change
    create_table :agreements do |t|
      t.integer :club_id
      t.date :from_date
      t.date :through_date
      t.decimal :club_monthly_rate
      t.decimal :member_monthly_rate

      t.timestamps
    end
  end
end
