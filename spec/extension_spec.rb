require 'everyday-plugins'
include EverydayPlugins
require_relative '../lib/mvr/plugin'
require_relative '../lib/mvr/plugin/extension.plugin'

describe ExtensionPlugin do
  it 'removes and adds back the extension' do
    Plugins.set_var :options, { exclude_extension: true }
    Plugins.set_var :ext, nil
    name  = 'filename.txt'
    edit1 = Plugins.get :name_change_before, name
    edit1.should eq 'filename'
    ext = Plugins.get_var :ext
    ext.should eq '.txt'
    edit2 = Plugins.get :name_change_after, edit1
    edit2.should eq name
  end

  it 'does not mess up with no extension' do
    Plugins.set_var :options, { exclude_extension: true }
    Plugins.set_var :ext, nil
    name  = 'filename'
    edit1 = Plugins.get :name_change_before, name
    edit1.should eq name
    ext = Plugins.get_var :ext
    ext.should be_nil
    edit2 = Plugins.get :name_change_after, edit1
    edit2.should eq name
  end

  it 'handles multiple extensions fine' do
    Plugins.set_var :options, { exclude_extension: true }
    Plugins.set_var :ext, nil
    name  = 'filename.a.b.c.txt'
    edit1 = Plugins.get :name_change_before, name
    edit1.should eq 'filename.a.b.c'
    ext = Plugins.get_var :ext
    ext.should eq '.txt'
    edit2 = Plugins.get :name_change_after, edit1
    edit2.should eq name
  end

  it 'does not mess up with no filename' do
    Plugins.set_var :options, { exclude_extension: true }
    Plugins.set_var :ext, nil
    name  = '.filename'
    edit1 = Plugins.get :name_change_before, name
    edit1.should eq name
    ext = Plugins.get_var :ext
    ext.should be_nil
    edit2 = Plugins.get :name_change_after, edit1
    edit2.should eq name
  end

  it 'does not remove and add back extension if option disabled' do
    Plugins.set_var :options, { exclude_extension: false }
    Plugins.set_var :ext, nil
    name  = 'filename.txt'
    edit1 = Plugins.get :name_change_before, name
    edit1.should eq name
    edit2 = Plugins.get :name_change_after, edit1
    edit2.should eq name
  end
end