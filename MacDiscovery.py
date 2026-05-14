#!/usr/bin/python3
# Last updated Aug 17, 2021: Chris Norris

import fnmatch
import os 
import os.path
import platform
import socket
import subprocess
import datetime
import tkinter as tk
from tkinter import ttk
import smtplib
import glob
from email.message import EmailMessage

# Initial Variables
now = datetime.datetime.now()
hostName = socket.gethostname()
extData = {'asset': hostName}
DiscoveryReport = 'Discovery_' + hostName + now.strftime("_%b%d%Y_%I%M%S%p") + '.txt'
DRpath = '/Users/Shared/Old_Discoveries/'
if not os.path.exists(DRpath):
	os.makedirs(DRpath)
	os.chmod(DRpath, 0o777)
DiscoveryReportLocation = DRpath + DiscoveryReport
DiscLog = open(DiscoveryReportLocation, "w")
TechUsername = ''

# Defined Functions	
def DateTimeMarker():
	# uses the datetime library
	now = datetime.datetime.now()
	DiscLog.write("*~*~*~*~*~*~*~*~*~*  " + now.strftime("%a, %B %d, %Y %I:%M:%S %p") + "  *~*~*~*~*~*~*~*~*~*\n\n")

def CountElements(list):
    count = 0
    for element in list:
        count += 1
    return count

def COMPUNAMES():
	# uses the socket library	
	DiscLog.write('HostName: \t' + hostName)
	DiscLog.write('\n')

	domainName = socket.getfqdn()
	DiscLog.write('FQDN: \t\t' + domainName)
	DiscLog.write('\n\n')

def USERACCTS():
	# uses the subprocess library
	DiscLog.write('*~*~*~*~* User Accounts *~*~*~*~*\n')
	# list accounts in the /Users folder
	for i in next(os.walk('/Users'))[1]:
		if i != 'Shared':
			uFullName = subprocess.run(['id', '-F', i], capture_output=True, text=True).stdout
			usersUID = subprocess.run(['id', '-u', i], capture_output=True, text=True).stdout
			DiscLog.write('Account:\t' + i)
			DiscLog.write('\nFull Name:\t' + uFullName)
			DiscLog.write('\nAccount UID:\t' + str(usersUID))
			DiscLog.write('______________________________\n')

def MacOSInfo():
	# uses the platform library
	DiscLog.write('*~*~*~*~* MacOS Information *~*~*~*~*\n\n')

	# OS version number
	platform.mac_ver()
	vers, _, _ = platform.mac_ver()
	DiscLog.write('\tOS Version: ' + vers)
	DiscLog.write('\n')

def DesignFonts():
	# List any Design licensed fonts
	DiscLog.write('\n*~*~*~*~* CompanyName Licensed Fonts *~*~*~*~*\n')
	DiscLog.write('*~* LinotypeSyntaxCom (Design Font):\n')
	for font in os.listdir('/Library/Fonts'):
		if fnmatch.fnmatch(font, 'LinotypeSyntaxCom*.*'):
			DiscLog.write('\t' + font + '\n')
	DiscLog.write('\n')

	DiscLog.write('*~* SabonNext:\n')
	for font in os.listdir('/Library/Fonts'):
		if fnmatch.fnmatch(font, 'SabonNext*.*'):
			DiscLog.write('\t' + font + '\n')
	DiscLog.write('\n')

	DiscLog.write('*~* Graphik:\n')
	for font in os.listdir('/Library/Fonts'):
		if fnmatch.fnmatch(font, 'Graphik-*.*'):
			DiscLog.write('\t' + font + '\n')
	DiscLog.write('\n')

	DiscLog.write('*~* GraphikCondensed:\n')
	for font in os.listdir('/Library/Fonts'):
		if fnmatch.fnmatch(font, 'GraphikCondensed-*.*'):
			DiscLog.write('\t' + font + '\n')
	DiscLog.write('\n')

	DiscLog.write('*~* GraphikXCondensed:\n')
	for font in os.listdir('/Library/Fonts'):
		if fnmatch.fnmatch(font, 'GraphikXCondensed-*.*'):
			DiscLog.write('\t' + font + '\n')
	DiscLog.write('\n')

	DiscLog.write('*~* GraphikXXCondensed:\n')
	for font in os.listdir('/Library/Fonts'):
		if fnmatch.fnmatch(font, 'GraphikXXCondensed-*.*'):
			DiscLog.write('\t' + font + '\n')
	DiscLog.write('\n')

