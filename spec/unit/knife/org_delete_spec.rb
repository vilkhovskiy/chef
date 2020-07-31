#
# Author:: Snehal Dwivedi (<sdwivedi@msystechnologies.com>)
# Copyright:: Copyright 2014-2016 Chef Software, Inc.
# License:: Apache License, Version 2.0
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

require "spec_helper"
require "chef/org"

describe Chef::Knife::OrgDelete do

  let(:rest) { double("Chef::ServerAPI") }

  before :each do
    @knife = Chef::Knife::OrgDelete.new
    @org_name = "foobar"
    @org_full_name = "secretsauce"
    @knife.name_args << @org_name
    @org = double("Chef::Org")
  end

  it "should confirm that you want to delete and then delete organizations" do
    expect(Chef::ServerAPI).to receive(:new).with(Chef::Config[:chef_server_root]).and_return(rest)
    expect(@knife.ui).to receive(:confirm).with("Do you want to delete the organization #{@org_name}")
    expect(rest).to receive(:delete).with("organizations/#{@org_name}")
    expect(@knife.ui).to receive(:output)
    @knife.run
  end
end
