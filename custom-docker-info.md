 a brief recap of what we learnt in the process/ how to start a virtual machine with a custom Docker image. 

######

1. To start a VM/cluster in a Terra Workspace - Curl + Json file 

Note: Requires a Terra workspace in which user is (at least) Writer
Note: This curl command requires Google-Cloud-SDK

A. Curl command: 

curl -X PUT -H "Authorization:Bearer $(gcloud auth print-access-token)" -H "Content-type:application/json" -d "@<path-to-json-file>" 'https://notebooks.firecloud.org/api/cluster/v2/<billing-account>/<random-name-including-ONLY-lowercase-letters-dash-and-numbers>' 

Example:

curl -X PUT -H "Authorization:Bearer $(gcloud auth print-access-token)" -H "Content-type:application/json" -d "@/ahg/regevdata/projects/Breg/Terra_try/terra_try_docker.json" 'https://notebooks.firecloud.org/api/cluster/v2/b-cell-kuchroo/abcde' 

Note: It is *REALLY* important that the name of the cluster includes only lowercase letters, dash and numbers, NO uppercase letters or underscores. 
Note2: Path to cluster doesn't include the Workspace name, only Billing account name. If a user requires a cluster inside one billing account, it is created / accessible by the user across all Workspaces in that billing account.

B. Json file: 

```json
{
  "machineConfig": {
    "masterMachineType": "n1-standard-1",
    "masterDiskSize": 50,
    "numberOfWorkers": 0,
    "numberOfPreemptibleWorkers": 0,
    "workerMachineType": "n1-standard-4",
    "workerDiskSize": 50
  },
  "labels": {
    "saturnAutoCreated": "true",
    "saturnVersion": "6"
  },
  "defaultClientId": "424501080111-b3bt4p1vo4gbo4m0573nvi4d49784bp8.apps.googleusercontent.com",
  "userJupyterExtensionConfig": {
    "nbExtensions": {
      "saturn-iframe-extension": "https://app.terra.bio/jupyter-iframe-extension.js"
    },
    "labExtensions": {},
    "serverExtensions": {},
    "combinedExtensions": {}
  },
  "jupyterDockerImage":"<image-name>",
  "scopes": [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/userinfo.profile"
  ]
}
```

Note: The image name should be equivalent to what you would put after a docker pull command. 
Scanpy/Seurat and other packages commonly used in the Regev Lab are present in the image that is loaded if "<image-name>" is "gokceneraslan/regevlab-jupyter-docker" Link here

Note2: "machineConfig" can be modified to request specific configurations of the virtual machine 

2. To check status of a cluster/ delete - Curl 

```bash
curl -X GET -H "Authorization:Bearer $(gcloud auth print-access-token)" 'https://notebooks.firecloud.org/api/cluster/<billing-account>/<name-used-when-starting>' 
```

Note: path to the cluster here does NOT include /v2/
Note2: to force deletion of the cluster, same curl command as to check the status but with -X DELETE instead of -X GET. More documentation in this Swagger page. 
Note3: Forcing deletion should not be needed - if the cluster is loaded properly it is possible to delete the cluster in Terra's UI.

######
