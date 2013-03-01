class ChangeNextSellAndFinishToDatetime < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE runs
        ALTER COLUMN next_due TYPE timestamp
        USING to_timestamp(next_due, 'YYYY-MM-DD HH24:MI:SS.MS')
    SQL

    execute <<-SQL
      ALTER TABLE runs
        ALTER COLUMN sell_date TYPE timestamp
        USING to_timestamp(sell_date, 'YYYY-MM-DD HH24:MI:SS.MS')
    SQL

    execute <<-SQL
      ALTER TABLE runs
        ALTER COLUMN finish_date TYPE timestamp
        USING to_timestamp(finish_date, 'YYYY-MM-DD HH24:MI:SS.MS')
    SQL
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
