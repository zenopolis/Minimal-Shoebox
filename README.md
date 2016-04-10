# Minimum Shoebox

## What is this?

A template for **OS X** *Shoebox* type applications (i.e. applications that use a central library as apposed to seperate documents). 

The *Minimum Shoebox* template can be used as a starting point for your own shoebox type app, as the start of a new project for experimenting with a specific OS X technology of your choosing, or as a starting point for a tutorial. 

## Features

*	Swift
*	Core Data
*	Storyboards
*	Seperation of Concerns:
	*	AppDelegate
	*	DataController
	*	CoreDataStack
*	Dependency Injection (DataController)

## Usage

The interface is minimal by design. You add new items to the *Shoebox* via the context menu (associated with the table of items). Closing the app causes the data to be writen to the storage.