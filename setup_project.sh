#!/bin/bash

cleanup() {
    echo ""
    echo "WARNING: script interrupted! Starting emergency cleanup..."

    if [ - d "attendance_tracker_${PROJECT_NAME}" ]; then
	echo "Building incomplete directory into archive..."
	tar -czf "attendance_tracker_${PROJECT_NAME}_archive.tar.gz"
	"attendance_tracker_${PROJECT_NAME}"

	rm -rf "attendance_tracker_${PROJECT_NAME}"
	echo "Incomplete directory deleted. Workspace is clean."
   else
       echo "No directory to clean up."
   fi

   echo "Goodbye."
   exit 1

}

trap cleanup SIGINT

# step 2: welcome message

echo "===================================================="
echo " Student Attendance Tracker - Project Setup"
echo "===================================================="
echo ""


# step3: ask for project name

read -p "Enter project name (example: v1): " PROJECT_NAME

if [ -z "$PROJECT_NAME" ]; then
    echo "ERROR: Project name cannot be empty. Exiting"
    echo "Please choose a different project name or delete the existing directory."
    exit 1
fi


# step 4: create directory structure


echo ""
echo " Creating Project directory Structure..."

mkdir -p "${PROJECT_DIR}/Helpers"
mkdir -p "${PROJECT_DIR}/reports"

echo "Directories created"



# step 5: copy source file

echo "Copying source file..."

SCRIPT_DIR="$(dirname "$(realpath "$0")")"


cp "${SCRIPT_DIR}/attendance_checker.py" "${PROJECT_DIR}/attendance_checker.py"

cp "${SCRIPT_DIR}/assets.csv"    "${PROJECT_DIR}/Helpers/assets.csv"

cp "${SCRIPT_DIR}/config.json"   "${PROJECT_DIR}/Helpers/config.json"

cp "${SCRIPT_DIR}/reports.log"   "${PROJECT_DIR}/reports/reports.log"


echo "All files placed successfully."








