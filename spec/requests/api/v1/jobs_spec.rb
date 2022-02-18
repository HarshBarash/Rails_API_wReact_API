require "swagger_helper"

RSpec.describe "api/v1/jobs_controller", type: :request do

  path "/api/v1/jobs" do
    post "Create a Job " do
      tags "Jobs"
      consumes "application/json"
      parameter name: :job, in: :body, schema: {
        type: :object,
        properties: {
          id: { type: :integer },
          company: { type: :string },
          position: { type: :integer },
          description: { type: :string },
        },
        required: ["id", "company", "position", "description"],
      }
      response '422', 'invalid request' do
        let(:job) { { company: 'Evrone', position: 1, description: 'Intern' } }
        run_test!
      end
    end
  end

  path '/api/v1/jobs/{id}' do
    delete "Destroy a Job" do
      tags 'Jobs'
      produces 'application/json'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'name found' do
        schema type: :object,
               properties: {
                 id: { type: :integer, },
                 company: { type: :string },
                 position: { type: :integer },
                 description: { type: :string }
               },
               required: %w[id company position description]

        let(:id) { Job.create(company: 'foo', position: 1, description: 'bar').id }
        run_test!
      end
    end
  end

  path '/api/v1/jobs/{id}' do
    get 'Retrieves a job' do
      tags 'Jobs'
      produces 'application/json'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'name found' do
        schema type: :object,
               properties: {
                 id: { type: :integer, },
                 company: { type: :string },
                 position: { type: :integer },
                 description: { type: :string }
               },
               required: %w[id company position description]

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