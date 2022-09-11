<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="document.aspx.cs" Inherits="Molina.ProcessManager.UI.document" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI, Version=2011.3.1115.35, Culture=neutral, PublicKeyToken=121fae78165ba3d4" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserControl/LightViewerToolbar.ascx" TagName="LightViewerToolbar" TagPrefix="UC" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .RadWindow_Default td.rwWindowContent .RadWindow_Default {
            left: 0px !important;
            top: 0px;
        }

        .RadWindow_Default .rwTopLeft {
            background: url(./Images/popupTop_leftNew.png) left top no-repeat !important;
            width: 25px !important;
            height: 31px !important;
        }

        .RadWindow .rwTitlebar {
            background: url(./Images/popuptopNew.png) left top repeat-x !important;
            height: 31px !important;
        }

        .RadWindow .rwTopRight {
            background: url(./Images/popupTop_rightNew.png) left top no-repeat !important;
            width: 25px !important;
            height: 31px !important;
        }

        .RadWindow_Default .rwBodyLeft {
            background: url(./Images/popupleftNew.png) left top repeat-y !important;
            width: 25px !important;
        }

        .RadWindow_Default .rwExternalContent {
            background: #fff !important;
        }

        .RadWindow_Default .rwBodyRight {
            background: url(./Images/popuprightNew.png) left top repeat-y !important;
            width: 25px !important;
        }

        .RadWindow_Default .rwFooterLeft {
            background: url(./Images/popupBottom_leftNew.png) left top no-repeat !important;
            width: 25px !important;
            height: 31px !important;
        }

        .RadWindow_Default .rwFooterCenter {
            background: url(./Images/popupbottomNew.png) left top repeat-x !important;
            height: 31px !important;
        }

        .RadWindow_Default .rwFooterRight {
            background: url(./Images/popupBottom_rightNew.png) left top no-repeat !important;
            width: 25px !important;
            height: 31px !important;
        }

        .RadWindow_Default .rwTitlebarControls .rwIcon {
            display: none;
        }

        .RadWindow .rwTitlebarControls {
            height: auto !important;
        }

        .RadWindow_Default .rwTitlebarControls em {
            display: block;
            font: bold 14px verdana !important;
            color: #305C98 !important;
            margin: 0 0 0px;
            /*border-bottom:1px solid #305C99 !important;*/
            padding: 6px 0 5px !important;
            line-height: normal !important;
            border-collapse: separate !important;
        }

        .RadWindow_Default .rwTitlebarControls .rwControlButtons a.rwCloseButton {
            background: url(./Images/closewindow_iconNew.png) left top no-repeat !important;
            height: 21px !important;
            width: 20px !important;
            position: relative;
            top: 3px;
            right: 0px;
        }

        .RadWindow .rwTitlebar .rwTopResize {
            height: auto;
            background: none;
        }

        .RadWindow .rwTitlebar .rwControlButtons {
            margin: 1px 0 0;
        }

        .RadWindow_Default .rwPopupButton {
            background: none !important;
            height: 32px !important;
            padding: 0px 10px 0 0 !important;
            margin: 5px 5px 0 0 !important;
            line-height: normal !important;
            outline: none;
            float: none !important;
            width: 100px;
            display: inline !important;
        }

            .RadWindow_Default .rwPopupButton span.rwOuterSpan {
                background: url(./Images/linkright.png) right top no-repeat !important;
                height: 32px !important;
                padding: 0px 10px 10px 0px !important;
                font: bold 12px verdana;
                margin: 0px !important;
                line-height: normal !important;
                float: none !important;
                display: inline-block !important;
            }

                .RadWindow_Default .rwPopupButton span.rwOuterSpan:focus,
                .RadWindow_Default .rwPopupButton span.rwOuterSpan:active,
                .RadWindow_Default .rwPopupButton span.rwOuterSpan:hover {
                    background: url(./Images/linkright.png) right top no-repeat !important;
                }

                    .RadWindow_Default .rwPopupButton span.rwOuterSpan:focus span.rwInnerSpan {
                        background: url(./Images/link_left1.png) left top no-repeat !important;
                    }

                .RadWindow_Default .rwPopupButton span.rwOuterSpan span.rwInnerSpan {
                    background: url(./Images/link_left1.png) left top no-repeat !important;
                    line-height: normal !important;
                    padding: 10px 0px 10px 10px !important;
                    margin: 0px 0 0 !important;
                    height: 32px !important;
                    float: none !important;
                    text-align: center;
                    display: inline-block;
                }

                    .RadWindow_Default .rwPopupButton span.rwOuterSpan span.rwInnerSpan:focus,
                    .RadWindow_Default .rwPopupButton span.rwOuterSpan span.rwInnerSpan:active,
                    .RadWindow_Default .rwPopupButton span.rwOuterSpan span.rwInnerSpan:hover {
                        background: url(./Images/link_left1.png) left top no-repeat !important;
                    }

        .RadWindow_Default .rwDialogPopup {
            text-align: left;
        }

            .RadWindow_Default .rwDialogPopup div {
                text-align: center;
            }

            .RadWindow_Default .rwDialogPopup .rwDialogText {
                text-align: left;
                margin: 2px 0 8px;
            }

        .RadWindow_Default .rwWindowContent .radalert, .RadWindow_Default .rwWindowContent .radconfirm {
            background-position: left top !important;
        }

            .RadWindow_Default .rwWindowContent .radalert .rwPopupButton, .RadWindow_Default .rwWindowContent .radconfirm .rwPopupButton {
                position: relative;
                left: -17px;
                top: 5px;
            }
    </style>
