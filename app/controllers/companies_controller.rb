class CompaniesController < ApplicationController
  before_action :set_company, except: [:index, :create, :new]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def show
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path, notice: "Saved"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to companies_path, notice: "Changes Saved"
    else
      render :edit
    end
  end

  def destroy
    company_name = @company.name
    if @company.destroy
      flash[:notice] = "The company #{company_name} has been destroyed successfully."
    else
      flash[:alert] = "The company  #{company_name}  has not been destroyed."
    end

    redirect_to companies_path
  end

  private

  def company_params
    params.require(:company).permit(
      :name,
      :legal_name,
      :description,
      :zip_code,
      :brand_color,
      :phone,
      :email,
      :owner_id,
      services: []
    )
  end

  def set_company
    @company = Company.find(params[:id])
  end

end
