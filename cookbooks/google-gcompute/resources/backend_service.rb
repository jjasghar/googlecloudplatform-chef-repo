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

# Add our google/ lib
$LOAD_PATH.unshift ::File.expand_path('../libraries', ::File.dirname(__FILE__))

require 'chef/resource'
require 'google/compute/network/delete'
require 'google/compute/network/get'
require 'google/compute/network/post'
require 'google/compute/network/put'
require 'google/compute/property/backendservice_backends'
require 'google/compute/property/backendservice_cache_key_policy'
require 'google/compute/property/backendservice_cdn_policy'
require 'google/compute/property/backendservice_connection_draining'
require 'google/compute/property/boolean'
require 'google/compute/property/double'
require 'google/compute/property/enum'
require 'google/compute/property/instancegroup_selflink'
require 'google/compute/property/integer'
require 'google/compute/property/region_selflink'
require 'google/compute/property/string'
require 'google/compute/property/string_array'
require 'google/compute/property/time'
require 'google/hash_utils'

module Google
  module GCOMPUTE
    # A provider to manage Google Compute Engine resources.
    # rubocop:disable Metrics/ClassLength
    class BackendService < Chef::Resource
      resource_name :gcompute_backend_service

      property :affinity_cookie_ttl_sec,
               Integer,
               coerce: ::Google::Compute::Property::Integer.coerce,
               desired_state: true
      # backends is Array of
      # Google::Compute::Property::BackendServiceBackendArray
      property :backends,
               Array,
               coerce: \
                 ::Google::Compute::Property::BackendServiceBackendArray.coerce,
               desired_state: true
      property :cdn_policy,
               [Hash, ::Google::Compute::Data::BackeServiCdnPolic],
               coerce: ::Google::Compute::Property::BackeServiCdnPolic.coerce,
               desired_state: true
      property :connection_draining,
               [Hash, ::Google::Compute::Data::BackeServiConneDrain],
               coerce: ::Google::Compute::Property::BackeServiConneDrain.coerce,
               desired_state: true
      property :creation_timestamp,
               Time,
               coerce: ::Google::Compute::Property::Time.coerce,
               desired_state: true
      property :description,
               String,
               coerce: ::Google::Compute::Property::String.coerce,
               desired_state: true
      property :enable_cdn,
               kind_of: [TrueClass, FalseClass],
               coerce: ::Google::Compute::Property::Boolean.coerce,
               desired_state: true
      # health_checks is Array of Google::Compute::Property::StringArray
      property :health_checks,
               Array,
               coerce: ::Google::Compute::Property::StringArray.coerce,
               desired_state: true
      property :id,
               Integer,
               coerce: ::Google::Compute::Property::Integer.coerce,
               desired_state: true
      property :bs_label,
               String,
               coerce: ::Google::Compute::Property::String.coerce,
               name_property: true, desired_state: true
      property :port_name,
               String,
               coerce: ::Google::Compute::Property::String.coerce,
               desired_state: true
      property :protocol,
               equal_to: %w[HTTP HTTPS TCP SSL],
               coerce: ::Google::Compute::Property::Enum.coerce,
               desired_state: true
      property :region,
               [String, ::Google::Compute::Data::RegioSelfLinkRef],
               coerce: ::Google::Compute::Property::RegioSelfLinkRef.coerce,
               desired_state: true
      property :session_affinity,
               equal_to: %w[NONE CLIENT_IP GENERATED_COOKIE
                            CLIENT_IP_PROTO CLIENT_IP_PORT_PROTO],
               coerce: ::Google::Compute::Property::Enum.coerce,
               desired_state: true
      property :timeout_sec,
               Integer,
               coerce: ::Google::Compute::Property::Integer.coerce,
               desired_state: true

      property :credential, String, desired_state: false, required: true
      property :project, String, desired_state: false, required: true

      action :create do
        fetch = fetch_resource(@new_resource, self_link(@new_resource),
                               'compute#backendService')
        if fetch.nil?
          converge_by ['Creating gcompute_backend_service',
                       "[#{new_resource.name}]"].join do
            # TODO(nelsonjr): Show a list of variables to create
            # TODO(nelsonjr): Determine how to print green like update converge
            puts # making a newline until we find a better way TODO: find!
            compute_changes.each { |log| puts "    - #{log.strip}\n" }
            create_req = ::Google::Compute::Network::Post.new(
              collection(@new_resource), fetch_auth(@new_resource),
              'application/json', resource_to_request
            )
            wait_for_operation create_req.send, @new_resource
          end
        else
          @current_resource = @new_resource.clone
          @current_resource.affinity_cookie_ttl_sec =
            ::Google::Compute::Property::Integer.api_parse(
              fetch['affinityCookieTtlSec']
            )
          @current_resource.backends =
            ::Google::Compute::Property::BackendServiceBackendArray.api_parse(
              fetch['backends']
            )
          @current_resource.cdn_policy =
            ::Google::Compute::Property::BackeServiCdnPolic.api_parse(
              fetch['cdnPolicy']
            )
          @current_resource.connection_draining =
            ::Google::Compute::Property::BackeServiConneDrain.api_parse(
              fetch['connectionDraining']
            )
          @current_resource.creation_timestamp =
            ::Google::Compute::Property::Time.api_parse(
              fetch['creationTimestamp']
            )
          @current_resource.description =
            ::Google::Compute::Property::String.api_parse(
              fetch['description']
            )
          @current_resource.enable_cdn =
            ::Google::Compute::Property::Boolean.api_parse(fetch['enableCDN'])
          @current_resource.health_checks =
            ::Google::Compute::Property::StringArray.api_parse(
              fetch['healthChecks']
            )
          @current_resource.id =
            ::Google::Compute::Property::Integer.api_parse(fetch['id'])
          @current_resource.bs_label =
            ::Google::Compute::Property::String.api_parse(fetch['name'])
          @current_resource.port_name =
            ::Google::Compute::Property::String.api_parse(fetch['portName'])
          @current_resource.protocol =
            ::Google::Compute::Property::Enum.api_parse(fetch['protocol'])
          @current_resource.region =
            ::Google::Compute::Property::RegioSelfLinkRef.api_parse(
              fetch['region']
            )
          @current_resource.session_affinity =
            ::Google::Compute::Property::Enum.api_parse(
              fetch['sessionAffinity']
            )
          @current_resource.timeout_sec =
            ::Google::Compute::Property::Integer.api_parse(
              fetch['timeoutSec']
            )

          update
        end
      end

      action :delete do
        fetch = fetch_resource(@new_resource, self_link(@new_resource),
                               'compute#backendService')
        unless fetch.nil?
          converge_by ['Deleting gcompute_backend_service',
                       "[#{new_resource.name}]"].join do
            delete_req = ::Google::Compute::Network::Delete.new(
              self_link(@new_resource), fetch_auth(@new_resource)
            )
            wait_for_operation delete_req.send, @new_resource
          end
        end
      end

      # TODO(nelsonjr): Add actions :manage and :modify

      private

      action_class do
        # rubocop:disable Metrics/AbcSize
        # rubocop:disable Metrics/MethodLength
        def resource_to_request
          request = {
            kind: 'compute#backendService',
            affinityCookieTtlSec: new_resource.affinity_cookie_ttl_sec,
            backends: new_resource.backends,
            cdnPolicy: new_resource.cdn_policy,
            connectionDraining: new_resource.connection_draining,
            description: new_resource.description,
            enableCDN: new_resource.enable_cdn,
            healthChecks: new_resource.health_checks,
            name: new_resource.bs_label,
            portName: new_resource.port_name,
            protocol: new_resource.protocol,
            region: new_resource.region,
            sessionAffinity: new_resource.session_affinity,
            timeoutSec: new_resource.timeout_sec
          }.reject { |_, v| v.nil? }
          request.to_json
        end
        # rubocop:enable Metrics/MethodLength
        # rubocop:enable Metrics/AbcSize

        def update
          converge_if_changed do |_vars|
            # TODO(nelsonjr): Determine how to print indented like upd converge
            # TODO(nelsonjr): Check w/ Chef... can we print this in red?
            puts # making a newline until we find a better way TODO: find!
            compute_changes.each { |log| puts "    - #{log.strip}\n" }
            update_req =
              ::Google::Compute::Network::Put.new(self_link(@new_resource),
                                                  fetch_auth(@new_resource),
                                                  'application/json',
                                                  resource_to_request)
            wait_for_operation update_req.send, @new_resource
          end
        end

        def self.fetch_export(resource, type, id, property)
          return if id.nil?
          resource.resources("#{type}[#{id}]").exports[property]
        end

        # rubocop:disable Metrics/MethodLength
        def self.resource_to_hash(resource)
          {
            project: resource.project,
            name: resource.bs_label,
            kind: 'compute#backendService',
            affinity_cookie_ttl_sec: resource.affinity_cookie_ttl_sec,
            backends: resource.backends,
            cdn_policy: resource.cdn_policy,
            connection_draining: resource.connection_draining,
            creation_timestamp: resource.creation_timestamp,
            description: resource.description,
            enable_cdn: resource.enable_cdn,
            health_checks: resource.health_checks,
            id: resource.id,
            port_name: resource.port_name,
            protocol: resource.protocol,
            region: resource.region,
            session_affinity: resource.session_affinity,
            timeout_sec: resource.timeout_sec
          }.reject { |_, v| v.nil? }
        end
        # rubocop:enable Metrics/MethodLength

        # Copied from Chef > Provider > #converge_if_changed
        def compute_changes
          properties = @new_resource.class.state_properties.map(&:name)
          properties = properties.map(&:to_sym)
          if current_resource
            compute_changes_for_existing_resource properties
          else
            compute_changes_for_new_resource properties
          end
        end

        # Collect the list of modified properties
        def compute_changes_for_existing_resource(properties)
          specified_properties = properties.select do |property|
            @new_resource.property_is_set?(property)
          end
          modified = specified_properties.reject do |p|
            @new_resource.send(p) == current_resource.send(p)
          end

          generate_pretty_green_text(modified)
        end

        def generate_pretty_green_text(modified)
          property_size = modified.map(&:size).max
          modified.map! do |p|
            properties_str = if @new_resource.sensitive
                               '(suppressed sensitive property)'
                             else
                               [
                                 @new_resource.send(p).inspect,
                                 "(was #{current_resource.send(p).inspect})"
                               ].join(' ')
                             end
            "  set #{p.to_s.ljust(property_size)} to #{properties_str}"
          end
        end

        # Write down any properties we are setting.
        def compute_changes_for_new_resource(properties)
          property_size = properties.map(&:size).max
          properties.map do |property|
            default = ' (default value)' \
              unless @new_resource.property_is_set?(property)
            next if @new_resource.send(property).nil?
            properties_str = if @new_resource.sensitive
                               '(suppressed sensitive property)'
                             else
                               @new_resource.send(property).inspect
                             end
            ["  set #{property.to_s.ljust(property_size)}",
             "to #{properties_str}#{default}"].join(' ')
          end.compact
        end

        def fetch_auth(resource)
          self.class.fetch_auth(resource)
        end

        def self.fetch_auth(resource)
          resource.resources("gauth_credential[#{resource.credential}]")
                  .authorization
        end

        def fetch_resource(resource, self_link, kind)
          self.class.fetch_resource(resource, self_link, kind)
        end

        def debug(message)
          Chef::Log.debug(message)
        end

        def self.collection(data)
          URI.join(
            'https://www.googleapis.com/compute/v1/',
            expand_variables(
              'projects/{{project}}/global/backendServices',
              data
            )
          )
        end

        def collection(data)
          self.class.collection(data)
        end

        def self.self_link(data)
          URI.join(
            'https://www.googleapis.com/compute/v1/',
            expand_variables(
              'projects/{{project}}/global/backendServices/{{name}}',
              data
            )
          )
        end

        def self_link(data)
          self.class.self_link(data)
        end

        # rubocop:disable Metrics/CyclomaticComplexity
        def self.return_if_object(response, kind)
          raise "Bad response: #{response.body}" \
            if response.is_a?(Net::HTTPBadRequest)
          raise "Bad response: #{response}" \
            unless response.is_a?(Net::HTTPResponse)
          return if response.is_a?(Net::HTTPNotFound)
          return if response.is_a?(Net::HTTPNoContent)
          result = JSON.parse(response.body)
          raise_if_errors result, %w[error errors], 'message'
          raise "Bad response: #{response}" unless response.is_a?(Net::HTTPOK)
          raise "Incorrect result: #{result['kind']} (expected '#{kind}')" \
            unless result['kind'] == kind
          result
        end
        # rubocop:enable Metrics/CyclomaticComplexity

        def return_if_object(response, kind)
          self.class.return_if_object(response, kind)
        end

        def self.extract_variables(template)
          template.scan(/{{[^}]*}}/).map { |v| v.gsub(/{{([^}]*)}}/, '\1') }
                  .map(&:to_sym)
        end

        def self.expand_variables(template, var_data, extra_data = {})
          data = if var_data.class <= Hash
                   var_data.merge(extra_data)
                 else
                   resource_to_hash(var_data).merge(extra_data)
                 end
          extract_variables(template).each do |v|
            unless data.key?(v)
              raise "Missing variable :#{v} in #{data} on #{caller.join("\n")}}"
            end
            template.gsub!(/{{#{v}}}/, CGI.escape(data[v].to_s))
          end
          template
        end

        def expand_variables(template, var_data, extra_data = {})
          self.class.expand_variables(template, var_data, extra_data)
        end

        def fetch_resource(resource, self_link, kind)
          self.class.fetch_resource(resource, self_link, kind)
        end

        def async_op_url(data, extra_data = {})
          URI.join(
            'https://www.googleapis.com/compute/v1/',
            expand_variables(
              'projects/{{project}}/global/operations/{{op_id}}',
              data, extra_data
            )
          )
        end

        def wait_for_operation(response, resource)
          op_result = return_if_object(response, 'compute#operation')
          return if op_result.nil?
          status = ::Google::HashUtils.navigate(op_result, %w[status])
          wait_done = wait_for_completion(status, op_result, resource)
          fetch_resource(
            resource,
            URI.parse(::Google::HashUtils.navigate(wait_done,
                                                   %w[targetLink])),
            'compute#backendService'
          )
        end

        def wait_for_completion(status, op_result, resource)
          op_id = ::Google::HashUtils.navigate(op_result, %w[name])
          op_uri = async_op_url(resource, op_id: op_id)
          while status != 'DONE'
            debug("Waiting for completion of operation #{op_id}")
            raise_if_errors op_result, %w[error errors], 'message'
            sleep 1.0
            raise "Invalid result '#{status}' on gcompute_backend_service." \
              unless %w[PENDING RUNNING DONE].include?(status)
            op_result = fetch_resource(resource, op_uri, 'compute#operation')
            status = ::Google::HashUtils.navigate(op_result, %w[status])
          end
          op_result
        end

        def raise_if_errors(response, err_path, msg_field)
          self.class.raise_if_errors(response, err_path, msg_field)
        end

        def self.fetch_resource(resource, self_link, kind)
          get_request = ::Google::Compute::Network::Get.new(
            self_link, fetch_auth(resource)
          )
          return_if_object get_request.send, kind
        end

        def self.raise_if_errors(response, err_path, msg_field)
          errors = ::Google::HashUtils.navigate(response, err_path)
          raise_error(errors, msg_field) unless errors.nil?
        end

        def self.raise_error(errors, msg_field)
          raise IOError, ['Operation failed:',
                          errors.map { |e| e[msg_field] }.join(', ')].join(' ')
        end
      end
    end
    # rubocop:enable Metrics/ClassLength
  end
end
