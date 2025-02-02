param (
    [string]$configPath,
    [string]$backupPath,
    [string]$newPassword,
	# [string]$decryptBatchFilePath
	[string]$decryptBatchFileName = "WIS_Decrypt.bat",
	[string]$EncryptBatchFileName = "WIS_Encrypt.bat",
	# [string]$decrypt_configPath = "C:\Users\Path",
	# [string]$encrypt_configPath = "C:\Users\Path"
	[string]$decrypt_configPath,
	[string]$encrypt_configPath,
	[string]$DB_Name
)


# Function to validate paths
function ValidatePaths {
    param (
        [string]$configPath,
        [string]$backupPath
    )

    # Check if the file exists
    if (-Not (Test-Path $configPath)) {
        Write-Host "`nError: The Web.config file was not found at the provided path." -ForegroundColor Red
    }
    # Validate backup file path
    if (-Not (Test-Path $backupPath)) {
        Write-Host "`nError: The backup path does not exist: $backupPath" -ForegroundColor Red
        exit 1
    }
    Write-Output "`nConfig File path: $configPath"
}

try {
	
    # Validate paths using the function
    ValidatePaths -configPath $configPath -backupPath $backupPath


    # Prompt for confirmation
    $confirmation = Read-Host "Are you sure you want to update the password? [Y/N]"

    switch ($confirmation.ToLower()) {
        'y' {
			
			$dateTimeSuffix = (Get-Date).ToString("yyyyMMMdd_HHmmss")
            $backupFileName = "web_BK{0}{1}" -f $dateTimeSuffix, [System.IO.Path]::GetExtension($configPath)
            $backupFilePath = Join-Path $backupPath $backupFileName

            # Move the original file to the backup path with the new name
            Copy-Item -Path $configPath -Destination $backupFilePath -Force
            Write-Output "`nBackup created at path: $backupFilePath"
			
            # Call decrypt batch file
            Write-Output "`nDecrypt Job File: `"$decryptBatchFileName`""
            $decryptProcess = Start-Process -FilePath "./Script/$decryptBatchFileName" -ArgumentList "`"$decrypt_configPath`"" -NoNewWindow -Wait -PassThru 
            if ($decryptProcess.ExitCode -ne 0) {
                Write-Host "`nDecryption failed. Skipping backup and password update process." -ForegroundColor Red
                exit $decryptProcess.ExitCode
            }
                    


            try {
            [xml]$config = Get-Content $configPath
            $connectionString = $config.configuration.connectionStrings.add | Where-Object { $_.Attributes["name"].Value -eq $DB_Name }
            if ($connectionString) {
                $connectionString.Attributes["connectionString"].Value = $connectionString.Attributes["connectionString"].Value -replace 'Password=.*?;', "Password=$newPassword;"
                $config.Save($configPath)
				Write-Host "`n***Password updated successfully.***" -ForegroundColor Green
            } else {
                    Write-Host "`nError: Connection string with the name 'DB_Name' was not found." -ForegroundColor Red
					throw "Updating password failed."
            }
			
			# Call Encrypt batch file
			Write-Output "`nEncrypt Job File: `"$EncryptBatchFileName`""
			$EncryptProcess = Start-Process -FilePath "./Script/$EncryptBatchFileName" -ArgumentList "`"$encrypt_configPath`""  -NoNewWindow -Wait -PassThru 
			if ($EncryptProcess.ExitCode -ne 0) {
                     Write-Host "`nEncryption failed. Skipping backup and password update process." -ForegroundColor Red
					 exit $EncryptProcess.ExitCode
                }
				
            } catch {
                Write-Host "`nPassword update failed. Attempting Encryption again." -ForegroundColor Red
                Write-Output "`nEncrypt Job File: `"$EncryptBatchFileName`""
                $EncryptProcess = Start-Process -FilePath "./Script/$EncryptBatchFileName" -ArgumentList "`"$encrypt_configPath`""  -NoNewWindow -Wait -PassThru 
                if ($EncryptProcess.ExitCode -ne 0) {
                    Write-Host "`nEncryption failed. Exiting process." -ForegroundColor Red
                    exit $EncryptProcess.ExitCode
                }
            }
        }
        'n' {
            Write-Host "Operation canceled. Password was not updated." -ForegroundColor Red
        }
        default {
            Write-Host "Invalid input. Operation canceled. Please enter 'Y' for Yes or 'N' for No." -ForegroundColor Red
        }
    }
} catch {
    Write-Host "Error: Unable to process the Web.config file. $_" -ForegroundColor Red
}



