
# Static Activity Transition Graph Creation
---------------------------------------------

After that, run 
```
path_to_apk2satg.sh your_apk.apk java_runtime_dir result_dir
```

java_runtime_dir is actually the path that contains the rt.jar or classes.jar file. This file contains the initial java classes that are loaded
by the JVM when a java program runs.

The procedure may take several minutes depending on the size of the apk. The output will be two files in the result dir,

your_apk.apk.g.xml: This xml file will contain the relation between parent and child activties.
your_apk.apk.g.dot: This dot file is for visualization purpose.
