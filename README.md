Alicloud Auto Scaling Terraform Module  
terraform-alicloud-autoscaling-rule
---

Terraform moudle which create auto scaling Rules on Alibaba Cloud. 
After that, the created rules can be triggered by alarm task or scheduled task automatically.

These types of resources are supported:

* [Auto Scaling Rule](https://www.terraform.io/docs/providers/alicloud/r/ess_scaling_rule.html)
* [Auto Scaling Alarm Task](https://www.terraform.io/docs/providers/alicloud/r/ess_alarm.html)
* [Auto Scaling Scheduled Task](https://www.terraform.io/docs/providers/alicloud/r/ess_scheduled_task.html)

## Usage

```hcl
// Create a scaling group using autoscaling module at first.
module "ess-group" {
  source             = "terraform-alicloud-modules/autoscaling/alicloud"
  scaling_group_name = "tf-scalingGroup"
  min_size           = 0
  max_size           = 1
  //...
}

// Then add scaling rule and alarm task
module "ess-rule" {
  source             = "terraform-alicloud-modules/autoscaling-rule/alicloud"
  scaling_group_id   = module.ess-group.this_autoscaling_group_id
  create_simple_rule = true
  create_alarm_task  = true
}
```

**NOTE:** This module using AccessKey and SecretKey are from `profile` and `shared_credentials_file`.
If you have not set them yet, please install [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) and configure it.

## Conditional creation

This moudle can create Auto Scaling Rules, Alarm Task and Scheduled Task using a existing Scaling Group.

1. To create rules and tasks, but not scaling group id:
    ```hcl
    scaling_group_name_regex = "existing-scaling-group-name-regex"
    ```

1. Create a simple scaling rule and specify the number of ECS instances to be adjusted:
    ```hcl
    create_simple_rule = true
    adjustment_value   = 5
    ```

1. Create a target tracking scaling rule and specify metric name and its target value:
    ```hcl
    create_target_tracking_rule = true
    metric_name                 = "CpuUtilization"
    target_value                = 80
    ```

1. Create a step scaling rule and specify the lower/upper limit value and the specified number of ECS instances to be adjusted:
    ```hcl
    create_step_rule = true
    step_adjustments = [
      {
        lower_limit      = 50
        upper_limit      = 60.5
        adjustment_value = 2
      },
      {
        lower_limit      = 60.5
        adjustment_value = 5
      }
    ]
    ```

1. Create a alarm task and specify monitoring setting:
    ```hcl
    create_alarm_task      = true
    alarm_task_metric_name = "CpuUtilization"
    alarm_task_setting = {
      period              = 60
      method              = "Minimum"
      threshold           = 60
      comparison_operator = ">="
      trigger_after       = 3
    }
    ```
    
1. Create a scheduled task and specify recurrence setting:
    ```hcl
    create_scheduled_task = true
    scheduled_task_setting = {
      run_at           = "2019-11-05T07:15Z"
      retry_interval   = 300
      recurrence_type  = "Cron"
      recurrence_value = "10 0 * * *"
      end_at           = "2019-12-05T07:15Z"
    }
    ```
    
    **NOTE:** You can use [timestamp](https://www.terraform.io/docs/configuration/functions/timestamp.html) to produce a self-define timestamp, like `run_at = formatdate("YYYY-MM-DD'T'hh:mmZ", timeadd(timestamp(), "24h")` return this time of the next day.

## Inputs

| Name | Description | Type | Default | Required | Vaild When |
|------|-------------|:----:|:-----:|:-----:|:-----:|
| region | The region ID used to launch this module resources. If not set, it will be sourced from followed by ALICLOUD_REGION environment variable and profile | string  | - | no  | - |
| profile | The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable. | string  | - | no  | - |
| shared_credentials_file | This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used. | string  | - | no  | - |
| skip_region_validation | Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet). | bool  | false | no  | - |
| scaling_group_id  | Specifying existing autoscaling group ID. If not set, it can be retrieved automatically by specifying filter `scaling_group_name_regex`.  | string  | - | no  |SimpleScalingRule, TargetTrackingScalingRule, StepScalingRule, AlarmTask|
| scaling_group_name_regex | Using a name regex to retrieve existing scaling group automactially | string  | - | no  |SimpleScalingRule, TargetTrackingScalingRule, StepScalingRule, AlarmTask|
| scaling_rule_name  | The name for scaling rule. Default to a random string prefixed with `terraform-ess-<rule type>-`  | string  | - | no  |SimpleScalingRule, TargetTrackingScalingRule, StepScalingRule|
| create_simple_rule  | Whether to create a simple scaling rule in the specified scaling group | bool  | false | no  |SimpleScalingRule|
| adjustment_type  | The method only used by the simple and step scaling rule to adjust the number of ECS instances. Valid values: QuantityChangeInCapacity, PercentChangeInCapacity and TotalCapacity  | string  | "TotalCapacity"  | no  | SimpleScalingRule, StepScalingRule|
| adjustment_value | The number of ECS instances to be adjusted in the simple scaling rule. The number of ECS instances to be adjusted in a single scaling activity cannot exceed 500 | int | 0 | no | SimpleScalingRule |
| cooldown | The cooldown time of the simple scaling rule. Valid values: 0 to 86400. Unit: seconds. If not set, the scaling group's cooldown will be used | int | - | no |SimpleScalingRule|
| create_target_tracking_rule | Whether to create a target tracking scaling rule in the specified scaling group | bool | false | no |TargetTrackingScalingRule|
| metric_name | The predefined metric to monitor. This parameter is required and applicable only to target tracking scaling rules. See valid values: https://www.alibabacloud.com/help/doc-detail/25948.htm | string | "CpuUtilization" | no |TargetTrackingScalingRule|
| target_value | The target value of a metric. This parameter is required and applicable only to target tracking scaling rules. It must be greater than 0 and can have a maximum of three decimal places | string | "80.5" | no |TargetTrackingScalingRule|
| disable_scale_in | Whether to disable scale-in. This parameter is applicable only to target tracking scaling rules | bool | false | no |TargetTrackingScalingRule|
| estimated_instance_warmup | The warm-up period of the ECS instances. It is applicable to target tracking scaling rules and step scaling rules. The system adds ECS instances that are in the warm-up state to the scaling group, but does not report monitoring data during the warm-up period to CloudMonitor. Valid values: 0 to 86400. Unit: seconds. | int | 300 | no |TargetTrackingScalingRule, StepScalingRule|
| create_step_rule | Whether to create a step scaling rule in the specified scaling group | bool | false | no |StepScalingRule|
| step_adjustments | The predefined metric to monitor. This parameter is required and applicable only to step scaling rules. Each item contains the following parameters: `lower_limit`(The lower limit value specified. Valid values: -9.999999E18 to 9.999999E18.), `upper_limit`(The upper limit value specified. Valid values: -9.999999E18 to 9.999999E18.), `adjustment_value`(The specified number of ECS instances to be adjusted) | list(map(string)) | [] | no |StepScalingRule|
| create_alarm_task | If true, the module will create a scheduled task for each scaling rule | bool | false | no |AlarmTask|
| alarm_task_name | The name for alarm task. Default to a random string prefixed with `terraform-alarm-task-` | string | "" | no |AlarmTask|
| alarm_task_metric_type | The monitoring type for alarm task. Valid values system, custom. `system` means the metric data is collected by Aliyun Cloud Monitor Service(CMS); `custom` means the metric data is upload to CMS by users. | string | "system" | no |AlarmTask|
| alarm_task_metric_name | The monitoring index name. Details see [system monitoring index](https://help.aliyun.com/document_detail/141651.htm) and [custom monidoring index](https://www.alibabacloud.com/help/doc-detail/74861.htm). | string | "CpuUtilization" | no |AlarmTask|
| alarm_task_setting | The setting of monitoring index setting. It contains the following parameters: `period`(A reference period used to collect, summary, and compute data. Default to 60 seconds), `method`(The method used to statistics data, default to Average), `threshold`(Verify whether the statistics data value of a metric exceeds the specified threshold. Default to 0), `comparison_operator`(The arithmetic operation to use when comparing the specified method and threshold. Default to >=), `trigger_after`(You can select one the following options, such as 1, 2, 3, and 5 times. When the value of a metric exceeds the threshold for specified times, an event is triggered, and the specified scaling rule is applied. Default to 3 times.) | map(string) | {} | no |AlarmTask|
| enable_alarm_task | Whether to enable the alarm task | bool | true | no |AlarmTask|
| create_scheduled_task | If true, the module will create a scheduled task for each scaling rule | bool | false | no |ScheduledTask|
| scheduled_task_name | The name for scheduled task. Default to a random string prefixed with `terraform-scheduled-task-` | string | - | no |ScheduledTask|
| scheduled_task_setting | The setting of running a scheduled task. It contains basic and recurrence setting. Deails see `run_at`(the time at which the scheduled task is triggered), `retry_interval`(the time period during which a failed scheduled task is retried, default to 600 seconds), `recurrence_type`(the recurrence type of the scheduled task: Daily, Weekly, Monthly or Cron, default to empty), `recurrence_value`(the recurrence frequency of the scheduled task, it must be set when `recurrence_type` is set) and `end_at`(the end time after which the scheduled task is no longer repeated. it will ignored if `recurrence_type` is not set) | map(string) | {} | no |ScheduledTask|
| enable_scheduled_task | Whether to enable the scheduled task | bool | true | no |ScheduledTask|

## Outputs

| Name | Description |
|------|-------------|
| this_autoscaling_group_id  | The ID of Autoscaling Group  |
| this_autoscaling_simple_rule_id | The id of the autoscaling simple rule |
| this_autoscaling_simple_rule_ari | The ari of the autoscaling simple rule |
| this_autoscaling_simple_rule_name | The name of the autoscaling simple rule |
| this_autoscaling_target_tracking_rule_id | The id of the autoscaling target tracking rule |
| this_autoscaling_target_tracking_rule_ari | The ari of the autoscaling target tracking rule |
| this_autoscaling_target_tracking_rule_name | The name of the autoscaling target tracking rule |
| this_autoscaling_step_rule_id | The id of the autoscaling step rule |
| this_autoscaling_step_rule_ari | The ari of the autoscaling step rule |
| this_autoscaling_step_rule_name | The name of the autoscaling step rule |
| this_autoscaling_alarm_task_name | The name of the autoscaling alarm task |
| this_autoscaling_alarm_task_id | The id of the autoscaling alarm task |
| this_autoscaling_scheduled_task_name | The name of the autoscaling scheduled task |
| this_autoscaling_scheduled_task_id | The id of the autoscaling scheduled task |

## Notes
From the version v1.1.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
   version                 = ">=1.60.0"
   profile                 = var.profile != "" ? var.profile : null
   shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
   region                  = var.region != "" ? var.region : null
   skip_region_validation  = var.skip_region_validation
   configuration_source    = "terraform-alicloud-modules/autoscaling-rule"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.0.3:

```hcl
module "ess-rule" {
  source             = "terraform-alicloud-modules/autoscaling-rule/alicloud"
  version            = "1.0.3"
  region             = "cn-beijing"
  profile            = "Your-Profile-Name"
  create_simple_rule = true
  create_alarm_task  = true
  // ...
}
```

If you want to upgrade the module to 1.1.0 or higher in-place, you can define a provider which same region with
previous region:

```hcl
provider "alicloud" {
  region  = "cn-beijing"
  profile = "Your-Profile-Name"
}
module "ess-rule" {
  source             = "terraform-alicloud-modules/autoscaling-rule/alicloud"
  create_simple_rule = true
  create_alarm_task  = true
  // ...
}
```
or specify an alias provider with a defined region to the module using `providers`:

```hcl
provider "alicloud" {
   region  = "cn-beijing"
   profile = "Your-Profile-Name"
   alias   = "bj"
}
module "ess-rule" {
  source             = "terraform-alicloud-modules/autoscaling-rule/alicloud"
  providers          = {
    alicloud = alicloud.bj
  }
  create_simple_rule = true
  create_alarm_task  = true
  // ...
}
```

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.60.0 |

Authors
----
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)
