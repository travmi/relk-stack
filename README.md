#RELK Stack Setup

```
client -> syslog -> redis -> logstash -> elasticsearch -> kibana
```

Client - To generate logs
Syslog Server - Collect the logs
Redis - Buffer logs
Logstash - Filter and parse the logs
Elasticsearch - Index and store the data
Kibana - Interact with the data (via web interface)
