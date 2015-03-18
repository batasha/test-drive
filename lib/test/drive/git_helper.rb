require 'methadone'

module Test
  module Drive
    module GitHelper
      include Methadone::SH
      include Methadone::CLILogging

      def create_patch filename
        sh 'git pull --rebase'

        res = sh 'git diff --binary origin/master' do |stdout|
          File.open(filename, 'w') { |f| f.write stdout }
        end

        unless res == 0
          raise IOError.new 'Failed to create patch'
        end
      end

      def delete_patch filename
        File.delete filename
      end

      def git_push
        sh 'git push origin'
      end
    end
  end
end