def SWUpdateHistory():
	# uses the subprocess library
	# gets a list of updates installed via the softwareupdate framework
	DiscLog.write('*~*~*~*~* Installed Software Updates History *~*~*~*~*\n')
	Data = subprocess.run(['softwareupdate', '--history'], capture_output=True, text=True).stdout
	swu = str(Data)
	# try block
	try:
		# parse and arrange the string of output
		for i in range(len(swu)):
			DiscLog.write(swu.split('\\n')[i])
	except IndexError as IndxEr:
		DiscLog.write('')
	DiscLog.write('\n')

def SystemInfo():
	# show model, serial number, RAM, Storage
	DiscLog.write('*~*~*~*~* System Configuration *~*~*~*~*\n\n')
	sncmd = "system_profiler SPHardwareDataType | grep 'Serial Number'"
	serial_number = subprocess.run(sncmd, stdout=subprocess.PIPE, shell=True, check=True, text=True).stdout
	DiscLog.write(serial_number)

	platform.machine()
	proc = platform.machine()
	# determines if the processor is Intel or Apple
	cmd = ['sysctl', '-n', 'machdep.cpu.brand_string']
	proctyp = subprocess.check_output(cmd).decode('utf-8')
	for line in proctyp.splitlines():
		if 'Intel' in line:
			processrID = 'Intel'
		else:
			processrID = 'Apple'
	DiscLog.write('\tProcessor: ' + line)
	DiscLog.write('\n')

	corcmd = "system_profiler SPHardwareDataType | grep 'Cores'"
	proc_cores = subprocess.run(corcmd, stdout=subprocess.PIPE, shell=True, check=True, text=True).stdout
	DiscLog.write(proc_cores)

	memcmd = "system_profiler SPHardwareDataType | grep 'Memory'"
	memory_gb = subprocess.run(memcmd, stdout=subprocess.PIPE, shell=True, check=True, text=True).stdout
	DiscLog.write(memory_gb)

	DiscLog.write('\nGraphics Processors:\n')
	grphcmd = 'system_profiler SPDisplaysDataType | grep -A5 Chipset '
	grph = subprocess.run(grphcmd, stdout=subprocess.PIPE, shell=True, check=True, text=True).stdout
	DiscLog.write(grph)

	storcmd = 'system_profiler SPStorageDataType | grep -B5 "File System" | grep -v -- "^--$"'
	storage = subprocess.run(storcmd, stdout=subprocess.PIPE, shell=True, check=True, text=True).stdout
  
	dfcmd = "df -h /Users | awk '{ print $1,$2,$3,$4,$5 }' | sed -e 's/ /\t/g'"
	diskfree = subprocess.run(dfcmd, stdout=subprocess.PIPE, shell=True, check=True, text=True).stdout
	
	DiscLog.write('\n*~*~*~*~* Storage *~*~*~*~*\n\n')
	DiscLog.write(diskfree)
	DiscLog.write('\n')
	DiscLog.write(storage)

def DisplaysConnected():
	# show Mapping Status, domain, etc.
	DiscLog.write('*~*~*~*~* Displays *~*~*~*~*\n')
	DiscLog.write('\n')
	displcmd = 'system_profiler SPDisplaysDataType | grep -B3 "Framebuffer Depth:" | grep -v -- "^--$"'
	try:
		displ = subprocess.run(displcmd, stdout=subprocess.PIPE, shell=True, text=True).stdout
		DiscLog.write(displ)
	except subprocess.CalledProcessError as err:
		DiscLog.write('There are currently no External Displays connected.')
		DiscLog.write('Error occurred: ', err)
	DiscLog.write('\n')

def PrintScanInstalled():
	# show printers and scanners installed, drivers used
	DiscLog.write('*~*~*~*~* Installed Printers *~*~*~*~*\n')
	DiscLog.write('\n')
	cupscmd = 'system_profiler SPPrintersDataType | grep -h -B4 -A5 "Driver Version:" | grep -v -- "^--$"'
	# determines if printers are installed or if the result is empty
	try:
		instPrinters = subprocess.run(cupscmd, stdout=subprocess.PIPE, shell=True, text=True).stdout
		DiscLog.write(instPrinters + '\n')
	except subprocess.CalledProcessError as err:
		DiscLog.write('There are currently no printers installed.')
		DiscLog.write('Error occurred: ', err)
	DiscLog.write('\n')

