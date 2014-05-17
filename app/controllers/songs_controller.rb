class SongsController < ApplicationController
  layout "main"
  before_action :is_signed?
  before_action :set_song, only: [:show, :edit, :update, :destroy]
  before_action :set_options, only: [:new, :edit]

  def index
    @songs = Song.all.where("SingerIndex1 != ''").order('SongNumber').page(params[:page])
  end

  def show

  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    respond_to do |format|
      if @song.save
        set_flash 'success', 'Song was successfully created.'
        format.html {redirect_to song }
      else
        format.html {render :new}
      end
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if song.update(song_params)
        set_flash 'success', 'Song was successfully updated.'
        format.html { redirect_to @song }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

  end

  private
  def set_options
    @phylum = Phylum.all
    @taxonomies = Taxonomy.all.where('parent_id is null')
    @licensees = Licensee.all
  end

  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:device).permit(:Album, :Location, :SongNumber, :SongNameT, :NameIndexT, :SongNameC, :NameIndexC, :StrokeC, :SingerIndex1, :SingerIndex2, :Type, :Count, :MyFavorite, :Phylum, :Class, :Group, :Party, :Data, :ExStartTime, :ExAllTime, :LightID, :LogoID, :MV, :Teaching)
  end
end
