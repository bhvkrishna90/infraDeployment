package sharedlib
class dockerBuild implements Serializable {
    def steps
    private version = null
    def configjson
    String repoName
    String environment
dockerBuild(steps) {
    this.steps = steps
    //this.configjson = configjson
    }
def public buildDocker() {
    //repoName = configjson.repoName
    //environment = configjson.environment
    steps.powershell(returnStdout: true, script: '''
     docker build -t bhvkrishna/samplehelloworld:green .
     docker build -t bhvkrishna/samplehelloworld:ver1 .
    ''')
  }
def public deployDocker() {
    steps.powershell(returnStdout: true, script: '''
    docker push bhvkrishna/samplehelloworld:green
    docker push bhvkrishna/samplehelloworld:ver1
    ''')
  }
}
