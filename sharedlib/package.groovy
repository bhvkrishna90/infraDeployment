package sharedlib
class package implements Serializable {
    def steps
    private version = null
    def configjson
    String repoName
    String environment
package(steps,configjson) {
    this.steps = steps
    this.configjson = configjson
    }
def public buildDocker() {
    repoName = configjson.repoName
    environment = configjson.environment
    steps.powershell(returnStdout: true, script: '''
    docker build -t ${repoName}/samplehelloworld:${environment} .
    docker build -t ${repoName}/samplehelloworld:${version} .
    ''')
  }
def public deployPublish() {
    steps.powershell(returnStdout: true, script: '''
    docker push ${repoName}/samplehelloworld:${environment}
    docker push ${repoName}/samplehelloworld:${version}
    ''')
  }
}