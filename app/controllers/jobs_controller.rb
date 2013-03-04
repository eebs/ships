class JobsController < ApplicationController
  before_filter :authenticate_character!
  load_and_authorize_resource
  
  # GET /jobs
  # GET /jobs.json
  def index
    # AR doesn't quote order by clauses. Postgres downcases all non-quoted 
    # values. In addition, values must be in double quotes. The following
    # is a bit of a hack.
    @jobs = Job.where(:completed => '0').order('"endProductionTime"')
    @next_update = JobApi.new.next_update

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.json
  def new
    flash[:alert] = "Manually creating jobs has been disabled"
    return redirect_to :root
    @job = Job.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    flash[:alert] = "Manually editing jobs has been disabled"
    return redirect_to :root
    @job = Job.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.json
  def create
    flash[:alert] = "Manually creating jobs has been disabled"
    return redirect_to :root
    @job = Job.new(params[:job])

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render json: @job, status: :created, location: @job }
      else
        format.html { render action: "new" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.json
  def update
    flash[:alert] = "Manually updating jobs has been disabled"
    return redirect_to :root
    @job = Job.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    flash[:alert] = "Manually deleting jobs has been disabled"
    return redirect_to :root
    @job = Job.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url }
      format.json { head :no_content }
    end
  end
end
