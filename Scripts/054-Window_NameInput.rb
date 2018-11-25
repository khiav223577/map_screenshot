#==============================================================================
# ■ Window_NameInput
#------------------------------------------------------------------------------
# 輸入名稱以及文字選擇畫面的視窗。
#==============================================================================

class Window_NameInput < Window_Base
  CHARACTER_TABLE =
  [
    "我","人","米","木","水","阿","雲","迪","子","大",
    "雪","靈","明","多","樂","露","雨","男","珂","龍",
    "神","晶","瑪","飛","女","娜","信","香","力","爾",
    "斯","特","冰","潔","瑩","麗","藍","巴","星","名",
    "一","仙","良","月","曉","光","梅","草","中","南",
    "春","夏","秋","東","花","朋","奇","克","敏","音",
    "可","貝","偉","莉","洛","艾","亞","倫","卡","奧",
    "拉","情","西","修","帝","蓮","薩","安","哈","河",
    "海","倩","綾","魔","草","其","花","圓","天","愛",
    "雙","佛","波","寶","鳴","漫","丸","步","宇","磊",
    "趙","錢","孫","李","周","吳","鄭","王","馮","陳",
    "諸","衛","蔣","沈","韓","楊","朱","秦","尤","許",
    "何","呂","施","張","孔","曹","嚴","華","金","魏",
    "陶","姜","戚","謝","鄒","喻","柏","竇","章","蘇",
    "潘","葛","奚","范","彭","郎","魯","韋","昌","馬",
    "苗","鳳","方","俞","袁","柳","史","雷","賀","羅",
    "于","皮","齊","康","元","孟","平","黃","和","蕭",
    "姚","毛","計","熊","林","徐","杜","賈","江","童",
    "顔","高","田","成","宋","胡","萬","盧","程","烏",
    "桑","瓦","羽","博","索","邦","彬","普","櫻","提",
    "狂","石","礦","仔","慶","正","智","浩","京","艾",
    "尼","頓","物","極","鑫","琳","士","語","奈","容",
    "平","伊","琪","采","白","君","望","書","依","黎",
    "遠","心","何","果","湖","瑞","向","本","茹","賽",
    "牙","妮","科","彩","加","新","德","仁","通","轉",
    "之","夢","火","金","三","鳥","喬","霜","聆","傑",
    "東","筆","生","球","蟲","日","拉","貓","寒","格",
  ]
  #--------------------------------------------------------------------------
  # ● 初始化目標
  #--------------------------------------------------------------------------
  def initialize
    super(0, 128, 640, 352)
    self.contents = Bitmap.new(width - 32, height - 32)
    @index = 0
    refresh
    update_cursor_rect
  end
  #--------------------------------------------------------------------------
  # ● 取得文字
  #--------------------------------------------------------------------------
  def character
    return CHARACTER_TABLE[@index]
  end
  #--------------------------------------------------------------------------
  # ● 更新
  #--------------------------------------------------------------------------
  def refresh
    self.contents.clear
    for i in 0..179
      x = 4 + i / 5 / 9 * 152 + i % 5 * 28
      y = i / 5 % 9 * 32
      self.contents.draw_text(x, y, 28, 32, CHARACTER_TABLE[i], 1)
    end
    self.contents.draw_text(544, 9 * 32, 64, 32, "確定", 1)
  end
  #--------------------------------------------------------------------------
  # ● 更新游標矩形
  #--------------------------------------------------------------------------
  def update_cursor_rect
    # 游標位置剛好位在 [確定] 的情況下
    if @index >= 180
      self.cursor_rect.set(544, 9 * 32, 64, 32)
    # 游標位置在 [確定] 以外的情況下
    else
      x = 4 + @index / 5 / 9 * 152 + @index % 5 * 28
      y = @index / 5 % 9 * 32
      self.cursor_rect.set(x, y, 28, 32)
    end
  end
  #--------------------------------------------------------------------------
  # ● 更新畫面
  #--------------------------------------------------------------------------
  def update
    super
    # 游標位置剛好位在 [確定] 的情況下
    if @index >= 180
      # 游標下
      if Input.trigger?(Input::DOWN)
        $game_system.se_play($data_system.cursor_se)
        @index -= 180
      end
      # 游標上
      if Input.repeat?(Input::UP)
        $game_system.se_play($data_system.cursor_se)
        @index -= 180 - 40
      end
    # 游標位置在 [確定] 以外的情況下
    else
      # 按下方向鍵右的情況下
      if Input.repeat?(Input::RIGHT)
        # 按下狀態不是重複的情況下、
        # 游標位置不在右端的情況下
        if Input.trigger?(Input::RIGHT) or
           @index / 45 < 3 or @index % 5 < 4
          # 游標向右移動
          $game_system.se_play($data_system.cursor_se)
          if @index % 5 < 4
            @index += 1
          else
            @index += 45 - 4
          end
          if @index >= 180
            @index -= 180
          end
        end
      end
      # 按下方向鍵左的情況下
      if Input.repeat?(Input::LEFT)
        # 按下狀態不是重複的情況下、
        # 游標位置不在左端的情況下
        if Input.trigger?(Input::LEFT) or
           @index / 45 > 0 or @index % 5 > 0
          # 游標向右移動
          $game_system.se_play($data_system.cursor_se)
          if @index % 5 > 0
            @index -= 1
          else
            @index -= 45 - 4
          end
          if @index < 0
            @index += 180
          end
        end
      end
      # 按下方向鍵下的情況下
      if Input.repeat?(Input::DOWN)
        # 游標向下移動
        $game_system.se_play($data_system.cursor_se)
        if @index % 45 < 40
          @index += 5
        else
          @index += 180 - 40
        end
      end
      # 按下方向鍵上的情況下
      if Input.repeat?(Input::UP)
        # 按下狀態不是重複的情況下、
        # 游標位置不在上端的情況下
        if Input.trigger?(Input::UP) or @index % 45 >= 5
          # 游標向上移動
          $game_system.se_play($data_system.cursor_se)
          if @index % 45 >= 5
            @index -= 5
          else
            @index += 180
          end
        end
      end
      # L 鍵與 R 鍵被按下的情況下
      if Input.repeat?(Input::L) or Input.repeat?(Input::R)
        # 常用輸入法之間的切換
        $game_system.se_play($data_system.cursor_se)
        if @index / 45 < 2
          @index += 90
        else
          @index -= 90
        end
      end
    end
    update_cursor_rect
  end
end
