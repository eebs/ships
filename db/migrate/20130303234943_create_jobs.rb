class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|

      t.string :jobID
      t.string :assemblyLineID
      t.string :containerID
      t.string :installedItemID
      t.string :installedItemLocationID
      t.string :installedItemQuantity
      t.string :installedItemProductivityLevel
      t.string :installedItemMaterialLevel
      t.string :installedItemLicensedProductionRunsRemaining
      t.string :outputLocationID
      t.string :installerID
      t.string :runs
      t.string :licensedProductionRuns
      t.string :installedInSolarSystemID
      t.string :containerLocationID
      t.string :materialMultiplier
      t.string :charMaterialMultiplier
      t.string :timeMultiplier
      t.string :charTimeMultiplier
      t.string :installedItemTypeID
      t.string :outputTypeID
      t.string :containerTypeID
      t.string :installedItemCopy
      t.string :completed
      t.string :completedSuccessfully
      t.string :installedItemFlag
      t.string :outputFlag
      t.string :activityID
      t.string :completedStatus
      t.string :installTime
      t.string :beginProductionTime
      t.string :endProductionTime
      t.string :pauseProductionTime

      t.timestamps
    end

    add_index :jobs, :jobID, :unique => true
  end
end
