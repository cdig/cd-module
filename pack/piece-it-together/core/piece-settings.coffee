do ()->
	zIndexTop = 1000
	zIndexOnPanel= 100
	Take ["Panel","Piece", "PieceStyle"], (Panel, Piece, PieceStyle)->

		Make "PieceSettings", PieceSettings = 
			setSettingsForAnimation: (piece)->
				piece.element.removeEventListener("mousedown", piece.drag.mouseDown)
				piece.element.removeEventListener("touchstart", piece.drag.mouseDown)
				PieceStyle.setZIndex(piece, zIndexTop)
				PieceStyle.enablePointerEvents(piece, false)

			setSettingsForDrag: (piece)->
				piece.element.removeEventListener("mousedown", piece.drag.mouseDown)
				piece.element.removeEventListener("touchstart", piece.drag.mouseDown)
				PieceStyle.setZIndex(piece, zIndexTop)

			setSettingsForPanel: (piece)->
				piece.element.addEventListener("mousedown", piece.drag.mouseDown)
				piece.element.addEventListener("touchstart", piece.drag.mouseDown)
				piece.drag.dragPosition = piece.panelPosition
				PieceStyle.setZIndex(piece, zIndexOnPanel)
				PieceStyle.enablePointerEvents(piece, true)


			setSettingsForOriginalPosition: (piece)->
				piece.element.removeEventListener("mousedown", piece.drag.mouseDown)
				piece.element.removeEventListener("touchstart", piece.drag.mouseDown)
				piece.drag.dragPosition = piece.panelPosition
				PieceStyle.setZIndex(piece, null)
				PieceStyle.enablePointerEvents(piece, false)
