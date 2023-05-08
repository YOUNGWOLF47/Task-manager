#!/bin/bash

# Function to display the header of the task manager interface

function display_header {

    echo "==========================================="

    echo "|            Task Manager                |"

    echo "==========================================="

    echo "▀█▀ ▄▀█ █▀ █▄▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀█"

    echo "░█░ █▀█ ▄█ █░█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █▀▄"

}

# Function to display the list of processes with their respective PIDs

function display_processes {

    echo "  PID |     Process Name"

    echo "------+-------------------------"

    ps -axo pid,comm | tail -n +2 | awk '{printf "%5d | %s\n", $1, $2}'

}

# Function to display the loading animation

function display_loading_animation {

    echo -ne "\r|"

    for i in {1..20}; do

        echo -ne "█"

        sleep 0.1

    done

    echo -ne "| Done!\n"

}

# Function to prompt the user to enter the PID of the process to stop/kill

function prompt_user {

    read -p "Enter the PID of the process to stop/kill: " pid

}

# Function to display the confirmation message before stopping/killing the process

function display_confirmation_message {

    echo "Are you sure you want to stop/kill the following process?"

    echo "PID: $pid"

    ps -p $pid -o comm= | awk '{print "Name: "$0}'

    read -p "(Y/N): " choice

}

# Function to stop the process

function stop_process {

    kill -STOP $pid

    display_loading_animation

}

# Function to kill the process

function kill_process {

    kill -KILL $pid

    display_loading_animation

}

# Main function to run the task manager interface

function main {

    while true; do

        clear

        display_header

        display_processes

        prompt_user

        display_confirmation_message

        case $choice in

            [Yy]* ) kill_process; break;;

            [Nn]* ) continue;;

            * ) echo "Invalid choice. Please try again.";;

        esac

    done

}

# Run the main function

main

