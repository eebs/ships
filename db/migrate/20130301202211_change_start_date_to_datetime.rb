class ChangeStartDateToDatetime < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE runs
        ALTER COLUMN start_date TYPE timestamp
        USING to_timestamp(start_date, 'YYYY-MM-DD HH24:MI:SS.MS')
    SQL
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
