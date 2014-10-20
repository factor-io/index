require 'spec_helper'
require 'yaml'
require 'json'
require 'restclient'

describe 'Workflows' do
  describe 'Index' do
    it 'is loadable as YML' do
      file_contents = File.read('./workflows.yml')
      expect{ YAML.parse(file_contents) }.to_not raise_error
    end

    it 'is formatted correctly' do
      file_contents = File.read('./workflows.yml')
      h = YAML.parse(file_contents).to_ruby

      expect(h).to be_a(Hash)
      expect(h.length).to be > 0

      h.each do |connector_id, connector_config|
        expect(connector_id).to be_a(String)
        expect(connector_config.keys).to include('name')
        expect(connector_config.keys).to include('config')
        expect(connector_config.keys).to include('description')
        
        expect(connector_config['name']).to be_a(String)
        expect(connector_config['config']).to be_a(String)
        expect(connector_config['description']).to be_a(String)

      end
    end

    it 'includes valid configurations' do
      connector_file_contents = File.read('./connectors.yml')
      connectors = YAML.parse(connector_file_contents).to_ruby
      valid_connectors = connectors.keys


      workflow_file_contents = File.read('./workflows.yml')
      h = YAML.parse(workflow_file_contents).to_ruby

      h.each do |workflow_id,workflow_settings|
        config_url = workflow_settings['config']

        config = {}
        expect do
          raw = RestClient.get(config_url)
          config = JSON.parse(raw)
        end.to_not raise_error

        expect(config).to be_a(Hash)
        expect(config.keys).to include('required-connectors')
        expect(config.keys).to include('template')
        expect(config.keys).to include('variables')

        expect(config['required-connectors']).to be_a(Array)

        config['required-connectors'].each do |connector|
          expect(valid_connectors).to include(connector)
        end

        template_url = config['template']

        expect do
          RestClient.get(template_url)
        end

      end

    end
  end
end