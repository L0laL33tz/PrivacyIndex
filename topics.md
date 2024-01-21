---
layout: page
title: Topics
permalink: /topics/
---

{% assign all_tags = "" | split: "" %}

{% for article in site.data.articles %}
{% for tag in article.tags %}
{% unless all_tags contains tag %}
{% assign all_tags = all_tags | push: tag %}
{% endunless %}
{% endfor %}
{% endfor %}

{% assign sorted_tags = all_tags | uniq | sort %}

{% for tag in sorted_tags %}
<a class="tag-link" data-type="tag">{{ tag }}</a>
{% endfor %}
