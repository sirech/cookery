module JsonResponse
  extend ActiveSupport::Concern

  def respond_as_json(model)
    respond_to do |format|
      if model.save
        format.json { render json: model, status: 'created' }
      else
        format.json { render json: model.errors, status: :unprocessable_entity }
      end
    end
  end
end
