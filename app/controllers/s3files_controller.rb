class S3filesController < ApplicationController
    def index
        @s3files = AWS::S3::Bucket.find(BUCKET).objects
    end

    def upload
        begin
            AWS::S3::S3Object.store(sanitize_filename(params[:newfile].original_filename), params[:newfile].read, BUCKET, :access => :public_read)
            redirect_to root_path
            rescue
            render :text => "Couldn't complete the upload"
        end
    end

    def delete
        if (params[:s3file])
            AWS::S3::S3Object.find(params[:s3file], BUCKET).delete
            redirect_to root_path
            else
            render :text => "No file was found to delete!"
        end
    end

    private

    def sanitize_filename(file_name)
        just_filename = File.basename(file_name)
        just_filename.sub(/[^\w\.\-]/,'_')
    end

end


