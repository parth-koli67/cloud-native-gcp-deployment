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
variable "region_name" {
    description = "Name of the Region for deployment"
    type= string    
}

variable "repo_id" {
    description = "Name of the Repository for deployment"
    type= string    
}

variable "format_type" {
    description = "Name of the Format for deployment"
    type= string    
}

variable "project_id" {
    description = "Name of the Project ID"
    type = string
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the artifact registry"
  type        = map(string)
  default     = null
}

variable "description" {
  description = "A set of key/value label pairs to assign to the artifact registry"
  type        = string
  default     = "For Docker Images"
}
