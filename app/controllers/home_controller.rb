class HomeController < ApplicationController
  # responde to GET
  def index
      if params[:oauth_token] then # handles call back from dropbox
        logger.debug "handle call back"
        dropbox_session = Dropbox::Session.deserialize(session[:dropbox_session])
        dropbox_session.authorize(params)
        session[:dropbox_session] = dropbox_session.serialize # re-serialize the authenticated dropbox_session 
      else
        if session[:dropbox_session].nil? then # user landed with no previous dropbox_session
          logger.debug "no previous session available"
          app_key = DROPBOX_CONFIG['app_key']
          app_secret = DROPBOX_CONFIG['app_secret']
          # create a new dropbox_session and save in session variable
          dropbox_session = Dropbox::Session.new(app_key, app_secret)
          session[:dropbox_session] = dropbox_session.serialize

          redirect_to dropbox_session.authorize_url(:oauth_callback => url_for(:controller => 'home', :action => 'index'))
        else # user landed with previous dropbox_session
          logger.debug "use previous session"
          dropbox_session = Dropbox::Session.deserialize(session[:dropbox_session])
          if !dropbox_session.authorized? then 
            # dropbox_session is not authorized
            logger.debug "redirect to dropbox oauth page"
            redirect_to dropbox_session.authorize_url(:oauth_callback => url_for(:controller => 'home', :action => 'index'))
          end
        end
      end
    end
  
    def photos
      if session[:dropbox_session].nil? then
        logger.debug 'no previous session available'
        return redirect_to(:controller => 'home', :action => 'index')
      else
        logger.debug 'previous session found'
        dropbox_session = Dropbox::Session.deserialize(session[:dropbox_session])
        dropbox_session.mode = :dropbox
              
        if dropbox_session.authorized? then
          
          @photos = Array.new
          @itemNum = params[:item_number]
          begin
          metadata = dropbox_session.list('/public/%s' % @itemNum)
          
          metadata.each do |photo|
            path = photo['path']
            path['/Public'] = 'http://dl.dropbox.com/u/8319978'
            @photos.push path
          end
          rescue
            
          end
        end
      end
      
      respond_to do |format|
        format.json { render :json => @photos.to_json }
      end
    end
    
end
