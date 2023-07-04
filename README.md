# BIDS_DCMConverter
A general MRI DICOM to [BIDS](https://bids.neuroimaging.io/) converter GUI. 

## Depenencies 
* Matlab (should work >r2017, written in 2023a)
* [dcm2niix](https://github.com/rordenlab/dcm2niix) (v1.0.20230411 included in download) 
* [ExploreASL](https://github.com/ExploreASL/ExploreASL) written with v1.10.1

## Preparing the data
*  Create a new folder and title it the project title, this is your project ROOT
*  Create a folder "sourcedata"
*  Put all raw MRI scan folders (1 per patient) into sourcedata

## Using the GUI
* Run the app in Matlab and put in path to ROOT
* (if you are unpacking asl, also include ExploreASL path)
* Fill in your BIDS specifications (right table) only for the files you will be converting (the scanner may output many more sequences than you intend to use
* Pick a subject, include exam ID, and then match ID tags in both tables
* click convert

![](https://github.com/ABI-Animus-Laboratory/DCM2BIDS/blob/main/images/GUIimage.png)


After converting, run "WriteDescriptionJSON" to make your dataset-description, fill in the blanks appropriate to your study.

## Some Notes
The gui runs dcm2niix to unpack the DICOM folders. This function is not perfect and currently does not unpack 4D-flow, or ASL correctly. As such, this GUI uses ExploreASL's dcm2niix which runs the 2023 BIDS asl standard. 4Dflow import is a coming feature!

# To run with Explore ASL
To run the ASL importer with ExploreASL, make sure the ID is "asl". It is assumed each subject only has 1 asl scan. 
If you wish to use ExploreASL after import, the suffixes to use are as follows

Scan type -> suffix
* T1weighted -> T1w
* T2 FLAIR -> FLAIR
* asl -> asl 
