module Test
  module Drive
    module GitHelper
      def create_patch
        `git pull --rebase && git diff --binary origin > #{options['file']}`
        unless $? == 0
          raise 'Failed to create patch'
        end
      end

      def delete_patch
        `rm #{options['file']}`
      end

      def git_push
        `git push origin master`
      end
    end
  end
end