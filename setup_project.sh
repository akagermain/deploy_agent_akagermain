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


# step 6: Dynamic configuration i.e upadate, threshold using sed

echo ""
read -p "Do you want to update the attendance thresholds? (yes/no): " UPDATE_CONFIG



if [[ "$UPDATE_CONFIG" == "yes" || "$UPDATE_CONFIG" == "y" ]]; then



   read -p "Enter new Warning threshold % (default is 75, press Enter to keep): " WARNING_VAL

   if [ -n "$WARNING_VAL" ]; then

      if ! [[ "$WARNING_VAL" =~ ^[0-9]+$ ]] || [ "$WARNING_VAL" -lt 0 ] || [ "WARNING_VAL" -gt 100 ]; then
          echo "ERROR: Warning threshold must be a whole number between 0 and 100."
          exit 1
      fi

       sed -i "s/\"warning\": [0-9]*/\"warning\": ${WARNING_VAL}/" "${PROJECT_DIR}/Helpers/config.json"
       echo "Warning threshold updated to ${WARNING_VAL}%"
      else
        echo "Warning threshold kept at default (75%)."
    fi



    read -p "Enter new Failure threshold % (default is 50, press Enter to keep): " FAILURE_VAL

    if [ -n "$FAILURE_VAL" ]; then
        if ! [[ "$FAILURE_VAL" =~ ^[0-9]+$ ]] || [ "$FAILURE_VAL" -lt 0 ] || [ "$FAILURE_VAL" -gt 100 ]; then
            echo "ERROR: Failure threshold must be a whole number between 0 and 100."
            exit 1
        fi

        sed -i "s/\"failure\": [0-9]*/\"failure\": ${FAILURE_VAL}/" "${PROJECT_DIR}/Helpers/config.json"
        echo "Failure threshold updated to ${FAILURE_VAL}%"
    else
        echo "Failure threshold kept at default (50%)."
    fi

else
    echo "Threshold kept at defaults (Warning: 75%, Failure: 50%)."
fi




# Step 7: Environment validation and health check















































