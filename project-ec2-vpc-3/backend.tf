backend {
    backend "s3" {
        bucket = "bibhishan-remote-lock"
        region = "ap-south-1"
        encrypt = true
        use_lockfile = true
    }

}