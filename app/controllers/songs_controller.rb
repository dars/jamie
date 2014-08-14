class SongsController < ApplicationController
  layout "main"
  before_action :is_signed?
  before_action :check_role
  before_action :set_song, only: [:show, :edit, :update, :destroy]
  before_action :set_options, only: [:new, :edit]

  def index
    if(params)
      @songs = Song.all
      if(params[:name])
        @songs = @songs.where("SongNameT Like '%"+params[:name]+"%'")
      end
      if(params[:number].to_i > 0)
        @songs = @songs.select('id, SongNumber, SongNameT, SingerIndex1, SingerIndex2, Phylum').where('substring(Conv(SongNumber, 10, 16), 12)=?', params[:number])
      end
      if(params[:singer])
        @singer = Singer.where("SingerNameT=?", params[:singer]).first
        if(@singer)
          @songs = @songs.where("SingerIndex1=?", @singer.ID)
        end
      end
      @songs = @songs.where("SingerIndex1 != ''").order('SongNumber').page(params[:page])
    else
      @songs = Song.all.where("SingerIndex1 != ''").order('SongNumber').page(params[:page])
    end
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
        format.html {redirect_to song, :notice => 'Song was successfully created.' }
      else
        format.html {render :new}
      end
    end
  end

  def edit
     @party = Taxonomy.where('parent_id=?', @song.Groups)
  end

  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, :notice => 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

  end

  def getParty
    @items = Taxonomy.where('parent_id='+params[:groups]).order('identity')
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
    params.require(:song).permit(:Album, :Location, :SongNumber, :SongNameT, :NameIndexT, :SongNameC, :NameIndexC, :StrokeC, :SingerIndex1, :SingerIndex2, :Type, :Count, :MyFavorite, :Phylum, :Class, :Groups, :Party, :Data, :ExStartTime, :ExAllTime, :LightID, :LogoID, :MV, :Teaching, :licensee_id)
  end
end
