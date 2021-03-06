defmodule Audiophile.FileParser do
  def extract_tags_from_mp3(filename) do
    case File.read(filename) do
      {:ok, mp3} ->
        try do
          mp3_byte_size = byte_size(mp3) - 128

          << _ :: binary-size(mp3_byte_size), id3_tag :: binary >> = mp3
          << _tag      :: binary-size(3),
             _title    :: binary-size(30),
             artist    :: binary-size(30),
             _album    :: binary-size(30),
             year      :: binary-size(4),
             _comment  :: binary-size(28),
             _reserved :: binary-size(1),
             _track    :: binary-size(1),
             genre     :: binary-size(1) >> = id3_tag

          {:ok, %{ genre: genre_id_to_name(genre), artist: pretty_print(artist), year: pretty_print(year) }}
        catch
          _ -> {:error, {filename, :invalid_id3_tag}}
        end

      _ ->
        {:error, {filename, :cannot_open_file}}
    end
  end

  defp pretty_print(raw) do
    String.codepoints(raw)
    |> Enum.filter(&String.valid?/1)
    |> Enum.filter(fn(codepoint) -> codepoint != <<0>> end)
    |> Enum.join("")
    |> String.trim()
  end

  defp genre_id_to_name(<<0>>), do: "Blues"
  defp genre_id_to_name(<<1>>), do: "Classic Rock"
  defp genre_id_to_name(<<2>>), do: "Country"
  defp genre_id_to_name(<<3>>), do: "Dance"
  defp genre_id_to_name(<<4>>), do: "Disco"
  defp genre_id_to_name(<<5>>), do: "Funk"
  defp genre_id_to_name(<<6>>), do: "Grunge"
  defp genre_id_to_name(<<7>>), do: "Hip-Hop"
  defp genre_id_to_name(<<8>>), do: "Jazz"
  defp genre_id_to_name(<<9>>), do: "Metal"
  defp genre_id_to_name(<<10>>), do: "New Age"
  defp genre_id_to_name(<<11>>), do: "Oldies"
  defp genre_id_to_name(<<12>>), do: "Other"
  defp genre_id_to_name(<<13>>), do: "Pop"
  defp genre_id_to_name(<<14>>), do: "R&B"
  defp genre_id_to_name(<<15>>), do: "Rap"
  defp genre_id_to_name(<<16>>), do: "Reggae"
  defp genre_id_to_name(<<17>>), do: "Rock"
  defp genre_id_to_name(<<18>>), do: "Techno"
  defp genre_id_to_name(<<19>>), do: "Industrial"
  defp genre_id_to_name(<<20>>), do: "Alternative"
  defp genre_id_to_name(<<21>>), do: "Ska"
  defp genre_id_to_name(<<22>>), do: "Death Metal"
  defp genre_id_to_name(<<23>>), do: "Pranks"
  defp genre_id_to_name(<<24>>), do: "Soundtrack"
  defp genre_id_to_name(<<25>>), do: "Euro-Techno"
  defp genre_id_to_name(<<26>>), do: "Ambient"
  defp genre_id_to_name(<<27>>), do: "Trip-Hop"
  defp genre_id_to_name(<<28>>), do: "Vocal"
  defp genre_id_to_name(<<29>>), do: "Jazz+Funk"
  defp genre_id_to_name(<<30>>), do: "Fusion"
  defp genre_id_to_name(<<31>>), do: "Trance"
  defp genre_id_to_name(<<32>>), do: "Classical"
  defp genre_id_to_name(<<33>>), do: "Instrumental"
  defp genre_id_to_name(<<34>>), do: "Acid"
  defp genre_id_to_name(<<35>>), do: "House"
  defp genre_id_to_name(<<36>>), do: "Game"
  defp genre_id_to_name(<<37>>), do: "Sound Clip"
  defp genre_id_to_name(<<38>>), do: "Gospel"
  defp genre_id_to_name(<<39>>), do: "Noise"
  defp genre_id_to_name(<<40>>), do: "Alternative Rock"
  defp genre_id_to_name(<<41>>), do: "Bass"
  defp genre_id_to_name(<<42>>), do: "Soul"
  defp genre_id_to_name(<<43>>), do: "Punk"
  defp genre_id_to_name(<<44>>), do: "Space"
  defp genre_id_to_name(<<45>>), do: "Meditative"
  defp genre_id_to_name(<<46>>), do: "Instrumental Pop"
  defp genre_id_to_name(<<47>>), do: "Instrumental Rock"
  defp genre_id_to_name(<<48>>), do: "Ethnic"
  defp genre_id_to_name(<<49>>), do: "Gothic"
  defp genre_id_to_name(<<50>>), do: "Darkwave"
  defp genre_id_to_name(<<51>>), do: "Techno-Industrial"
  defp genre_id_to_name(<<52>>), do: "Electronic"
  defp genre_id_to_name(<<53>>), do: "Pop-Folk"
  defp genre_id_to_name(<<54>>), do: "Eurodance"
  defp genre_id_to_name(<<55>>), do: "Dream"
  defp genre_id_to_name(<<56>>), do: "Southern Rock"
  defp genre_id_to_name(<<57>>), do: "Comedy"
  defp genre_id_to_name(<<58>>), do: "Cult"
  defp genre_id_to_name(<<59>>), do: "Gangsta"
  defp genre_id_to_name(<<60>>), do: "Top 40"
  defp genre_id_to_name(<<61>>), do: "Christian Rap"
  defp genre_id_to_name(<<62>>), do: "Pop/Funk"
  defp genre_id_to_name(<<63>>), do: "Jungle"
  defp genre_id_to_name(<<64>>), do: "Native US"
  defp genre_id_to_name(<<65>>), do: "Cabaret"
  defp genre_id_to_name(<<66>>), do: "New Wave"
  defp genre_id_to_name(<<67>>), do: "Psychadelic"
  defp genre_id_to_name(<<68>>), do: "Rave"
  defp genre_id_to_name(<<69>>), do: "Showtunes"
  defp genre_id_to_name(<<70>>), do: "Trailer"
  defp genre_id_to_name(<<71>>), do: "Lo-Fi"
  defp genre_id_to_name(<<72>>), do: "Tribal"
  defp genre_id_to_name(<<73>>), do: "Acid Punk"
  defp genre_id_to_name(<<74>>), do: "Acid Jazz"
  defp genre_id_to_name(<<75>>), do: "Polka"
  defp genre_id_to_name(<<76>>), do: "Retro"
  defp genre_id_to_name(<<77>>), do: "Musical"
  defp genre_id_to_name(<<78>>), do: "Rock & Roll"
  defp genre_id_to_name(<<79>>), do: "Hard Rock"
  defp genre_id_to_name(<<80>>), do: "Folk"
  defp genre_id_to_name(<<81>>), do: "Folk-Rock"
  defp genre_id_to_name(<<82>>), do: "National Folk"
  defp genre_id_to_name(<<83>>), do: "Swing"
  defp genre_id_to_name(<<84>>), do: "Fast Fusion"
  defp genre_id_to_name(<<85>>), do: "Bebob"
  defp genre_id_to_name(<<86>>), do: "Latin"
  defp genre_id_to_name(<<87>>), do: "Revival"
  defp genre_id_to_name(<<88>>), do: "Celtic"
  defp genre_id_to_name(<<89>>), do: "Bluegrass"
  defp genre_id_to_name(<<90>>), do: "Avantgarde"
  defp genre_id_to_name(<<91>>), do: "Gothic Rock"
  defp genre_id_to_name(<<92>>), do: "Progressive Rock"
  defp genre_id_to_name(<<93>>), do: "Psychedelic Rock"
  defp genre_id_to_name(<<94>>), do: "Symphonic Rock"
  defp genre_id_to_name(<<95>>), do: "Slow Rock"
  defp genre_id_to_name(<<96>>), do: "Big Band"
  defp genre_id_to_name(<<97>>), do: "Chorus"
  defp genre_id_to_name(<<98>>), do: "Easy Listening"
  defp genre_id_to_name(<<99>>), do: "Acoustic"
  defp genre_id_to_name(<<100>>), do: "Humour"
  defp genre_id_to_name(<<101>>), do: "Speech"
  defp genre_id_to_name(<<102>>), do: "Chanson"
  defp genre_id_to_name(<<103>>), do: "Opera"
  defp genre_id_to_name(<<104>>), do: "Chamber Music"
  defp genre_id_to_name(<<105>>), do: "Sonata"
  defp genre_id_to_name(<<106>>), do: "Symphony"
  defp genre_id_to_name(<<107>>), do: "Booty Bass"
  defp genre_id_to_name(<<108>>), do: "Primus"
  defp genre_id_to_name(<<109>>), do: "Porn Groove"
  defp genre_id_to_name(<<110>>), do: "Satire"
  defp genre_id_to_name(<<111>>), do: "Slow Jam"
  defp genre_id_to_name(<<112>>), do: "Club"
  defp genre_id_to_name(<<113>>), do: "Tango"
  defp genre_id_to_name(<<114>>), do: "Samba"
  defp genre_id_to_name(<<115>>), do: "Folklore"
  defp genre_id_to_name(<<116>>), do: "Ballad"
  defp genre_id_to_name(<<117>>), do: "Power Ballad"
  defp genre_id_to_name(<<118>>), do: "Rhytmic Soul"
  defp genre_id_to_name(<<119>>), do: "Freestyle"
  defp genre_id_to_name(<<120>>), do: "Duet"
  defp genre_id_to_name(<<121>>), do: "Punk Rock"
  defp genre_id_to_name(<<122>>), do: "Drum Solo"
  defp genre_id_to_name(<<123>>), do: "Acapella"
  defp genre_id_to_name(<<124>>), do: "Euro-House"
  defp genre_id_to_name(<<125>>), do: "Dance Hall"
  defp genre_id_to_name(<<126>>), do: "Goa"
  defp genre_id_to_name(<<127>>), do: "Drum & Bass"
  defp genre_id_to_name(<<128>>), do: "Club-House"
  defp genre_id_to_name(<<129>>), do: "Hardcore"
  defp genre_id_to_name(<<130>>), do: "Terror"
  defp genre_id_to_name(<<131>>), do: "Indie"
  defp genre_id_to_name(<<132>>), do: "BritPop"
  defp genre_id_to_name(<<133>>), do: "Negerpunk"
  defp genre_id_to_name(<<134>>), do: "Polsk Punk"
  defp genre_id_to_name(<<135>>), do: "Beat"
  defp genre_id_to_name(<<136>>), do: "Christian Gangsta"
  defp genre_id_to_name(<<137>>), do: "Heavy Metal"
  defp genre_id_to_name(<<138>>), do: "Black Metal"
  defp genre_id_to_name(<<139>>), do: "Crossover"
  defp genre_id_to_name(<<140>>), do: "Contemporary C"
  defp genre_id_to_name(<<141>>), do: "Christian Rock"
  defp genre_id_to_name(<<142>>), do: "Merengue"
  defp genre_id_to_name(<<143>>), do: "Salsa"
  defp genre_id_to_name(<<144>>), do: "Thrash Metal"
  defp genre_id_to_name(<<145>>), do: "Anime"
  defp genre_id_to_name(<<146>>), do: "JPop"
  defp genre_id_to_name(<<147>>), do: "SynthPop"
  defp genre_id_to_name(_),       do: "Unknown Genre"
end