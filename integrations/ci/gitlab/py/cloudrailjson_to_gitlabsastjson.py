import json
import sys
import os
from re import sub

# Into this:
# https://docs.gitlab.com/12.10/ee/user/application_security/sast/#reports-json-format

def evidence_to_simple_string(evidence):
    message = ""
    for evidence_line in evidence.split('. '):
        evidence_line = sub("```(?!\\S)", "", evidence_line)
        evidence_line = sub("```", "", evidence_line)
        if evidence_line.startswith('~') and evidence_line.endswith('~'):
            evidence_line = evidence_line.replace('~', '')
            message += f'         {evidence_line}\n'
        else:
            message += f'             | {evidence_line}\n'
        message += ''
    return message


def convert_issue_items_to_githab_vulns(rule_results):
    vulns = []
    for rule_result in rule_results:
        for issue_item in rule_result['issue_items']:
            vulns.append({
                "id": rule_result['id'] + issue_item['violating_entity']['id'] + issue_item['exposed_entity']['id'],
                "category": "sast",
                "name": rule_result['rule_name'],
                "message": rule_result['rule_name'] + ": <" + get_friendly_name(issue_item['violating_entity']) + "> is exposing <" + get_friendly_name(issue_item['exposed_entity']) + ">",
                "description": rule_result['rule_description'] + '\n\n' + evidence_to_simple_string(issue_item['evidence']),
                "severity": "Medium", # Need to pull this from rule severity when supported
                "confidence": "High",
                "scanner": {
                    "id": "indeni_cloudrail",
                    "name": "Indeni Cloudrail"
                },
                "location": {
                    "file": base_tf_path + '/' + issue_item['violating_entity']['tf_resource_metadata']['file_name'],
                    "start_line": issue_item['violating_entity']['tf_resource_metadata']['start_line'],
                    "end_line": issue_item['violating_entity']['tf_resource_metadata']['end_line']
                }
            })
    return vulns

def get_friendly_name(resource) -> str:
    return resource['tf_address'] or resource['name'] or resource['cloud_id'] or resource['cloud_arn']


if len(sys.argv) != 3:
    print('Incorrect number of parameters. Correct usage:\n')
    print(os.path.basename(__file__) + ' <cloudrail_results.json> <base_tf_path>')
    exit(1)

results_json = sys.argv[1]
base_tf_path = sys.argv[2]

# Convert this Cloudrail's results format:
with open(results_json, 'r') as file:
    cloudrail_result = json.loads(file.read().replace('\n', ''))

result = {
    "version" : "2.0",
    "vulnerabilities": convert_issue_items_to_githab_vulns(cloudrail_result)
}

print(json.dumps(result))
