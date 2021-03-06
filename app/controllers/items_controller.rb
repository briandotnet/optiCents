class ItemsController < ApplicationController
  # GET /items
  # GET /items.xml
  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
      format.json  { render :json => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
      format.json  { render :json => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to(@item, :notice => 'Item was successfully created.') }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to(@item, :notice => 'Item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end
  
  def find
    name = params.has_key?('name') ?  "name LIKE '%" + params['name'] + "%'" : ""
    category = params.has_key?('category') ?  "category = '" + params['category'] + "'" : ""
    brand = params.has_key?('brand') ?  "brand LIKE '%" + params['brand'] + "%'" : ""
    conditions = Array[] 
    if name != ""
      conditions.push(name)
    end
    if category != ""
      conditions.push(category)
    end
    if brand != ""
      conditions.push(brand)
    end
    # if conditions.count > 0
      @items = Item.all(:limit => 100, :conditions => conditions.join(' AND '))
    # else
      # @items = Array[]
    # end
    respond_to do |format|
      format.json  { render :json => @items }
    end
  end
  
  def category
    @categories = Item.find_by_sql(["SELECT DISTINCT(category) FROM items"])
    respond_to do |format|
      format.json  { render :json => @categories }
    end
  end
end
