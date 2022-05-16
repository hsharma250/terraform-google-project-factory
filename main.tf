/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

resource "google_folder" "workload" {
  display_name = "workload"
  parent       = "organizations/${var.organization_id}"
}

module "project-prod" {
  source            = "./modules/gsuite_enabled"
  random_project_id = true
  name              = "hierarchy-sample-prod"
  org_id            = var.organization_id
  billing_account   = var.billing_account
  folder_id         = google_folder.workload.folder_id
}

module "project-non-prod" {
  source            = "./modules/gsuite_enabled"
  random_project_id = true
  name              = "hierarchy-sample-non-prod"
  org_id            = var.organization_id
  billing_account   = var.billing_account
  folder_id         = google_folder.workload.folder_id
}

# module "project-factory" {
#   source = "./modules/core_project_factory"

#   group_email                        = module.gsuite_group.email
#   group_role                         = var.group_role
#   lien                               = var.lien
#   manage_group                       = var.group_name != "" ? true : false
#   random_project_id                  = var.random_project_id
#   org_id                             = var.org_id
#   name                               = var.name
#   project_id                         = var.project_id
#   shared_vpc                         = var.svpc_host_project_id
#   enable_shared_vpc_service_project  = var.svpc_host_project_id != ""
#   enable_shared_vpc_host_project     = var.enable_shared_vpc_host_project
#   grant_network_role                 = var.grant_network_role
#   billing_account                    = var.billing_account
#   folder_id                          = var.folder_id
#   create_project_sa                  = var.create_project_sa
#   project_sa_name                    = var.project_sa_name
#   sa_role                            = var.sa_role
#   activate_apis                      = var.activate_apis
#   activate_api_identities            = var.activate_api_identities
#   usage_bucket_name                  = var.usage_bucket_name
#   usage_bucket_prefix                = var.usage_bucket_prefix
#   shared_vpc_subnets                 = var.shared_vpc_subnets
#   labels                             = var.labels
#   bucket_project                     = var.bucket_project
#   bucket_name                        = var.bucket_name
#   bucket_location                    = var.bucket_location
#   bucket_versioning                  = var.bucket_versioning
#   bucket_labels                      = var.bucket_labels
#   bucket_force_destroy               = var.bucket_force_destroy
#   bucket_ula                         = var.bucket_ula
#   auto_create_network                = var.auto_create_network
#   disable_services_on_destroy        = var.disable_services_on_destroy
#   default_service_account            = var.default_service_account
#   disable_dependent_services         = var.disable_dependent_services
#   vpc_service_control_attach_enabled = var.vpc_service_control_attach_enabled
#   vpc_service_control_perimeter_name = var.vpc_service_control_perimeter_name
#   default_network_tier               = var.default_network_tier
# }