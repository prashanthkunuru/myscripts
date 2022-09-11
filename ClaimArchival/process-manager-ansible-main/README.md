# Process Manager Action Server and Web Server Install

Process Manager applications are installed on 2 servers.  The **Web Server** runs the IIS based web application and the **Action Server** runs the Action Server Windows service based application.  Logging services that are installed as IIS applications run on both of those servers.  The Web and Tracing services are installed on the Web Server and the Event and Tracing services are installed on the Action Server.  The following documentation provides the information and requirements to install Process Manager.   

### Application Team

- Amy Maldonado <amaldonado9@gainwelltechnologies.com>
- Johnny Entremont <jentremont@gainwelltechnologies.com> 

## <u>Install Process Manager</u>
The processman_deploy.yml is the primary ansible playbook that is used to deploy Process Manager.  This playbook does the following:
- Create EC2 host groups by using the host_type tag.  The groups are then used in conditional statements for deployment of the roles.
  - PMA = Process Manager Action Server
  - PMW = Process Manager Web Server
- Call the processman-webserver role to install the required pre-requisiste software, install the Web Server application, install the logging services and configure the applications on the web server.  
- Call the processman-actionserver role to install the  required pre-requisiste software, install the Action Server application, install the logging services and configure the applications on the action server.
- Call the logging service role that will install and configure the logging applications on the action server and web server, depending on what is required for each of those servers.

### Ansible Automation Platform
Ansible Automation Platform is the tool used to configure the job that runs the automated installation.
* Project: Process Manager
* Template: Process Manager Install - DEV
  - processman_deploy.yml 
* Credentials: HCLS-LEV\SVCTXDevPM 
In AAP, to deploy the application, the **Process Manager Install - DEV** template should be launched. 

### GitHub repository for infrastructure as code
GitHub Repository: https://github.com/mygainwell/process-manager-ansible
This repository contains the code to install and configure Process Manager Action Server and Web Server products.  

# <u>Roles</u>
The following roles are called by the playbooks to deploy and configure the applicatoins on the servers.

### Roles to install applications:
* processman-webserver role
  - Run tasks required to initialize and format the secondary disk (D drive).
  - Create required directories
  - Downloading artifacts from JFrog and putting them into the temporary directory
  - Install Web Application Pre-req software
  - Updating DLL files in the \bin directory
  - Install IIS
  - Create a new application pool in 'Started' state
  - Web Application Install
  - Create and configure the Process Manager web application in IIS and set the app pool
  - Set Windows Auth as "Enabled" & "Anonymouts Auth" as "Disabled"
  - Providing Full Control to IIS_IUsers
  - Add Home.aspx to list of Default Documents
  - Copy files to the appropriate folders 
  - Create the Web.config file from a Jinja2 template.


* processman-actionserver role
  - Create web server FQDN to be used in the Molina config file web server endpoint url value
  - Run tasks required to initialize and format the secondary disk (D drive).
  - Check to see if the temp download directory exists.
  - Create the temporary directory to pull down the artifacts to install Action Server.  
  - Download artifacts required for the Action Server deployment.
  - Install pre-requisite applications required for Action Server deployment.
  - Enable Windows features required for the logging services to run.
  - Registry entry that the installers look for to verify IIS version. ** The installers do not recognize version 10 of IIS, so this reg merge will update the key to show IIS version 6 for the installer to work.
  -  Create parent directories for the installer and log data directories
  - Install application and then the application patch update.
  - Run Registry entry that sets the IIS version back to 10 after app installs. 
  - Add DLLs that update the application.
  - Add service account to the local Administrators group so that it can manage the Action Server service.
  - Set rights that are required to be able to manage the Action Server service.
  - Configure the domain service account to run the Action Server service.
  - Create the Molina.ProcessManager.ActionServerController.exe.config file from a Jinja2 template.
  - Copy the config files to the correct directory
  
* logging-service role
  - Check to see if the temp download directory exists.
  - Create the temporary directory to pull down the artifacts to install logging services.  
  - Download artifacts required for the logging services deployment.
  - Download common artifacts for Process Manager Logging installation.  
  - Unzip the artifacts into the temp folder on the C:\ drive
  - Create and configure the logging application pool in IIS 
  - Registry entry that the installers look for to verify IIS version. ** The installers do not recognize version 10 of IIS, so this reg merge will update the key to show IIS version 6 for the installer to work.
  - Install the appropriate logging services on the Action server
  - Install the appropriate logging services on the Web server
  - Run Registry entry that sets the IIS version back to 10 after app installs. 
  - Create and configure the logging IIS applications on the Action Server
  - Create and configure the logging IIS applications on the Web Server
  - Set Anonymous Auth to Enabled on the IIS applications
  - Configure the IIS_IUSRS to have Full Control NTFS permissions on the folder of the IIS logging services web applications.
  - Create web.config files for logging IIS applications from a Jinja2 template.


