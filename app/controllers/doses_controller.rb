class DosesController < ApplicationController
  before_action :find_dose, only: [:destroy]
  before_action :find_cocktail, only: [ :create]

  def create
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to @cocktail, notice: 'Dose was successfully created.'
    else
      render 'show'
    end
  end

  def destroy
    dose = @dose
    dose.destroy
    redirect_to cocktail_path(dose.cocktail)
  end

  private

  def find_dose
    @dose = Dose.find(params[:id])
  end

  def find_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end

end
