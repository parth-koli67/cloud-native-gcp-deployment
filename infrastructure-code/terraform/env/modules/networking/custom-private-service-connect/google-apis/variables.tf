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

variable "project_id" {
  description = "The ID of the project where this address and forwarding rule will be created."
  type        = string
  default     = ""
}

variable "address_name" {
  description = "The name of IP address to create."
  type        = string
  default     = ""
}

variable "description" {
  description = "Description for the Private Service Connect."
  type        = string
  default     = ""
}

variable "ip_version" {
  description = "The IP Version that will be used by this address. The default value is IPV4"
  type        = string
  default     = "IPV4"
}

variable "type" {
  description = "The type of the address to reserve. If unspecified, defaults to \"INTERNAL\"."
  type        = string
  default     = "INTERNAL"
}

variable "purpose" {
  description = "The purpose of the address."
  type        = string
  default     = ""
}

variable "network" {
  description = "The network name where the IP address will be created."
  type        = string
  default     = ""
}

variable "address" {
  description = "IPv4 or IPv6 address to create."
  type        = string
  default     = ""
}

variable "psc_name" {
  description = "The name of private service connect to create."
  type        = string
  default     = ""
}

variable "target" {
  description = "The target resource to receive the matched traffic."
  type        = string
  default     = ""
}

variable "load_balancing_scheme" {
  description = "This signifies what the Global Forwarding Rule will be used for."
  type        = string
  default     = ""
}

variable "prefix_length" {
  description = "The prefix length of the IP range."
  type        = number
  default     = 20
}
