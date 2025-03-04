#!/bin/bash

# List of folders in the required order (reverse for destroy)
folders=(
  "06.backend-frontend/"
  "05.internal-external/"
  "04.rds/"
  "03.bastion-vpn/"
  "02.sg/"
  "01.vpc/"
  "00.iam"
)

# Start the overall timer
overall_start=$(date +%s)

# Iterate through each folder in reverse order and execute Terraform destroy
for folder in "${folders[@]}"; do
  echo "Processing $folder..."

  # Start the timer for the current folder
  start=$(date +%s)

  # Change to the directory
  cd "$folder" || { echo "Cannot change directory to $folder"; exit 1; }

  # Execute Terraform destroy
  terraform destroy --auto-approve || { echo "Terraform destroy failed in $folder"; exit 1; }

  # Calculate the time taken for this folder
  end=$(date +%s)
  duration=$((end - start))
  duration_minutes=$(awk "BEGIN {print $duration/60}")
  echo "$folder destroyed successfully in $duration_minutes minutes."

  # Return to the previous directory
  cd - || { echo "Cannot return to previous directory"; exit 1; }

done

# Calculate the overall time taken
overall_end=$(date +%s)
overall_duration=$((overall_end - overall_start))
overall_duration_minutes=$(awk "BEGIN {print $overall_duration/60}")
echo "All folders destroyed successfully in $overall_duration_minutes minutes."