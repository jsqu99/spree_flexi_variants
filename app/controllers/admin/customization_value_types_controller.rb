class Admin::CustomizationValueTypesController  < Admin::BaseController
  # GET /admin/customization_value_types
  def index
    @customization_value_types = CustomizationValueType.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /admin/customization_value_types/1
  def show
    @customization_value_type = CustomizationValueType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /admin/customization_value_types/new
  def new
    @customization_value_type = CustomizationValueType.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /admin/customization_value_types/1/edit
  def edit
    @customization_value_type = CustomizationValueType.find(params[:id])
  end

  # POST /admin/customization_value_types
  def create
    @customization_value_type = CustomizationValueType.new(params[:customization_value_type])

    respond_to do |format|
      if @customization_value_type.save
        format.html { redirect_to(@customization_value_type, :notice => 'Customization value type was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /admin/customization_value_types/1
  def update
    @customization_value_type = CustomizationValueType.find(params[:id])

    respond_to do |format|
      if @customization_value_type.update_attributes(params[:customization_value_type])
        format.html { redirect_to(@customization_value_type, :notice => 'Customization value type was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /admin/customization_value_types/1
  def destroy
    @customization_value_type = CustomizationValueType.find(params[:id])
    @customization_value_type.destroy

    respond_to do |format|
      format.html { redirect_to(customization_value_types_url) }
    end
  end
end
