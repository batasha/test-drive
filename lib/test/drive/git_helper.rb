module Test
  module Drive
    module GitHelper
      def create_patch filename
        res = sh "git pull --rebase && git diff --binary origin > #{filename}"
        unless res == 0
          raise IOError.new 'Failed to create patch'
        end
      end

      def delete_patch filename
        `rm #{filename}`
      end

      def git_push
        `git push origin master`
      end
    end
  end
end
