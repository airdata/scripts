## DRY RUN
## rsync -av --dry-run /Volumes/store/Studio/ /Volumes/store_backup/Studio/ | head --lines=-3 | tail --lines=+3

#docs
rsync -avh /Volumes/store/Docs/  /Volumes/store_backup/Docs/  #--delete

#gopro
rsync -avh /Volumes/store/GoPro/ /Volumes/store_backup/GoPro/ #--delete

#media
rsync -avh /Volumes/store/Media/  /Volumes/store_backup/Media/ #--delete

#Studio
rsync -avh /Volumes/store/Studio/ /Volumes/store_backup/Studio/ #--delete

#videos
rsync -avh /Volumes/store/Videos/ /Volumes/store_backup/Videos/ #--delete

