package sharedlib
class dockerBuild implements Serializable {
    def steps
    private version = null
    def env = null
    String repoName
    String environment
dockerBuild(steps,env) {
    this.steps = steps
    this.env = env
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
    String username = env.DUser_Name
    String password = env.DPassword
    steps.echo "${username}"
    steps.echo "${password}"
    steps.powershell(returnStdout: true, script: '''
    //docker login -u  -p 
    docker push bhvkrishna/samplehelloworld:green
    docker push bhvkrishna/samplehelloworld:ver1
    ''')
  }
}
