local generate = function()
    local colors = {}
    if vim.g.vscode_style == 'dark' then
        colors = {
            vscNone = 'NONE',
            vscFront = '#D4D4D4',
            vscBack = '#121212',

            vscTabCurrent = '#0E0E0E',
            vscTabOther = '#222222',
            vscTabOutside = '#151516',

            vscLeftDark = '#151516',
            vscLeftMid = '#272727',
            vscLeftLight = '#6F6F76',

            vscPopupFront = '#BBBBBB',
            vscPopupBack = '#272727',
            vscPopupHighlightBlue = '#004b72',
            vscPopupHighlightGray = '#343B41',

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
    else
        colors = {
            vscNone = 'NONE',
            vscFront = '#343434',
            vscBack = '#FFFFFF',

            vscTabCurrent = '#FFFFFF',
            vscTabOther = '#CECECE',
            vscTabOutside = '#E8E8E8',

            vscLeftDark = '#F3F3F3',
            vscLeftMid = '#E5E5E5',
            vscLeftLight = '#F3F3F3',

            vscPopupFront = '#000000',
            vscPopupBack = '#F3F3F3',
            vscPopupHighlightBlue = '#0064c1',
            vscPopupHighlightGray = '#767676',

            vscSplitLight = '#EEEEEE',
            vscSplitDark = '#DDDDDD',
            vscSplitThumb = '#DFDFDF',

            vscCursorDarkDark = '#E5EBF1',
            vscCursorDark = '#6F6F6F',
            vscCursorLight = '#767676',
            vscSelection = '#ADD6FF',
            vscLineNumber = '#098658',

            vscDiffRedDark = '#FFCCCC',
            vscDiffRedLight = '#FFA3A3',
            vscDiffRedLightLight = '#FFCCCC',
            vscDiffGreenDark = '#DBE6C2',
            vscDiffGreenLight = '#EBF1DD',
            vscSearchCurrent = '#A8AC94',
            vscSearch = '#F8C9AB',

            -- Syntax colors
            vscGray = '#000000',
            vscViolet = '#000080',
            vscBlue = '#0000FF',
            vscDarkBlue = '#007ACC',
            vscLightBlue = '#0451A5',
            vscGreen = '#008000',
            vscBlueGreen = '#16825D',
            vscLightGreen = '#098658',
            vscRed = '#FF0000',
            vscOrange = '#C72E0F',
            vscLightRed = '#A31515',
            vscYellowOrange = '#800000',
            vscYellow = '#795E26',
            vscPink = '#AF00DB',
        }
    end

    if vim.g.vscode_transparent then
        colors.vscBack = 'NONE'
    end

    -- Other ui specific colors
    colors.vscUiBlue = '#084671'
    colors.vscUiOrange = '#f28b25'

    return colors
end

return { generate = generate }
