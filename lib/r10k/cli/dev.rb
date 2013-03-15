require 'r10k/cli'
require 'r10k/root'
require 'r10k/synchro/git'

require 'cri'

module R10K::CLI
  module Dev
    def self.command
      @cmd ||= Cri::Command.define do
        name  'dev'
        usage 'dev <options>'
        summary 'Set up local dev environment'

        flag :u, :update, 'Enable or disable cache updating'

        run do |opts, args, cmd|
          env = R10K::Root.new({
            'name'    => '.',
            'basedir' => '.',
            'remote'  => 'local',
            'ref'     => 'master',
          })
          R10K::Synchro::Git.cache_root = '.r10k_cache'
          env.sync_modules!({ :update_cache => opts[:update] })
        end
      end
    end
  end
  self.command.add_command(Dev.command)
end
