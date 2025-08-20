project           = "gitops"
stage             = "dev"
region_code       = "kr"
region            = "KR-WEST-1"
dr_region         = "KR-EAST-1"
dr_enabled        = "N"
dr_destroy_enabled = false

name              = "changeme"
object_id         = "changeme"

schedules         = [
{
   schedule_frequency         = "DAYS"
   schedule_frequency_detail  = "2"
   schedule_type              = "INCREMENTAL"
   start_time                 = "00:00:00+09:00"
},
{
   schedule_frequency         = "WEEKLY"
   schedule_frequency_detail  = "MON"
   schedule_type              = "INCREMENTAL"
   start_time                 = "01:00:00+09:00"
},
{
   schedule_frequency         = "MONTHLY"
   schedule_frequency_detail  = "1"
   schedule_type              = "FULL"
   start_time                 = "02:00:00+09:00"
}]

tags              = {"createdBy" = "gitops"}
