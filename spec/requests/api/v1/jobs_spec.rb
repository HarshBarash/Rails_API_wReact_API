require 'swagger_helper'

RSpec.describe 'api/v1/jobs_controller', type: :request do

  path '/api/v1/jobs' do
    post 'Create a Job ' do
      tags 'Jobs'
      consumes 'application/json'
      parameter name: :job, in: :body, schema: {
        type: :object,
        properties: {
          company: { type: :string },
          position: { type: :integer },
          description: { type: :string },
        },
        required: ['company', 'position', 'description']
      }

      response '200', 'successful request' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 company: { type: :string, nullable: false }, # preferred syntax
                 position: { type: :integer, nullable: false }, # preferred syntax
                 description: { type: :description, nullable: false } # preferred syntax
               }

        let(:job) { { company: 'Ruby', position: 1, description: 'Backend' } }
        run_test!
      end

      response '422', 'invalid request' do
        schema type: :object,
               properties: {
                 company: { type: :array,
                            items: { type: :string } },
                 description: { type: :array,
                                items: { type: :string } },
                 position: { type: :array,
                             items: { type: :string } }, nullable: false
               }

        let(:job) { { company: 'Compnb', position: "1", description: 'Descrr' } }
        run_test!
      end
    end
  end

  path '/api/v1/jobs/{id}' do
    delete 'Destroy a Job' do
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