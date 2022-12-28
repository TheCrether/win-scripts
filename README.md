# Windows Scripts

These are just Windows scripts I write for various tasks.

## `SetAppTheme.ps1`

checks for the current time and then sets the app theme accordingly (light at day & dark at night)

## `AddToPath.ps1`

This script paths to your `PATH` variable has two optional arguments:

- `Path` - The path to add to the path. If not supplied, the directory of the script will be used.
- `Target` - The target to add the path to. Can be `User` or `Machine`. If not supplied, `User` will be used.

If you are trying to add a Path to the `Machine` target, you can either run the script as an administrator, or you can run it as a normal user and it will prompt you for an administrator password.

TODOs:

- [ ] Include linux check

## `taskmgr.bat`

Wrapper for `taskmgr.ps1` so that it can be run through Windows search.

## `taskmgr.ps1`

If a task manager like program like [Process Explorer](https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer) is installed and set as the default Task Manager, this script will open the default task manager. You can also give the script a path to a program to set as the default task manager afterwards (example: to set it back to process explorer).

It **can be run as administrator**, but it will automatically elevate itself (or ask you with the standard Windows prompt).
