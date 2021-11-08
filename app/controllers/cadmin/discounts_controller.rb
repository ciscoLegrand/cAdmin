require_dependency "cadmin/application_controller"

module Cadmin
  class DiscountsController < ApplicationController
    before_action :set_discount, only: [:show, :edit, :update, :destroy]
    add_breadcrumb 'Descuentos', :discounts_path
    
    # GET /discounts
    def index
      @discounts = Discount.all
    end

    # GET /discounts/1
    def show
    end

    # GET /discounts/new
    def new
      add_breadcrumb 'Nuevo Descuento'
      @discount = Discount.new
    end

    # GET /discounts/1/edit
    def edit     
      add_breadcrumb 'Editar Descuento'
    end

    # POST /discounts
    def create
      @discount = Discount.new(discount_params)

      if @discount.save
        redirect_to @discount, notice: t('.success')
      else
        render :new
      end
    end

    # PATCH/PUT /discounts/1
    def update
      if @discount.update(discount_params)
        redirect_to @discount, notice: t('.success')
        render :edit
      end
    end

    # DELETE /discounts/1
    def destroy
      @discount.destroy
      redirect_to discounts_url, notice: 'Discount was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_discount
        @discount = Discount.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def discount_params
        params.require(:discount).permit(:name, :type_discount, :description, :percentage,:start_date,:end_date, :amount, :observations)
      end
  end
end