# <u>Variables</u>
Variables used in the playbooks for the customization of the deployment.  All of these variables are required for the playbook to run successfully.  

## Common Variables for all roles
vars file: \group_vars\all, AAP and ansible facts

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| download\_dir | Location in the Windows server where the artifacts will be downloaded | `string` | 'C:\\processman_temp' | yes | 
| web\_server\_fqdn | This variable is dymanically created using ansible facts when the playbook runs | | | yes |
| ansible\_fqdn | This variable is dynamically obtained through ansible facts when the playbook runs | | | yes |
| hcls_lev_svc_domain | This variable is pulled from AAP Credentials |  | HCLS-LEV | yes |
| hcls_lev_svc_username | This variable is pulled from AAP Credentials |  | HCLS-LEV | yes |
| hcls_lev_svc_password | This variable is pulled from AAP Credentials |  | HCLS-LEV | yes |

## Variables for the Web Server role
vars file: roles\processman-webserver\vars\main.yml

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app_folder | Folder to install the Action Server application | `string` | 'C:\inetpub\wwwroot\ProcessManager5.0P8' | yes | 
| filenet_base_url | URL for application access to FileNet | `string` | 'ec2amaz-lhkjouu.a349119001557.amazonaws.com' | yes | 
| fileNetP8URI | URL for P8 access to FileNet | `string` | 'http://{{ filenet_base_url }}:9080/wsi/FNCEWS40MTOM/' | yes | 
| filenet_object_store | FileNet ObjectStore configuration | `string` | 'P8DOCS' | yes | 
| custom_app_dirs | Custom directories required by applications. |  |  | yes |
|  |  | `string` |  'D:\MMISAppsData\ProcessManager\Logs\DebugLog\archives' | yes |
|  |  | `string` |  'D:\MMISAppsData\ProcessManager\Logs\FileNet\archives' | yes |
|  |  | `string` |  'D:\MMISAppsData\ProcessManager\Logs\InfoLog\archives' | yes |
|  |  | `string` |  'D:\MMISAppsData\ProcessManager\Logs\ErrorLog\archives' | yes |
|  |  | `string` |  'D:\MMISAppsData\ProcessManager\PMCompanionApps' | yes |
|  |  | `string` |  'D:\MMISAppsData\ProcessManager\FileNet\Temp'  | yes |
| eventLogService_Server_FQDN | Server where Event Log service is running | `string` | '{{ ansible_fqdn }}' | yes | 
| tracingService_Server_FQDN | Server where Trace service is running |`string` | '{{ ansible_fqdn }}' | yes | 
| webLoggingService_Server_FQDN | Server where Web Log service is running |`string` | '{{ web_server_fqdn }}' | yes | 
| compilation_debug | Property for config file | `bool` | true | yes | 
| view_header_history_config | Property for config file | `string` | 'D:\program files\process mangaer\pmcompanionapps\ViewHistoryHeaderConfig.xml' | yes | 
| use_old_light_viewer | Property for config file | `bool` | false | yes | 
| remote_url | Property for config file | `string` | '{{ ansible_fqdn }}' | yes | 
| dll_files | Property for config file | `string` | | | yes | 
|  |  | `string` |  'Molina.ProcessManager.Common.dll' | yes | 
|  |  | `string` |  'Molina.ProcessManager.RepositoryConnector.dll' | yes | 
|  |  | `string` |  'Molina.ProcessManager.DataAccess.dll' | yes | 
|  |  | `string` |  'Molina.ProcessManager.Common.dll' | yes | 


## Variables for the Action Server role
vars file: roles\processman-actionserver\vars\main.yml

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| base\_jfrog\_url | Base URL for artifacts in JFrog | `string` | 'https://gwproductengineering.jfrog.io/artifactory' | yes |
| gainwell\_common\_jfrog\_folder | Folder in Artifactory that has common Gainwell specific artifacts | `string` | 'common/gainwell' | yes |
| process\_manager\_jfrog\_folder | Folder in Artifactory with Process Manager artifacts | 'string' | 'process-manager-local' | yes |
| artifacts | Artifacts downloaded for application install |  |  | yes |  
|  |  | `string` | Microsoft WSE 3.0.msi | yes |  
|  |  | `string` | ActionServerControllerP8.msi | yes |  
|  |  | `string` | PM 5.6.6 Action Server P8 Patch.msi |  yes |  
|  |  | `string` | Molina.ProcessManager.Common.dll | yes |  
|  |  | `string` | Molina.ProcessManager.RepositoryConnector.dll | yes |  
|  |  | `string` | iis-version-6.reg | yes |  
|  |  | `string` | iis-version-10.reg | yes |  
| app_folder | Folder to install the Action Server application | 'string' | 'D:\MMISApps\ActionServerControllerP8' | yes |
| gainwell\_iis\_reg\_6 | Registry file to modify IIS version to allow installers to run | 'string' | 'iis-version-6.reg' | yes |
| gainwell\_iis\_reg\_10 | Registry entry to return IIS value to original version  | 'string' | 'iis-version-10.reg' | yes |

