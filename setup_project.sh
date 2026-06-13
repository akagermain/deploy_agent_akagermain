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