def BlueToothStatus():
	DiscLog.write('*~*~*~*~* Bluetooth Connected Device List *~*~*~*~*\n')
	DiscLog.write('\n')
	# show devices connected via Bluetooth SPBluetoothDataType
	blutoothcmd = 'system_profiler SPBluetoothDataType | grep -C2 "Major Type:" | sed "/^--$/d"'
	if not blutoothcmd:
		DiscLog.write('There are currently no Bluetooth devices configured.')
	else:
		blutoothdev = blutoothcmd
		btinfo = subprocess.run(blutoothdev, stdout=subprocess.PIPE, shell=True, check=True, text=True).stdout
		DiscLog.write(btinfo + '\n')
	DiscLog.write('\n')

def TimeMachStatus():
	DiscLog.write('*~*~*~*~* Time Machine Backup Drive *~*~*~*~*\n\n')
	try:
		result = subprocess.run(['tmutil', 'destinationinfo'], capture_output=True, text=True)
		tminfo = str(result.stdout)
		if tminfo:
			DiscLog.write(tminfo)
			DiscLog.write("\n")
	except ValueError:
		DiscLog.write('Time Machine has not been configured.\n\n')

	try:
		result = subprocess.run(['defaults', 'read', '/Library/Preferences/com.apple.TimeMachine.plist', 'LastConfigurationTraceDate'], capture_output=True, text=True)
		tmlast = str(result.stdout)
		if tmlast:
			budate, butime, buvari = tmlast.split()
			DiscLog.write('Date of Last BackUp:\t' + str(budate))
			DiscLog.write('\n')
			DiscLog.write('Time of Last BackUp:\t' + str(butime))
			DiscLog.write('\n')
	except subprocess.CalledProcessError as e:
		DiscLog.write(e.returncode)
		DiscLog.write(e.output)
		DiscLog.write('Time Machine has not scheduled a BackUp.\n\n')

def ActivDirStatus():
	DiscLog.write('\n')
	DiscLog.write('*~*~*~*~* Active Directory Settings *~*~*~*~*\n\n')
	# show Mapping Status, domain, etc.
	ADstatus = subprocess.run(['dsconfigad', '-show'], capture_output=True, text=True).stdout
	if len(ADstatus) == 0:
		DiscLog.write('This system is not mapped to AD')
		DiscLog.write('\n\n')
	else:
		DiscLog.write(ADstatus)
		DiscLog.write('\n')

def NetworkPorts():
	DiscLog.write('*~*~*~*~* Network Ports Configuration *~*~*~*~*\n')
	# list the network ports
	NetPortscmd ='networksetup -listallhardwareports | sed "/^--$/d"'
	NetPorts = subprocess.run(NetPortscmd, stdout=subprocess.PIPE, shell=True, check=True, text=True).stdout
	DiscLog.write(NetPorts)
	DiscLog.write('\n')

def InternetPlugins():
	# list the Internet Plug-ins installed
	DiscLog.write('*~*~*~*~* Internet Plug-Ins Installed *~*~*~*~*\n')
	count = 0
	IntPlugDir = os.listdir('/Library/Internet Plug-Ins')
	DiscLog.write('\n')
	for IntPlug in sorted(IntPlugDir):
		DiscLog.write(IntPlug + '\n')
		count += 1
	DiscLog.write('\n')
	DiscLog.write('No. of Plug-Ins: '+ str(count) + '\n')
	DiscLog.write('\n')

def ApplicationPlugins():
	DiscLog.write('*~*~*~*~* Application Plug-Ins Installed *~*~*~*~*\n')
	# list the Application Plugins and their location
	count = 0
	for dirpath, dirs, files in os.walk("/Applications/"):
		for filename in files:
			if filename.endswith('.plugin'):
				fname = os.path.join(dirpath,filename)
				DiscLog.write('\t' + fname + '\n')
				count += 1
	DiscLog.write('\n')
	DiscLog.write('No. of App Plug-Ins: '+ str(count) + '\n')
	DiscLog.write('\n')

def AddtlPreferencePanes():
	# list any 3rd party Preference Panes installed
	DiscLog.write('*~*~*~*~* System Preference Panes Installed *~*~*~*~*\n')
	count = 0
	PrefPaneDir = os.listdir('/Library/PreferencePanes')
	for PrefPane in sorted(PrefPaneDir):
		DiscLog.write(PrefPane + '\n')
		count += 1
	DiscLog.write('\n')
	if count == 0:
		DiscLog.write('3rd Party Preference Panes: None\n')
	else:
		DiscLog.write('3rd Party Preference Panes: '+ str(count) + '\n')
	DiscLog.write('\n')

