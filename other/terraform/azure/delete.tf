module "gce-ilb-http"{
  source = "github.com/GoogleCloudPlatform/terraform-google-lb-http"
  name = "group-http-lb"
  target_tags = ["${module.mig1.target_tags}","${module.mig2.target_tags}"]
  backends = {
  "0"=[
    {group = "${module.mig2.instance_group}"},
    {group = "${module.mig3.instance_group}"}],
  }
  backend_params = [
  # health check path, port name, port number, timeout seconds.
    "/,http,80,10"
  ]
}