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
     String id = docker ps -q
     docker stop (docker ps -q)
     docker build -t bhvkrishna/samplehelloworld:blue .
     docker run -p 8888:8080 bhvkrishna/samplehelloworld:blue
    ''')
  }
def public deployDocker() {
    String username = env.DUser_Name
    String password = env.DPassword
    steps.echo "${username}"
    steps.powershell(returnStdout: true, script: '''
    docker push bhvkrishna/samplehelloworld:green
    docker push bhvkrishna/samplehelloworld:ver1
    ''')
  }
}
