class ResumesController < ApplicationController
  before_filter :signed_in_user

  # GET /resumes
  # GET /resumes.json
  def index
    @resumes = Resume.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @resumes }
    end
  end

  # GET /resumes/1
  # GET /resumes/1.json
  def show
    @resume = Resume.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resume }
    end
  end

  # GET /resumes/new
  # GET /resumes/new.json
  def new
    @resume = Resume.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resume }
    end
  end

  # GET /resumes/1/edit
  def edit
    @resume = Resume.find(params[:id])
  end

  # POST /resumes
  # POST /resumes.json
  def create
    old_resume = current_user.resume
    old_resume.destroy unless old_resume.nil?
    @resume = Resume.new(params[:resume])
    @resume.user_id = current_user.id
    respond_to do |format|
      if @resume.save
        flash[:success] = "Added Resume"
        format.html { redirect_to current_user}
      else
        flash[:error] = "Failed Adding Resume"
        format.html { render action: "new" }
      end
    end
  end

  # PUT /resumes/1
  # PUT /resumes/1.json
  def update
    @resume = current_user.resume.destroy
    @resume = Resume.find(params[:id])
    @resume.user_id = current_user.id
    respond_to do |format|
      if @resume.update_attributes(params[:resume])
        format.html { redirect_to @resume, notice: 'Resume was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resumes/1
  # DELETE /resumes/1.json
  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy

    respond_to do |format|
      format.html { redirect_to resumes_url }
      format.json { head :no_content }
    end
  end
end
