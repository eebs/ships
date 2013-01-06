class RunsController < ApplicationController
  # GET /runs
  # GET /runs.json
  def index
    @runs = Run.all

    @runs.sort! do |a, b|
      if a.next_due.empty? && b.next_due.empty?
        0
      elsif a.next_due.empty?
        1
      elsif b.next_due.empty?
        -1 
      else
        a.next_due <=> b.next_due
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @runs }
    end
  end

  # GET /runs/1
  # GET /runs/1.json
  def show
    @run = Run.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @run }
    end
  end

  # GET /runs/new
  # GET /runs/new.json
  def new
    @run = Run.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @run }
    end
  end

  # GET /runs/1/edit
  def edit
    @run = Run.find(params[:id])
  end

  # POST /runs
  # POST /runs.json
  def create
    run_params = params[:run]
    [:next_due, :start_date, :sell_date].each do |date|
      date_param = run_params[date]
      begin
        date_param = Time.zone.parse(date_param)
        if date_param
          run_params[date] = date_param
        end
      rescue ArgumentError => e
      end
    end

    @run = Run.new(run_params)

    respond_to do |format|
      if @run.save
        format.html { redirect_to @run, notice: 'Run was successfully created.' }
        format.json { render json: @run, status: :created, location: @run }
      else
        format.html { render action: "new" }
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /runs/1
  # PUT /runs/1.json
  def update
    @run = Run.find(params[:id])
    run_params = params[:run]
    [:next_due, :start_date, :sell_date].each do |date|
      date_param = run_params[date]
      begin
        date_param = Time.zone.parse(date_param)
        if date_param
          run_params[date] = date_param
        end
      rescue ArgumentError => e
      end
    end

    respond_to do |format|
      if @run.update_attributes(run_params)
        format.html { redirect_to @run, notice: 'Run was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /runs/1
  # DELETE /runs/1.json
  def destroy
    @run = Run.find(params[:id])
    @run.destroy

    respond_to do |format|
      format.html { redirect_to runs_url }
      format.json { head :no_content }
    end
  end
end
