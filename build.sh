#!/usr/bin/env bash
# Builds the static site into _site/.
#
# website/index.html is plain HTML. A line that consists only of one of these
# markers is replaced by rendered markdown:
#
#   <!-- md FILE -->                      FILE rendered to HTML
#   <!-- each GLOB TEMPLATE -->           every file matching GLOB, A→Z, rendered with TEMPLATE
#   <!-- each-newest GLOB TEMPLATE -->    same, Z→A (date-prefixed files: newest first)
#
# Templates are HTML with pandoc variables: front-matter fields as $field$,
# the markdown text as $body$.
set -euo pipefail
shopt -s nullglob
cd "$(dirname "$0")"

render() {  # render FILE [TEMPLATE]
  pandoc -f markdown-smart-implicit_figures -t html --wrap=none \
    --metadata pagetitle=- ${2:+--template "$2"} "$1"
}

marker='^[[:space:]]*<!--[[:space:]]+(md|each|each-newest)[[:space:]]+([^[:space:]]+)([[:space:]]+([^[:space:]]+))?[[:space:]]+-->[[:space:]]*$'

rm -rf _site
mkdir _site
cp -r website/images _site/

while IFS= read -r line; do
  if [[ ! $line =~ $marker ]]; then
    printf '%s\n' "$line"
    continue
  fi
  kind=${BASH_REMATCH[1]} glob=${BASH_REMATCH[2]} template=${BASH_REMATCH[4]}
  files=( $glob )
  if [[ $kind == md ]]; then
    render "$glob"
    continue
  fi
  if [[ $kind == each-newest ]]; then
    mapfile -t files < <(printf '%s\n' "${files[@]}" | sort -r)
  fi
  for f in "${files[@]}"; do
    [[ -n $f ]] && render "$f" "$template"
  done
done < website/index.html > _site/index.html

echo "Built _site/index.html"
