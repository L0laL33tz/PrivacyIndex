---
layout: page
title: Glossary
permalink: /glossary/
---

{% assign sorted_items = site.glossary | sort: 'title' %}

{% for item in sorted_items %}
{% assign href = site.baseurl | append: "/glossary/" | append: item.auto-links-id %}<a class="glossary" href="{{ href }}">{{ item.title }}</a>{% endfor %}
