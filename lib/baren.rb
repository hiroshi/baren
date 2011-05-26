require "tilt"
require "sprockets"
module Baren
  class PjsTemplate < Tilt::Template
    #self.default_mime_type = 'image/png'
    
    def prepare
    end
    
    def evaluate(scope, locals, &block)
      phantomjs = "/Volumes/phantomjs/phantomjs.app/Contents/MacOS/phantomjs" # FIXME
      require "tempfile"
      dataURL = Tempfile.open("pjs2png") do |f|
        # FIXME: path to pjs2png.js.erb
        # FIXME: path to processing.js
        f.print Tilt.new((Rails.root + "pjs2png.js.erb").to_s).render(nil, :pjs => data.inspect, :processingjs => File.read(Rails.root + "processing-1.1.0.min.js").inspect)
        f.flush
        cmd = "#{phantomjs} #{f.path}"
        `#{cmd}`
      end
      require "base64"
      @output ||= Base64.decode64(dataURL[%r"data:image/png;base64,(.*)",1])
    end
  end
  #Tilt.register Baren::PjsTemplate, "pjs"
  
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

  class Railtie < Rails::Railtie
    config.after_initialize do |app|
      app.assets.instance_eval do
        register_mime_type 'image/png', '.png'
        register_engine '.pjs', Baren::PjsTemplate
        register_processor 'image/png', Baren::PossibleBinaryDirectiveProcessor #Sprockets::DirectiveProcessor
      end
    end
  end
end

