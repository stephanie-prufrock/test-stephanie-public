########## Project Definition ########## {
variable "project" {
    description = <<-EOF
        description: Project Name
        type: string
        required: yes
    EOF
    type = string
}

variable "stage" {
    description = <<-EOF
        description: Service stage of project
        type: string
        required: no
        example:
        '''
            stage = "dev" # dev, stg, prd
        '''
    EOF
    type = string
    default     = "dev"
}

variable "region" {
    description = <<-EOF
        description: Region name 
        type: string
        required: no
        default: KR-WEST-1
        example:'''
            region = "KR-WEST-1"
        '''
    EOF
    type    = string
    default = "KR-WEST-1"
}

variable "dr_region" {
    description = <<-EOF
        description: DR Region name 
        type: string
        required: no
        example:'''
            dr_region = "KR-EAST-1"
        '''
    EOF
    type    = string
    default = "KR-EAST-1"
}

variable "region_code" {
    description = <<-EOF
        description: Country code for region
        type: string
        required: no
        default: kr
        example:'''
            region_code = "kr"
        '''
    EOF
    type = string
    default = "kr"
}
########## Project Definition ########## }

########## Backup Definition ########## {
variable "description" {
    description = <<-EOF
        description: description of backup
        type: string
        required: no
    EOF
    type        = string
    default     = ""
}

variable "name" {
    description = <<-EOF
        description: backup name
        type: string
        required: yes
        input_validate_rule: ^[a-zA-Z0-9]{3,30}$
        input_validate_mesg: Enter a Backup name using letters and numbers with a length between 3 and 30 characters
    EOF
    type        = string
}

variable "object_id" {
    description = <<-EOF
        description: backup object id
        type: string
        required: yes
        example:'''
            object_id = "INSTANCE-******"
        '''
    EOF
    type        = string
} 

variable "category" {
    description = <<-EOF
        description: Backup Policy Type Category (VM, FILESYSTEM)
        type: string
        required: no
        example:'''
            category = "VM"
        '''
    EOF
    type        = string
    default     = "VM"
}

variable "repository" {
    description = <<-EOF
        description: Backup Repository (SD_STORAGE)
        type: string
        required: no
        example:'''
            repository = "SD_STORAGE"
        '''
    EOF
    type        = string
    default     = "SD_STORAGE"
}

variable "object_type" {
    description = <<-EOF
        description: Backup Object Type (INSTANCE|BAREMETAL)
        type: string
        required: no
        example:'''
            object_type = "INSTANCE"
        '''
    EOF
    type        = string
    default     = "INSTANCE"
}

variable "policy_type" {
    description = <<-EOF
        description: Backup Policy Type
        type: string
        required: no
        example:'''
            policy_type = "VMsnapshot"
        '''
    EOF
    type        = string
    default     = "VMsnapshot"
}

variable "product_names" {
    description = <<-EOF
        description: Product Names
        type: list(string)
        required: no
        example:'''
            product_names = ["VM Image"]
        '''
    EOF
    type        = list(string)
    default     = ["VM Image"]
}

variable "retention_period" {
    description = <<-EOF
        description: Backup Retention Period (2W|4W|3M|6M|1Y)
        type: string
        required: no
        example:'''
            retention_period = "2W"
        '''
    EOF
    type        = string
    default     = "2W"
}

variable "incremental_retention_period" {
    description = <<-EOF
        description: Incremental Backup Retention Period (2W|4W|3M|6M|1Y)
        type: string
        required: no
        example:'''
            incremental_retention_period = "2W"
        '''
    EOF
    type        = string
    default     = "2W"
}

variable "dr_enabled" {
    description = <<-EOF
        description: Backup(DR) Activation (Y|N)
        type: string
        required: no
        example:'''
            dr_enabled = "Y"
        '''
    EOF
    type        = string
    default     = "N"
}

variable "dr_destroy_enabled" {
    description = <<-EOF
        description: Backup(DR) Destroy Activation (Y|N), IF 'Y', Destroy DR replica together
        type: bool
        required: no
        example:'''
            dr_destroy_enabled = false
        '''
    EOF
    type        = bool
    default     = true
}

variable "schedules" {
    description = <<EOT
        type: list(object)
        required: no
        description:'''
          schedule_frequency : (String) Backup Schedule Frequency (MONTHLY, WEEKLY, DAYS)
          schedule_frequency_detail : (String) Backup Schedule Frequency details
          schedule_type :  (String) Backup Schedule Type (FULL, INCREMENTAL)
        start_time : (String) Backup Start Time (format:HH:mm±hh:mm)
        '''
        example:'''
        schedules = [
        {
            schedule_frequency = "WEEKLY"
            schedule_frequency_detail = "MON"
            schedule_type = "INCREMENTAL"
            start_time = "01:00:00+09:00"
        },
        {
            schedule_frequency = "MONTHLY"
            schedule_frequency_detail = "1"
            schedule_type = "FULL"
            start_time = "02:00:00+09:00"
        },
        ]
        '''
    EOT
    type = list(object({
      schedule_frequency = optional(string,"MONTHLY")
      schedule_frequency_detail = optional(string,"1")
      schedule_type = optional(string,"FULL")
      start_time = optional(string,"01:00:00+09:00")
    }))
    default = []
}

variable "tags" {
    description = <<-EOF
        description: tags for backup
        type: map(string)
        required: no
        example:'''
            tags = {"createdBy" = "gitops"}
        '''        
    EOF
    type = map(string)
    default = {}
}
########## Backup Definition ########## }
