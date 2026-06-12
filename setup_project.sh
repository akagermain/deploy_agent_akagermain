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