def ApplicationsInstalled():
	# list all the Applications installed
	DiscLog.write('*~*~*~*~* Applications Installed *~*~*~*~*\n')
	DiscLog.write('*~* Applications Folder\n')
	count = 0
	AppDir = os.listdir('/Applications')
	DiscLog.write('\n')
	for app in sorted(AppDir):
		if fnmatch.fnmatch(app, '*.app'):
			DiscLog.write(app + '\n')
			count += 1
	DiscLog.write('\n')
	DiscLog.write('No. of Apps: '+ str(count) + '\n')
	DiscLog.write('\n')

	DiscLog.write('*~* Utilities Folder\n')
	count = 0
	AppDir = os.listdir('/Applications/Utilities')
	DiscLog.write('\n')
	for app in sorted(AppDir):
		if fnmatch.fnmatch(app, '*.app'):
			DiscLog.write(app + '\n')
			count += 1
	DiscLog.write('\n')
	DiscLog.write('No. of Apps: '+ str(count) + '\n')
	DiscLog.write('\n')

def EmailDiscovery():
	# email the resulting discovery report to the users
	list_Discoveries = glob.glob('/Users/Shared/Old_Discoveries/Discovery_*.txt')
	latest_DiscReport = max(list_Discoveries, key=os.path.getctime)

	sender_email = (name + "@CompanyName.com")
	# receivers=[ sender_email, 'user1@CompanyName.com' ]
	receivers=[ sender_email, 'user1@CompanyName.com', 'puser2@gCompanyName.com', 'user3@CompanyName.com']

	# Create a multipart message and set headers
	message = EmailMessage()
	message["From"] = sender_email
	message["To"] = sender_email
	message["Subject"] = "Discovery report for " + hostName
	# Recommended for mass emails
	message["Bcc"] = ', '.join(receivers)
	message.set_content("""\
		Hi!

		You should find the Discovery report from 
		""" + hostName + """ as an attachment.
		
		Report was generated and sent by:

		""" + sender_email + """\
		
		""")

	# Open the DiscoveryReport file for attachment.
	message.add_attachment(open(latest_DiscReport, "r").read(), filename=latest_DiscReport)

	# Send the message via our own SMTP server.
	with smtplib.SMTP('smtp.CompanyName.com') as s:
		s.send_message(message)
		s.quit()

# mark the beginning of the report by date and time generated
DateTimeMarker()
# creating a GUI to get username from tech
requestname = tk.Tk()
requestname.title("Request for Discovery Report")
requestname.geometry("400x200")
# Gets both half the screen width/height and window width/height
positionRight = int(requestname.winfo_screenwidth()/2 - 200)
positionDown = int(requestname.winfo_screenheight()/2 - 100)
# Positions the window in the center of the page.
requestname.geometry("+{}+{}".format(positionRight, positionDown))
# creating a label for widget
requestframe = ttk.LabelFrame(requestname, text = 'Enter your Username to receive the Discovery Report')
requestframe.grid(column=0, row=0, padx=6, pady=2)

# declaring string variable for storing name
usrname = tk.StringVar()
requestEntry = tk.Entry(requestframe, bd=4, justify='center', textvariable=usrname)
requestEntry.grid(row=1,
column=0,
padx=70,
pady=40,
ipadx=20,
ipady=5)
#Make the window jump above all
requestname.attributes('-topmost',True)

# defining a function that will
# get the name entered
def submit():
	global name
	name = usrname.get()
	usrname.set("")
	requestname.quit()

# creating a button that will call the submit function
action = ttk.Button(requestframe,text = 'Click to Continue', command=submit)
action.grid(column=0, row=8, padx=10, pady=10)
requestEntry.focus()
requestname.mainloop()

# Asset Name, Accounts
COMPUNAMES()
USERACCTS()

# Installed OS and System Configuration Settings
MacOSInfo()
SystemInfo()
ActivDirStatus()
DisplaysConnected()
BlueToothStatus()
PrintScanInstalled()
NetworkPorts()

# Hardware Inventory
SWUpdateHistory()
TimeMachStatus()
DesignFonts()

InternetPlugins()
ApplicationPlugins()
AddtlPreferencePanes()
ApplicationsInstalled()

DateTimeMarker()
DiscLog.write('\n')
# Close the log file
DiscLog.close()
EmailDiscovery()

exit()