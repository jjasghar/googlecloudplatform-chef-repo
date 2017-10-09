# Copyright 2017 Google Inc.
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

# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    AUTO GENERATED CODE     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by chef-codegen and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

require 'spec_helper'

# TODO(alexstephen): Reformat tests to use nested describe blocks
# TODO(alexstephen): Add title == name tests
# Test Matrix:
#
# +--------------------------------------------------------+
# | Action  | Exists | Changes | Success | Result          |
# +--------------------------------------------------------+
# | create  | Y      | Y       | Y       | Edit            |
# | create  | Y      | Y       | N       | Fail            |
# | create  | Y      | N       | Y       | Fetch (no-op)   |
# | create  | Y      | N       | N       | Fail            |
# | create  | N      | Y       | Y       | Create          |
# | create  | N      | Y       | N       | Fail            |
# +--------------------------------------------------------+
# | delete  | Y      | Y       | Y       | Delete          |
# | delete  | Y      | Y       | N       | Fail            |
# | delete  | N      | Y       | Y       | Fail (no delete)|
# | delete  | N      | Y       | N       | Fail            |
# +--------------------------------------------------------+
# TODO(alexstephen): Add tests for manage
# TODO(alexstephen): Add tests for modify
context 'gcompute_zone' do
  context 'resource exists' do
    # Ensure ignore: resource exists, no change
    context 'no changes == no action' do
      # Ensure ignore: resource exists, no change, no name, pass
      context 'title == name (pass)' do
        # TODO(alexstephen): Implement new test format.
      end

      # Ensure ignore: resource exists, no change, has name, pass
      context 'title != name (pass)' do
        # TODO(alexstephen): Implement new test format.
      end
    end

    # Ensure ignore: resource exists, changes
    context 'changes == action' do
      # Ensure ignore: resource exists, changes, no name, fail
      context 'title == name (fail)' do
        # TODO(alexstephen): Implement new test format.
        subject { -> { raise '[placeholder] This should fail.' } }
        it { is_expected.to raise_error(RuntimeError, /placeholder/) }
      end

      # Ensure ignore: resource exists, changes, has name, fail
      context 'title != name (fail)' do
        # TODO(alexstephen): Implement new test format.
        subject { -> { raise '[placeholder] This should fail.' } }
        it { is_expected.to raise_error(RuntimeError, /placeholder/) }
      end
    end
  end

  context 'resource missing' do
    # Ensure ignore: resource missing, ignore, no name, fail
    context 'title == name (fail)' do
      # TODO(alexstephen): Implement new test format.
      subject { -> { raise '[placeholder] This should fail.' } }
      it { is_expected.to raise_error(RuntimeError, /placeholder/) }
    end

    # Ensure ignore: resource missing, ignore, has name, fail
    context 'title != name (fail)' do
      # TODO(alexstephen): Implement new test format.
      subject { -> { raise '[placeholder] This should fail.' } }
      it { is_expected.to raise_error(RuntimeError, /placeholder/) }
    end
  end

  def expand_variables(template, data, extra_data = {})
    Google::GCOMPUTE::Zone
      .action_class.expand_variables(template, data, extra_data)
  end

  def expect_network_get_success(id, data = {})
    id_data = data.fetch(:name, '').include?('title') ? 'title' : 'name'
    body = load_network_result("success#{id}~#{id_data}.yaml").to_json

    request = double('request')
    allow(request).to receive(:send).and_return(http_success(body))

    debug_network "!! GET #{self_link(uri_data(id).merge(data))}"
    expect(Google::Compute::Network::Get).to receive(:new)
      .with(self_link(uri_data(id).merge(data)),
            instance_of(Google::FakeAuthorization)) do |args|
      debug_network ">> GET #{args}"
      request
    end
  end

  def http_success(body)
    response = Net::HTTPOK.new(1.0, 200, 'OK')
    response.body = body
    response.instance_variable_set(:@read, true)
    response
  end

  def expect_network_get_failed(id, data = {})
    request = double('request')
    allow(request).to receive(:send).and_return(http_failed_object_missing)

    debug_network "!! #{self_link(uri_data(id).merge(data))}"
    expect(Google::Compute::Network::Get).to receive(:new)
      .with(self_link(uri_data(id).merge(data)),
            instance_of(Google::FakeAuthorization)) do |args|
      debug_network ">> GET [failed] #{args}"
      request
    end
  end

  def http_failed_object_missing
    Net::HTTPNotFound.new(1.0, 404, 'Not Found')
  end

  def load_network_result(file)
    results = File.join(File.dirname(__FILE__), 'data', 'network',
                        'gcompute_zone', file)
    debug("Loading result file: #{results}")
    raise "Network result data file #{results}" unless File.exist?(results)
    data = YAML.safe_load(File.read(results))
    raise "Invalid network results #{results}" unless data.class <= Hash
    data
  end

  def expect_network_get_success_region(id, data = {})
    id_data = data.fetch(:name, '').include?('title') ? 'title' : 'name'
    body = load_network_result_region("success#{id}~" \
                                                           "#{id_data}.yaml")
           .to_json
    uri = uri_data_region(id).merge(data)

    request = double('request')
    allow(request).to receive(:send).and_return(http_success(body))

    debug_network "!! GET #{uri}"
    expect(Google::Compute::Network::Get).to receive(:new)
      .with(self_link_region(uri),
            instance_of(Google::FakeAuthorization)) do |args|
      debug_network ">> GET #{args}"
      request
    end
  end

  def load_network_result_region(file)
    results = File.join(File.dirname(__FILE__), 'data', 'network',
                        'gcompute_region', file)
    raise "Network result data file #{results}" unless File.exist?(results)
    data = YAML.safe_load(File.read(results))
    raise "Invalid network results #{results}" unless data.class <= Hash
    data
  end

  # Creates variable test data to comply with self_link URI parameters
  # Only used for gcompute_region objects
  def uri_data_region(id)
    {
      project: GoogleTests::Constants::R_PROJECT_DATA[(id - 1) \
        % GoogleTests::Constants::R_PROJECT_DATA.size],
      name: GoogleTests::Constants::R_NAME_DATA[(id - 1) \
        % GoogleTests::Constants::R_NAME_DATA.size]
    }
  end

  def self_link_region(data)
    URI.join(
      'https://www.googleapis.com/compute/v1/',
      expand_variables_region(
        'projects/{{project}}/regions/{{name}}',
        data
      )
    )
  end

  def debug(message)
    puts(message) if ENV['RSPEC_DEBUG']
  end

  def debug_network(message)
    puts("Network #{message}") \
      if ENV['RSPEC_DEBUG'] || ENV['RSPEC_HTTP_VERBOSE']
  end

  def expand_variables_region(template, data, ext_dat = {})
    Google::GCOMPUTE::Region
      .action_class.expand_variables(template, data, ext_dat)
  end

  def collection(data)
    URI.join(
      'https://www.googleapis.com/compute/v1/',
      expand_variables(
        'projects/{{project}}/zones',
        data
      )
    )
  end

  def self_link(data)
    URI.join(
      'https://www.googleapis.com/compute/v1/',
      expand_variables(
        'projects/{{project}}/zones/{{name}}',
        data
      )
    )
  end

  # Creates variable test data to comply with self_link URI parameters
  def uri_data(id)
    {
      project: GoogleTests::Constants::Z_PROJECT_DATA[(id - 1) \
        % GoogleTests::Constants::Z_PROJECT_DATA.size],
      name: GoogleTests::Constants::Z_NAME_DATA[(id - 1) \
        % GoogleTests::Constants::Z_NAME_DATA.size]
    }
  end

  def build_cred
    <<-CRED
    gauth_credential 'mycred' do
      action :serviceaccount
      path '/home'
      scopes [
        'test_path'
      ]
    end
    CRED
  end

  # Creates a test recipe file and runs a block before destroying the file
  def apply_recipe(recipe)
    # Creates a random string name
    recipe_name = "recipe~test~#{(0...8).map { (65 + rand(26)).chr }.join}"
    recipe_loc = File.join(File.dirname(__FILE__), '..', 'recipes',
                           "#{recipe_name}.rb")

    File.open(recipe_loc, 'w') do |file|
      file.write([build_cred, recipe].join("\n"))
    end
    recipe_path = "google-gcompute::#{recipe_name}"
    begin
      yield recipe_path
    ensure
      File.delete(recipe_loc)
    end
  end
end
