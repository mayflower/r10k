require 'erb'

module R10K::Util
  class Generator
    def initialize(wat, name)
      @name     = name
      @path     = File.join('site', "#{wat}", "manifests", name.split('::')) + '.pp'
      @template = File.read(File.join('.', 'templates', "#{wat}.erb"))
    end

    def render
      ERB.new(@template, nil, '-').result(binding)
    end

    def save
      content = self.render

      unless File.exists?(@path)
        begin
          fh = File.open(@path, 'w')
          fh.puts(content)
          fh.close
        rescue => e
          raise "Failed to write: #{e.message}"
        end
      end
    end
  end
end
