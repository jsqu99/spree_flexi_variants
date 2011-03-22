class Admin::CustomizationTypesController < Admin::BaseController
  # GET /admin/customization_types
  def index
    @customization_types = CustomizationType.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /admin/customization_types/1
  def show
    @customization_type = CustomizationType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /admin/customization_types/new
  def new
    @customization_type = CustomizationType.new

    respond_to do |format|
      format.html {render :action => :new, :layout => !request.xhr?}
    end
  end

  # GET /admin/customization_types/1/edit
  def edit
    @customization_type = CustomizationType.find(params[:id])
  end

  # POST /admin/customization_types
  def create
    @customization_type = CustomizationType.new(params[:customization_type])

    respond_to do |format|
      if @customization_type.save
        format.html { redirect_to(edit_admin_customization_type_url(@customization_type)) }  
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /admin/customization_types/1
  def update
    @customization_type = CustomizationType.find(params[:id])

    respond_to do |format|
      if @customization_type.update_attributes(params[:customization_type])
        format.html { redirect_to(admin_customization_types_url) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /admin/customization_types/1

  def destroy
    @customization_type = CustomizationType.find(params[:id])
    @customization_type.destroy

    respond_to do |format|
      format.js { render_js_for_destroy }
    end
  end
end
