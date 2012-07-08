class SysConfigurationsController < ApplicationController


  layout 'sysadmins' 

  # GET /sys_configurations
  # GET /sys_configurations.json
  def index
    @sys_configurations = SysConfiguration.where("1=1").order("config_key")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sys_configurations }
    end
  end

  # GET /sys_configurations/1
  # GET /sys_configurations/1.json
  def show
            
    @sys_configuration = SysConfiguration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sys_configuration }
    end
  end

  # GET /sys_configurations/new
  # GET /sys_configurations/new.json
  def new
    @sys_configuration = SysConfiguration.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sys_configuration }
    end
  end

  # GET /sys_configurations/1/edit
  def edit
    @sys_configuration = SysConfiguration.find(params[:id])
  end

  # POST /sys_configurations
  # POST /sys_configurations.json
  def create
    @sys_configuration = SysConfiguration.new(params[:sys_configuration])

    respond_to do |format|
      if @sys_configuration.save
        format.html { redirect_to @sys_configuration, notice: 'Sys configuration was successfully created.' }
        format.json { render json: @sys_configuration, status: :created, location: @sys_configuration }
      else
        format.html { render action: "new" }
        format.json { render json: @sys_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sys_configurations/1
  # PUT /sys_configurations/1.json
  def update
    @sys_configuration = SysConfiguration.find(params[:id])

    respond_to do |format|
      if @sys_configuration.update_attributes(params[:sys_configuration])
        format.html { redirect_to @sys_configuration, notice: 'Sys configuration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sys_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sys_configurations/1
  # DELETE /sys_configurations/1.json
  def destroy
    @sys_configuration = SysConfiguration.find(params[:id])
    @sys_configuration.destroy

    respond_to do |format|
      format.html { redirect_to sys_configurations_url }
      format.json { head :no_content }
    end
  end
end
