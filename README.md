# deploy_agent_akagermain
Individual Summative lab

## What this script does

Setup_project.sh is a shell script that automatically sets up the Student Attendance Tracker project workspace.


## How to run the script

1.  Make sure all source files are in the same folder as the script:
    - attendance_checker.py
    - assets.csv
    - config.json
    - reports.log

2. Make the script executable:
   chmod +x setup_project.sh

3. Run the script: 
   ./setup_project.sh 
   or
   bash setup_project.sh

4. Follow the prompts:
   - Enter a project name (example: v2)
   - Choose whether to update attendance thresholds
   - The script will run a health check for python3

## How to trigger the archive feature

while the script is running, press Ctrl+C on your keyboard

Then the script will:

1. Catch the interrupt signal (SIGINT)
2. Bundle the incomplete project folder into a .tar.gz.archive
3. Delete the incomplete folder to keep your workspace clean 
