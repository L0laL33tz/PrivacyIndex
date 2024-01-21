---
layout: page
title: Glossary
permalink: /glossary/
---

{% assign sorted_items = site.data.glossary | map: 'title' | uniq | sort %}

{% for item in sorted_items %}
<a class="tag-link" data-type="glossary">{{ item }}</a>
{% endfor %}
