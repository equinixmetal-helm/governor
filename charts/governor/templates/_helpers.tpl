{{/*
Cedar authorization templates.

The cedar-agent sidecar loads three JSON files at startup:
  - schema.json   (CEDAR_AGENT_SCHEMA)   fully generated here, maintainer-owned
  - policies.json (CEDAR_AGENT_POLICIES)  generated from .Values.cedar.roles
  - data.json     (CEDAR_AGENT_DATA)      generated from .Values.cedar.bindings

All JSON is built as native dicts/lists and serialized with toPrettyJson so
escaping (e.g. the embedded Role::"x" quotes in a policy content string) is
handled mechanically and never authored by hand.
*/}}

{{/*
governor.cedar.actionNames returns {"actions": ["create:governor:users", ...]}
as JSON text. The resource and verb lists are hard-coded here (governor-api's
route scopes) and maintained by governor maintainers, not via values.yaml. The
action set is the full dot product of verbs x resources.

Callers recover the list with:
  {{- $names := (fromJson (include "governor.cedar.actionNames" .)).actions -}}
(include only returns strings, so the list is wrapped in a dict + JSON).
*/}}
{{- define "governor.cedar.actionNames" -}}
{{- $resources := list "users" "groups" "applications" "organizations" "extensions" "extensionresources" "notifications" "events" -}}
{{- $verbs := list "create" "read" "update" "delete" -}}
{{- $names := list -}}
{{- range $verb := $verbs -}}
{{- range $res := $resources -}}
{{- $names = append $names (printf "%s:governor:%s" $verb $res) -}}
{{- end -}}
{{- end -}}
{{- dict "actions" $names | toJson -}}
{{- end -}}

{{/*
governor.cedar.schema renders the cedar-agent schema.json. Entity types are
Workload (member of Role), Role, and a placeholder Resource; the actions map is
the generated dot product, each applying to Workload/Role principals against
Resource.
*/}}
{{- define "governor.cedar.schema" -}}
{{- $actionNames := (fromJson (include "governor.cedar.actionNames" .)).actions -}}
{{- $appliesTo := dict "appliesTo" (dict "principalTypes" (list "Workload" "Role") "resourceTypes" (list "Resource")) -}}
{{- $actions := dict -}}
{{- range $a := $actionNames -}}
{{- $_ := set $actions $a $appliesTo -}}
{{- end -}}
{{- $record := dict "type" "Record" "attributes" (dict) -}}
{{- $entityTypes := dict
      "Workload" (dict "shape" $record "memberOfTypes" (list "Role"))
      "Role"     (dict "shape" $record)
      "Resource" (dict "shape" $record) -}}
{{- dict "" (dict "entityTypes" $entityTypes "actions" $actions) | toPrettyJson -}}
{{- end -}}

{{/*
governor.cedar.policies renders cedar-agent policies.json: one policy per role,
granting that role's permissions. Validates each role id and permission and
fails the render on bad input.
*/}}
{{- define "governor.cedar.policies" -}}
{{- $valid := (fromJson (include "governor.cedar.actionNames" .)).actions -}}
{{- $policies := list -}}
{{- $seen := dict -}}
{{- range $role := .Values.cedar.roles -}}
  {{- if not $role.id -}}{{- fail "cedar.roles[]: 'id' is required" -}}{{- end -}}
  {{- if hasKey $seen $role.id -}}{{- fail (printf "cedar.roles: duplicate role id %q" $role.id) -}}{{- end -}}
  {{- $_ := set $seen $role.id true -}}
  {{- $name := $role.name | default $role.id -}}
  {{- if not (regexMatch "^[A-Za-z0-9:_./-]+$" $name) -}}{{- fail (printf "cedar.roles[%s]: role name %q contains unsupported characters (allowed: A-Z a-z 0-9 : _ . / -)" $role.id $name) -}}{{- end -}}
  {{- if not $role.permissions -}}{{- fail (printf "cedar.roles[%s]: 'permissions' must be a non-empty list" $role.id) -}}{{- end -}}
  {{- $refs := list -}}
  {{- range $p := ($role.permissions | uniq | sortAlpha) -}}
    {{- if not (has $p $valid) -}}
      {{- fail (printf "cedar.roles[%s]: permission %q is not a valid governor action (valid: %s)" $role.id $p (join ", " $valid)) -}}
    {{- end -}}
    {{- $refs = append $refs (printf "Action::%q" $p) -}}
  {{- end -}}
  {{- $content := printf "permit(principal in Role::%q, action in [%s], resource);" $name (join ", " $refs) -}}
  {{- $policies = append $policies (dict "id" $role.id "content" $content) -}}
{{- end -}}
{{- $policies | toPrettyJson -}}
{{- end -}}

{{/*
governor.cedar.data renders cedar-agent data.json: Workload entities (one per
subject, aggregating role memberships when a subject is bound to more than one
role), one Role entity per role, and the placeholder Resource::"na". Validates
that every binding references a known role.
*/}}
{{- define "governor.cedar.data" -}}
{{- $roleNames := dict -}}
{{- range $r := .Values.cedar.roles -}}
{{- $_ := set $roleNames $r.id ($r.name | default $r.id) -}}
{{- end -}}
{{- $subjects := dict -}}
{{- range $b := .Values.cedar.bindings -}}
  {{- if not (hasKey $roleNames ($b.role | toString)) -}}
    {{- fail (printf "cedar.bindings: role %q does not match any cedar.roles[].id" $b.role) -}}
  {{- end -}}
  {{- if not $b.subjects -}}{{- fail (printf "cedar.bindings[%s]: 'subjects' must be a non-empty list" $b.role) -}}{{- end -}}
  {{- $parent := dict "type" "Role" "id" (get $roleNames $b.role) -}}
  {{- range $s := $b.subjects -}}
    {{- $existing := get $subjects $s | default list -}}
    {{- if not (has $parent $existing) -}}
    {{- $_ := set $subjects $s (append $existing $parent) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
{{- $entities := list -}}
{{- range $s, $parents := $subjects -}}
  {{- $entities = append $entities (dict "uid" (dict "type" "Workload" "id" $s) "attrs" (dict) "parents" $parents) -}}
{{- end -}}
{{- range $r := .Values.cedar.roles -}}
  {{- $entities = append $entities (dict "uid" (dict "type" "Role" "id" ($r.name | default $r.id)) "attrs" (dict) "parents" (list)) -}}
{{- end -}}
{{- $entities = append $entities (dict "uid" (dict "type" "Resource" "id" "na") "attrs" (dict) "parents" (list)) -}}
{{- $entities | toPrettyJson -}}
{{- end -}}
