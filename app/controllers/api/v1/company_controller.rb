class Api::V1::CompanyController < Api::ApiController
  before_action :current_user

  def index
    @companies = Company.all
    if @companies.present?
      user = []
      @companies.each do |data|
        debugger
        user.push(data.attributes.merge(users_details: data))
      end
      render json:{company: user }
    end
  end

  def create
    @company=current_user.build_company(company_params)
     if @company.save
       render json:{status:"success",message:"loaded company",data:@company},status:  :ok
     else
       render json:{status:"failed",message:"company not save", data:@company.errors},status:  :unprocessable_entity
     end
  end

  def update
   @company=Company.find(params[:id])
    if @company.update(company_params)
      render json:{status:"success",message:"loaded company",data:@company},status:  :ok
    else
      render json:{status:"failed",message:"company not save", data:@company.errors},status:  :unprocessable_entity
    end
  end

  def show
    @company = Company.find(params[:id])
    render json:{success: "success", data: @company }
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    render json: { status: "success", message: "loaded company", data: @company },status:  :ok   
  end

  private
    def company_params
      params.permit(:name, :salary, :address, :user_id)
    end

    def current_user
      if params[:auth_token].present?
        @current_user ||= User.find_by_auth_token(params[:auth_token])
      else
        render json:{ status: "failed",  message: "failed"} 
      end
    end
end
