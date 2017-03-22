module Cms
  module S3
    class << self
      attr_accessor :heroku_caching
      attr_accessor :www_domain_prefix
      attr_accessor :options
    end
    
    module ContentController
      def self.included(controller_class)
        controller_class.alias_method_chain :render_page_with_caching, :s3
      end
      def render_page_with_caching_with_s3
        render_page
        response.headers['Cache-Control'] = 'public, max-age=300' if Cms::S3.heroku_caching
      end
      
    end
    
    module ApplicationController
      def self.included(controller_class)
        controller_class.alias_method_chain :url_without_cms_domain_prefix, :www
      end
      def url_without_cms_domain_prefix_with_www
        if Cms::S3.www_domain_prefix
          request.url.sub(/#{cms_domain_prefix}\./,'www.')
        else
          request.url.sub(/#{cms_domain_prefix}\./,'')
        end
      end
    end
  end
end


