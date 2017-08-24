#!/bin/bash
# Copyright 2017 Huawei Technologies Co., Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


kubectl expose -f zipkin-service.yaml
kubectl create -f zipkin-deployment.yaml

kubectl expose -f company-bulletin-board-service.yaml 
kubectl create -f company-bulletin-board-deployment.yaml 

kubectl create -f company-worker-deployment.yaml 
kubectl create -f company-doorman-deployment.yaml 
kubectl create -f company-beekeeper-deployment.yaml 

kubectl create -f company-manager-service.yaml 
kubectl create -f company-manager-deployment.yaml 

#Create Horizontal Pod Autoscaler
kubectl autoscale deployment zipkin --cpu-percent=50 --min=1 --max=10
kubectl autoscale deployment company-bulletin-board --cpu-percent=50 --min=1 --max=10
kubectl autoscale deployment company-worker --cpu-percent=50 --min=1 --max=10
kubectl autoscale deployment company-doorman --cpu-percent=50 --min=1 --max=10
kubectl autoscale deployment company-manager --cpu-percent=50 --min=1 --max=10
kubectl autoscale deployment company-beekeeper --cpu-percent=50 --min=1 --max=10

