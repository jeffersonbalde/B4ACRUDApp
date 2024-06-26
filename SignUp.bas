﻿B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=12.8
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: False
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	
	Private xui As XUI
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

	Private Name As B4XFloatTextField
	Private Email As B4XFloatTextField  
	Private Password As B4XFloatTextField
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("SignUp")
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Public Sub insertData As ResumableSub
	Dim result As Boolean
	
	Try
		Dim query As String = $"INSERT INTO accounts (name, email, password) VALUES (?,?,?)"$
		Main.sql.ExecNonQuery2(query, Array As Object(Name.Text, Email.Text, Password.Text))
		result = True
	Catch
		Log(LastException)
		xui.MsgboxAsync(LastException, "Error")
		result = False
	End Try

	Return result
End Sub


Private Sub RegisterButton_Click
	Try
		Wait For (insertData) Complete (Success As Boolean)
		If Success Then
			xui.MsgboxAsync("Register Complete", "Register")
			Wait For Msgbox_Result (response As Int)
			If response = xui.DialogResponse_Positive Then
				StartActivity(Main)
				Activity.Finish
			End If
		End If
	Catch
		Log(LastException)
		xui.MsgboxAsync(LastException, "Error")
	End Try
End Sub