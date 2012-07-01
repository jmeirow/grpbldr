class LeaderHistoriesController < ApplicationController
  # GET /leader_histories
  # GET /leader_histories.json
  def index
    @leader_histories = LeaderHistory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @leader_histories }
    end
  end

  # GET /leader_histories/1
  # GET /leader_histories/1.json
  def show
    @leader_history = LeaderHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @leader_history }
    end
  end

  # GET /leader_histories/new
  # GET /leader_histories/new.json
  def new
    @leader_history = LeaderHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @leader_history }
    end
  end

  # GET /leader_histories/1/edit
  def edit
    @leader_history = LeaderHistory.find(params[:id])
  end

  # POST /leader_histories
  # POST /leader_histories.json
  def create
    @leader_history = LeaderHistory.new(params[:leader_history])

    respond_to do |format|
      if @leader_history.save
        format.html { redirect_to @leader_history, notice: 'Leader history was successfully created.' }
        format.json { render json: @leader_history, status: :created, location: @leader_history }
      else
        format.html { render action: "new" }
        format.json { render json: @leader_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /leader_histories/1
  # PUT /leader_histories/1.json
  def update
    @leader_history = LeaderHistory.find(params[:id])

    respond_to do |format|
      if @leader_history.update_attributes(params[:leader_history])
        format.html { redirect_to @leader_history, notice: 'Leader history was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @leader_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leader_histories/1
  # DELETE /leader_histories/1.json
  def destroy
    @leader_history = LeaderHistory.find(params[:id])
    @leader_history.destroy

    respond_to do |format|
      format.html { redirect_to leader_histories_url }
      format.json { head :no_content }
    end
  end
end
