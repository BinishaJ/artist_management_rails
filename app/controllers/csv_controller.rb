class CsvController < ApplicationController

  require 'csv'
  authorize_resource :class => false


  # POST /csv
  def import
    begin
      file = params[:file]  # Assuming 'file' is the name of your file input in the form

      if file.nil?
        render json: { error: 'No file attached' }, status: :unprocessable_entity
        return
      end

      # Process the uploaded file
      opened_file = file.tempfile  # Access the uploaded file's temporary file

      options = { headers: true, col_sep: ',' }
      CSV.foreach(opened_file, **options).with_index do |row, index|
        artist_hash = {
          name: row['Name'],
          dob: row['DOB'],
          gender: row['Gender'],
          address: row['Address'],
          first_release_year: row['First Release Year'],
          no_of_albums_released: row['No of Albums Released']
        }

        @artist = Artist.new(artist_hash)

        unless @artist.save
          render json: { error: @artist.errors.full_messages }, status: :unprocessable_entity
          return
        end
      end

      render json: { data: "Artists imported successfully" }, status: :ok
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  # GET /csv
  def export
    @artists = Artist.all

    # attributes = %w{Name DOB Gender Address First\ Release\ Year No\ of\ Albums\ Released}
    #
    # csv_data = CSV.generate(headers: true) do |csv|
    #   csv << attributes
    #
    #   @artists.each do |artist|
    #     csv << attributes.map{ |attr| artist.send(attr.downcase.gsub(" ", "_")) }
    #   end
    #
    # end

    # puts "CSV ========> #{csv_data}\n"
    #
    # send_data csv_data, filename: "test.csv"

    respond_to do |format|
      format.html
      format.csv do
        # response.headers['Content-Disposition'] = 'attachment; filename=artists.csv'
        send_data @artists.to_csv, filename: "artists.csv"
      end
    end
    #
    # send_data csv_data


    # response.headers["Content-Type"] = "text/csv; charset=UTF-8; header=present"
    # response.headers["Content-Disposition"] = "attachment; filename=artists.csv"
    # send_data csv_data, filename: "artists.csv", disposition: :attachment

  end
end