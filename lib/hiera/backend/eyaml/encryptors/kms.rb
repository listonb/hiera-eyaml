require 'hiera/backend/eyaml/encryptor'
require 'hiera/backend/eyaml/utils'
require 'hiera/backend/eyaml/plugins'
require 'hiera/backend/eyaml/options'
require 'aws-sdk'
require 'base64'

class Hiera
  module Backend
    module Eyaml
      module Encryptors

        class Kms < Encryptor
          
          self.options = {
            :region => { :desc => "AWS Region", 
                              :type => :string, 
                              :default => "us-east-1" },
            :key => { :desc => "KMS KeyID",
                      :type => :string }
          }
          
          region = self.option :region
          
          
          self.tag = "KMS"

          def self.encrypt plaintext
            region = self.option :region
            key = self.option :key
            raise StandardError, "KMS KeyId Required" unless key
            
            kms = Aws::KMS::Client.new(region: region)
            kms.encrypt(key_id: key, plaintext: plaintext).ciphertext_blob
          end

          def self.decrypt ciphertext
            region = self.option :region            
            kms = Aws::KMS::Client.new(region: region)
            kms.decrypt(ciphertext_blob: Base64.decode64(Base64.encode64(ciphertext))).plaintext
          end

        end

      end

    end

  end

end