# gcs-pypi
Google Cloud Build job that converts GCS bucket into a simple PyPI static site server using [`dumb-pypi`](https://github.com/chriskuehl/dumb-pypi).  First, need to [set up a GCS bucket](https://cloud.google.com/storage/docs/hosting-static-website) where you can host a static site.  Packages should be uploaded to the `raw` directory within the bucket.

To build the site:
```
gcloud builds submit --config cloudbuild.yaml --no-source
```

Running the Cloud Build job requires a `dumb-pypi` custom step:
```
gcloud builds submit --config cloudbuild_step.yaml .
```

If have another Cloud Build job that is building a package and uploading to the GCS bucket, can trigger this job by adding the following 2 steps:
```
steps:
  ...
  - name: gcr.io/cloud-builders/git
    args: ['clone', 'https://github.com/donaldrauscher/gcs-pypi.git']
  - name: gcr.io/cloud-builders/gcloud
    args: ['builds', 'submit', '--config', 'cloudbuild.yaml', '--no-source', '--async', '--substitutions', '_BUCKET=${_BUCKET}']
    dir: '/workspace/gcs-pypi'
substitutions:
  _BUCKET: ...
```

Example of this: [https://github.com/donaldrauscher/djr-py](https://github.com/donaldrauscher/djr-py)
