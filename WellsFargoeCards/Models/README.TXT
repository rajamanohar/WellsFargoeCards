/*************************************************/
/************       		        **************/
/**********  VIGO SAMPLE V1.20 README  ***********/
/************                       **************/
/*************************************************/


In order to start using the ViGo demo project, please follow these steps:

1. Download and extract the project files

2. Open the project in Xcode

3. Modify the DAViewController.m source file to add your ViGo app credentials:

	Replace the placeholder text with the ViGo developer credentials you received in the ViGo developer program registration e-mail:
		VIGO_SERVER_URL - insert the correct VIGO_SERVER_URL web services URL
		VIGO_CREDENTIAL_ID - insert your VIGO_CREDENTIAL_ID string
		VIGO_CREDENTIAL_PWD - insert your VIGO_CREDENTIAL_PWD string
		VIGO_APP_ID - insert your VIGO_APP_ID string which will be unique for each application
        VIGO_CONFIGURATION_ID - insert the VIGO_CONFIGURATION_ID that corresponds to the passphrase you wish to use
        VIGO_PHRASE_LANGUAGE - only change this if you have been supplied with a specific configuration supporting alternative languages, otherwise it should be left at the default of "EnglishUnitedStates".

4. Modify ParseViewController.m to support a selected Passphrase:

	Change the VIGO_PHRASE_TEXT to match the phrase you want to use, from the details sent in your registration e-mail. (Please ensure that the phrase is copied exactly as it appears in the email.)
	
	Finally, if the phrase is particularly long or short, or if you wish to increase or reduce the time that audio is recorded
	then change the value of VIGO_RECORD_TIME_SECS accordingly. For example, some of the longer passphrases may require a record time of 7 seconds (7.0f).
	
5. Run the sample application on a supported device, and follow the instructions:

	a) Press Registration button to move to registration screen
	b) Press Record and say phrase displayed, repeat until registration process completes
		and you are returned to the initial screen
	c) Press Login and repeat the phrase to login successfully
