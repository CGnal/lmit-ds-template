#!/bin/bash

nc="\033[0m"
red="\033[0;31m"
green="\033[0;32m"

printf "===========================================\n"
printf "              INITIALIZATION               \n"
printf "                  SCRIPT                   \n"
printf "===========================================\n"
printf "\n"

root_path="$(dirname "$0")/.."
PYTHON_VERSION=$(python --version)
PYTHON_VERSION="${PYTHON_VERSION#Python }"
PYTHON_VERSION="${PYTHON_VERSION%.*}"
SEP=", "
SUPPORTED_VERSIONS="3.6, 3.7, 3.8, 3.9, 3.10, 3.11, "

if [[ ! ${SUPPORTED_VERSIONS} =~ ${PYTHON_VERSION}${SEP} ]];
then
  echo "Python ${PYTHON_VERSION} not supported"
  exit 0
fi

mkdir -p "${root_path}/.github/workflows"

# template_file_path:destination_file_path. File paths are relative to the project root
templates=(
    "templates/setup.cfg.tmpl:setup.cfg"
    "templates/continous-delivery.yml.tmpl:.github/workflows/continous-delivery.yml"
    "templates/continous-integration.yml.tmpl:.github/workflows/continous-integration.yml"
    "templates/github-page-build-and-deploy.yml.tmpl:.github/workflows/github-page-build-and-deploy.yml"
    "templates/source_index.rst.tmpl:sphinx/source/index.rst"
    "templates/userguide_index.rst.tmpl:sphinx/source/userguide/index.rst"
    "templates/Dockerfile.tmpl:Dockerfile"
    "templates/Makefile.tmpl:Makefile"
    "templates/MANIFEST.in.tmpl:MANIFEST.in"
    "templates/.gitattributes.tmpl:.gitattributes"
    "templates/terraform.sh.tmpl:bin/terraform.sh"
    "templates/backend.tf.tmpl:terraform/backend.tf"
    "templates/vars.tf.tmpl:terraform/vars.tf"
    "templates/google-client.tf.tmpl:terraform/google-client.tf"
)

# placeholder in format placeholder:description
placeholders=(
    "PROJECT_NAME:Project name"
    "SRC:Source folder name"
    "PROJECT_DESCRIPTION:Project description"
    "PROJECT_ID:Google Cloud Project ID"
)

user_values=()

for placeholder in "${placeholders[@]}" ; do
    placeholder_name="${placeholder%%:*}"
    description="${placeholder##*:}"
    printf "%s: " "${description}"
    read -r value
    user_values+=("${value}")
done
printf "Remove templates (Y/n)? "
read -r remove_templates
placeholders+=("GITHUB_REPO:Github repository" "PYTHON_VERSION:Python Version")
user_values+=("$(git remote get-url origin)" "${PYTHON_VERSION}")

for template in "${templates[@]}" ; do
    source_path="${root_path}/${template%%:*}"
    dest_path="${root_path}/${template##*:}"

    if [ -f "${source_path}" ] ;
    then
        result=$(cat "${source_path}")
        for idx in "${!user_values[@]}" ; do
            placeholder=${placeholders[idx]}
            placeholder_name="${placeholder%%:*}"
            val=${user_values[idx]}
            result="${result//"{{${placeholder_name}}}"/${val}}"
            if [ "${placeholder_name}" = "SRC" ] && [ ! -d "${root_path}/${val}" ]; then
              mkdir -p "${root_path}/${val}"
              cp "${root_path}/src/"* "${root_path}/${val}"
              rm -rf "${root_path}/src"
            fi
        done
        mkdir -p "$(dirname "${dest_path}")"
        echo "${result}" > "${dest_path}"
        printf "${green}Processed and created ${nc}%s\n" "${dest_path}"
    else
        printf "${red}File not found ${nc}%s\n" "${source_path}"
    fi
done

if [ "${remove_templates}" = "Y" ] || [ "${remove_templates}" = "y" ]; then
    rm -rf "templates"
fi