## Variables for the logging service role
vars file: roles\logging-service\vars\main.yml

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| base\_jfrog\_url | Base URL for artifacts in JFrog | `string` | 'https://gwproductengineering.jfrog.io/artifactory' | yes |
| gainwell\_common\_jfrog\_folder | Folder in Artifactory that has common Gainwell specific artifacts | `string` | 'common/gainwell' | yes |
| process\_manager\_jfrog\_folder | Folder in Artifactory with Process Manager artifacts | 'string' | 'process-manager-local' | yes |
| gainwell\_common\_folder | Folder in Artifactory with shared artifacts | 'string' | 'common/gainwell' | yes |
| artifacts | Artifacts downloaded for application install |  |  | yes |  
|  |  | `string` | EventLoggingService.zip | yes |  
|  |  | `string` | TraceLoggingService.zip | yes |  
|  |  | `string` | WebLoggingService.zip |  yes |
| common_artifacts | Artifacts downloaded for application install |  |  | yes |  
|  |  | `string` | iis-version-6.reg | yes |  
|  |  | `string` | iis-version-10.reg | yes |  
| gainwell\_iis\_reg\_6 | Registry file to modify IIS version to allow installers to run | `string` | 'iis-version-6.reg' | yes |
| gainwell\_iis\_reg\_10 | Registry entry to return IIS value to original version  | `string` | 'iis-version-10.reg' | yes |
| logging\_services \<Event Log service\> path | Installer file path | `string` | {{download_dir}}\EventLogService.msi | yes |  
| logging\_services \<Event Log service\> product\_id | Product ID of application |`string` | D9B8331B-F1AB-4BC2-87AB-346D9FBDCF89 | yes | 
| logging\_services \<Event Log service\> iis\_app\_path | Physical path of IIS app | `string` | 'c:\inetpub\wwwroot\EventLogService'
| logging\_services \<Event Log service\> iis\_app\_site | IIS web site | `string` | 'Default Web Site'
| logging\_services \<Event Log service\> iis\_app\_name |  IIS application name| `string` | 'EventLogService'
| logging\_services \<Event Log service\> iis_web_config | Web.config file for the application | `string` | 'EventLogService.web.config.j2'
| logging\_services \<Event Log service\> installed\_on | Server on which to install this application | `string` | 'ActionServer'
| logging\_services \<Tracing Service\> path | Installer file path | `string` | {{download_dir}}\TracingService.msi | yes |  
| logging\_services \<Tracing Service\> product\_id | Product ID of application |`string` | 6663BFE8-B664-4315-B3AD-7369D85177B5 | yes | 
| logging\_services \<Tracing Service\> iis\_app\_path | Physical path of IIS app | `string` | 'c:\inetpub\wwwroot\TracingService'
| logging\_services \<Tracing Service\> iis\_app\_site | IIS web site | `string` | 'Default Web Site'
| logging\_services \<Tracing Service\> iis\_app\_name | IIS application name | `string` | 'TracingService'
| logging\_services \<Tracing Service\> iis_web_config | Web.config file for the application | `string` | 'TracingService.web.config.j2'
| logging\_services \<Tracing Service\> installed\_on | Server on which to install this application | `string` | 'ALL'
| logging\_services \<Web Logging Service\> path | Installer file path | `string` | {{download_dir}}\WebLoggingService.msi | yes |  
| logging\_services \<Web Logging Service\> product\_id | Product ID of application |`string` | E898023E-1F8F-4DE2-8DA1-7C199634CB0C | yes | 
| logging\_services \<Web Logging Service\> iis\_app\_path | Physical path of IIS app | `string` | 'c:\inetpub\wwwroot\WebLoggingService'
| logging\_services \<Web Logging Service\> iis\_app\_site |  IIS web site| `string` | 'Default Web Site'
| logging\_services \<Web Logging Service\> iis\_app\_name | IIS application name | `string` | 'WebLoggingService'
| logging\_services \<Web Logging Service\> iis_web_config | Web.config file for the application | `string` | 'WebLoggingService.web.config.j2'
| logging\_services \<Web Logging Service\> installed\_on | Server on which to install this application | `string` | 'WebApplicationServer'

