#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../../ruby_task_helper/files/task_helper.rb'
require_relative '../../ruby_plugin_helper/lib/plugin_helper.rb'
require 'json'
require 'aws-sdk-kms'

class KMS < TaskHelper
  include RubyPluginHelper

  def task(opts)
    kms = Aws::KMS::Client.new()
    blob = opts[:cyphertext]
    blob_packed = [blob].pack("H*")
    resp = kms.decrypt({
        ciphertext_blob: blob_packed, # The encrypted data (ciphertext).
    })
    { value: resp.plaintext }
  end
end

KMS.run if $PROGRAM_NAME == __FILE__