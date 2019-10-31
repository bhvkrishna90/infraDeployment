package sharedlib
class checkout implements Serializable {
  def steps
  checkout(steps) {
    this.steps = steps
    }
  def public code() {
    steps.checkout([
    $class: 'GitSCM', 
    branches: [[name: '*/master']], 
    doGenerateSubmoduleConfigurations: false, 
    extensions: [], 
    submoduleCfg: [], 
    userRemoteConfigs: [[url: 'https://github.com/bhvkrishna90/AppDeployment']]
    ])
  }
} 
