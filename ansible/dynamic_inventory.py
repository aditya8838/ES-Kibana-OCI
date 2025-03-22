#!/usr/bin/env python3

import boto3
import json

def get_instances_by_tag(tag_key, tag_value):
    ec2 = boto3.resource('ec2')
    instances = ec2.instances.filter(Filters=[{'Name': f'tag:{tag_key}', 'Values': [tag_value]}])
    return instances

def generate_inventory():
    inventory = {
        'elasticsearch': {
            'hosts': [],
            'vars': {}
        },
        'kibana': {
            'hosts': [],
            'vars': {}
        }
    }

    es_instances = get_instances_by_tag('Name', 'elasticsearch*')
    kibana_instances = get_instances_by_tag('Name', 'kibana')

    for instance in es_instances:
        inventory['elasticsearch']['hosts'].append(instance.private_ip_address)

    for instance in kibana_instances:
        inventory['kibana']['hosts'].append(instance.private_ip_address)

    print(json.dumps(inventory))

if __name__ == "__main__":
    generate_inventory()
