Import-Module ActiveDirectory

# Running some of these commands requires elevated permissions.
$cred = Get-Credential -Message "Enter your Windows admin account [domain\username]"

$PSScriptRoot
$DisableScript= $PSScriptRoot+"\Disableuser.ps1"

function CreateForm {
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.drawing

#Form Setup
$form1 = New-Object System.Windows.Forms.Form
$button1 = New-Object System.Windows.Forms.Button
$button2 = New-Object System.Windows.Forms.Button
$checkBox1 = New-Object System.Windows.Forms.CheckBox
$checkBox2 = New-Object System.Windows.Forms.CheckBox
$checkBox3 = New-Object System.Windows.Forms.CheckBox
$checkBox4 = New-Object System.Windows.Forms.CheckBox
$TabControl = New-object System.Windows.Forms.TabControl
$NewUserPage = New-Object System.Windows.Forms.TabPage
$UserDetailPage = New-Object System.Windows.Forms.TabPage
$AddUserGroupPage = New-Object System.Windows.Forms.TabPage
$DisableaccountPage = New-Object System.Windows.Forms.TabPage

$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState

#Form Parameter
$form1.Text = "User Admin GUI"
$form1.Name = "form1"
$form1.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 900
$System_Drawing_Size.Height = 600
$form1.ClientSize = $System_Drawing_Size

$Embelton                        = New-Object System.Windows.Forms.Label
$Embelton.Text                   = ""
$Embelton.Location               = New-Object System.Drawing.Point(700,10)
$Embelton.AutoSize               = $true
$Embelton.ForeColor              = [System.Drawing.Color]::Blue
$Embelton.Font                   = 'Georgia, 26pt'
$form1.Controls.Add($Embelton)

$ForestText                      = New-Object System.Windows.Forms.Label
$ForestText.Text                 = "Current Forest Connected:"
$ForestText.Location             = New-Object System.Drawing.Point(20,10)
$ForestText.AutoSize             = $true
$form1.Controls.Add($ForestText)

$CurrentForest                   = New-Object System.Windows.Forms.Label
$CurrentForest.Text              = Get-ADForest -Current LoggedOnUser
$CurrentForest.Location          = New-Object System.Drawing.Point(160,10)
$CurrentForest.AutoSize          = $true
$form1.Controls.Add($CurrentForest)

#Tab Control 
$tabControl.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 20
$System_Drawing_Point.Y = 60
$tabControl.Location = $System_Drawing_Point
$tabControl.Name = "tabControl"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 850
$System_Drawing_Size.Height = 485
$tabControl.Size = $System_Drawing_Size
$form1.Controls.Add($tabControl)

# ------ ------ Create new User tab ------ ------ #

#Create new user Page
$NewUserPage.DataBindings.DefaultDataSourceUpdateMode = 0
$NewUserPage.UseVisualStyleBackColor = $True
$NewUserPage.Name = "Createnewuser"
$NewUserPage.Text = "Create new user"
$NewUserPage.BorderStyle = 'Fixed3D'
$tabControl.Controls.Add($NewUserPage)

# New user functions and labels
$FirstNameLabel                  = New-Object system.Windows.Forms.Label
$FirstNameLabel.text             = "First Name"
$FirstNameLabel.AutoSize         = $true
$FirstNameLabel.width            = 25
$FirstNameLabel.height           = 10
$FirstNameLabel.location         = New-Object System.Drawing.Point(20,20)
$FirstNameLabel.Font             = 'Microsoft Sans Serif,10,style=Bold'
$NewUserPage.Controls.Add($FirstNameLabel)

# First Name
$Fname                           = New-Object system.Windows.Forms.TextBox
$Fname.multiline                 = $false
$Fname.width                     = 205
$Fname.height                    = 30
$Fname.location                  = New-Object System.Drawing.Point(120,20)
$Fname.Font                      = 'Microsoft Sans Serif,10'
$NewUserPage.Controls.Add($Fname)

# Last Name
$LastNameLabel                   = New-Object system.Windows.Forms.Label
$LastNameLabel.text              = "Last Name"
$LastNameLabel.AutoSize          = $true
$LastNameLabel.width             = 25
$LastNameLabel.height            = 10
$LastNameLabel.location          = New-Object System.Drawing.Point(20,70)
$LastNameLabel.Font              = 'Microsoft Sans Serif,10,style=Bold'
$NewUserPage.Controls.Add($LastNameLabel)

$LName                           = New-Object system.Windows.Forms.TextBox
$LName.multiline                 = $false
$LName.width                     = 205
$LName.height                    = 20
$LName.location                  = New-Object System.Drawing.Point(120,70)
$LName.Font                      = 'Microsoft Sans Serif,10'
$NewUserPage.Controls.Add($LName)

# User Name
$UserLabel                       = New-Object system.Windows.Forms.Label
$UserLabel.text                  = "Username"
$UserLabel.AutoSize              = $true
$UserLabel.width                 = 25
$UserLabel.height                = 10
$UserLabel.location              = New-Object System.Drawing.Point(20,120)
$UserLabel.Font                  = 'Microsoft Sans Serif,10,style=Bold'
$NewUserPage.Controls.Add($UserLabel)

$Username                        = New-Object system.Windows.Forms.TextBox
$Username.multiline              = $false
$Username.width                  = 205
$Username.height                 = 20
$Username.location               = New-Object System.Drawing.Point(120,120)
$Username.Font                   = 'Microsoft Sans Serif,10'
$NewUserPage.Controls.Add($Username)

# Password
$PasswordText                    = New-Object system.Windows.Forms.Label
$PasswordText.text               = "Password"
$PasswordText.AutoSize           = $true
$PasswordText.width              = 25
$PasswordText.height             = 10
$PasswordText.location           = New-Object System.Drawing.Point(20,170)
$PasswordText.Font               = 'Microsoft Sans Serif,10,style=Bold'
$NewUserPage.Controls.Add($PasswordText)

$Password                        = New-Object system.Windows.Forms.MaskedTextBox
$Password.PasswordChar           = '*'
$Password.multiline              = $false
$Password.width                  = 206
$Password.height                 = 20
$Password.location               = New-Object System.Drawing.Point(120,170)
$Password.Font                   = 'Microsoft Sans Serif,10'
$NewUserPage.Controls.Add($Password)

# Profile Path
$ProfileLbel                     = New-Object system.Windows.Forms.Label
$ProfileLbel.text                = "Profile Path"
$ProfileLbel.AutoSize            = $true
$ProfileLbel.width               = 25
$ProfileLbel.height              = 10
$ProfileLbel.location            = New-Object System.Drawing.Point(20,220)
$ProfileLbel.Font                = 'Microsoft Sans Serif,10,style=Bold'
$NewUserPage.Controls.Add($ProfileLbel)

$ProfileBox                      = New-Object system.Windows.Forms.TextBox
$ProfileBox.multiline            = $false
$ProfileBox.width                = 205
$ProfileBox.height               = 20
$ProfileBox.location             = New-Object System.Drawing.Point(120,220)
$ProfileBox.Font                 = 'Microsoft Sans Serif,10'
$NewUserPage.Controls.Add($ProfileBox)

# Home Drive
$HomeLabel                       = New-Object system.Windows.Forms.Label
$HomeLabel.text                  = "Drive"
$HomeLabel.AutoSize              = $true
$HomeLabel.width                 = 25
$HomeLabel.height                = 10
$HomeLabel.location              = New-Object System.Drawing.Point(20,270)
$HomeLabel.Font                  = 'Microsoft Sans Serif,10,style=Bold'
$NewUserPage.Controls.Add($HomeLabel)

$HomeBox                         = New-Object system.Windows.Forms.TextBox
$HomeBox.multiline               = $false
$HomeBox.width                   = 205
$HomeBox.height                  = 20
$HomeBox.location                = New-Object System.Drawing.Point(120,270)
$HomeBox.Font                    = 'Microsoft Sans Serif,10'
$NewUserPage.Controls.Add($HomeBox)

# Mobile Number
$MobileLabel                     = New-Object system.Windows.Forms.Label
$MobileLabel.text                = "Mobile"
$MobileLabel.AutoSize            = $true
$MobileLabel.width               = 25
$MobileLabel.height              = 10
$MobileLabel.location            = New-Object System.Drawing.Point(20,320)
$MobileLabel.Font                = 'Microsoft Sans Serif,10,style=Bold'
$NewUserPage.Controls.Add($MobileLabel)

$Mobile                          = New-Object system.Windows.Forms.TextBox
$Mobile.multiline                = $false
$Mobile.width                    = 205
$Mobile.height                   = 20
$Mobile.location                 = New-Object System.Drawing.Point(120,320)
$Mobile.Font                     = 'Microsoft Sans Serif,10'
$NewUserPage.Controls.Add($Mobile)

# Job Title
$TitleLabel                      = New-Object system.Windows.Forms.Label
$TitleLabel.text                 = "Job Title"
$TitleLabel.AutoSize             = $true
$TitleLabel.width                = 25
$TitleLabel.height               = 10
$TitleLabel.location             = New-Object System.Drawing.Point(480,20)
$TitleLabel.Font                 = 'Microsoft Sans Serif,10,style=Bold'
$NewUserPage.Controls.Add($TitleLabel)

$JTitle                          = New-Object system.Windows.Forms.TextBox
$JTitle.multiline                = $false
$JTitle.width                    = 205
$JTitle.height                   = 20
$JTitle.location                 = New-Object System.Drawing.Point(580,20)
$JTitle.Font                     = 'Microsoft Sans Serif,10'
$NewUserPage.Controls.Add($JTitle)

# Department
$DepartmentLabel                 = New-Object system.Windows.Forms.Label
$DepartmentLabel.text            = "Department"
$DepartmentLabel.AutoSize        = $true
$DepartmentLabel.width           = 25
$DepartmentLabel.height          = 10
$DepartmentLabel.location        = New-Object System.Drawing.Point(480,70)
$DepartmentLabel.Font            = 'Microsoft Sans Serif,10,style=Bold'
$NewUserPage.Controls.Add($DepartmentLabel)

$Department                      = New-Object system.Windows.Forms.MaskedTextBox
$Department.multiline            = $false
$Department.width                = 205
$Department.height               = 20
$Department.location             = New-Object System.Drawing.Point(580,70)
$Department.Font                 = 'Microsoft Sans Serif,10'
$NewUserPage.Controls.Add($Department)

# Text "Select a branch"
$SelectBranchText                = New-Object System.Windows.Forms.Label
$SelectBranchText.Text           = "Please Select a branch and press populate:"
$SelectBranchText.Location       = New-Object System.Drawing.Point(525,110)
$SelectBranchText.AutoSize       = $true
$NewUserPage.Controls.Add($SelectBranchText)

# Branch Drop Down Menu
$branchBox                       = New-Object System.Windows.Forms.ComboBox
$branchBox.Location              = New-Object System.Drawing.Point(540, 130)
$branchBox.Size                  = New-Object System.Drawing.Size(100,20)
$branchBox.Height                = 80
$NewUserPage.Controls.Add($branchBox)

[void] $branchBox.Items.Add('Brisbane')
[void] $branchBox.Items.Add('Coburg')
[void] $branchBox.Items.Add('Huntingdale')
[void] $branchBox.Items.Add('Perth')
[void] $branchBox.Items.Add('Sydney')

# Branch auto-populate button
$BranchPopulateButton            = New-Object System.Windows.Forms.Button
$BranchPopulateButton.Location   = New-Object System.Drawing.Point(660, 130)
$BranchPopulateButton.Size       = New-Object System.Drawing.Size(75,23)
$BranchPopulateButton.Text       = 'Populate'
#$NewUserPage.AcceptButton       = $BranchPopulateButton
$NewUserPage.Controls.Add($BranchPopulateButton)

# Branch 
$BranchLabel                     = New-Object system.Windows.Forms.Label
$BranchLabel.text                = "Branch"
$BranchLabel.AutoSize            = $true
$BranchLabel.width               = 25
$BranchLabel.height              = 10
$BranchLabel.location            = New-Object System.Drawing.Point(480,170)
$BranchLabel.Font                = 'Microsoft Sans Serif,10,style=Bold'
$NewUserPage.Controls.Add($BranchLabel)

$Branch                          = New-Object system.Windows.Forms.TextBox
$Branch.multiline                = $false
$Branch.width                    = 205
$Branch.height                   = 20
$Branch.location                 = New-Object System.Drawing.Point(580,170)
$Branch.Font                     = 'Microsoft Sans Serif,10'
$NewUserPage.Controls.Add($Branch)

# State
$StateLabel                      = New-Object system.Windows.Forms.Label
$StateLabel.text                 = "State"
$StateLabel.AutoSize             = $true
$StateLabel.width                = 25
$StateLabel.height               = 10
$StateLabel.location              = New-Object System.Drawing.Point(480,220)
$StateLabel.Font                 = 'Microsoft Sans Serif,10,style=Bold'
$NewUserPage.Controls.Add($StateLabel)

$Statebox                        = New-Object system.Windows.Forms.TextBox
$Statebox.multiline              = $false
$Statebox.width                  = 205
$Statebox.height                 = 20
$Statebox.location               = New-Object System.Drawing.Point(580,220)
$Statebox.Font                   = 'Microsoft Sans Serif,10'
$NewUserPage.Controls.Add($Statebox)

# City
$CityLabel                       = New-Object system.Windows.Forms.Label
$CityLabel.text                  = "City"
$CityLabel.AutoSize              = $true
$CityLabel.width                 = 25
$CityLabel.height                = 10
$CityLabel.location            = New-Object System.Drawing.Point(480,270)
$CityLabel.Font                  = 'Microsoft Sans Serif,10,style=Bold'
$NewUserPage.Controls.Add($CityLabel)

$City                            = New-Object system.Windows.Forms.TextBox
$City.multiline                  = $false
$City.width                      = 205
$City.height                     = 20
$City.location                  = New-Object System.Drawing.Point(580,270)
$City.Font                       = 'Microsoft Sans Serif,10'
$NewUserPage.Controls.Add($City)

# Post Code
$PostalLabel                     = New-Object system.Windows.Forms.Label
$PostalLabel.text                = "Postal"
$PostalLabel.AutoSize            = $true
$PostalLabel.width               = 25
$PostalLabel.height              = 10
$PostalLabel.location            = New-Object System.Drawing.Point(480,320)
$PostalLabel.Font                = 'Microsoft Sans Serif,10,style=Bold'
$NewUserPage.Controls.Add($PostalLabel)

$PCode                           = New-Object system.Windows.Forms.TextBox
$PCode.multiline                 = $false
$PCode.width                     = 205
$PCode.height                    = 20
$PCode.location                  = New-Object System.Drawing.Point(580,320)
$PCode.Font                      = 'Microsoft Sans Serif,10'
$NewUserPage.Controls.Add($PCode)

# Street
$StreetLabel                     = New-Object system.Windows.Forms.Label
$StreetLabel.text                = "Street"
$StreetLabel.AutoSize            = $true
$StreetLabel.width               = 25
$StreetLabel.height              = 10
$StreetLabel.location            = New-Object System.Drawing.Point(480,370)
$StreetLabel.Font                = 'Microsoft Sans Serif,10,style=Bold'
$NewUserPage.Controls.Add($StreetLabel)

$Street                          = New-Object system.Windows.Forms.TextBox
$Street.multiline                = $false
$Street.width                    = 205
$Street.height                   = 20
$Street.location                 = New-Object System.Drawing.Point(580,370)
$Street.Font                     = 'Microsoft Sans Serif,10'
$NewUserPage.Controls.Add($Street)

# Display User Details Button
$NUDisplayButton                          = New-Object system.Windows.Forms.Button
$NUDisplayButton.text                     = "Display details"
$NUDisplayButton.width                    = 120
$NUDisplayButton.height                   = 25
$NUDisplayButton.location                 = New-Object System.Drawing.Point(20,410)
$NUDisplayButton.Font                     = 'Microsoft Sans Serif,10'
$NewUserPage.Controls.AddRange(@($NUDisplayButton))

# ------ ------ User details tab ------ ------ #

#User details Page
$UserDetailPage.DataBindings.DefaultDataSourceUpdateMode = 0
$UserDetailPage.UseVisualStyleBackColor = $True
$UserDetailPage.Name = "UserDetails"
$UserDetailPage.Text = "User Details"
$UserDetailPage.BorderStyle = 'Fixed3D'
$tabControl.Controls.Add($UserDetailPage)

# New user functions and labels

# First Name
$DetailsFirstNameLabel                  = New-Object system.Windows.Forms.Label
$DetailsFirstNameLabel.text             = "First Name"
$DetailsFirstNameLabel.AutoSize         = $true
$DetailsFirstNameLabel.width            = 25
$DetailsFirstNameLabel.height           = 10
$DetailsFirstNameLabel.location         = New-Object System.Drawing.Point(20,120)
$DetailsFirstNameLabel.Font             = 'Microsoft Sans Serif,10,style=Bold'
$UserDetailPage.Controls.Add($DetailsFirstNameLabel)

$DetailsFname                           = New-Object system.Windows.Forms.TextBox
$DetailsFname.multiline                 = $false
$DetailsFname.width                     = 205
$DetailsFname.height                    = 30
$DetailsFname.location                  = New-Object System.Drawing.Point(120,120)
$DetailsFname.Font                      = 'Microsoft Sans Serif,10'
$UserDetailPage.Controls.Add($DetailsFname)

# User Name
$DetailsUserLabel                       = New-Object system.Windows.Forms.Label
$DetailsUserLabel.text                  = "Username"
$DetailsUserLabel.AutoSize              = $true
$DetailsUserLabel.width                 = 25
$DetailsUserLabel.height                = 10
$DetailsUserLabel.location              = New-Object System.Drawing.Point(20,20)
$DetailsUserLabel.Font                  = 'Microsoft Sans Serif,10,style=Bold'
$UserDetailPage.Controls.Add($DetailsUserLabel)

$DetailsUsername                        = New-Object system.Windows.Forms.TextBox
$DetailsUsername.multiline              = $false
$DetailsUsername.width                  = 205
$DetailsUsername.height                 = 20
$DetailsUsername.location               = New-Object System.Drawing.Point(120,20)
$DetailsUsername.Font                   = 'Microsoft Sans Serif,10'
$UserDetailPage.Controls.Add($DetailsUsername)

# Last Name
$DetailsLastNameLabel                   = New-Object system.Windows.Forms.Label
$DetailsLastNameLabel.text              = "Last Name"
$DetailsLastNameLabel.AutoSize          = $true
$DetailsLastNameLabel.width             = 25
$DetailsLastNameLabel.height            = 10
$DetailsLastNameLabel.location          = New-Object System.Drawing.Point(20,70)
$DetailsLastNameLabel.Font              = 'Microsoft Sans Serif,10,style=Bold'
$UserDetailPage.Controls.Add($DetailsLastNameLabel)

$DetailsLName                           = New-Object system.Windows.Forms.TextBox
$DetailsLName.multiline                 = $false
$DetailsLName.width                     = 205
$DetailsLName.height                    = 20
$DetailsLName.location                  = New-Object System.Drawing.Point(120,70)
$DetailsLName.Font                      = 'Microsoft Sans Serif,10'
$UserDetailPage.Controls.Add($DetailsLName)

# Profile Path
$DetailsProfileLbel                     = New-Object system.Windows.Forms.Label
$DetailsProfileLbel.text                = "Profile Path"
$DetailsProfileLbel.AutoSize            = $true
$DetailsProfileLbel.width               = 25
$DetailsProfileLbel.height              = 10
$DetailsProfileLbel.location            = New-Object System.Drawing.Point(20,170)
$DetailsProfileLbel.Font                = 'Microsoft Sans Serif,10,style=Bold'
$UserDetailPage.Controls.Add($DetailsProfileLbel)

$DetailsProfileBox                      = New-Object system.Windows.Forms.TextBox
$DetailsProfileBox.multiline            = $false
$DetailsProfileBox.width                = 205
$DetailsProfileBox.height               = 20
$DetailsProfileBox.location             = New-Object System.Drawing.Point(120,170)
$DetailsProfileBox.Font                 = 'Microsoft Sans Serif,10'
$UserDetailPage.Controls.Add($DetailsProfileBox)

# Home Drive
$DetailsHomeLabel                       = New-Object system.Windows.Forms.Label
$DetailsHomeLabel.text                  = "Drive"
$DetailsHomeLabel.AutoSize              = $true
$DetailsHomeLabel.width                 = 25
$DetailsHomeLabel.height                = 10
$DetailsHomeLabel.location              = New-Object System.Drawing.Point(20,220)
$DetailsHomeLabel.Font                  = 'Microsoft Sans Serif,10,style=Bold'
$UserDetailPage.Controls.Add($DetailsHomeLabel)

$DetailsHomeBox                         = New-Object system.Windows.Forms.TextBox
$DetailsHomeBox.multiline               = $false
$DetailsHomeBox.width                   = 205
$DetailsHomeBox.height                  = 20
$DetailsHomeBox.location                = New-Object System.Drawing.Point(120,220)
$DetailsHomeBox.Font                    = 'Microsoft Sans Serif,10'
$UserDetailPage.Controls.Add($DetailsHomeBox)

# Mobile Number
$DetailsMobileLabel                     = New-Object system.Windows.Forms.Label
$DetailsMobileLabel.text                = "Mobile"
$DetailsMobileLabel.AutoSize            = $true
$DetailsMobileLabel.width               = 25
$DetailsMobileLabel.height              = 10
$DetailsMobileLabel.location            = New-Object System.Drawing.Point(20,270)
$DetailsMobileLabel.Font                = 'Microsoft Sans Serif,10,style=Bold'
$UserDetailPage.Controls.Add($DetailsMobileLabel)

$DetailsMobile                          = New-Object system.Windows.Forms.TextBox
$DetailsMobile.multiline                = $false
$DetailsMobile.width                    = 205
$DetailsMobile.height                   = 20
$DetailsMobile.location                 = New-Object System.Drawing.Point(120,270)
$DetailsMobile.Font                     = 'Microsoft Sans Serif,10'
$UserDetailPage.Controls.Add($DetailsMobile)

# Job Title
$DetailsTitleLabel                      = New-Object system.Windows.Forms.Label
$DetailsTitleLabel.text                 = "Job Title"
$DetailsTitleLabel.AutoSize             = $true
$DetailsTitleLabel.width                = 25
$DetailsTitleLabel.height               = 10
$DetailsTitleLabel.location             = New-Object System.Drawing.Point(480,20)
$DetailsTitleLabel.Font                 = 'Microsoft Sans Serif,10,style=Bold'
$UserDetailPage.Controls.Add($DetailsTitleLabel)

$DetailsJTitle                          = New-Object system.Windows.Forms.TextBox
$DetailsJTitle.multiline                = $false
$DetailsJTitle.width                    = 205
$DetailsJTitle.height                   = 20
$DetailsJTitle.location                 = New-Object System.Drawing.Point(580,20)
$DetailsJTitle.Font                     = 'Microsoft Sans Serif,10'
$UserDetailPage.Controls.Add($DetailsJTitle)

# Department
$DetailsDepartmentLabel                 = New-Object system.Windows.Forms.Label
$DetailsDepartmentLabel.text            = "Department"
$DetailsDepartmentLabel.AutoSize        = $true
$DetailsDepartmentLabel.width           = 25
$DetailsDepartmentLabel.height          = 10
$DetailsDepartmentLabel.location        = New-Object System.Drawing.Point(480,70)
$DetailsDepartmentLabel.Font            = 'Microsoft Sans Serif,10,style=Bold'
$UserDetailPage.Controls.Add($DetailsDepartmentLabel)

$DetailsDepartment                      = New-Object system.Windows.Forms.MaskedTextBox
$DetailsDepartment.multiline            = $false
$DetailsDepartment.width                = 205
$DetailsDepartment.height               = 20
$DetailsDepartment.location             = New-Object System.Drawing.Point(580,70)
$DetailsDepartment.Font                 = 'Microsoft Sans Serif,10'
$UserDetailPage.Controls.Add($DetailsDepartment)

# Branch 
$DetailsBranchLabel                     = New-Object system.Windows.Forms.Label
$DetailsBranchLabel.text                = "Branch"
$DetailsBranchLabel.AutoSize            = $true
$DetailsBranchLabel.width               = 25
$DetailsBranchLabel.height              = 10
$DetailsBranchLabel.location            = New-Object System.Drawing.Point(480,120)
$DetailsBranchLabel.Font                = 'Microsoft Sans Serif,10,style=Bold'
$UserDetailPage.Controls.Add($DetailsBranchLabel)

$DetailsBranch                          = New-Object system.Windows.Forms.TextBox
$DetailsBranch.multiline                = $false
$DetailsBranch.width                    = 205
$DetailsBranch.height                   = 20
$DetailsBranch.location                 = New-Object System.Drawing.Point(580,120)
$DetailsBranch.Font                     = 'Microsoft Sans Serif,10'
$UserDetailPage.Controls.Add($DetailsBranch)

# State
$DetailsStateLabel                      = New-Object system.Windows.Forms.Label
$DetailsStateLabel.text                 = "State"
$DetailsStateLabel.AutoSize             = $true
$DetailsStateLabel.width                = 25
$DetailsStateLabel.height               = 10
$DetailsStateLabel.location              = New-Object System.Drawing.Point(480,170)
$DetailsStateLabel.Font                 = 'Microsoft Sans Serif,10,style=Bold'
$UserDetailPage.Controls.Add($DetailsStateLabel)

$DetailsStatebox                        = New-Object system.Windows.Forms.TextBox
$DetailsStatebox.multiline              = $false
$DetailsStatebox.width                  = 205
$DetailsStatebox.height                 = 20
$DetailsStatebox.location               = New-Object System.Drawing.Point(580,170)
$DetailsStatebox.Font                   = 'Microsoft Sans Serif,10'
$UserDetailPage.Controls.Add($DetailsStatebox)

# City
$DetailsCityLabel                       = New-Object system.Windows.Forms.Label
$DetailsCityLabel.text                  = "City"
$DetailsCityLabel.AutoSize              = $true
$DetailsCityLabel.width                 = 25
$DetailsCityLabel.height                = 10
$DetailsCityLabel.location            = New-Object System.Drawing.Point(480,220)
$DetailsCityLabel.Font                  = 'Microsoft Sans Serif,10,style=Bold'
$UserDetailPage.Controls.Add($DetailsCityLabel)

$DetailsCity                            = New-Object system.Windows.Forms.TextBox
$DetailsCity.multiline                  = $false
$DetailsCity.width                      = 205
$DetailsCity.height                     = 20
$DetailsCity.location                  = New-Object System.Drawing.Point(580,220)
$DetailsCity.Font                       = 'Microsoft Sans Serif,10'
$UserDetailPage.Controls.Add($DetailsCity)

# Post Code
$DetailsPostalLabel                     = New-Object system.Windows.Forms.Label
$DetailsPostalLabel.text                = "Postal"
$DetailsPostalLabel.AutoSize            = $true
$DetailsPostalLabel.width               = 25
$DetailsPostalLabel.height              = 10
$DetailsPostalLabel.location            = New-Object System.Drawing.Point(480,270)
$DetailsPostalLabel.Font                = 'Microsoft Sans Serif,10,style=Bold'
$UserDetailPage.Controls.Add($DetailsPostalLabel)

$DetailsPCode                           = New-Object system.Windows.Forms.TextBox
$DetailsPCode.multiline                 = $false
$DetailsPCode.width                     = 205
$DetailsPCode.height                    = 20
$DetailsPCode.location                  = New-Object System.Drawing.Point(580,270)
$DetailsPCode.Font                      = 'Microsoft Sans Serif,10'
$UserDetailPage.Controls.Add($DetailsPCode)

# Street
$DetailsStreetLabel                     = New-Object system.Windows.Forms.Label
$DetailsStreetLabel.text                = "Street"
$DetailsStreetLabel.AutoSize            = $true
$DetailsStreetLabel.width               = 25
$DetailsStreetLabel.height              = 10
$DetailsStreetLabel.location            = New-Object System.Drawing.Point(480,320)
$DetailsStreetLabel.Font                = 'Microsoft Sans Serif,10,style=Bold'
$UserDetailPage.Controls.Add($DetailsStreetLabel)

$DetailsStreet                          = New-Object system.Windows.Forms.TextBox
$DetailsStreet.multiline                = $false
$DetailsStreet.width                    = 205
$DetailsStreet.height                   = 20
$DetailsStreet.location                 = New-Object System.Drawing.Point(580,320)
$DetailsStreet.Font                     = 'Microsoft Sans Serif,10'
$UserDetailPage.Controls.Add($DetailsStreet)

# Display Groups

$GroupLabel                      = New-Object system.Windows.Forms.Label
$GroupLabel.text                 = "Groups"
$GroupLabel.AutoSize             = $true
$GroupLabel.width                = 25
$GroupLabel.height               = 10
$GroupLabel.location             = New-Object System.Drawing.Point(20,315)
$GroupLabel.Font                 = 'Microsoft Sans Serif,10,style=Bold'
$UserDetailPage.Controls.Add($GroupLabel)

$GroupsList                      = New-Object system.Windows.Forms.ListBox
$GroupsList.BackColor            = "#ffffff"
$GroupsList.text                 = "listBox"
$GroupsList.width                = 320
$GroupsList.height               = 120
$GroupsList.location             = New-Object System.Drawing.Point(20,340)
$GroupsList.SelectionMode         = "MultiExtended"
$UserDetailPage.Controls.Add($GroupsList)

# Display User Details Button
$DisplayButton                          = New-Object system.Windows.Forms.Button
$DisplayButton.text                     = "Display details"
$DisplayButton.width                    = 120
$DisplayButton.height                   = 25
$DisplayButton.location                 = New-Object System.Drawing.Point(665,410)
$DisplayButton.Font                     = 'Microsoft Sans Serif,10'
$UserDetailPage.Controls.AddRange(@($DisplayButton))

# ------ ------ Add Users group tab ------ ------ #

#Add groups Page
$AddUserGroupPage.DataBindings.DefaultDataSourceUpdateMode = 0
$AddUserGroupPage.UseVisualStyleBackColor = $True
$AddUserGroupPage.Name = "AddUserGroup"
$AddUserGroupPage.Text = "Add Group"
$AddUserGroupPage.BorderStyle = 'Fixed3D'
$tabControl.Controls.Add($AddUserGroupPage)

# Text for username
$AddUTG                      = New-Object System.Windows.Forms.Label
$AddUTG.Text                 = "Specify the user name and select the group:"
$AddUTG.Location             = New-Object System.Drawing.Point(20,10)
$AddUTG.AutoSize             = $true
$AddUserGroupPage.Controls.Add($AddUTG)

# User Name
$GroupUserLabel                       = New-Object system.Windows.Forms.Label
$GroupUserLabel.text                  = "Username"
$GroupUserLabel.AutoSize              = $true
$GroupUserLabel.width                 = 25
$GroupUserLabel.height                = 10
$GroupUserLabel.location              = New-Object System.Drawing.Point(20,40)
$GroupUserLabel.Font                  = 'Microsoft Sans Serif,10,style=Bold'
$AddUserGroupPage.Controls.Add($GroupUserLabel)

$GroupUsername                        = New-Object system.Windows.Forms.TextBox
$GroupUsername.multiline              = $false
$GroupUsername.width                  = 205
$GroupUsername.height                 = 20
$GroupUsername.location               = New-Object System.Drawing.Point(120,40)
$GroupUsername.Font                   = 'Microsoft Sans Serif,10'
$AddUserGroupPage.Controls.Add($GroupUsername)

# Group box to list all groups available
$AllGroupLabel                      = New-Object system.Windows.Forms.Label
$AllGroupLabel.text                 = "All Groups available"
$AllGroupLabel.AutoSize             = $true
$AllGroupLabel.width                = 25
$AllGroupLabel.height               = 10
$AllGroupLabel.location             = New-Object System.Drawing.Point(20,70)
$AllGroupLabel.Font                 = 'Microsoft Sans Serif,10,style=Bold'
$AddUserGroupPage.Controls.Add($AllGroupLabel)

$AllGroupsList                      = New-Object system.Windows.Forms.ListBox
$AllGroupsList.BackColor            = "#ffffff"
$AllGroupsList.text                 = "listBox"
$AllGroupsList.width                = 320
$AllGroupsList.height               = 176
$AllGroupsList.location             = New-Object System.Drawing.Point(20,90)
$AllGroupsList.SelectionMode         = "MultiExtended"
$AddUserGroupPage.Controls.Add($AllGroupsList)

# Group box to list display a specific users groups
$SpecificUserGroupLabel                      = New-Object system.Windows.Forms.Label
$SpecificUserGroupLabel.text                 = "Groups from Username"
$SpecificUserGroupLabel.AutoSize             = $true
$SpecificUserGroupLabel.width                = 25
$SpecificUserGroupLabel.height               = 10
$SpecificUserGroupLabel.location             = New-Object System.Drawing.Point(500,70)
$SpecificUserGroupLabel.Font                 = 'Microsoft Sans Serif,10,style=Bold'
$AddUserGroupPage.Controls.Add($SpecificUserGroupLabel)

$SpecificUserGroups                     = New-Object system.Windows.Forms.ListBox
$SpecificUserGroups.BackColor            = "#ffffff"
$SpecificUserGroups.text                 = "listBox"
$SpecificUserGroups.width                = 320
$SpecificUserGroups.height               = 176
$SpecificUserGroups.location             = New-Object System.Drawing.Point(500,90)
$SpecificUserGroups.SelectionMode         = "MultiExtended"
$AddUserGroupPage.Controls.Add($SpecificUserGroups)

# Group buttons
$DisplayGroupButton = New-Object System.Windows.Forms.Button
$DisplayGroupButton.Location = New-Object System.Drawing.Point(265,270)
$DisplayGroupButton.Size = New-Object System.Drawing.Size(75,23)
$DisplayGroupButton.Text = 'Display All'
$AddUserGroupPage.Controls.Add($DisplayGroupButton)

$AddGroups = New-Object System.Windows.Forms.Button #690
$AddGroups.Location = New-Object System.Drawing.Point(185,270)
$AddGroups.Size = New-Object System.Drawing.Size(75,23)
$AddGroups.Text = 'Add'
$AddUserGroupPage.Controls.Add($AddGroups)

$DisplayUserGroups = New-Object System.Windows.Forms.Button #690
$DisplayUserGroups.Location = New-Object System.Drawing.Point(625,270)
$DisplayUserGroups.Size = New-Object System.Drawing.Size(195,23)
$DisplayUserGroups.Text = 'Display Usernames Groups'
$AddUserGroupPage.Controls.Add($DisplayUserGroups)

$CopyGroups = New-Object System.Windows.Forms.Button #690
$CopyGroups.Location = New-Object System.Drawing.Point(20,430)
$CopyGroups.Size = New-Object System.Drawing.Size(100,23)
$CopyGroups.Text = 'Copy Groups'
$AddUserGroupPage.Controls.Add($CopyGroups)

# Copy Groups from another user sections:
$CopyUserGroups                      = New-Object System.Windows.Forms.Label
$CopyUserGroups.Text                 = "Copy the groups from another user:"
$CopyUserGroups.Location             = New-Object System.Drawing.Point(20,370)
$CopyUserGroups.AutoSize             = $true
$AddUserGroupPage.Controls.Add($CopyUserGroups)

# User Name copy FROM
$FromUserLabel                       = New-Object system.Windows.Forms.Label
$FromUserLabel.text                  = "Copy from Username"
$FromUserLabel.AutoSize              = $true
$FromUserLabel.width                 = 25
$FromUserLabel.height                = 10
$FromUserLabel.location              = New-Object System.Drawing.Point(20,400)
$FromUserLabel.Font                  = 'Microsoft Sans Serif,10,style=Bold'
$AddUserGroupPage.Controls.Add($FromUserLabel)

$FromUsername                        = New-Object system.Windows.Forms.TextBox
$FromUsername.multiline              = $false
$FromUsername.width                  = 205
$FromUsername.height                 = 20
$FromUsername.location               = New-Object System.Drawing.Point(180,400)
$FromUsername.Font                   = 'Microsoft Sans Serif,10'
$AddUserGroupPage.Controls.Add($FromUsername)

# User Name copy TO
$ToUserLabel                       = New-Object system.Windows.Forms.Label
$ToUserLabel.text                  = "Copy To Username"
$ToUserLabel.AutoSize              = $true
$ToUserLabel.width                 = 25
$ToUserLabel.height                = 10
$ToUserLabel.location              = New-Object System.Drawing.Point(410,400)
$ToUserLabel.Font                  = 'Microsoft Sans Serif,10,style=Bold'
$AddUserGroupPage.Controls.Add($ToUserLabel)

$ToUsername                        = New-Object system.Windows.Forms.TextBox
$ToUsername.multiline              = $false
$ToUsername.width                  = 205
$ToUsername.height                 = 20
$ToUsername.location               = New-Object System.Drawing.Point(550,400)
$ToUsername.Font                   = 'Microsoft Sans Serif,10'
$AddUserGroupPage.Controls.Add($ToUsername)

# Display specific user groups:
$DisplayAUserGroups                      = New-Object System.Windows.Forms.Label
$DisplayAUserGroups.Text                 = "Display a users groups:"
$DisplayAUserGroups.Location             = New-Object System.Drawing.Point(500,10)
$DisplayAUserGroups.AutoSize             = $true
$AddUserGroupPage.Controls.Add($DisplayAUserGroups)


# ------ ------ Disable User tab ------ ------ #

#Disable account Page
$DisableaccountPage.DataBindings.DefaultDataSourceUpdateMode = 0
$DisableaccountPage.UseVisualStyleBackColor = $True
$DisableaccountPage.Name = "DisableUser"
$DisableaccountPage.Text = "Disable User"
$DisableaccountPage.BorderStyle = 'Fixed3D'
$tabControl.Controls.Add($DisableaccountPage)

# New user functions and labels

# User Name
$DisUserLabel                       = New-Object system.Windows.Forms.Label
$DisUserLabel.text                  = "Username"
$DisUserLabel.AutoSize              = $true
$DisUserLabel.width                 = 25
$DisUserLabel.height                = 10
$DisUserLabel.location              = New-Object System.Drawing.Point(20,20)
$DisUserLabel.Font                  = 'Microsoft Sans Serif,10,style=Bold'
$DisableaccountPage.Controls.Add($DisUserLabel)

$DisUsername                        = New-Object system.Windows.Forms.TextBox
$DisUsername.multiline              = $false
$DisUsername.width                  = 205
$DisUsername.height                 = 20
$DisUsername.location               = New-Object System.Drawing.Point(120,20)
$DisUsername.Font                   = 'Microsoft Sans Serif,10'
$DisableaccountPage.Controls.Add($DisUsername)

# Disable user Button
$DisableUserButton                  = New-Object System.Windows.Forms.Button
$DisableUserButton.Location         = New-Object System.Drawing.Point(20, 170)
$DisableUserButton.Size             = New-Object System.Drawing.Size(125,23)
$DisableUserButton.Text             = 'Disable Account'
$DisableaccountPage.Controls.Add($DisableUserButton)

# Exit Button
$Exit                             = New-Object system.Windows.Forms.Button
$Exit.text                        = "Exit"
$Exit.width                       = 120
$Exit.height                      = 25
$Exit.location                    = New-Object System.Drawing.Point(750,560)
$Exit.Font                        = 'Microsoft Sans Serif,10'
$form1.Controls.AddRange(@($Exit))

# Create New User Button
$Generate                          = New-Object system.Windows.Forms.Button
$Generate.text                     = "Create user"
$Generate.width                    = 120
$Generate.height                   = 25
$Generate.location                 = New-Object System.Drawing.Point(665,410)
$Generate.Font                     = 'Microsoft Sans Serif,10'
$NewUserPage.Controls.AddRange(@($Generate))

$Generate.Add_Click({
    Generate
})

$BranchPopulateButton.Add_Click({
    BranchPopulate
})

$DisableUserButton.Add_Click({
    DisableUser
})

$DisplayButton.Add_Click({
    DisplayUserDetails
})

$NUDisplayButton.Add_Click({
    NUDisplayUserDetails
})

$DisplayGroupButton.Add_Click({
    GroupDisplay
})

$AddGroups.Add_Click({
    AddGroup
})

$DisplayUserGroups.Add_Click({
    UserGroupsDisplay
})

$CopyGroups.Add_Click({
    CopyGroups
})


#Show the Form
$form1.ShowDialog()
} #End function CreateForm

