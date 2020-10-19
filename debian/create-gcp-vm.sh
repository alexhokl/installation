#! /bin/bash

if [ -z "$(gcloud compute addresses list | grep dev-ip)" ]; then
	gcloud compute addresses create dev-ip --region asia-east1
else
	echo IP address has been created
fi

gcloud compute instances create dev-vm \
	--zone=asia-east1-b \
	--image-family=debian-10 \
	--image-project=debian-cloud \
	--machine-type=n2-standard-16 \
	--hostname=alex-debian-gcp.asia-east1-b.c.craffy.internal \
	--boot-disk-size=300 \
	--boot-disk-type=pd-ssd \
	--address=dev-ip

