
class HomeController < ApplicationController

  # respond to index request for all items list
  def index
    @items = items
    respond_to do |format|
      format.html # render index.html.erb
    end
  end
  
  # respond to item request
  def item
    if params[:id] == nil and params[:itemNumber] != nil then
      params[:id] = params[:itemNumber]
    end
    
    if params[:oauth_token] then # handles call back from dropbox
      logger.debug "handle call back"
      dropbox_session = Dropbox::Session.deserialize(session[:dropbox_session])
      begin 
        if !dropbox_session.authorized? then 
          dropbox_session.authorize(params)
        end
      rescue
        # can't authorize, probably expired token, redirect to login
        redirect_to dropbox_session.authorize_url(:oauth_callback => url_for(:controller => 'home', :action => 'item'))
      end
      session[:dropbox_session] = dropbox_session.serialize # re-serialize the authenticated dropbox_session 
    else
      if session[:dropbox_session].nil? then # user landed with no previous dropbox_session
        logger.debug "no previous session available"
        app_key = "tcu08l85y39ybxd" #DROPBOX_CONFIG['app_key']
        app_secret = "3daxhdk2813pcng" #DROPBOX_CONFIG['app_secret']
        # create a new dropbox_session and save in session variable
        dropbox_session = Dropbox::Session.new(app_key, app_secret)
        session[:dropbox_session] = dropbox_session.serialize

        redirect_to dropbox_session.authorize_url(:oauth_callback => url_for(:controller => 'home', :action => 'item'))
      else # user landed with previous dropbox_session
        logger.debug "use previous session"
        dropbox_session = Dropbox::Session.deserialize(session[:dropbox_session])
        dropbox_session.mode = :dropbox
        
        if !dropbox_session.authorized? then 
          # dropbox_session is not authorized
          logger.debug "redirect to dropbox oauth page"
          redirect_to dropbox_session.authorize_url(:oauth_callback => url_for(:controller => 'home', :action => 'item'))
        else 
          begin
            file_contents = dropbox_session.download('/public/%s/details.xml' % params[:id])
            logger.debug "DETAILS.XML: %s" % file_contents
            str = "%s" % file_contents
            str = str.gsub(/\r/, "")
            str = str.gsub(/\n/, "")
          
            str.scan (/\<key\>comments\<\/key\>\s+\<string\>(.*?)\<\/string\>/) {
              params[:comments] = "#{$1}"
            }
            str.scan (/\<key\>productMaterial\<\/key\>\s+\<string\>(.*?)\<\/string\>/) {
              params[:product_materials] = "#{$1}"
            }
            str.scan (/\<key\>done\<\/key\>\s+\<string\>(.*?)\<\/string\>/) {
              params[:done] = false
              if "#{$1}" == "true" then
                params[:done] = true
              end
            }
          rescue
            params[:comments] = ""
            params[:product_materials] = ""
            params[:done] = false
          end
        end
      end
    end
    if params[:id] then
      @id=params[:id]
    end
    #render item.html.erb
  end

  # respond to request to get item details
  def details
    if session[:dropbox_session].nil? then
      logger.debug 'no previous session available'
      return redirect_to(:controller => 'home', :action => 'item')
    else
      logger.debug 'previous session found'
      dropbox_session = Dropbox::Session.deserialize(session[:dropbox_session])
      dropbox_session.mode = :dropbox
      
      if dropbox_session.authorized? then        
        if params[:n].nil? then
          logger.debug 'Requesting details with no parameters!!!!!'
        else
          details = dropbox_session.download('/public/%s/details.xml' % params[:n])
          logger.debug "DETAILS.XML: %s" % details
          
        end
        # this line throw error on heroku but not in localhost
        # logger.error $!, $!.backtrace
      end
    end
  end
  

  
  # respond to json request for photo paths
  def photos
    if session[:dropbox_session].nil? then
      logger.debug 'no previous session available'
      return redirect_to(:controller => 'home', :action => 'item')
    else
      logger.debug 'previous session found'
      dropbox_session = Dropbox::Session.deserialize(session[:dropbox_session])
      dropbox_session.mode = :dropbox
              
      if dropbox_session.authorized? then
        photos = Array.new

        begin
            if params[:n].nil? then
                logger.debug 'Requesting Photos with no parameters!!!!!'
            else
                metadata = dropbox_session.list('/public/%s' % params[:n])
                # photoStruct = Struct.new(:path, :width, :height)
                metadata.each do |photo|
                  #logger.debug photo.inspect
                if photo['mime_type'] == "image/png" then
                  path = photo['path']
                  path['/Public'] = 'http://dl.dropbox.com/u/8319978'
                  # width = photo['width']
                  # height = photo['height']
                  logger.debug "path is now: %s" % path
                  photos.push path
                end
            end
          end
        rescue
          # this line throw error on heroku but not in localhost
          # logger.error $!, $!.backtrace
        end
      end
    end

    respond_to do |format|
      format.json { render :json => photos.to_json }
    end
  end
  
  def save 
    if session[:dropbox_session].nil? then
      logger.debug 'no previous session available'
      return redirect_to(:controller => 'home', :action => 'item')
      else
      logger.debug 'previous session found'
      dropbox_session = Dropbox::Session.deserialize(session[:dropbox_session])
      dropbox_session.mode = :dropbox
      
      if dropbox_session.authorized? then
        if params[:id] then
          begin
            @file = Tempfile.new('%s' % params[:id])
            begin
              done = false
              if params[:done] == "yes" then
                done = true
              end
              @contents = <<-EOF
              <?xml version="1.0" encoding="UTF-8"?>
              <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
              <plist version="1.0">
              <dict>
              <key>comments</key>
              <string>#{params[:comments]}</string>
              
              <key>productMaterial</key>
              <string>#{params[:product_materials]}</string>
              
              <key>done</key>
              <string>#{done}</string>
              </dict>
              </plist>
              EOF
              logger.debug "CONTENTS OF NEW DETAILS.XML: %s" % @contents
              @file.print @contents
              @file.flush
              
              dropbox_session.delete('/public/%s/details.xml' % params[:id])
              logger.debug "TEMPORARY FILE PATH: %s" % @file.path
              dropbox_session.upload("%s" % @file.path, '/public/%s/' % params[:id])
              filename = "%s" % @file.path
              filename = filename.gsub(/^.*\//,"")
              logger.debug "TEMPORARY FILE NAME: %s" % filename
              dropbox_session.rename('/public/%s/%s' % [params[:id], filename], 'details.xml')
            ensure
              @file.close
              @file.unlink   # deletes the temp file
            end
            
            redirect_to url_for(:controller=>'home', :action => 'index')
          rescue
            logger.error $!, $!.backtrace
          end
        end
      end
    end
  end
  
  def delete 
    if session[:dropbox_session].nil? then
      logger.debug 'no previous session available'
      return redirect_to(:controller => 'home', :action => 'item')
    else
      logger.debug 'previous session found'
      dropbox_session = Dropbox::Session.deserialize(session[:dropbox_session])
      dropbox_session.mode = :dropbox
              
      if dropbox_session.authorized? then
        if params[:id] then
          begin
            logger.debug params[:id]
            item = dropbox_session.file('/public/%s' % params[:id])
            item.move('/public/archive/')
            redirect_to url_for(:controller=>'home', :action => 'index')
          rescue
            logger.error $!, $!.backtrace
          end
        end
      end
    end
  end
  
  def items 
    if session[:dropbox_session].nil? then
      logger.debug 'no previous session available'
      redirect_to(:controller => 'home', :action => 'item') and return
    else
      logger.debug 'previous session found'
      dropbox_session = Dropbox::Session.deserialize(session[:dropbox_session])
      dropbox_session.mode = :dropbox
              
      if dropbox_session.authorized? then
        item_numbers = Array.new

        begin
          metadata = dropbox_session.list('/public/')
            Struct.new("Item", :done, :number, :date)
          metadata.each do |item|
            # logger.debug item.inspect
            logger.debug item            
            
            number = item['path']
            number['/Public/'] = ''# url_for(:controller => 'home', :action => 'index')
            date = item['modified']
            
            #xml = File.read('http://dl.dropbox.com/u/8319978/%s' % number)
            logger.debug 'XML DETAIL FILE LOCATION: http://dl.dropbox.com/u/8319978/%s/details.xml' % number 
            #logger.debug 'READ XML DETAIL FILE: %s' % xml
            
            if(number.casecmp("archive") != 0 ) then
              item_numbers.push Struct::Item.new(false, number, date.strftime("%b %d, %Y"))
            end
          end
            logger.debug item_numbers.inspect
          return item_numbers
        rescue
          logger.error $!, $!.backtrace
        end
      end
    end
  end
  
end
