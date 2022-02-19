require "swagger_helper"

RSpec.describe "api/v1/jobs_controller", type: :request do

  path "/api/v1/jobs" do
    post "Create a Job " do
      tags "Jobs"
      consumes "application/json"
      parameter name: :job, in: :body, schema: {
        type: :object,
        properties: {
          company: { type: :string },
          position: { type: :integer },
          description: { type: :string },
        },
        required: ["company", "position", "description"],
      }

      response '200', 'successful request' do
        produces 'application/json'
        parameter name: :job, :in => :path, :type => :string
        let(:job) { Job.create(company: 'foo', position: 1, description: 'bar') }
        schema type: :object,
               properties: {
                 company: { type: :string },
                 position: { type: :integer },
                 description: { type: :string }
               },
               required: %w[ company position description]

        let(:job) { { company: "Ruby", position: 1, description: "Backend" } }

        run_test!

      end

      response '422', 'invalid request' do
        produces 'application/json'
        parameter name: :job, :in => :path, :type => :string
        schema type: :object,
               properties: {
                 company: { type: :integer },
                 position: { type: :integer },
                 description: { type: :integer }
               },
               required: %w[ company position description]

        let(:job) { { company: 1, position: 1, description: 1 } }
        run_test!
      end
    end
  end

  path '/api/v1/jobs/{id}' do
    delete "Destroy a Job" do
      tags 'Jobs'
      produces 'application/json'
      parameter name: :job, :in => :path, :type => :string

      response '200', 'name found' do
        schema type: :object,
               properties: {
                 company: { type: :string },
                 position: { type: :integer },
                 description: { type: :string }
               },
               required: %w[ company position description]

        let(:job) { create(:job) }
        run_test!
      end
    end
  end

  path '/api/v1/jobs/{id}' do
    get 'Retrieves a job' do
      tags 'Jobs'
      produces 'application/json'
      parameter name: :job, :in => :path, :type => :string
      response '200', 'name found' do
        schema type: :object,
               properties: {
                 company: { type: :string },
                 position: { type: :integer },
                 description: { type: :string }
               },
               required: %w[ company position description]

        let(:id) { Job.create(company: 'foo', position: 1, description: 'bar').id }
        run_test!
      end

      response '404', 'Job not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end