</head>
<script type="text/javascript" src="Scripts/jquery-1.8.1.min.js"></script>
<script language="javaScript" type="text/javascript" src="Scripts/KeypressFunctions.js"></script>
<script language="javaScript" type="text/javascript" src="Scripts/JavaFunc.js"></script>
<script language="javascript" type="text/javascript" src="Scripts/ControlNDisable.js"></script>
<script language="javascript" type="text/javascript" src="Scripts/Hidestatus.js"></script>
<script language="javascript" type="text/javascript" src="Scripts/SessionoutScript.js"></script>
<script language="javaScript" type="text/javascript">





    function setShowMagnificationWindow(pbShowWindow) {
        mbShowMagnificationWindow = pbShowWindow;
    }

    function getShowMagnificationWindow() {
        return mbShowMagnificationWindow;
    }


    function ZoomWindow(e) {
        var llXpos = 0;
        var llYpos = 0;
        var llCurrentZoom = 0;
        var lForm;
        var lsWindowOptions = document.getElementById("hidWindowOptions").value;
        var lsZoomOptions = "";
        var llEnhance = 0;
        var llRotate = 0;
        var llPageNum = 1;
        var lsDocID = "";

        if (mbShowMagnificationWindow) {
            if (isNetscape() == true) {
                llXpos = e.pageX;
                llYpos = e.pageY;
            }
            else {
                llXpos = event.offsetX;
                llYpos = event.offsetY;
            }

            lForm = window.parent.frames[0].document.frmImageConrols;
            llCurrentZoom = lForm.zoom.options[lForm.zoom.selectedIndex].value;
            lsDocID = lForm.docid.value;
            llEnhance = lForm.enhance.options[lForm.enhance.selectedIndex].value;
            llRotate = lForm.rotate.options[lForm.rotate.selectedIndex].value;
            llPageNum = lForm.pagenum.options[lForm.pagenum.selectedIndex].value;
            lbMultiPage = lForm.MultiPage.value;
            lsZoomOptions = "MagnifyViewer.aspx?x=" + llXpos + "&y=" + llYpos + "&CurrentZoom=" + llCurrentZoom +
				"&docid=" + lsDocID + "&pagenum=" + llPageNum + "&rotate=" + llRotate + "&enhance=" + llEnhance +
				"&MultiPage=" + lbMultiPage;
            window.open(lsZoomOptions, "MagWindow", lsWindowOptions);
        }
    }

    document.onkeydown = function () {
        if ((event.keyCode == 78) && (event.ctrlKey)) {
            //alert ("No new window")
            event.cancelBubble = true;
            event.returnValue = false;
            event.keyCode = false;
            return false;
        }
    }

    var mbShowMagnificationWindow = false;
    setShowMagnificationWindow(true);
    function setShowMagnificationWindow(pbShowWindow) {
        mbShowMagnificationWindow = pbShowWindow;
    }
