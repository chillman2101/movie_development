class ProducerController < ApplicationController
  def index
  end
  def get_dataproducer
   @producer = Producer.all
   render :json => @producer.to_json  
  end
  def new 
  end
  def create
    @producer = Producer.new(producer_params)
    if @producer.save
      redirect_to producer_path, notice: 'Successfully add Producer'
    else
      redirect_to add_producer_path, notice: "Invalid Format #{@producer.errors.full_messages.to_sentence}"
    end
  end

  def edit
    @producer = Producer.find(params[:id])
  end

  def update
    @producer = Producer.find(params[:id])
    # logger.debug "Log Film: #{@film.inspect}"
    if @producer.update(producer_params_edit)
      logger.debug "Log Film: #{producer_params_edit.inspect}"
      redirect_to producer_path, notice: 'Successfully Edit Producer'
    else
      redirect_to edit_producer_path, notice: "Invalid Format #{@producer.errors.full_messages.to_sentence}"
    end
  end

  # def destroy
  #   @producer = Producer.find(params[:id])
  #   if @producer.destroy
  #     redirect_to producer_path, notice: "Producer '#{@producer.name}' has been destroyed"
  #   else
  #     redirect_to edit_producer_path, notice: "Invalid Format #{@producer.errors.full_messages.to_sentence}"
  #   end
  # end

  private
  def producer_params
    # strong parameters
    params.permit(:name,:born)
  end
  def producer_params_edit
    # strong parameters
    params.require(:producer).permit(:name,:born)
  end
end
