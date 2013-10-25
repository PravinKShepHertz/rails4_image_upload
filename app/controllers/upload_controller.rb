class UploadController < ApplicationController

  @@upload_service = $api.buildUploadService

  def index
  	begin
  	  @upload = @@upload_service.get_all_files
    rescue Exception => e
      "#{e.message}"	
    end
  end

  def new
  end

  def create
  	begin
  	  file_type = App42::Upload::UploadFileType.new
	  upload_file_type = file_type.enum("IMAGE")         
	  upload = @@upload_service.upload_file(params['name'], params['file'].tempfile, upload_file_type, params['description'])   
	  redirect_to upload_index_path, notice: 'Image uploaded successfully.'	
	rescue Exception => e
  	  redirect_to upload_index_path, notice: "#{e.message}"
    end
  end
end
