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
require 'google/hash_utils'
require 'google/sql/network/delete'
require 'google/sql/network/get'
require 'google/sql/network/post'
require 'google/sql/network/put'
require 'google/sql/property/instance_name'
require 'google/sql/property/string'
require 'google/sql/property/time'

module Google
  module GSQL
    # A provider to manage Google Cloud SQL resources.
    # rubocop:disable Metrics/ClassLength
    class SslCert < Chef::Resource
      resource_name :gsql_ssl_cert

      property :cert,
               String,
               coerce: ::Google::Sql::Property::String.coerce,
               desired_state: true
      property :cert_serial_number,
               String,
               coerce: ::Google::Sql::Property::String.coerce,
               desired_state: true
      property :common_name,
               String,
               coerce: ::Google::Sql::Property::String.coerce,
               desired_state: true
      property :create_time,
               Time,
               coerce: ::Google::Sql::Property::Time.coerce, desired_state: true
      property :expiration_time,
               Time,
               coerce: ::Google::Sql::Property::Time.coerce, desired_state: true
      property :instance,
               [String, ::Google::Sql::Data::InstancNameRef],
               coerce: ::Google::Sql::Property::InstancNameRef.coerce,
               desired_state: true
      property :sha1_fingerprint,
               String,
               coerce: ::Google::Sql::Property::String.coerce,
               desired_state: true

      property :credential, String, desired_state: false, required: true
      property :project, String, desired_state: false, required: true

      action :create do
        fetch = fetch_resource(@new_resource, self_link(@new_resource),
                               'sql#sslCert')
        if fetch.nil?
          converge_by "Creating gsql_ssl_cert[#{new_resource.name}]" do
            # TODO(nelsonjr): Show a list of variables to create
            # TODO(nelsonjr): Determine how to print green like update converge
            puts # making a newline until we find a better way TODO: find!
            compute_changes.each { |log| puts "    - #{log.strip}\n" }
            create_req = ::Google::Sql::Network::Post.new(
              collection(@new_resource), fetch_auth(@new_resource),
              'application/json', resource_to_request
            )
            return_if_object create_req.send, 'sql#sslCert'
          end
        else
          @current_resource = @new_resource.clone
          @current_resource.cert =
            ::Google::Sql::Property::String.api_parse(fetch['cert'])
          @current_resource.cert_serial_number =
            ::Google::Sql::Property::String.api_parse(
              fetch['certSerialNumber']
            )
          @current_resource.common_name =
            ::Google::Sql::Property::String.api_parse(fetch['commonName'])
          @current_resource.create_time =
            ::Google::Sql::Property::Time.api_parse(fetch['createTime'])
          @current_resource.expiration_time =
            ::Google::Sql::Property::Time.api_parse(fetch['expirationTime'])

          update
        end
      end

      action :delete do
        fetch = fetch_resource(@new_resource, self_link(@new_resource),
                               'sql#sslCert')
        unless fetch.nil?
          converge_by "Deleting gsql_ssl_cert[#{new_resource.name}]" do
            delete_req = ::Google::Sql::Network::Delete.new(
              self_link(@new_resource), fetch_auth(@new_resource)
            )
            return_if_object delete_req.send, 'sql#sslCert'
          end
        end
      end

      # TODO(nelsonjr): Add actions :manage and :modify

      private

      action_class do
        def resource_to_request
          request = {
            kind: 'sql#sslCert',
            cert: new_resource.cert,
            certSerialNumber: new_resource.cert_serial_number,
            commonName: new_resource.common_name,
            createTime: new_resource.create_time,
            expirationTime: new_resource.expiration_time
          }.reject { |_, v| v.nil? }
          request.to_json
        end

        def update
          converge_if_changed do |_vars|
            # TODO(nelsonjr): Determine how to print indented like upd converge
            # TODO(nelsonjr): Check w/ Chef... can we print this in red?
            puts # making a newline until we find a better way TODO: find!
            compute_changes.each { |log| puts "    - #{log.strip}\n" }
            update_req =
              ::Google::Sql::Network::Put.new(self_link(@new_resource),
                                              fetch_auth(@new_resource),
                                              'application/json',
                                              resource_to_request)
            return_if_object update_req.send, 'sql#sslCert'
          end
        end

        def self.fetch_export(resource, type, id, property)
          return if id.nil?
          resource.resources("#{type}[#{id}]").exports[property]
        end

        def self.resource_to_hash(resource)
          {
            project: resource.project,
            name: resource.name,
            kind: 'sql#sslCert',
            cert: resource.cert,
            cert_serial_number: resource.cert_serial_number,
            common_name: resource.common_name,
            create_time: resource.create_time,
            expiration_time: resource.expiration_time,
            instance: resource.instance,
            sha1_fingerprint: resource.sha1_fingerprint
          }.reject { |_, v| v.nil? }
        end

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
            'https://www.googleapis.com/sql/v1beta4/',
            expand_variables(
              'projects/{{project}}/instances/{{instance}}/sslCerts',
              data
            )
          )
        end

        def collection(data)
          self.class.collection(data)
        end

        def self.self_link(data)
          URI.join(
            'https://www.googleapis.com/sql/v1beta4/',
            expand_variables(
              [
                'projects/{{project}}/instances/{{instance}}/sslCerts/',
                '{{sha1_fingerprint}}'
              ].join,
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

        def self.fetch_resource(resource, self_link, kind)
          get_request = ::Google::Sql::Network::Get.new(
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