</script>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="radScriptManager" runat="server" AsyncPostBackTimeout="1200">
        </telerik:RadScriptManager>
        <telerik:RadAjaxManager ID="radAJAXManager" runat="server">
        </telerik:RadAjaxManager>
        <telerik:RadScriptBlock ID="radScriptBlockDocumentPublisher" runat="server">
            <script type="text/javascript" language="javascript">

                function OpenImageInNewWindow() {

                    var imgURL = document.getElementById("hdnImageURL");
                    var mgfy = document.getElementById("hdnMagnify");
                    if (imgURL != null && mgfy != null && mgfy.value == "1") {
                        var newWindow = window.open("", "pictureViewer", "location=no, directories=no, fullscreen=no, " +
                        "menubar=no, status=no,titlebar=0, toolbar=no, width=750, height=750, scrollbars=yes, resizable=yes");
                        newWindow.document.writeln("<html>");
                        newWindow.document.writeln("<body style='margin: 0 0 0 0;'>");
                        newWindow.document.writeln("<a href='javascript:window.close();'>");
                        newWindow.document.writeln("<img style='max-width:99%;max-height:99%' src='" + imgURL.value + "' alt='Click to close' id='bigImage'/>");
                        newWindow.document.writeln("</a>");
                        newWindow.document.writeln("</body></html>");
                        newWindow.document.close();
                    }
                }

                function PrintImageInNewWindow() {

                    var imgURL = document.getElementById("hdnImageURL");
                    var imageBase = imgURL.value.substring(0, imgURL.value.indexOf('IMG'));
                    var imageTrail = imgURL.value.substring(imgURL.value.indexOf('IMG') + document.getElementById("hdnPageNum").value.length + 3);
                    var totalPage = document.getElementById('UCLightViewerToolbar_radTextBoxTotalPages_text').value.substring(2);
                    var mgfy = document.getElementById("hdnMagnify");
                    if (imgURL != null && mgfy != null && mgfy.value == "1") {
                        var newWindow = window.open("", "PrintImage", "location=no, directories=no, fullscreen=no, " +
                        "menubar=no, status=no,titlebar=0, toolbar=no, width=650, height=500, scrollbars=yes, resizable=yes");
                        newWindow.document.writeln("<html>");
                        newWindow.document.writeln("<body style='margin: 0 0 0 0;'>");

                        newWindow.document.writeln("<img style='max-width:99%;max-height:99%' src='" + imageBase + 'IMG' + 1 + imageTrail + "' alt='' id='bigImage" + 1 + "'/>");
                        for (var i = 2; i <= totalPage; ++i) {
                            //newWindow.document.writeln("<img src='" + imgURL.value + "' alt='' id='bigImage'/>");
                            newWindow.document.writeln('<p style="page-break-after:always;"></p>');
                            newWindow.document.writeln("<img style='max-width:99%;max-height:99%' src='" + imageBase + 'IMG' + i + imageTrail + "' alt='' id='bigImage" + i + "'/>");
                        }

                        newWindow.document.writeln("</body></html>");
                        newWindow.document.close();
                        newWindow.focus();
                        newWindow.print();
                        newWindow.close();
                    }
                }

            </script>
        </telerik:RadScriptBlock>
        <div>
            <asp:Panel ID="pnlLightViewer" runat="server" Style="padding-top: 25px">
                <input type="hidden" id="hidWindowOptions" runat="server" />
                <input type="hidden" id="hidMsgWindow" runat="server" />
                <UC:LightViewerToolbar ID="UCLightViewerToolbar" runat="server"/>
                <a href="#" tabindex="1" onmousedown="javascript:OpenImageInNewWindow()">
                    <img src="<%= this.ImageURL %>" title="image" tooltip="Image" alt="Image" border="2" />
                    <asp:HiddenField ID="hdnImageURL" runat="server" />
                    <asp:HiddenField ID="hdnPageNum" runat="server" />
                    <asp:HiddenField ID="hdnMagnify" runat="server" />
                    <asp:HiddenField ID="hdnInformationId" runat="server" />
                    <asp:HiddenField ID="hdnRepositoryId" runat="server" />
                </a>
                <br />
            </asp:Panel>
        </div>
    </form>
</body>
</html>
