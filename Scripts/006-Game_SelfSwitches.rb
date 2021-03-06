#==============================================================================
# ■ Game_SelfSwitches
#------------------------------------------------------------------------------
# 處理獨立開關的類別。編入的是哈希表類別的外觀。
# 本類別的實例請參考 $game_self_switches。
#==============================================================================

class Game_SelfSwitches
  #--------------------------------------------------------------------------
  # ● 初始化目標
  #--------------------------------------------------------------------------
  def initialize
    @data = {}
  end
  #--------------------------------------------------------------------------
  # ● 取得獨立開關
  #     key : 鍵
  #--------------------------------------------------------------------------
  def [](key)
    return @data[key] == true ? true : false
  end
  #--------------------------------------------------------------------------
  # ● 設定獨立開關
  #     key   : 鍵
  #     value : ON (true) / OFF (false)
  #--------------------------------------------------------------------------
  def []=(key, value)
    @data[key] = value
  end
end
