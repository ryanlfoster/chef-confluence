#
# Cookbook Name:: confluence
# Recipe:: configuration
#
# Copyright 2013, Brian Flad
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# settings = Confluence.settings(node)

template "#{node['confluence']['install_path']}/confluence/WEB-INF/classes/confluence-init.properties" do
  source 'confluence-init.properties.erb'
  owner node['confluence']['user']
  mode '0644'
  notifies :restart, 'service[confluence]', :delayed
end

template "#{node['confluence']['install_path']}/confluence/WEB-INF/classes/crowd.properties" do
  source "crowd.properties.erb"
  owner  node['confluence']['user']
  mode   "0644"
  notifies :restart, "service[confluence]", :delayed
  only_if { node['confluence']['crowd']['integration'] }
end

template "#{node['confluence']['install_path']}/confluence/WEB-INF/classes/seraph-config.xml" do
  source 'seraph-config.xml.erb'
  owner node['confluence']['user']
  mode '0644'
  notifies :restart, 'service[confluence]', :delayed
end

# template "#{node['confluence']['home_path']}/confluence.cfg.xml" do
#  source "confluence.cfg.xml.erb"
#  owner  node['confluence']['user']
#  mode   "0644"
#  variables :database => settings['database']
#  notifies :restart, "service[confluence]", :delayed
# end
