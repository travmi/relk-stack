#RELK Stack Setup

```
client -> syslog -> redis -> logstash -> elasticsearch -> kibana
client beat -> logstash -> redis -> logstash -> elasticsearch -> kibana
```

Reason for using Logstash before Redis: https://github.com/elastic/filebeat/issues/132

- Client - To generate logs. Filebeat will be the log forwarder
- Logstash Queue - This server intercepts the beats and outputs to Redis queue
- Syslog Server - Collect the logs
- Redis - Queue for logs
- Logstash - Input logs from Redis
- Elasticsearch - Index and store the data
- Kibana - Interact with the data (via web interface)
