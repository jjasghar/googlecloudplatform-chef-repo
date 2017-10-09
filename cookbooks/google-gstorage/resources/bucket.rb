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
require 'google/storage/network/delete'
require 'google/storage/network/get'
require 'google/storage/network/post'
require 'google/storage/network/put'
require 'google/storage/property/boolean'
require 'google/storage/property/bucket_acl'
require 'google/storage/property/bucket_action'
require 'google/storage/property/bucket_condition'
require 'google/storage/property/bucket_cors'
require 'google/storage/property/bucket_lifecycle'
require 'google/storage/property/bucket_logging'
require 'google/storage/property/bucket_name'
require 'google/storage/property/bucket_owner'
require 'google/storage/property/bucket_project_team'
require 'google/storage/property/bucket_rule'
require 'google/storage/property/bucket_versioning'
require 'google/storage/property/bucket_website'
require 'google/storage/property/enum'
require 'google/storage/property/integer'
require 'google/storage/property/string'
require 'google/storage/property/string_array'
require 'google/storage/property/time'

module Google
  module GSTORAGE
    # A provider to manage Google Cloud Storage resources.
    # rubocop:disable Metrics/ClassLength
    class Bucket < Chef::Resource
      resource_name :gstorage_bucket

      # acl is Array of Google::Storage::Property::BucketAclArray
      property :acl,
               Array,
               coerce: ::Google::Storage::Property::BucketAclArray.coerce,
               desired_state: true
      # cors is Array of Google::Storage::Property::BucketCorsArray
      property :cors,
               Array,
               coerce: ::Google::Storage::Property::BucketCorsArray.coerce,
               desired_state: true
      property :id,
               String,
               coerce: ::Google::Storage::Property::String.coerce,
               desired_state: true
      property :lifecycle,
               [Hash, ::Google::Storage::Data::BucketLifecycle],
               coerce: ::Google::Storage::Property::BucketLifecycle.coerce,
               desired_state: true
      property :location,
               String,
               coerce: ::Google::Storage::Property::String.coerce,
               desired_state: true
      property :logging,
               [Hash, ::Google::Storage::Data::BucketLogging],
               coerce: ::Google::Storage::Property::BucketLogging.coerce,
               desired_state: true
      property :metageneration,
               Integer,
               coerce: ::Google::Storage::Property::Integer.coerce,
               desired_state: true
      property :b_label,
               String,
               coerce: ::Google::Storage::Property::String.coerce,
               name_property: true, desired_state: true
      property :owner,
               [Hash, ::Google::Storage::Data::BucketOwner],
               coerce: ::Google::Storage::Property::BucketOwner.coerce,
               desired_state: true
      property :project_number,
               Integer,
               coerce: ::Google::Storage::Property::Integer.coerce,
               desired_state: true
      property :storage_class,
               equal_to: %w[MULTI_REGIONAL REGIONAL STANDARD
                            NEARLINE COLDLINE DURABLE_REDUCED_AVAILABILITY],
               coerce: ::Google::Storage::Property::Enum.coerce,
               desired_state: true
      property :time_created,
               Time,
               coerce: ::Google::Storage::Property::Time.coerce,
               desired_state: true
      property :_updated,
               Time,
               coerce: ::Google::Storage::Property::Time.coerce,
               desired_state: true
      property :versioning,
               [Hash, ::Google::Storage::Data::BucketVersioning],
               coerce: ::Google::Storage::Property::BucketVersioning.coerce,
               desired_state: true
      property :website,
               [Hash, ::Google::Storage::Data::BucketWebsite],
               coerce: ::Google::Storage::Property::BucketWebsite.coerce,
               desired_state: true
      property :project,
               String,
               coerce: ::Google::Storage::Property::String.coerce,
               desired_state: true
      property :predefined_default_object_acl,
               equal_to: %w[authenticatedRead bucketOwnerFullControl
                            bucketOwnerRead private projectPrivate publicRead],
               coerce: ::Google::Storage::Property::Enum.coerce,
               desired_state: true

      property :credential, String, desired_state: false, required: true
      property :project, String, desired_state: false, required: true

      action :create do
        fetch = fetch_resource(@new_resource, self_link(@new_resource),
                               'storage#bucket')
        if fetch.nil?
          converge_by "Creating gstorage_bucket[#{new_resource.name}]" do
            # TODO(nelsonjr): Show a list of variables to create
            # TODO(nelsonjr): Determine how to print green like update converge
            puts # making a newline until we find a better way TODO: find!
            compute_changes.each { |log| puts "    - #{log.strip}\n" }
            create_req = ::Google::Storage::Network::Post.new(
              collection(@new_resource), fetch_auth(@new_resource),
              'application/json', resource_to_request
            )
            return_if_object create_req.send, 'storage#bucket'
          end
        else
          @current_resource = @new_resource.clone
          @current_resource.acl =
            ::Google::Storage::Property::BucketAclArray.api_parse(
              fetch['acl']
            )
          @current_resource.cors =
            ::Google::Storage::Property::BucketCorsArray.api_parse(
              fetch['cors']
            )
          @current_resource.id =
            ::Google::Storage::Property::String.api_parse(fetch['id'])
          @current_resource.lifecycle =
            ::Google::Storage::Property::BucketLifecycle.api_parse(
              fetch['lifecycle']
            )
          @current_resource.location =
            ::Google::Storage::Property::String.api_parse(fetch['location'])
          @current_resource.logging =
            ::Google::Storage::Property::BucketLogging.api_parse(
              fetch['logging']
            )
          @current_resource.metageneration =
            ::Google::Storage::Property::Integer.api_parse(
              fetch['metageneration']
            )
          @current_resource.b_label =
            ::Google::Storage::Property::String.api_parse(fetch['name'])
          @current_resource.owner =
            ::Google::Storage::Property::BucketOwner.api_parse(fetch['owner'])
          @current_resource.project_number =
            ::Google::Storage::Property::Integer.api_parse(
              fetch['projectNumber']
            )
          @current_resource.storage_class =
            ::Google::Storage::Property::Enum.api_parse(fetch['storageClass'])
          @current_resource.time_created =
            ::Google::Storage::Property::Time.api_parse(fetch['timeCreated'])
          @current_resource._updated =
            ::Google::Storage::Property::Time.api_parse(fetch['updated'])
          @current_resource.versioning =
            ::Google::Storage::Property::BucketVersioning.api_parse(
              fetch['versioning']
            )
          @current_resource.website =
            ::Google::Storage::Property::BucketWebsite.api_parse(
              fetch['website']
            )

          update
        end
      end

      action :delete do
        fetch = fetch_resource(@new_resource, self_link(@new_resource),
                               'storage#bucket')
        unless fetch.nil?
          converge_by "Deleting gstorage_bucket[#{new_resource.name}]" do
            delete_req = ::Google::Storage::Network::Delete.new(
              self_link(@new_resource), fetch_auth(@new_resource)
            )
            return_if_object delete_req.send, 'storage#bucket'
          end
        end
      end

      # TODO(nelsonjr): Add actions :manage and :modify

      def exports
        {
          name: b_label
        }
      end

      private

      action_class do
        # rubocop:disable Metric/AbcSize
        # rubocop:disable Metrics/MethodLength
        def resource_to_request
          request = {
            kind: 'storage#bucket',
            acl: new_resource.acl,
            cors: new_resource.cors,
            lifecycle: new_resource.lifecycle,
            location: new_resource.location,
            logging: new_resource.logging,
            metageneration: new_resource.metageneration,
            name: new_resource.b_label,
            owner: new_resource.owner,
            storageClass: new_resource.storage_class,
            versioning: new_resource.versioning,
            website: new_resource.website,
            project: new_resource.project,
            predefinedDefaultObjectAcl:
              new_resource.predefined_default_object_acl
          }.reject { |_, v| v.nil? }
          request.to_json
        end
        # rubocop:enable Metrics/MethodLength
        # rubocop:enable Metric/AbcSize

        def update
          converge_if_changed do |_vars|
            # TODO(nelsonjr): Determine how to print indented like upd converge
            # TODO(nelsonjr): Check w/ Chef... can we print this in red?
            puts # making a newline until we find a better way TODO: find!
            compute_changes.each { |log| puts "    - #{log.strip}\n" }
            update_req =
              ::Google::Storage::Network::Put.new(self_link(@new_resource),
                                                  fetch_auth(@new_resource),
                                                  'application/json',
                                                  resource_to_request)
            return_if_object update_req.send, 'storage#bucket'
          end
        end

        # rubocop:disable Metrics/MethodLength
        def self.resource_to_hash(resource)
          {
            name: resource.b_label,
            kind: 'storage#bucket',
            acl: resource.acl,
            cors: resource.cors,
            id: resource.id,
            lifecycle: resource.lifecycle,
            location: resource.location,
            logging: resource.logging,
            metageneration: resource.metageneration,
            owner: resource.owner,
            project_number: resource.project_number,
            storage_class: resource.storage_class,
            time_created: resource.time_created,
            updated: resource._updated,
            versioning: resource.versioning,
            website: resource.website,
            project: resource.project,
            predefined_default_object_acl:
              resource.predefined_default_object_acl
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
            'https://www.googleapis.com/storage/v1/',
            expand_variables(
              'b?project={{project}}',
              data
            )
          )
        end

        def collection(data)
          self.class.collection(data)
        end

        def self.self_link(data)
          URI.join(
            'https://www.googleapis.com/storage/v1/',
            expand_variables(
              'b/{{name}}?projection=full',
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
          get_request = ::Google::Storage::Network::Get.new(
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