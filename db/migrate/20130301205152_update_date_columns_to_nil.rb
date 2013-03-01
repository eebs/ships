class UpdateDateColumnsToNil < ActiveRecord::Migration
  def up
    execute <<-SQL
      UPDATE runs
        SET next_due = NULL where next_due = '0001-01-01 00:00:00 BC'
    SQL

    execute <<-SQL
      UPDATE runs
        SET sell_date = NULL where sell_date = '0001-01-01 00:00:00 BC'
    SQL

    execute <<-SQL
      UPDATE runs
        SET start_date = NULL where start_date = '0001-01-01 00:00:00 BC'
    SQL

    execute <<-SQL
      UPDATE runs
        SET finish_date = NULL where finish_date = '0001-01-01 00:00:00 BC'
    SQL
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
