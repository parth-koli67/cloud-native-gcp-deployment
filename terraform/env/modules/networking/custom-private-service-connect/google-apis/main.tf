/**
 * Copyright 2022 Google LLC
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

resource "google_compute_global_address" "global_address" {
  provider      = google-beta
  project       = var.project_id
  name          = var.address_name
  description   = var.description
  address_type  = var.type
  purpose       = var.purpose
  ip_version    = var.ip_version
  network       = var.network
  address       = var.address
  prefix_length = var.prefix_length
}

resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  provider = google-beta
  project  = var.project_id
  name     = var.psc_name
  # description           = var.description
  target                = var.target
  network               = var.network
  ip_address            = google_compute_global_address.global_address.address
  load_balancing_scheme = var.load_balancing_scheme
}