# <u>Templates</u>
The variables listed below are for the files that are templated in the roles


## Variables for the Molina.ProcessManager.ActionServerController.exe.config Jinja2 template used in the processman-actionserver role.
This file is part of the Action Server install and is added as a template to add all of the required parameters.
<p>Template: roles\processman-actionserver\templates\Molina.ProcessManager.ActionServerController.exe.config.j2

| Name | Default | Required |
|------|---------|:--------:|
| filenet_base_url | 'ec2amaz-lhkjouu.a349119001557.amazonaws.com' | yes |
| integrated_security |  'Integrated Security=True;' |
| mesdocs |  'MESDOCS:' |
| FileNetP8URI |  'http://{{ filenet_base_url }}:9080/wsi/FNCEWS40MTOM/' |
| FileNetP8UserID_value |  'NotRequiredAnyMore' |
| FileNetP8Password_value |  'NotRequiredAnyMore' |
| FileNetP8ProfessionalViewerURL |  'http://{{ filenet_base_url }}:9081/WorkplaceXT/getContent' |
| FileNetP8ObjectStore_key |  '<add key=\"FileNetP8ObjectStore\" value=\" \" />' | 
| FileNetLocalFileTempPath |  'D:\MMISApps\ActionServerControllerP8\FileNet\Temp\' |
| LogFile  |  'D:\MMISAppsData\ActionServerControllerP8\Logs\ErrorLog.txt' |
| RendezvousXmlPathDir |  'D:\MMISAppsData\ActionServerControllerP8\PMCompanionApps\Rendezvous\' |
| CustomConfigDir |  'D:\MMISAppsData\ActionServerControllerP8\PMCompanionApps\PMCompanionApps.config' |
| records_processed_value |  '500' |
| PopulateProcessAttempts |  '3' |
| ProcessManagerURL_value |  'http://{{ web_server_fqdn \| trim }}/ProcessManager5.0P8' |
| EventLogService_Server_FQDN |  '{{ ansible_fqdn }}' |
| TracingService_Server_FQDN |  '{{ ansible_fqdn }}' |
| WebLoggingService_Server_FQDN |  '{{ web_server_fqdn }}' |

## Variables for the web.config Jinja2 templates used in the logging-service role.
### Shared variable for Web.config templates:

| Name | Default | Required |
|------|---------|:--------:|
| web_config_data_source | '10.134.11.5\TXDEVENVPRMGR,50008' | yes |

### web.config variables for the EventLogService
Template: roles\logging-service\templates\EventLogService.web.config.j2

| Name | Default | Required |
|------|---------|:--------:|
| eventlog_initial_catalog | 'PRMGR' | yes |
| eventlog_log_file_path | 'D:\MMISAppsData\EventLogService\PMEventLog.txt' | yes |

### web.config variables for the TracingService
Template: roles\logging-service\templates\TracingService.web.config.j2

| Name | Default | Required |
|------|---------|:--------:|
| tracelog_initial_catalog | 'PRMGR' | yes |
| tracelog_log_file_path | 'D:\MMISAppsData\TracingService\TraceLog.txt' | yes |

### web.config variables for the WebLogService
Template: roles\logging-service\templates\WebLogService.web.config.j2

| Name | Default | Required |
|------|---------|:--------:|
| weblog_initial_catalog | 'PMLogging' | yes |
| weblog_log_file_path | 'D:\MMISAppsData\WebLogService\PMWebLogging.txt' | yes |

# <u>Files</u>
## Files deployed to the servers via Ansible
Action server files: roles\processman-actionserver\files
Web server files: roles\processman-webserver\files

| File Name | Role | Required |
|------|---------|:--------:|
| NLog.config | processman-actionserver | yes |
| PMCompanionApp.config | processman-actionserver | yes |
| Actionserver.Master | processman-webserver | yes |
| ControlWizardMaster.Master | processman-webserver | yes |
| document.aspx | processman-webserver | yes |
| ExportPage.Master | processman-webserver | yes |
| GlobalConfig.Master | processman-webserver | yes |
| Home.aspx | processman-webserver | yes |
| jquery-1.8.1.min.js | processman-webserver | yes |
| NLog.config | processman-webserver | yes |
| PMCompanionApps.config | processman-webserver | yes |
| PopUp.Master | processman-webserver | yes |
| Site.Master | processman-webserver | yes |
| ViewHistoryHeaderConfig.xml | processman-webserver | yes |
| Web.Master | processman-webserver | yes |
| Wizard.Master | processman-webserver | yes |
