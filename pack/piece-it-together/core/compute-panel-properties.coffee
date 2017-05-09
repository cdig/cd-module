do ()->
  itemPadding = 20
  maxItemWidth = 100
  maxItemHeightFraction = .8
  
  Take ["PieceProperties", "Panel","Vector"], (PieceProperties, Panel, Vector)->
    
    Make "ComputePanelProperties", (pieces, panel)->
      setItemsPanelScale(pieces, panel)
      setItemsPanelPosition(pieces, panel)

    
    
    setItemsPanelScale = (pieces, panel)->
      maxItemHeight = Panel.height(panel) * maxItemHeightFraction
      maxItemWidth = (Panel.width(panel) - (pieces.length + 2) * itemPadding) / pieces.length
      maxItemWidth = Math.max(maxItemWidth, 100)
      for item in pieces
        scaleX = if PieceProperties.width(item) <= maxItemWidth then 1 else maxItemWidth / PieceProperties.width(item)
        scaleY = if PieceProperties.height(item) <= maxItemHeight then 1 else maxItemHeight / PieceProperties.height(item)
        PieceProperties.setPanelScale(item, Math.min(scaleX, scaleY))
    
    
    setItemsPanelPosition = (pieces, panel)->
      panelInnerWidth = pieces.reduce(sumWithPadding, 0)
      availableSpace = Panel.width(panel) - panelInnerWidth
      currentOffset = availableSpace / 2
    
      for item in pieces
        x = currentOffset
        y = (Panel.height(panel) - PieceProperties.panelHeight(item))/2
        # Workaround: We don't have a good way to say "this position is based on your panelScale size"
        # This code just factors in the difference between panel size and natural size

        panelPosition = Vector.add(Vector.create(x, y), Panel.position(panel))
        PieceProperties.setPanelPosition(item, panelPosition)
        currentOffset += PieceProperties.panelWidth(item) + itemPadding
        
        
    sumWithPadding = (sum, item, index)->
      sum += PieceProperties.panelWidth(item)
      sum += itemPadding if index > 0
      return sum
