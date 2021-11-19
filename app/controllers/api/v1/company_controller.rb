class Api::V1::CompanyController < Api::ApiController
  before_action :current_user, except: :show

  def create
    if current_user.present?
    @company=current_user.build_company(company_params)
     if @company.save
       render json:{status:"success",message:"loaded company",data:@company},status:  :ok
     else
       render json:{status:"failed",message:"company not save", data:@company.errors},status:  :unprocessable_entity
     end
   else
     render json:{status:"failed",message:"User not found"}

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
    @companys = Company.all
   if @companys.present?
    user = []
    @companys.each do |data|
      user.push(data.attributes.merge(users_details: data.user))
    end
    render json:{success: true,company:user }
   else
      render json:{Failed: "company not found" }
   end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    render json:{status:"success",message:"loaded company",data:@company},status:  :ok   
  end

  private
  def company_params
    params.permit(:name,:salary,:address)
  end

  def current_user
    token =params[:auth_token]
      if token
        @current_user ||= User.find_by_auth_token(token)
      else
        render json:{ status:"failed",message:"failed"} 
      end
  end
end
