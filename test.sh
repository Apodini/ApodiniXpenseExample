#
# This source file is part of the Apodini open source project
#
# SPDX-FileCopyrightText: 2021 Paul Schmiedmayer and the project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
#
# SPDX-License-Identifier: MIT
#

curl --header "Content-Type: application/json" \
               --request POST \
               --data '{"name": "Paul", "password": "SuperSecretPassword"}' \
               http://localhost/v1/users