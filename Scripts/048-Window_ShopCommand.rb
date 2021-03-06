#==============================================================================
# ■ Window_ShopCommand
#------------------------------------------------------------------------------
# 商店畫面、選擇要做事情的視窗
#==============================================================================

class Window_ShopCommand < Window_Selectable
  #--------------------------------------------------------------------------
  # ● 初始化目標
  #--------------------------------------------------------------------------
  def initialize
    super(0, 64, 480, 64)
    self.contents = Bitmap.new(width - 32, height - 32)
    @item_max = 3
    @column_max = 3
    @commands = ["買入", "賣出", "取消"]
    refresh
    self.index = 0
  end
  #--------------------------------------------------------------------------
  # ● 更新
  #--------------------------------------------------------------------------
  def refresh
    self.contents.clear
    for i in 0...@item_max
      draw_item(i)
    end
  end
  #--------------------------------------------------------------------------
  # ● 描繪項目
  #     index : 項目編號
  #--------------------------------------------------------------------------
  def draw_item(index)
    x = 4 + index * 160
    self.contents.draw_text(x, 0, 128, 32, @commands[index])
  end
end
