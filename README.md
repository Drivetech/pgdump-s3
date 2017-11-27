# pgdump-s3

[![dockeri.co](http://dockeri.co/image/lgatica/pgdump-s3)](https://hub.docker.com/r/lgatica/pgdump-s3/)

[![Build Status](https://travis-ci.org/lgaticaq/pgdump-s3.svg?branch=master)](https://travis-ci.org/lgaticaq/pgdump-s3)

> Docker Image with Alpine Linux, pg_dump and awscli for backup postgres database to s3

## Use

### Periodic backup

Run every day at 2 am

```bash
docker run -d --name pgdump \
  -e "POSTGRESQL_URI=postgres://user:pass@host:port/dbname"
  -e "AWS_ACCESS_KEY_ID=your_aws_access_key"
  -e "AWS_SECRET_ACCESS_KEY=your_aws_secret_access_key"
  -e "AWS_DEFAULT_REGION=us-west-1"
  -e "S3_BUCKET=your_aws_bucket"
  -e "BACKUP_CRON_SCHEDULE=0 2 * * *"
  lgatica/pgdump-s3
```

### Inmediatic backup

```bash
docker run -d --name pgdump \
  -e "POSTGRESQL_URI=postgres://user:pass@host:port/dbname"
  -e "AWS_ACCESS_KEY_ID=your_aws_access_key"
  -e "AWS_SECRET_ACCESS_KEY=your_aws_secret_access_key"
  -e "AWS_DEFAULT_REGION=us-west-1"
  -e "S3_BUCKET=your_aws_bucket"
  lgatica/pgdump-s3
```

## IAM Policity

You need to add a user with the following policies. Be sure to change `your_bucket` by the correct.

```xml
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1412062044000",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:PutObjectAcl"
            ],
            "Resource": [
                "arn:aws:s3:::your_bucket/*"
            ]
        },
        {
            "Sid": "Stmt1412062128000",
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::your_bucket"
            ]
        }
    ]
}
```

## Extra environmnet

- `MAX_BACKUPS` - Default not set. If set doing it keeps the last n backups in /backup

## License

[MIT](https://tldrlegal.com/license/mit-license)
