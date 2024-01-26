---
layout: page
title: Topics
permalink: /topics/
---

{% assign sorted_items = site.tag | sort: 'title' %}
{% for item in sorted_items %}
{% assign href = site.baseurl | append: "/tag/" | append: item.auto-links-id %}<a class="tag" href="{{ href }}">{{ item.title }}</a>{% endfor %}
