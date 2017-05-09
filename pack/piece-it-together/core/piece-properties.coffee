Take ["Panel","Piece", "PieceTransformations", "Vector"], (Panel, Piece, PieceTransformations, Vector)->

	Make "PieceProperties", PieceProperties = 
		width: (piece)->
			return piece.element.offsetWidth


		height: (piece)->
			return piece.element.offsetHeight


		panelWidth: (piece)->
			return piece.element.offsetWidth * piece.panelScale


		panelHeight: (piece)->
			return piece.element.offsetHeight * piece.panelScale


		setPanelScale: (piece, panelScale)->
			piece.panelScale = panelScale


		setPanelPosition: (piece, panelPosition)->
			piece.panelPosition = PieceTransformations.getPanelPosition(piece, panelPosition)