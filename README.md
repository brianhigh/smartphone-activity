---
title: "Getting and Cleaning Data Course Project"
author: "Brian High"
date: "Sunday, November 23, 2014"
output: html_document
---

## Introduction

This code repository includes all of the files which satisfy the requirements 
of the "Getting and Cleaning Data Course Project".

## Files

* [run_analysis.R](run_analysis.R) - The R code which performs all clean-up work
* [CodeBook.md](CodeBook.md) - Describes the variables, the data, and clean-up work performed
* [README.md](README.md) - This document explains the project, files, and how they work

## Project Description

As quoted from the [course](https://class.coursera.org/getdata-009/human_grading/) "submissions" page

> The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the [site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) where the data was obtained.

> [Here are](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) the data for the project. 

## Top-Level Project Requirements

Here are the top-level requirements as quoted from the [course](https://class.coursera.org/getdata-009/human_grading/) "submissions" page:

### Purpose

> The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 

### Goal

> The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. 

### Submission Requirements

> You will be required to submit: 

> 1. a tidy data set as described below, 
> 2. a link to a Github repository with your script for performing the 
analysis, and 
> 3. a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

> You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

## Detailed Requirements

Detailed requirements for the [run_analysis.R](run_analysis.R) script are quoted in the comments
of that script, included in this code repository. This script is heavily 
commented to clarify the requirements and to show how these requirements were 
satisfied by the script. Please use the comments as a guide when assessing
this project submission. Further details are provided in the [CodeBook.md](CodeBook.md).

## Running the script

After placing the ZIP data file and the [run_analysis.R](run_analysis.R) script in the same folder, you should be able to run the script like this:


    # Set the working directory to the folder containing the data and script.
    setwd("path/to/folder")

    # Run the script.
    source("run_analysis.R")

Where "path/to/folder" should be replaced with the correct path to the folder.

## Importing the output file

You can confirm that the output data file meets the requirements by:

    data <- read.table("tidy_means.txt", header = TRUE)
    View(data)


## The Code Book

The [CodeBook.md](CodeBook.md) file contains the code book. This is a document which 
describes the variables, the data, and clean-up work performed on the raw data files to produce the tidy data set and the aggregated data set submitted to satisfy the project requirements.