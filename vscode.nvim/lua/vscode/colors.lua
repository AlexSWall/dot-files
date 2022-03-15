local generate = function()
	 local colors = {
		 vscNone = 'NONE',
		 vscFront = '#D4D4D4',
		 vscBack = '#121212',

		 vscTabCurrent = '#0E0E0E',
		 vscTabOther = '#222222',
		 vscTabOutside = '#151516',

		 vscLeftDark = '#151516',
		 vscLeftMid = '#20202A',
		 vscLeftLight = '#6F6F76',

		 vscPopupFront = '#BBBBBB',
		 vscPopupBack = '#121212',
		 vscPopupHighlightBlue = '#004B72',
		 vscPopupHighlightGray = '#2b3034',

		 vscSplitLight = '#898989',
		 vscSplitDark = '#444444',
		 vscSplitThumb = '#424242',

		 vscCursorDarkDark = '#111111',
		 vscCursorDark = '#51504F',
		 vscCursorLight = '#AEAFAD',
		 vscSelection = '#264F78',
		 vscLineNumber = '#5A5A5A',

		 vscDiffRedDark = '#4B1818',
		 vscDiffRedLight = '#6F1313',
		 vscDiffRedLightLight = '#FB0101',
		 vscDiffGreenDark = '#373D29',
		 vscDiffGreenLight = '#4B5632',
		 vscSearchCurrent = '#4B5632',
		 vscSearch = '#264F78',

		 vscHoverText = '#203845',

		 -- Syntax colors
		 vscGray = '#808080',
		 vscViolet = '#646695',
		 vscBlue = '#569CD6',
		 vscDarkBlue = '#223E55',
		 vscMediumBlue = '#18a2fe',
		 vscLightBlue = '#9CDCFE',
		 vscGreen = '#6A9955',
		 vscBlueGreen = '#4EC9B0',
		 vscLightGreen = '#B5CEA8',
		 vscRed = '#F44747',
		 vscOrange = '#CE9178',
		 vscLightRed = '#D16969',
		 vscYellowOrange = '#D7BA7D',
		 vscYellow = '#DCDCAA',
		 vscPink = '#C586C0',
	 }

    if vim.g.vscode_transparent then
        colors.vscBack = 'NONE'
    end

    -- Other ui specific colors
    colors.vscUiBlue = '#084671'
    colors.vscUiOrange = '#f28b25'

    return colors
end

return { generate = generate }
