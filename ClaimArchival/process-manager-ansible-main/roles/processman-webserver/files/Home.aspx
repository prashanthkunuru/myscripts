<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Molina.ProcessManager.UI.Home" %>

<%@ Register Assembly="Telerik.Web.UI, Version=2011.3.1115.35, Culture=neutral, PublicKeyToken=121fae78165ba3d4"
    Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/UserControl/FileNetLogout.ascx" TagName="FileNetLogout" TagPrefix="uc1" %>
<%@ Register Src="~/UserControl/SessionTimeout.ascx" TagName="SessionTimeout" TagPrefix="uc1" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Process Manager</title>
    <link href="Styles/Site.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .txtsplit
        {
            width: 400px;
            word-wrap: break-word;
        }
    </style>
    <script type="text/javascript" src="Scripts/jquery-1.8.1.min.js"></script>
    <script language="javascript" src="Scripts/CommonMasterScript.js" type="text/javascript"></script>
</head>
<body onkeydown="CancelBackSpace()" role="application">
    <form id="formHome" runat="server">
    <telerik:RadScriptManager ID="radScriptManager" runat="server">
    </telerik:RadScriptManager>
    <telerik:RadAjaxManager ID="radAJAXManager" runat="server">
    </telerik:RadAjaxManager>
    <table cellpadding="0" cellspacing="0" id="outContainer">
        <asp:HiddenField ID="hdnCheckAdminUser" runat="server" />
        <tr>
            <td class="whiteContent">
                <table cellpadding="0" cellspacing="0" id="header" class="inHome" width="100%">
                    <tr>
                        <td id="logo" class="home">
                            <div class="logo">
                                <h1>
                                    Health PAS</h1>
                            </div>
                        </td>
                        <td class="sublogo homesb">
                            <span>
                                <asp:Label ID="lblTitle" runat="server" Text="Process Manager" CssClass="PMTitle"></asp:Label>
                                <asp:Label ID="lblVersion" runat="server" CssClass="PMVersion"></asp:Label></span>
                        </td>
                        <td class="headerRight">
                            <table width="100%" cellspacing="0" cellpadding="0">
                                <tbody>
                                    <tr>
                                        <td>
                                            <ul>
                                                <li>
                                                    <uc1:FileNetLogout ID="FileNetLogout" runat="server" />
                                                </li>
                                                <li>
                                                    <telerik:RadButton ID="help" runat="server" ButtonType="LinkButton" Text="Help" OnClientClicking="helpClicked">
                                                    </telerik:RadButton>
                                                </li>
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="molinLogoHome">
                                            <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/Molina_logo.png" />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" class="weltext">
                    <tr>
                        <td>
                            <h3>
                                <asp:Label ID="lblWelcomeUser" runat="server"></asp:Label>
                            </h3>
                        </td>
                    </tr>
                    <%--<tr>
                        <td width="10%">
                            <asp:Label ID="lblService" runat="server" Text="Service" CssClass="servlabel"></asp:Label>
                        </td>
                        <td width="10%">
                            <telerik:RadComboBox ID="radComboBoxService" runat="server">
                                <Items>
                                    <telerik:RadComboBoxItem Value="1" Text="MEPMgr" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>--%>
                    <tr>
                        <td class="tracechk">
                            <asp:CheckBox ID="chkTraceSession" runat="server" Text="Trace Session" OnCheckedChanged="chkTraceSession_CheckedChanged"
                                AutoPostBack="True" />
                        </td>
                    </tr>
                    <tr>
                        <td class="tracechk">
                            <asp:CheckBox ID="chkLogging" runat="server" Text="Logging" OnCheckedChanged="chkLogging_CheckedChanged"
                                AutoPostBack="True" />
                        </td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" class="content">
                    <tr>
                        <td>
                            <div class="adminport" runat="server" id="divAdmin">
                                <table cellpadding="0" cellspacing="0" class="contportion">
                                    <tr>
                                        <td class="left">
                                            <asp:ImageButton ID="imgButtonProcessManagerWeb" runat="server" ImageUrl="~/Images/visual_processmanager.png"
                                                OnClick="imgButtonProcessManagerWeb_Click" ToolTip="Process Manager Web" />
                                        </td>
                                        <td width="100%" class="rightbd" style="border-right:none">
                                            <h4>
                                                <asp:Label ID="lblProcessManagerWeb" runat="server" Text="Process Manager Web"></asp:Label></h4>
                                            <p class="txtsplit">
                                                <asp:Label ID="lblAdminMsg" runat="server" Text=" "></asp:Label>
                                            </p>
                                            <p class="right" style="text-align: left">
                                                <telerik:RadButton ID="btnViewAll" runat="server" Text="View All" AutoPostBack="false"
                                                    CssClass="link" NavigateUrl="" OnClientClicked="ViewAllClicked" ButtonType="LinkButton">
                                                </telerik:RadButton>
                                            </p>
                                        </td>
                                        <!-- Issue No:632 - Tim 11/15/2016
                                            <td>
                                            <h4>
                                                <asp:Label ID="lblDidYouKnow" runat="server" Text="Did You Know?"></asp:Label></h4>
                                            <p>
                                                <asp:Label ID="lblDidYouKnowDetails" runat="server">You can copy an image and paste it into a Microsoft Word document. Right click on the image and choose "Copy", then in Word, simply paste the image into your document.</asp:Label>
                                            </p>
                                        </td>-->
                                    </tr>
                                    <tr>
                                        <td class="left">
                                            <asp:ImageButton ID="imgButtonWizards" runat="server" ImageUrl="~/Images/visual_wizards.png"
                                                OnClick="imgButtonWizards_Click" ToolTip="Wizards" />
                                        </td>
                                        <td>
                                            <h4>
                                                <asp:Label ID="lblWizards" runat="server" Text="Wizards"></asp:Label></h4>
                                            <p>
                                                <asp:Label ID="lblWizardsDetails" runat="server" Text="Process Manager Wizards is an administrator tool to create, configure, edit and delete the workflow entities. It is to manage the workflow entities like work class, queue, define workclass definitions, document class, user settings etc."></asp:Label>
                                            </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="left">
                                            <asp:ImageButton ID="imgButtonActionServer" runat="server" ImageUrl="~/Images/visual_actionserver.png"
                                                OnClick="imgButtonActionServer_Click" ToolTip="Action Server" />
                                        </td>
                                        <td>
                                            <h4>
                                                <asp:Label ID="lblActionServer" runat="server" Text="Action Server"></asp:Label>
                                            </h4>
                                            <p>
                                                <asp:Label ID="lblActionServerDetails" runat="server" Text="Action Server is the background process that performs the operations on the action queues and some additional operations. It provides options to perform logging for the operations and also options to run processes on a scheduled time frame."></asp:Label>
                                            </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="left">
                                            <asp:ImageButton ID="imgButtonGlobalConfiguration" runat="server" ImageUrl="~/Images/visual_globalconfiguration.png"
                                                OnClick="imgButtonGlobalConfiguration_Click" ToolTip="Global Configuration" />
                                        </td>
                                        <td>
                                            <h4>
                                                <asp:Label ID="lblGlobalConfiguration" runat="server" Text="Global Configuration"></asp:Label></h4>
                                            <p>
                                                <asp:Label ID="lblGlobalConfigurationDetails" runat="server" Text="Global Configuration is used to configure basic workflow configurations."></asp:Label>
                                            </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="left">
                                            <asp:ImageButton ID="imgButtonUtilities" runat="server" ImageUrl="~/Images/compareandexport.png"
                                                OnClick="imgButtonUtilities_Click" ToolTip="Compare and Export" />
                                        </td>
                                        <td>
                                            <h4>
                                                <asp:Label ID="lblUtilities" runat="server" Text="Compare & Export"></asp:Label></h4>
                                            <p>
                                                <asp:Label ID="lblUtilitiesDetails" runat="server" Text="Compare & Export is used to compare and export the new or updated features of workflow."></asp:Label>
                                            </p>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="userport" id="divUser" runat="server" style="min-height: 500px;">
                                <table cellpadding="0" cellspacing="0" class="contportion">
                                    <tr>
                                        <td class="left">
                                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/visual_processmanager.png"
                                                OnClick="imgButtonProcessManagerWeb_Click" ToolTip="Process Manager Web Application" />
                                        </td>
                                        <td width="92%" class="rightbd">
                                            <h4>
                                                <asp:Label ID="Label1" runat="server" Text="Process Manager Web"></asp:Label></h4>
                                            <p class="txtsplit">
                                                <asp:Label ID="lblUserMsg" runat="server"></asp:Label>
                                            </p>
                                        </td>
                                        <!--<td>
                                            <h4>
                                                <asp:Label ID="Label3" runat="server" Text="Did You Know?"></asp:Label></h4>
                                            <p>
                                                <asp:Label ID="Label4" runat="server">You can copy an image and paste it into a Microsoft Word document. Right click on the image and choose "Copy", then in Word, simply paste the image into your document.</asp:Label>
                                            </p>
                                        </td>-->
                                    </tr>
                                    <%--<tr>
                                    <td class="left">
                                        <asp:ImageButton ID="imgButtonUtilities" runat="server" ImageUrl="~/Images/compareandexport.png"
                                            OnClick="imgButtonUtilities_Click" ToolTip="Utilities" />
                                    </td>
                                    <td colspan="2">
                                        <h4>
                                            <asp:Label ID="lblUtilities" runat="server" Text="Utilities"></asp:Label></h4>
                                        <p>
                                            <asp:Label ID="lblUtilitiesDetails" runat="server" Text="Contains PM Import Export tool and PM DB Setup Tool. PM Import Export tool is used to export the PM Wizard settings of an existing database and import it to a newly created database. PM DB Setup tool elaborates the process of setting up a newly created database for the users access."></asp:Label>
                                        </p>
                                    </td>
                                </tr>--%>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
                <!--footer-->
                <table cellpadding="0" cellspacing="0" class="footer">
                    <tr>
                        <td>
                            ©
                            <asp:Label ID="Label_CopyRight" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
                <!--footer-->
            </td>
        </tr>
    </table>
    <telerik:RadWindowManager ID="rwManagerAuto" runat="server" EnableAriaSupport="true">
        <Windows>
            <telerik:RadWindow ID="rwViewAll" runat="server" OnClientClose="OnClientClose1" NavigateUrl=""
                AutoSize="false" Modal="true" ShowContentDuringLoad="false" VisibleStatusbar="false"
                ReloadOnShow="true" Overlay="false" Behaviors="Close" InitialBehaviors="Close"
                VisibleOnPageLoad="false" DestroyOnClose="false" EnableAriaSupport="true" />
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript" language="javascript">

            function WizardClicked() {
                radalert("You are not authorised to view this page", "400", "150", "", redirectFn);
            }

            function redirectFn() {
            }

            function ViewAllClicked() {
                Sys.Application.remove_load(ViewAllClicked);
                var wnd = $find('<%= rwViewAll.ClientID %>')
                wnd.set_width(700);
                wnd.set_height(500);
                wnd.setUrl("HomeViewAllLinkPage.aspx");
                wnd.SetTitle("Information");
                wnd.Show();
            }

            function helpClicked(sender, args) {
                Sys.Application.remove_load(helpClicked);
                var wnd = $find('<%= rwViewAll.ClientID %>')
                wnd.set_width(700);
                wnd.set_height(500);
                wnd.setUrl("Help.aspx");
                wnd.SetTitle("Help");
                wnd.Show();
                args.set_cancel(true);
            }

            function OnClientClose1(oWnd, args) {
                var ajaxManager = $find("<%= this.RadAjaxManager %>");
                var arg = args.get_argument();
                var argValue;
                if (arg) {
                    argValue = arg.action;
                    if (argValue) {
                        ajaxManager.ajaxRequest(argValue);
                    }
                }
            }

        </script>
    </telerik:RadScriptBlock>
    <uc1:SessionTimeout ID="UCSessionTimeout" runat="server" />
    </form>
