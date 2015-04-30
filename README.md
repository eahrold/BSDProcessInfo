-
-
#BSD process info in Objective-c

_When `- runningApplications` is not enough!_

-

__BSDProcessInfo__ consists of a single class. The class methods are used to obtain specific processes or lists of processes, and the instances provide information about the process.

###To get information on pid
```Objective-c
BSDProcessInfo *info = [[BSDProcessInfo alloc] initWithPid:300];
    
// Then use the object as you want
info.name; // Name of the Process
info.launchPath; // The path called when the process was launched
info.executablePath; // The path to the process's executable 

info.effectiveUser; // the user the process is running as
info.effectiveUserID; // the user ID of the above effective user

info.arguments; // the arguments used when the process was launched 
info.environment;  // Environmental variables for the process
```
_NOTE: arguments and environment will allways be nil for processes the user doesn't own (unless the user is root)._

--

###To get arrays processes

```Objective-c
NSArray *processes = [BSDProcessInfo allProcesses]; // Array of BSDProcessInfo objects
```

There are a number of class methods that return filltered 
results such as...
```Objective-c
[BSDProcessInfo allUserProcesses]
[BSDProcessInfo allUserProcessesWithName:@"procName"]
```
	
This will return a list matching both name and arguments used to launch the process.

```Objective-c
[BSDProcessInfo allProcessesWithName:@"procName" matchingArguments:@[@"-s", @"debug"]];
```

So the array will include the process 
	
	`/usr/bin/procName -s debug -otherArgs y'` 

But it will not include 
	
	`/usr/bin/procName -otherArgs`


See [BSDProcessInfo.h](./BSDProcessInfo/BSDProcessInfo.h) for more details.