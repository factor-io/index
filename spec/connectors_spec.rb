require 'spec_helper'
require 'yaml'

describe 'Connector' do
  describe 'Index' do
    it 'is loadable as YML' do
      file_contents = File.read('./connectors.yml')
      expect{ YAML.parse(file_contents) }.to_not raise_error
    end

    it 'is formatted correctly' do
      file_contents = File.read('./connectors.yml')
      h = YAML.parse(file_contents).to_ruby

      expect(h).to be_a(Hash)
      expect(h.length).to be > 0

      h.each do |connector_id, connector_config|
        expect(connector_id).to be_a(String)
        expect(connector_config.keys).to include('name')
        expect(connector_config.keys).to include('connectors')
        expect(connector_config.keys).to include('docs')
        expect(connector_config.keys).to include('source')

        expect(connector_config['name']).to be_a(String)
        expect(connector_config['docs']).to be_a(String)
        expect(connector_config['source']).to be_a(String)

        expect(connector_config['connectors']).to be_a(String).or be_a(Hash)

        if connector_config['credentials']
          expect(connector_config['credentials']).to be_a(Hash)
          connector_config['credentials'].each do |credential_id,credential_settings|
            expect(credential_id).to be_a(String)
            expect(credential_settings).to be_a(Hash)
            expect(credential_settings.keys).to include('name')
            expect(credential_settings.keys).to include('description')
            expect(credential_settings['name']).to be_a(String)
            expect(credential_settings['description']).to be_a(String)
          end
        end

      end

    end
  end
end