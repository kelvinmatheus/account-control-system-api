module API
  module V1
    class JuridicalPeopleController < ApplicationController
      before_action :set_juridical_person, only: [:show, :update, :destroy]

      # GET /juridical_people
      def index
        @juridical_people = JuridicalPerson.all

        render json: @juridical_people, status: 200
      end

      # GET /juridical_people/1
      def show
        render json: @juridical_person, status: 200
      end

      # POST /juridical_people
      def create
        @juridical_person = JuridicalPerson.new(juridical_person_params)

        if @juridical_person.save
          render json: @juridical_person, status: 204, location: api_v1_juridical_person_url(@juridical_person)
        else
          render json: @juridical_person.errors, status: 422
        end
      end

      # PATCH/PUT /juridical_people/1
      def update
        if @juridical_person.update(juridical_person_params)
          render json: @juridical_person, status: 200
        else
          render json: @juridical_person.errors, status: 422
        end
      end

      # DELETE /juridical_people/1
      def destroy
        @juridical_person.destroy

        head 204
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_juridical_person
        @juridical_person = JuridicalPerson.find(params[:id])

        rescue
          head 404
      end

      # Only allow a trusted parameter "white list" through.
      def juridical_person_params
        params.require(:juridical_person).permit(:cnpj, :company_name, :fantasy_name)
      end
    end

  end
end