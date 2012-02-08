class FlyersController < ApplicationController
  # GET /flyers
  # GET /flyers.xml
  def index
    @flyers = Flyer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @flyers }
    end
  end

  # GET /flyers/1
  # GET /flyers/1.xml
  def show
    @flyer = Flyer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @flyer }
    end
  end

  # GET /flyers/new
  # GET /flyers/new.xml
  def new
    @flyer = Flyer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @flyer }
    end
  end

  # GET /flyers/1/edit
  def edit
    @flyer = Flyer.find(params[:id])
  end

  # POST /flyers
  # POST /flyers.xml
  def create
    @flyer = Flyer.new(params[:flyer])

    respond_to do |format|
      if @flyer.save
        format.html { redirect_to(@flyer, :notice => 'Flyer was successfully created.') }
        format.xml  { render :xml => @flyer, :status => :created, :location => @flyer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @flyer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /flyers/1
  # PUT /flyers/1.xml
  def update
    @flyer = Flyer.find(params[:id])

    respond_to do |format|
      if @flyer.update_attributes(params[:flyer])
        format.html { redirect_to(@flyer, :notice => 'Flyer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @flyer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /flyers/1
  # DELETE /flyers/1.xml
  def destroy
    @flyer = Flyer.find(params[:id])
    @flyer.destroy

    respond_to do |format|
      format.html { redirect_to(flyers_url) }
      format.xml  { head :ok }
    end
  end
end
