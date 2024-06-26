require "test_helper"

class MusicsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @music = musics(:one)
  end

  test "should get index" do
    get musics_url, as: :json
    assert_response :success
  end

  test "should create music" do
    assert_difference("Music.count") do
      post musics_url, params: { music: { album_name: @music.album_name, artist_id: @music.artist_id, genre: @music.genre, title: @music.title } }, as: :json
    end

    assert_response :created
  end

  test "should show music" do
    get music_url(@music), as: :json
    assert_response :success
  end

  test "should update music" do
    patch music_url(@music), params: { music: { album_name: @music.album_name, artist_id: @music.artist_id, genre: @music.genre, title: @music.title } }, as: :json
    assert_response :success
  end

  test "should destroy music" do
    assert_difference("Music.count", -1) do
      delete music_url(@music), as: :json
    end

    assert_response :no_content
  end
end
