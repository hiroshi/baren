require "tilt"
module Baren
  class Error < Exception; end
  class ProcessingJsError < Error; end

  class ProcessingJs
    def self.path
      File.join(File.dirname(__FILE__), '..', 'vendor', 'assets', 'javascripts', 'processing.min.js')
    end
  end

  class PhantomJs
    def self.path
      File.join(File.dirname(__FILE__), '..', 'opt', 'phantomjs', 'bin', 'phantomjs')
    end

    def self.pjs2png_path
      File.join(File.dirname(__FILE__), '..', 'opt', 'phantomjs', 'pjs2png.js.erb')
    end
  end

  class PjsTemplate < Tilt::Template
    #self.default_mime_type = 'image/png'
    def prepare
    end

    def evaluate(scope, locals, &block)
      require "tempfile"
      dataURL = Tempfile.open("pjs2png") do |f|
        f.print Tilt.new(PhantomJs.pjs2png_path).render(nil, :pjs => data.inspect, :processingjs => File.read(ProcessingJs.path).inspect)
        f.flush
        case RUBY_PLATFORM
        when /linux/
          cmd = "xvfb-run #{PhantomJs.path} #{f.path}"
        else
          cmd = "#{PhantomJs.path} #{f.path}"
        end
        `#{cmd}`
      end
      if encodedImage = dataURL[%r"data:image/png;base64,(.*)",1]
        require "base64"
        @output ||= Base64.decode64(encodedImage)
      else
        raise Baren::ProcessingJsError, dataURL
      end
    end
  end
  #Tilt.register Baren::PjsTemplate, "pjs"

  if defined?(::Rails::Railtie)
    require "sprockets"
    # workaround for the problem about Sprockets::DirectiveProcessor parsing binary (png)
    class PossibleBinaryDirectiveProcessor < Sprockets::DirectiveProcessor
      def prepare
        if !data.respond_to?(:valid_encoding?) || data.valid_encoding?
          super
        end
      end

      def evaluate(context, locals, &block)
        if @directive_parser
          super
        else
          data
        end
      end
    end

    class Railtie < ::Rails::Railtie
      config.after_initialize do |app|
        app.assets.instance_eval do
          register_mime_type 'image/png', '.png'
          register_engine '.pjs', Baren::PjsTemplate
          register_processor 'image/png', Baren::PossibleBinaryDirectiveProcessor #Sprockets::DirectiveProcessor
        end
      end
    end
  end
end

