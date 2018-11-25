#==============================================================================
# ■ Spriteset_Map
#------------------------------------------------------------------------------
# 處理地圖畫面活動區塊和元件的類別。本類別使用在 Scene_Map 類別的內部。
#==============================================================================

class Spriteset_Map
  #--------------------------------------------------------------------------
  # ● 初始化目標
  #--------------------------------------------------------------------------
  def initialize
    # 製作顯示視口
    @viewport1 = Viewport.new(0, 0, 640, 480)
    @viewport2 = Viewport.new(0, 0, 640, 480)
    @viewport3 = Viewport.new(0, 0, 640, 480)
    @viewport2.z = 0
    @viewport3.z = 5000
    # 製作元件地圖
    @tilemap = Tilemap.new(@viewport1)
    @tilemap.tileset = RPG::Cache.tileset($game_map.tileset_name)
    for i in 0..6
      autotile_name = $game_map.autotile_names[i]
      @tilemap.autotiles[i] = RPG::Cache.autotile(autotile_name)
    end
    @tilemap.map_data = $game_map.data
    @tilemap.priorities = $game_map.priorities
    # 製作遠景平面
    @panorama = Plane.new(@viewport1)
    @panorama.z = -1000
    # 製作迷霧平面
    @fog = Plane.new(@viewport1)
    @fog.z = 3000
    # 製作角色活動區塊
    @character_sprites = []
    for i in $game_map.events.keys.sort
      sprite = Sprite_Character.new(@viewport1, $game_map.events[i])
      @character_sprites.push(sprite)
    end
    @character_sprites.push(Sprite_Character.new(@viewport1, $game_player))
    # 製作天氣
    @weather = RPG::Weather.new(@viewport1)
    # 製作圖片
    @picture_sprites = []
    for i in 1..50
      @picture_sprites.push(Sprite_Picture.new(@viewport2,
        $game_screen.pictures[i]))
    end
    # 製作計時器區塊
    @timer_sprite = Sprite_Timer.new
    # 更新畫面
    update
  end
  #--------------------------------------------------------------------------
  # ● 釋放所佔的記憶體空間
  #--------------------------------------------------------------------------
  def dispose
    # 釋放元件地圖所佔的記憶體空間
    @tilemap.tileset.dispose
    for i in 0..6
      @tilemap.autotiles[i].dispose
    end
    @tilemap.dispose
    # 釋放遠景平面所佔的記憶體空間
    @panorama.dispose
    # 釋放迷霧平面所佔的記憶體空間
    @fog.dispose
    # 釋放角色活動區塊所佔的記憶體空間
    for sprite in @character_sprites
      sprite.dispose
    end
    # 釋放天候所佔的記憶體空間
    @weather.dispose
    # 釋放圖片所佔的記憶體空間
    for sprite in @picture_sprites
      sprite.dispose
    end
    # 釋放計時器區塊所佔的記憶體空間
    @timer_sprite.dispose
    # 釋放顯示視口所佔的記憶體空間
    @viewport1.dispose
    @viewport2.dispose
    @viewport3.dispose
  end
  #--------------------------------------------------------------------------
  # ● 更新畫面
  #--------------------------------------------------------------------------
  def update
    # 遠景與現在的情況有差異發情況下
    if @panorama_name != $game_map.panorama_name or
       @panorama_hue != $game_map.panorama_hue
      @panorama_name = $game_map.panorama_name
      @panorama_hue = $game_map.panorama_hue
      if @panorama.bitmap != nil
        @panorama.bitmap.dispose
        @panorama.bitmap = nil
      end
      if @panorama_name != ""
        @panorama.bitmap = RPG::Cache.panorama(@panorama_name, @panorama_hue)
      end
      Graphics.frame_reset
    end
    # 迷霧與現在的情況有差異的情況下
    if @fog_name != $game_map.fog_name or @fog_hue != $game_map.fog_hue
      @fog_name = $game_map.fog_name
      @fog_hue = $game_map.fog_hue
      if @fog.bitmap != nil
        @fog.bitmap.dispose
        @fog.bitmap = nil
      end
      if @fog_name != ""
        @fog.bitmap = RPG::Cache.fog(@fog_name, @fog_hue)
      end
      Graphics.frame_reset
    end
    # 更新元件地圖
    @tilemap.ox = $game_map.display_x / 4
    @tilemap.oy = $game_map.display_y / 4
    @tilemap.update
    # 更新遠景平面
    @panorama.ox = $game_map.display_x / 8
    @panorama.oy = $game_map.display_y / 8
    # 更新迷霧平面
    @fog.zoom_x = $game_map.fog_zoom / 100.0
    @fog.zoom_y = $game_map.fog_zoom / 100.0
    @fog.opacity = $game_map.fog_opacity
    @fog.blend_type = $game_map.fog_blend_type
    @fog.ox = $game_map.display_x / 4 + $game_map.fog_ox
    @fog.oy = $game_map.display_y / 4 + $game_map.fog_oy
    @fog.tone = $game_map.fog_tone
    # 更新角色活動區塊
    for sprite in @character_sprites
      sprite.update
    end
    # 更新天候圖像
    @weather.type = $game_screen.weather_type
    @weather.max = $game_screen.weather_max
    @weather.ox = $game_map.display_x / 4
    @weather.oy = $game_map.display_y / 4
    @weather.update
    # 更新圖片
    for sprite in @picture_sprites
      sprite.update
    end
    # 更新計時器區塊
    @timer_sprite.update
    # 設定畫面的色彩與震動位置
    @viewport1.tone = $game_screen.tone
    @viewport1.ox = $game_screen.shake
    # 設定畫面的閃爍顏色
    @viewport3.color = $game_screen.flash_color
    # 更新顯示視口
    @viewport1.update
    @viewport3.update
  end
end
