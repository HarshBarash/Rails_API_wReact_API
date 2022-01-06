module Api::V1
  class JobsController < ApplicationController

    def index
      @jobs = Job.all
      render json: @jobs
    end

    def show
      @jobs = Job.find(params[:id])
      render json: @jobs
    end

    def create
      @jobs = Job.new(job_params)

      if @jobs.save
        render json: @jobs, status: :created
      else
        render json: @jobs.errors, status: :unprocessable_entity
      end
    end

    def update
      @jobs = Job.find(params[:id])
      if @jobs.update(job_params)
        render json: @jobs
      else
        render json: @jobs.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @jobs = Job.find(params[:id])
      @jobs.destroy
    end

    ###############################################################
    private

    def job_params
      params
        .require(:job)
        .permit(:company, :position, :description)
    end

  end
end