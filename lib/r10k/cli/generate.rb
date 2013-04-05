require 'r10k/cli'
require 'r10k/root'
require 'r10k/util/generator'

require 'cri'


module R10K::CLI
  module Generate
    def self.command
      @cmd ||= Cri::Command.define do
        name 'generate'
        usage 'generate <what> <name>'
        summary 'generate code'

        flag :t, :templates, 'templates directory'
        flag :n, :noop, 'Run in noop mode'

        templates = Dir.glob("./templates/*.erb").map { |x| File.basename(x, '.erb') }

        templates.each do |wat|
          subcommand do
            name "#{wat}"
            summary "generate #{wat}"

            run do |opts, args, cmd|
              generator = R10K::Util::Generator.new("#{wat}", args[0])
              generator.save

              exit 0
            end
          end
        end

        run do |opts, args, cmd|
          puts cmd.help
          exit 0
        end
      end
    end
  end

  self.command.add_command(Generate.command)
end
