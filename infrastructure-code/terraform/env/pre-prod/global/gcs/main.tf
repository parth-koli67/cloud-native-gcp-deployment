/**
 * Copyright 2023 Google LLC
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


/******************************************
  Storage Bucket Details
 *****************************************/

module "gcs_bucket" {
  source             = "../../../modules/cloud_storage"
  project_id         = var.project_id
  for_each           = var.gcs_bucket
  name               = each.value.app_name
  location           = each.value.location
  enable_neg         = each.value.enable_neg
  data_locations     = each.value.data_locations
  versioning         = each.value.versioning
  storage_class      = each.value.storage_class
  bucket_policy_only = each.value.bucket_policy_only
  force_destroy      = each.value.force_destroy
  labels             = each.value.labels
  retention_policy   = each.value.retention_policy
}