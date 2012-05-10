#!/usr/bin/env rspec

require 'spec_helper'
require 'puppet/face'

describe Puppet::Face[:shell, '0.0.1'] do
  # Lets make sure all the actions are available
  [:interact, :edit, :cp, :rm, :cat, :cd, :pwd, :ls, :quit].each do |action|
    it { should be_action action }
    it { should respond_to action }
  end

  context '#interact' do
    let :action do Puppet::Face[:shell, '0.1.0'].get_action(:interact) end

    it 'should call InteractiveShell#interact when invoked' do
      Puppet::Util::InteractiveShell.any_instance.expects(:interact)
      subject.interact
    end
  end

  context '#edit' do
    let :action do Puppet::Face[:shell, '0.1.0'].get_action(:edit) end

    it 'should use your system editor when invoked' do
      Tempfile.any_instance.stubs(:path).returns('/tmp/path')
      subject.expects(:system).with('vi', '/tmp/path')
      subject.expects(:apply_code)
      context = Puppet::Util::InteractiveShell::ShellContext.new
      context.cwd = ['foo','testuser']
      subject.edit({:context => context})
    end
  end

  context '#cp' do
    let :action do Puppet::Face[:shell, '0.1.0'].get_action(:cp) end
  end

  context '#rm' do
    let :action do Puppet::Face[:shell, '0.1.0'].get_action(:rm) end
  end

  context '#cat' do
    let :action do Puppet::Face[:shell, '0.1.0'].get_action(:cat) end
  end

  context '#cd' do
    let :action do Puppet::Face[:shell, '0.1.0'].get_action(:cd) end
  end

  context '#pwd' do
    let :action do Puppet::Face[:shell, '0.1.0'].get_action(:pwd) end
  end

  context '#ls' do
    let :action do Puppet::Face[:shell, '0.1.0'].get_action(:ls) end
  end

  context '#quit' do
    let :action do Puppet::Face[:shell, '0.1.0'].get_action(:quit) end
  end
end
