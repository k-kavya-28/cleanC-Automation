$users = Get-ChildItem -Path "C:\Users" -Directory

foreach ($user in $users) {
    $appDataLocalPath = Join-Path -Path $user.FullName -ChildPath "AppData\Local"

    # Additional paths to delete
    $pathsToDelete = @(
        "C:\Windows\Temp",
        "C:\Temp"
        # Add more paths here
    )

    # Delete additional paths
    foreach ($path in $pathsToDelete) {
        try {
            if (Test-Path -Path $path) {
                Remove-Item -Path $path\* -Recurse -Force -ErrorAction Stop
                Write-Host ("Deleted contents of " + $path)
            } else {
                Write-Host ("Path not found: " + $path)
            }
        } catch {
            $errorMessage = $_.Exception.Message
            Write-Host ("Failed to delete contents of " + $path + ": " + $errorMessage)
        }
    }

    try {
        if (Test-Path -Path $appDataLocalPath) {
            Remove-Item -Path $appDataLocalPath -Recurse -Force -ErrorAction Stop
            Write-Host ("Deleted " + $appDataLocalPath)
        } else {
            Write-Host ("AppData folder not found: " + $appDataLocalPath)
        }
    } catch {
        $errorMessage = $_.Exception.Message
        Write-Host ("Failed to delete " + $appDataLocalPath + ": " + $errorMessage)
    }
}

Write-Host "Deletion completed."
