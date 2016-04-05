require 'spec_helper'

describe MicroConfig do
  context 'Version' do
    it 'has a version number' do
      expect(MicroConfig::VERSION).not_to be nil
    end

    it 'has a semantic version number' do
      expect(MicroConfig::VERSION.split('.').size).to be 3
      expect(MicroConfig::VERSION.split('.').all? { |v| v =~ /\d/ }).to be true
    end
  end

  context 'Basic Hash interface' do
    before :all do
      MicroConfig.configure do |config|
        config.key = 'value'
      end
    end

    it 'has [] method' do
      expect(MicroConfig.respond_to?(:[])).to be true
      expect(MicroConfig[:other_key]).to eq(nil)
      expect(MicroConfig[:key]).not_to eq(nil)
    end

    it 'has fetch method' do
      expect(MicroConfig.respond_to?(:fetch)).to be true
      expect(MicroConfig.fetch(:other_key)).to be nil
      expect(MicroConfig.fetch(:key)).not_to be nil
    end

    it 'has fetch method with default value' do
      expect(MicroConfig.fetch(:other_key, 'default')).to eq('default')
      expect(MicroConfig.fetch(:key, 'default')).not_to eq('default')
      expect(MicroConfig.fetch(:key, 'default')).to eq('value')
    end

    it 'has to_h method' do
      expect(MicroConfig.respond_to?(:to_h)).to be true
      expect(MicroConfig.to_h).to eq(key: 'value')
    end
  end

  context 'Symbolize keys' do
    before :each do
      MicroConfig.configure do |config|
        config.key         = 'value'
        config.another_key = 'another value'
      end

      MicroConfig['deep'] = { 'deep_key' => 'deep value' }
    end

    it 'has allways symbolized keys' do
      expect(MicroConfig.to_h.keys.all? { |key| key.is_a?(Symbol) }).to be true
    end
  end

  context 'Magic interface' do
    before :each do
      MicroConfig.configure do |config|
        config.key         = 'value'
        config.another_key = 'another value'
      end
    end

    it 'get keys' do
      expect(MicroConfig.key).to eq('value')
      expect(MicroConfig.another_key).to eq('another value')
    end

    it 'update keys' do
      MicroConfig.key = 'new value'
      expect(MicroConfig.key).to eq('new value')

      MicroConfig.another_key = 'new another value'
      expect(MicroConfig.another_key).to eq('new another value')
    end

    it 'set new keys' do
      expect(MicroConfig.key).to eq('value')
      expect(MicroConfig.another_key).to eq('another value')

      MicroConfig.new_key = 'new key value'
      expect(MicroConfig.new_key).to eq('new key value')
    end

    it 'test keys' do
      expect(MicroConfig.key?).to be true
      expect(MicroConfig.another_key?).to be true
      expect(MicroConfig.unknown_key?).to be false
    end
  end

  context 'Configure interface' do
    before :each do
      MicroConfig.configure('development' => { key: 'value', 'another_key' => 'another value' })
    end

    it 'from another hash' do
      expect(MicroConfig.development[:key]).to eq('value')
      expect(MicroConfig.development[:another_key]).to eq('another value')
    end
  end

  context 'Configure interface with environment' do
    before :each do
      MicroConfig.configure('development' => { key: 'value', 'another_key' => 'another value' }, environment: :development)
    end

    it 'from another hash' do
      expect(MicroConfig.key).to eq('value')
      expect(MicroConfig.another_key).to eq('another value')
    end
  end

  context 'YAML Configure interface' do
    before :each do
      MicroConfig.configure('spec/fixtures/example.yaml')
    end

    it 'from a file' do
      expect(MicroConfig.development[:key]).to eq('development value')
      expect(MicroConfig.development[:another_key]).to eq('development another value')
    end
  end

  context 'YAML Configure interface with environment' do
    before :each do
      MicroConfig.configure('spec/fixtures/example.yaml', environment: :development)
    end

    it 'from a file' do
      expect(MicroConfig.key).to eq('development value')
      expect(MicroConfig.another_key).to eq('development another value')
    end
  end
end
