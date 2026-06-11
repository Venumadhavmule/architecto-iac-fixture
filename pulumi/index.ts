import * as aws from "@pulumi/aws";

const bucket = new aws.s3.Bucket("architectoFixtureLogs", {
  acl: "public-read",
  tags: {
    Environment: "dev",
    Owner: "architecto"
  }
});

export const bucketName = bucket.id;
