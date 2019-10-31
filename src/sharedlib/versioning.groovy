package sharedlib
class versioning implements Serializable {
  def steps
  private version = null
  versioning(steps) {
    this.steps = steps
    version = steps. VersionNumber versionNumberString: "1.0.${BUILDs_TODAY}", worstResultForIncrement: 'SUCCESS'
    }
  def public version() {
      return version
  }