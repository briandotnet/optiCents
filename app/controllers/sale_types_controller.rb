class SaleTypesController < ApplicationController
  # GET /sale_types
  # GET /sale_types.xml
  def index
    @sale_types = SaleType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sale_types }
      format.json  { render :json => @sale_types }
    end
  end

  # GET /sale_types/1
  # GET /sale_types/1.xml
  def show
    @sale_type = SaleType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sale_type }
      format.json  { render :json => @sale_type }
    end
  end

  # GET /sale_types/new
  # GET /sale_types/new.xml
  def new
    @sale_type = SaleType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sale_type }
    end
  end

  # GET /sale_types/1/edit
  def edit
    @sale_type = SaleType.find(params[:id])
  end

  # POST /sale_types
  # POST /sale_types.xml
  def create
    @sale_type = SaleType.new(params[:sale_type])

    respond_to do |format|
      if @sale_type.save
        format.html { redirect_to(@sale_type, :notice => 'Sale type was successfully created.') }
        format.xml  { render :xml => @sale_type, :status => :created, :location => @sale_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sale_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sale_types/1
  # PUT /sale_types/1.xml
  def update
    @sale_type = SaleType.find(params[:id])

    respond_to do |format|
      if @sale_type.update_attributes(params[:sale_type])
        format.html { redirect_to(@sale_type, :notice => 'Sale type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sale_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sale_types/1
  # DELETE /sale_types/1.xml
  def destroy
    @sale_type = SaleType.find(params[:id])
    @sale_type.destroy

    respond_to do |format|
      format.html { redirect_to(sale_types_url) }
      format.xml  { head :ok }
    end
  end
end
