#!/bin/bash

# Runtime
# --------
instances="aws ec2 describe-instances --output text --query"
volumes="aws rds describe-db-instances  --output text --query"
snapshots="aws ec2 describe-snapshots --output text --owner-ids self --query"


echo ##################################
echo Instances and AMIs which have no owner tag:
echo ---------------------------------
$instances 'Reservations[].Instances[?!not_null(Tags[?Key == `owner`].Value)] | [].[InstanceId,ImageId]'

echo ##################################
echo Instances and AMIs which have no budget tag:
echo ---------------------------------

$instances 'Reservations[].Instances[?!not_null(Tags[?Key == `budget`].Value)] | [].[InstanceId,ImageId] '

echo ##################################
echo Instances and AMIs which have no product tag:
echo ---------------------------------

$instances 'Reservations[].Instances[?!not_null(Tags[?Key == `product`].Value)] | [].[InstanceId,ImageId]'

echo ##################################
echo Instances and AMIs which have no environment tag:
echo ---------------------------------

$instances 'Reservations[].Instances[?!not_null(Tags[?Key == `environment`].Value)] | [].[InstanceId,ImageId]'

#Display VolumeId and Size of volumes which have no tag:
echo ##################################
echo Volumes which have no owner tag:
echo ---------------------------------

$volumes 'Volumes[?!not_null(Tags[?Key == `owner`].Value)] | [].[VolumeId]'

echo ##################################
echo Volumes which have no budget tag:
echo ---------------------------------
$volumes 'Volumes[?!not_null(Tags[?Key == `budget`].Value)] | [].[VolumeId]'

echo ##################################
echo Volumes which have no product tag:
echo ---------------------------------

$volumes 'Volumes[?!not_null(Tags[?Key == `product`].Value)] | [].[VolumeId]'

echo ##################################
echo Volumes which have no environment tag:
echo -------------------------------------------------

$volumes 'Volumes[?!not_null(Tags[?Key == `environment`].Value)] | [].[VolumeId]'

#Display SnapshotId and StartTime of my snapshots which have no CreatedBy tag:
echo ##################################
echo Snapshots which have no owner tag:
echo -------------------------------------------------

$snapshots 'Snapshots[?!not_null(Tags[?Key == `owner`].Value)] | [].[SnapshotId]'

echo ##################################
echo Snapshots which have no budget tag:
echo -----------------------------------------------

$snapshots 'Snapshots[?!not_null(Tags[?Key == `budget`].Value)] | [].[SnapshotId]'

echo ##################################
echo Snapshots which have no product tag:
echo -----------------------------------------------

$snapshots 'Snapshots[?!not_null(Tags[?Key == `product`].Value)] | [].[SnapshotId]'

echo ##################################
echo Snapshots which have no environment tag:
echo ----------------------------------------------------

$snapshots 'Snapshots[?!not_null(Tags[?Key == `environment`].Value)] | [].[SnapshotId]'
