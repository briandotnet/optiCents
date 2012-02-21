class StoresController < ApplicationController
  include Geokit::Geocoders
  # GET /stores
  # GET /stores.xml
  def index
    @stores = Store.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stores }
      format.json  { render :json => @stores }
    end
  end

  # GET /stores/1
  # GET /stores/1.xml
  def show
    @store = Store.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @store }
      format.json  { render :json => @store }
    end
  end

  # GET /stores/new
  # GET /stores/new.xml
  def new
    @store = Store.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @store }
    end
  end

  # GET /stores/1/edit
  def edit
    @store = Store.find(params[:id])
  end

  # POST /stores
  # POST /stores.xml
  def create
    @store = Store.new(params[:store])

    respond_to do |format|
      if @store.save
        format.html { redirect_to(@store, :notice => 'Store was successfully created.') }
        format.xml  { render :xml => @store, :status => :created, :location => @store }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @store.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stores/1
  # PUT /stores/1.xml
  def update
    @store = Store.find(params[:id])

    respond_to do |format|
      if @store.update_attributes(params[:store])
        format.html { redirect_to(@store, :notice => 'Store was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @store.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.xml
  def destroy
    @store = Store.find(params[:id])
    @store.destroy

    respond_to do |format|
      format.html { redirect_to(stores_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /stores/find
  # GET /stores/find.json
  def find
    # get within
    within = params.has_key?('within') ?  params['within'] : 10
    # get origin
    if params.has_key?('lat') && params.has_key?('lng')
      origin = [params['lat'], params['lng']]
      centre = {:lat => params['lat'], :lng => params['lng']}
    elsif params.has_key?('address')
      origin = params['address']
      
      res=MultiGeocoder.geocode(params['address'])
      if(res.success)
        centre = {:lat=>res.lat,:lng=>res.lng, :address => res.full_address }
      else  
          centre = nil;
      end
      
    elsif params.has_key?('ne_lat') && params.has_key?('ne_lng') && params.has_key?('sw_lat') && params.has_key?('sw_lng')
      ne_point = [params['ne_lat'], params['ne_lng']]
      sw_point = [params['sw_lat'], params['sw_lng']]
      bounds = [sw_point, ne_point];
    else
      raise "you need to specify lat and lng, or address, or bounds"
    end
    if origin != nil 
       begin
        @stores = Store.find(:all, :origin => origin, :within => within, :order=>'distance asc')
       rescue => error
        respond_to do |format|
          format.html{
            return
          }
          format.json{
            render :json => error.inspect# "{\"error\":\""+origin+" is invalid origin\"}"
            return
          }
        end
       end
    else
      @clubs = Club.find :all, :bounds=>bounds
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stores }
      format.json  { render :json => @stores }
    end
  end
end
