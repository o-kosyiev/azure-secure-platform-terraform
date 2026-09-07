# Design Decisions

| Decision | Choice | Rationale |
|---|---|---|
| Authentication | OIDC and managed identities | Removes long-lived deployment and runtime passwords |
| Module scope | Workload-level modules | Small enough to test, large enough to enforce secure defaults |
| Image versioning | OCI digest | Deployment points to immutable content |
| State layout | State per environment | Limits blast radius and lock contention |
| Registry tier | Premium | Required for private endpoints |
| Application ingress | Public HTTPS | Demonstrates a typical API; platform dependencies remain private |

Rejected alternatives include committing backend values, using registry admin credentials, and applying automatically after every merge.
