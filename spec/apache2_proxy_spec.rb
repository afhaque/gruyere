# -*- coding: utf-8 -*-

require 'spec_helper'

describe 'gruyere::apache2_proxy' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.set['gruyere']['path'] = '/opt/gruyere-app'
      node.set['gruyere']['apache2']['server_name']    = 'gruyere-app'
      node.set['gruyere']['apache2']['server_aliases'] = ['gruyere-app2']
    end.converge(described_recipe)
  end

  before do
    stub_command('/usr/sbin/apache2 -t').and_return(true)
  end

  it 'should include apache2 recipes for http proxy' do
    expect(subject).to include_recipe('apache2')
    expect(subject).to include_recipe('apache2::mod_proxy_http')
  end
end
