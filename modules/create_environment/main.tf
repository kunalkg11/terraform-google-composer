/**
 * Copyright 2020 Google LLC
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

resource "google_composer_environment" "composer_env" {
  project = var.project_id
  name    = var.composer_env_name
  region  = var.region

  config {
    node_count = var.node_count

    node_config {
      zone         = var.zone
      machine_type = var.machine_type

      network    = google_compute_network.composer_network.name
      subnetwork = google_compute_subnetwork.composer_subnetwork.name

      service_account = var.composer_service_account
    }
  }
}

resource "google_compute_network" "composer_network" {
  project                 = var.project_id
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "composer_subnetwork" {
  project       = var.project_id
  name          = var.subnet_name
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  network       = google_compute_network.composer_network.self_link
}
