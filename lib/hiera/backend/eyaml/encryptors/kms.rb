require 'hiera/backend/eyaml/encryptor'
require 'hiera/backend/eyaml/utils'
require 'hiera/backend/eyaml/options'

class Hiera
  module Backend
    module Eyaml
      module Encryptors

        class Kms < Encryptor

          self.tag = "KMS"

          def self.encrypt plaintext
            
          end

          def self.decrypt ciphertext
            
            raise StandardError, "decrypt"

          end

        end

      end

    end

  end

end