#!/usr/bin/env bash
pandoc "$1" --from=gfm --pdf-engine=wkhtmltopdf --output "${1%\.md}.pdf"
