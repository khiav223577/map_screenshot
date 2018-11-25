#==============================================================================
# ■ Window_Skill
#------------------------------------------------------------------------------
# 特技畫面、戰鬥畫面等顯示可以使用特技的瀏覽視窗。
#==============================================================================

class Window_Skill < Window_Selectable
  #--------------------------------------------------------------------------
  # ● 初始化目標
  #     actor : 角色
  #--------------------------------------------------------------------------
  def initialize(actor)
    super(0, 128, 640, 352)
    @actor = actor
    @column_max = 2
    refresh
    self.index = 0
    # 戰鬥中時將視窗移至畫面中央並將其半透明化
    if $game_temp.in_battle
      self.y = 64
      self.height = 256
      self.back_opacity = 160
    end
  end
  #--------------------------------------------------------------------------
  # ● 取得特技
  #--------------------------------------------------------------------------
  def skill
    return @data[self.index]
  end
  #--------------------------------------------------------------------------
  # ● 更新
  #--------------------------------------------------------------------------
  def refresh
    if self.contents != nil
      self.contents.dispose
      self.contents = nil
    end
    @data = []
    for i in 0...@actor.skills.size
      skill = $data_skills[@actor.skills[i]]
      if skill != nil
        @data.push(skill)
      end
    end
    # 如果項目數不是 0 就製作位圖、重新描繪全部項目
    @item_max = @data.size
    if @item_max > 0
      self.contents = Bitmap.new(width - 32, row_max * 32)
      for i in 0...@item_max
        draw_item(i)
      end
    end
  end
  #--------------------------------------------------------------------------
  # ● 描繪項目
  #     index : 項目編號
  #--------------------------------------------------------------------------
  def draw_item(index)
    skill = @data[index]
    if @actor.skill_can_use?(skill.id)
      self.contents.font.color = normal_color
    else
      self.contents.font.color = disabled_color
    end
    x = 4 + index % 2 * (288 + 32)
    y = index / 2 * 32
    rect = Rect.new(x, y, self.width / @column_max - 32, 32)
    self.contents.fill_rect(rect, Color.new(0, 0, 0, 0))
    bitmap = RPG::Cache.icon(skill.icon_name)
    opacity = self.contents.font.color == normal_color ? 255 : 128
    self.contents.blt(x, y + 4, bitmap, Rect.new(0, 0, 24, 24), opacity)
    self.contents.draw_text(x + 28, y, 204, 32, skill.name, 0)
    self.contents.draw_text(x + 232, y, 48, 32, skill.sp_cost.to_s, 2)
  end
  #--------------------------------------------------------------------------
  # ● 更新提示內容
  #--------------------------------------------------------------------------
  def update_help
    @help_window.set_text(self.skill == nil ? "" : self.skill.description)
  end
end