function Generate {
    $Emb = 'Embelton'
    $Fname = $Fname.Text
    $Lname = $Lname.Text
    $Branch = $Branch.Text
    $Street = $Street.Text
    $City = $City.Text
    $PCode = $PCode.Text
    $JTitle = $JTitle.Text
    $Department = $Department.Text
    $Username = $Username.Text
    $State = $Statebox.Text
    $ProfileBox = $ProfileBox.Text
    $HomeBox = $HomeBox.Text
    $Password = (ConvertTo-SecureString $Password.Text -AsPlainText -Force)
    $Mobile = $Mobile.Text
    $FirstInitial = $Fname
    $Extract = $FirstInitial.SubString(0,1).ToLower()
    $smtplname = $Lname.ToLower()
    $proxyAddress = @{proxyAddresses = ("SMTP:" + $Extract + "." + $smtplname + "@domain.com"), ("smtp:" + $Extract + "." + $smtplname + "@domain.com.au")}
    $samaccountname = "$Extract.$Lname"

    # c is the 2 char country as per ISO-3166, co = country spelled out, countryCode integer designation the language ISO-3166
    $Australia = 'AU'

    New-ADUser -name "$Fname $Lname" -SamAccountName $samaccountname -UserPrincipalName "$Username@embelton.com" -Office $Branch -StreetAddress $Street -City $City -PostalCode $PCode -Country $Australia -Title $JTitle -Department $Department -Company $Emb -State $State -GivenName $Fname -Surname $Lname -HomeDirectory $ProfileBox -HomeDrive $HomeBox -MobilePhone $Mobile -AccountPassword $Password -Enabled $true -ChangePasswordAtLogon $true -OtherAttributes $proxyAddress -Credential $cred

    $acl = Get-Acl "\\em-s-fp02\userdata$\$samaccountname" 
    $ar = New-Object System.Security.AccessControl.FileSystemAccessRule("$samaccountname", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow") 
    $acl.SetAccessRule($ar)
    Set-Acl "\\em-s-fp02\userdata$\$samaccountname" $acl -Credential $cred

}


function BranchPopulate {
    if ($branchBox.SelectedItem -eq 'Coburg')
    {
        $Branch.Text = 'Coburg'
        $Statebox.Text = 'Victoria'
        $City.Text = 'Coburg'
        $PCode.Text = '3058'
        $Street.Text = 'xx Bakers Road'
    }
    elseif ($branchBox.SelectedItem -eq 'Brisbane')
    {
        $Branch.Text = 'Brisbane'
        $Statebox.Text = 'Queensland'
        $City.Text = 'Eagle Farm'
        $PCode.Text = '4009'
        $Street.Text = 'xx Fison Avenue East'
    }
    elseif ($branchBox.SelectedItem -eq 'Sydney')
    {
        $Branch.Text = 'Sydney'
        $Statebox.Text = 'NSW'
        $City.Text = 'Wetherill Park'
        $PCode.Text = '2164'
        $Street.Text = 'xx Newton Road'
    }
    elseif ($branchBox.SelectedItem -eq 'Huntingdale')
    {
        $Branch.Text = 'Huntingdale'
        $Statebox.Text = 'Victoria'
        $City.Text = 'Melbourne'
        $PCode.Text = '3166'
        $Street.Text = 'xx Fenton St'
    }
    elseif ($branchBox.SelectedItem -eq 'Perth')
    {
        $Branch.Text = 'Perth'
        $Statebox.Text = 'WA'
        $City.Text = 'Osborne Park'
        $PCode.Text = '6017'
        $Street.Text = 'xx Pearson Way'
    }
}

# Function for disable user click 
function DisableUser {
	$DisUsername = $DisUsername.Text

	$UserDetails = Get-ADUser -Filter "sAMAccountName -eq '$DisUsername'"  -Properties *
    $UserBranch = $UserDetails.Office
    $UserFUllName = $UserDetails.Name
    $JobTitle = $UserDetails.Title
    $Department = $UserDetails.Department
    $UserFUllName = $UserDetails.Name
    $Mobile = $UserDetails.MobilePhone
    $SamAccName = $UserDetails.sAMAccountName
    $UserPathOU = $UserDetails.DistinguishedName

    $message = "Are sure you want to disable account for: " + $DisUsername + "`n" + "`nName: " + $UserFullName + "`nBranch: "+ $UserBranch + "`nTitle: " + $JobTitle + "`nDepartment: " + $Department + "`nMobile: " + $Mobile + "`nSamAccountName: " + $SamAccName + "`n" + "`nPath: " + $UserPathOU
    Add-Type -AssemblyName System.Windows.Forms
    $msgBoxInput =  [System.Windows.Forms.MessageBox]::Show($message,'Disable User','YesNoCancel','Error')

    switch  ($msgBoxInput) {
        'Yes' {
            &$DisableScript
        }

        'No' {
            Write-Host "Account Not Disabled" 
        }
    }
}

function DisplayUserDetails {
    $Username = $DetailsUsername.Text

    $Details = Get-ADUser -Filter "sAMAccountName -eq '$Username'"  -Properties *

    $DetailsFname.Text = $Details.GivenName
    $DetailsLname.Text = $Details.Surname
    $DetailsBranch.Text = $Details.Office
    $DetailsStreet.Text = $Details.StreetAddress
    $DetailsCity.Text = $Details.City
    $DetailsPCode.Text = $Details.PostalCode
    $DetailsJTitle.Text = $Details.Title
    $DetailsDepartment.Text = $Details.Department
    $DetailsProfileBox.Text = $Details.HomeDirectory
    $DetailsHomeBox.Text = $Details.HomeDrive
    $DetailsMobile.Text = $Details.MobilePhone
    $DetailsStatebox.Text = $Details.State

    #$ADGroups = Get-ADGroup -Filter * | Sort-Object

    $ADGroups = Get-ADPrincipalGroupMembership $Username | select name

    foreach ($groupname in $ADGroups)
    {
        [void] $GroupsList.Items.Add($groupname.name) 
    }
}

function NUDisplayUserDetails {
    $Username = $Username.Text

    $Details = Get-ADUser -Filter "sAMAccountName -eq '$Username'"  -Properties *

    $Fname.Text = $Details.GivenName
    $Lname.Text = $Details.Surname
    $Branch.Text = $Details.Office
    $Street.Text = $Details.StreetAddress
    $City.Text = $Details.City
    $PCode.Text = $Details.PostalCode
    $JTitle.Text = $Details.Title
    $Department.Text = $Details.Department
    $ProfileBox.Text = $Details.HomeDirectory
    $HomeBox.Text = $Details.HomeDrive
    $Mobile.Text = $Details.MobilePhone
    $Statebox.Text = $Details.State
}

function GroupDisplay {
    $ADGroups = Get-ADGroup -Filter * | Sort-Object

    foreach ($groupname in $ADGroups)
    {
        [void] $AllGroupsList.Items.Add($groupname.name) 
    }
}

function AddGroup {
    $GroupUsername = $GroupUsername.Text

    $samaccname = Get-ADUser -Filter "sAMAccountName -eq '$GroupUsername'" | Select -ExpandProperty SamAccountName
    Write-Host $samaccname
    $NewGroups = $AllGroupsList.SelectedItem

    foreach ($group in $NewGroups) {
        Add-ADGroupMember -Identity $NewGroups -Members $GroupUsername -Credential $cred
    }
}

function UserGroupsDisplay {
    $GroupUsername = $GroupUsername.Text
    #$ADGroups = Get-ADGroup -Filter * | Sort-Object
    Write-Host $GroupUsername

    $ADGroups = Get-ADPrincipalGroupMembership $GroupUsername | select name

    foreach ($groupname in $ADGroups)
    {
        [void] $SpecificUserGroups.Items.Add($groupname.name) 
    }
}

function CopyGroups {
    $FromUserName = $FromUserName.Text
    $ToUserName = $ToUserName.Text

    Get-ADUser -Identity $FromUserName -Properties memberof -Credential $cred | Select-Object -ExpandProperty memberof | Add-ADGroupMember -Members $ToUserName -Credential $cred
}

#Call the GUI
CreateForm 