</body>
</html>
<%--<telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
    <script type="text/javascript" language="javascript">

        // Session Timeout Code Starts

        var sessionTimeoutWarning = '<%= System.Configuration.ConfigurationSettings.AppSettings["SessionWarning"].ToString() %>';
        var sessionTimeout = "<%= Session.Timeout  %>";
        var timeOnPageLoad = new Date();
        var SessionWarningTimer = null;
        var RedirectToHomePageTimer = null;

        //For Warning
        SessionWarningTimer = setTimeout('SessionWarning()', parseInt(sessionTimeoutWarning) * 60 * 1000);

        //Redirect to home page
        RedirectToHomePageTimer = setTimeout('RedirectToHomePage()', parseInt(sessionTimeout) * 60 * 1000);

        //Session Warning
        function SessionWarning() {
            var minutesToExpire = (parseInt(sessionTimeout) - parseInt(sessionTimeoutWarning));

//            var message = "Your session will expire in another " + minutesToExpire + " minutes. Please confirm your actions.";
            //            alert(message);
            Warning("Open", minutesToExpire);
            //If session time is over. Exit session
            var currentTime = new Date();

            //time for expiry
            var timeForExpiry = timeOnPageLoad.setMinutes(timeOnPageLoad.getMinutes() + parseInt(sessionTimeout));
        }

        //Session Timeout
        function RedirectToHomePage() {
            alert("Session expired. You will be redirected to home page.");
            window.location = "SessionExpiry.aspx";
        }

        function Warning(Argument, minutesToExpire) {
            if (Argument == "Open") {
                Win_Warning = window.open('TimeoutWarning.aspx?t=' + minutesToExpire, 'Win_Warning', 'top=225,screenY=225,left=425,width=300,height=150,scrollbars=no,scrollbar=no,menubar=no');
                setTimeout("Warning('Close')", 10000);
            }
            if (Argument == "Close") {
                if (Win_Warning.closed + "" == "false") {
                    Win_Warning.close();
                }
                else {
                }
            }
        }
        //Session Timeout Code ends

        </script>
</telerik:RadScriptBlock>--%>
