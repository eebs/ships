class Job < ActiveRecord::Base
  attr_accessible :jobID, :assemblyLineID, :containerID, :installedItemID, :installedItemLocationID, :installedItemQuantity, :installedItemProductivityLevel, :installedItemMaterialLevel, :installedItemLicensedProductionRunsRemaining, :outputLocationID, :installerID, :runs, :licensedProductionRuns, :installedInSolarSystemID, :containerLocationID, :materialMultiplier, :charMaterialMultiplier, :timeMultiplier, :charTimeMultiplier, :installedItemTypeID, :outputTypeID, :containerTypeID, :installedItemCopy, :completed, :completedSuccessfully, :installedItemFlag, :outputFlag, :activityID, :completedStatus, :installTime, :beginProductionTime, :endProductionTime, :pauseProductionTime

end
