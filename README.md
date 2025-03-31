# NTUT WiFi Auto Login
A powershell script to login NTUT WiFi automatically

## Installation

1. Clone this repo by clicking the `Code` button, download zip, on the top right of the page

2. Extract the zip file to the path where you want to install this script

3. Use text editor to open the ``login.ps1``, and fill in these variable below

```shell
# Fill in your login credientials here
$USERNAME = 'Student ID HERE'
$PASSWORD = 'NTUT Portocal Password HERE';
```

4. After filling the information, you can right click on the ``login.ps1`` and run the script to test if the script is working

5. Now open ``run.vbs`` in any text editor, replace these lines below
```vbs
command = "powershell.exe ... -file "".\login.ps1"" "
```
```vbs
command = "powershell.exe ... -file ""<ABSOLUTE_PATH_TO_THE_SCRIPT>\login.ps1"" "
```

6. Open task scheduler, click on ``import task`` on the right side panel, and select ``WiFi Login Task.xml`` to import the task.

7. On the ``User`` section, select your own user

8. Go to ``Action`` tab, double click on the wscript.exe tile and replace the argument with the absolute path to the ``run.vbs``

8. Click apply and all done !