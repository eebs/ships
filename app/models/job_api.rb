class JobApi < EveApi

  def initialize
    @params = [
      :jobID,
      :assemblyLineID,
      :containerID,
      :installedItemID,
      :installedItemLocationID,
      :installedItemQuantity,
      :installedItemProductivityLevel,
      :installedItemMaterialLevel,
      :installedItemLicensedProductionRunsRemaining,
      :outputLocationID,
      :installerID,
      :runs,
      :licensedProductionRuns,
      :installedInSolarSystemID,
      :containerLocationID,
      :materialMultiplier,
      :charMaterialMultiplier,
      :timeMultiplier,
      :charTimeMultiplier,
      :installedItemTypeID,
      :outputTypeID,
      :containerTypeID,
      :installedItemCopy,
      :completed,
      :completedSuccessfully,
      :installedItemFlag,
      :outputFlag,
      :activityID,
      :completedStatus,
      :installTime,
      :beginProductionTime,
      :endProductionTime,
      :pauseProductionTime,
    ]
  end

  def fetch_jobs
    api.scope = 'corp'
    api.IndustryJobs.jobs
  end

  def update_jobs
    jobs = fetch_jobs
    jobs.each do |j|
      job = Job.find_or_initialize_by_jobID(j.jobID)
      job.update_attributes get_attributes(j)
      job.save
    end
  end

  def get_attributes(job)
    attributes = {}
    @params.each do |p|
      attributes[p] = job.send(p)
    end
    attributes
  end

end