module ApplicationHelper

    def download_url_for(s3file_key)
        AWS::S3::S3Object.url_for(s3file_key, BUCKET, :authenticated => false)
    end

end
