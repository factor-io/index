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
      
    end
  end
end