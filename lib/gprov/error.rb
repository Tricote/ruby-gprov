# = gprov/error.rb
#
# == Overview
#
# Common definition of possible gprov errors.
#
# == Authors
#
# Adrien Thebo
#
# == Copyright
#
# 2011 Puppet Labs
#
require 'gprov'
module GProv
  class Error < Exception
    attr_reader :request

    def initialize(request = nil)
      @request = request
    end

    # Raised when the requesting user is not authenticated, IE has an invalid
    # token
    class TokenInvalid < GProv::Error; end

    # Raised when a request is malformed
    class InputInvalid < GProv::Error; end

    # Raised when the Google Apps request quota is exceeded
    class QuotaExceeded < GProv::Error; end
  end
end
