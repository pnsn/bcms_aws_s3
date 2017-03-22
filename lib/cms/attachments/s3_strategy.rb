module Cms
  module Attachments
    
    # Automatically used to serve files when the following configuration is set:
    #   config.cms.attachments.storage = :s3
    class S3Strategy
      
      # Redirects users to the file on S3.
      #   Issues:
      #     1. No security, all files are assumed to be public
      #     2. CNAMEs are not supported.
      def self.send_attachment(attachment, controller)
        d {attachement.inspect}
        controller.redirect_to attachment.url
        
        # Possible s3_cname implementation
        # if Cms::S3.options[:s3_cname]
         # redirect_to("http://#{Cms::S3.options[:s3_cname]}/#{@attachment.file_location}")
        # else
        # redirect_to("http://#{Cms::S3.options[:bucket]}.s3.amazonaws.com/#{@attachment.file_location}")
        # end
      end
      
      # For S3, this returns the relative path within the bucket.
      # I.e. http://s3.amazonaws.com/:bucket/:attachments_storage_location/:path_to_file
      def self.attachments_storage_location
        "/attachments"
      end
            
    end
  end
end
