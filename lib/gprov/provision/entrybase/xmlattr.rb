# = gprov/provision/entrybase/xmlattr.rb: attribute accessors with xml annotations
#
# == Overview
#
# Defines a data type and provides the logic for extracting and formatting
# object information from xml data
#
# Attribute accessors are not directly defined, because this class was designed
# to be used DSL style
#
# == Examples
#
#     xmlattr :demo, :type => :numeric, :xpath => "example/xpath/text()"
#
#     xmlattr :demo do
#       type :numeric
#       xpath "example/xpath/text()"
#     end
#
# == Authors
#
# Adrien Thebo
#
# == Copyright
#
# 2011 Puppet Labs
#
require 'nokogiri'

module GProv
  module Provision
    class EntryBase
      class XMLAttr

        # The name attribute is not used by this class, but is used by calling
        # classes to determine the method/attribute name they'll use to
        # associate with this object.
        attr_reader :name

        def initialize(name, options={})
          @name = name
          @type = :string
          methodhash(options)
        end

        def xpath(val=nil)
          @xpath = val if val
          @xpath
        end

        def type(val=nil)

          if [:numeric, :string, :bool].include? val
            @type = val
          else
            raise ArgumentError, "#{@type} is not recognized as a valid format type"
          end

          @type
        end

        # Given an XML document, use the supplied xpath value to extract the
        # desired value for this attribute from the document.
        def parse(xml)
          @value = xml.at_xpath(@xpath).to_s
          format
        end

        private

        # Convert the given attribute from a string into an actual meaningful
        # type.
        def format
          case @type
          when :numeric
            @value = @value.to_i
          when :string
            # no op
          when :bool
            if @value == "true"
              @value = true
            else # XXX sketchy
              @value = false
            end
          else
            raise ArgumentError, "Unable to format data: #{@type} is not recognized as a valid format type"
          end
          @value
        end

        # Given a hash, use the keys as method names and the values as the
        # arguments to send to the method. This allows for quick instantiation
        # of this type.
        #
        # *Example:*
        #
        #   XMLAttr.new(:example, :type => :bool, :xpath => '/my/xpath')
        #
        def methodhash(hash)
          hash.each_pair do |method, value|
            if respond_to? method
              send method, value
            else
              raise ArgumentError, %Q{Received invalid attribute "#{method}"}
            end
          end
        end
      end
    end
  end
end
