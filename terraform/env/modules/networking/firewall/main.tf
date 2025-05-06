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
	Firewall Rules
 *****************************************/
resource "google_compute_firewall" "new-firewall" {

  name     = var.name
  network  = var.network
  disabled = var.disabled

  allow {
    protocol = var.protocol
    ports    = var.ports
  }

  target_tags   = var.target_tags
  source_ranges = var.source_ranges
  source_tags   = var.source_tags

}
