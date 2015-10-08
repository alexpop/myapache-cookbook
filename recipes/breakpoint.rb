#
# Cookbook Name:: myapache-cookbook
# Recipe:: default
#
# Copyright 2014, Great Blogs Ltd
#
# All rights reserved - Do Not Redistribute

ruby_block 'before_breakpoint1' do
  block do
    node.run_state['where'] = 'before'
  end
end

log '*** Before breakpoint1'

breakpoint 'breakpoint1'

log '*** After breakpoint1'

ruby_block 'after_breakpoint1' do
  block do
    node.run_state['where'] = 'after'
  end
end

breakpoint 'second_breakpoint'

# chef-shell -z
# recipe_mode
# run_chef
# Chef::Log.level = :info
# puts node.run_state['where']
# chef_run.step
# chef_run.step
# puts node.run_state['where']
