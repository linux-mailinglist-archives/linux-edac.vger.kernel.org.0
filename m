Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD8B999A6
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2019 18:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390191AbfHVQ5R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Thu, 22 Aug 2019 12:57:17 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33181 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727807AbfHVQ5Q (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 22 Aug 2019 12:57:16 -0400
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 31D105D64E49A408FF9F;
        Thu, 22 Aug 2019 17:57:15 +0100 (IST)
Received: from LHREML523-MBX.china.huawei.com ([169.254.7.10]) by
 LHREML714-CAH.china.huawei.com ([10.201.108.37]) with mapi id 14.03.0415.000;
 Thu, 22 Aug 2019 17:57:09 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     James Morse <james.morse@arm.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "baicar@os.amperecomputing.com" <baicar@os.amperecomputing.com>,
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>
Subject: RE: [PATCH RFC 1/4] ACPI: APEI: Add support to notify the vendor
 specific HW errors
Thread-Topic: [PATCH RFC 1/4] ACPI: APEI: Add support to notify the vendor
 specific HW errors
Thread-Index: AQHVUPaVDDB7fKoU40KADAw02afPcacF17OAgAFG26A=
Date:   Thu, 22 Aug 2019 16:57:08 +0000
Message-ID: <86258A5CC0A3704780874CF6004BA8A6584C7BBE@lhreml523-mbx.china.huawei.com>
References: <Shiju Jose> <20190812101149.26036-1-shiju.jose@huawei.com>
 <20190812101149.26036-2-shiju.jose@huawei.com>
 <12a7f2f7-3a81-b0c3-fb8e-96db0cd626c5@arm.com>
In-Reply-To: <12a7f2f7-3a81-b0c3-fb8e-96db0cd626c5@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.93.28]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi James,

>-----Original Message-----
>From: James Morse [mailto:james.morse@arm.com]
>Sent: 21 August 2019 18:24
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-acpi@vger.kernel.org; linux-edac@vger.kernel.org; linux-
>kernel@vger.kernel.org; rjw@rjwysocki.net; lenb@kernel.org;
>tony.luck@intel.com; bp@alien8.de; baicar@os.amperecomputing.com;
>Linuxarm <linuxarm@huawei.com>; Jonathan Cameron
><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>
>Subject: Re: [PATCH RFC 1/4] ACPI: APEI: Add support to notify the vendor
>specific HW errors
>
>Hi,
>
>On 12/08/2019 11:11, Shiju Jose wrote:
>> Presently the vendor specific HW errors, in the non-standard format,
>> are not reported to the vendor drivers for the recovery.
>>
>> This patch adds support to notify the vendor specific HW errors to the
>> registered kernel drivers.
>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c index
>> a66e00f..374d197 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -477,6 +477,77 @@ static void ghes_handle_aer(struct
>> acpi_hest_generic_data *gdata)  #endif  }
>>
>> +struct ghes_error_notify {
>> +	struct list_head list;> +	struct rcu_head	rcu_head;
>> +	guid_t sec_type; /* guid of the error record */
>
>> +	error_handle handle; /* error handler function */
>
>ghes_error_handler_t error_handler; ?
Sure.

>
>
>> +	void *data; /* handler driver's private data if any */ };
>> +
>> +/* List to store the registered error handling functions */ static
>> +DEFINE_MUTEX(ghes_error_notify_mutex);
>> +static LIST_HEAD(ghes_error_notify_list);
>
>> +static refcount_t ghes_ref_count;
>
>I don't think this refcount is needed.
refcount was added to register standard error handlers with this notification method one time when
multiple ghes platform devices are probed.
 
>
>
>> +/**
>> + * ghes_error_notify_register - register an error handling function
>> + * for the hw errors.
>> + * @sec_type: sec_type of the corresponding CPER to be notified.
>> + * @handle: pointer to the error handling function.
>> + * @data: handler driver's private data.
>> + *
>> + * return 0 : SUCCESS, non-zero : FAIL  */ int
>> +ghes_error_notify_register(guid_t sec_type, error_handle handle, void
>> +*data) {
>> +	struct ghes_error_notify *err_notify;
>> +
>> +	mutex_lock(&ghes_error_notify_mutex);
>> +	err_notify = kzalloc(sizeof(*err_notify), GFP_KERNEL);
>> +	if (!err_notify)
>> +		return -ENOMEM;
>
>Leaving the mutex locked.
>You may as well allocate the memory before taking the lock.
Good spot. I will fix.

>
>
>> +
>> +	err_notify->handle = handle;
>> +	guid_copy(&err_notify->sec_type, &sec_type);
>> +	err_notify->data = data;
>> +	list_add_rcu(&err_notify->list, &ghes_error_notify_list);
>> +	mutex_unlock(&ghes_error_notify_mutex);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(ghes_error_notify_register);
>
>Could we leave exporting this to modules until there is a user?
>
>
>> +/**
>> + * ghes_error_notify_unregister - unregister an error handling function.
>> + * @sec_type: sec_type of the corresponding CPER.
>> + * @handle: pointer to the error handling function.
>> + *
>> + * return none.
>> + */
>> +void ghes_error_notify_unregister(guid_t sec_type, error_handle
>> +handle)
>
>Why do we need the handle(r) a second time? Surely there can only be one
>callback for a given guid.
There is a possibility of sharing the guid between drivers if the non-standard error section format is common
for more than one devices if the error data to be reported is in the same format.
 
>
>
>> +{
>> +	struct ghes_error_notify *err_notify;
>> +	bool found = 0;
>> +
>> +	mutex_lock(&ghes_error_notify_mutex);
>> +	rcu_read_lock();
>> +	list_for_each_entry_rcu(err_notify, &ghes_error_notify_list, list) {
>> +		if (guid_equal(&err_notify->sec_type, &sec_type) &&
>> +		    err_notify->handle == handle) {
>> +			list_del_rcu(&err_notify->list);
>> +			found = 1;
>> +			break;
>> +		}
>> +	}
>> +	rcu_read_unlock();
>
>> +	synchronize_rcu();
>
>Is this for the kfree()? Please keep them together so its obvious what its for.
>Putting it outside the mutex will also save any contended waiter some time.
Yes. I will move synchronize_rcu () just before kfree. 
 
>
>
>> +	mutex_unlock(&ghes_error_notify_mutex);
>> +	if (found)
>> +		kfree(err_notify);
>> +}
>> +EXPORT_SYMBOL_GPL(ghes_error_notify_unregister);
>> +
>
>>  static void ghes_do_proc(struct ghes *ghes,
>>  			 const struct acpi_hest_generic_status *estatus)  {>
>@@ -512,11
>> +585,29 @@ static void ghes_do_proc(struct ghes *ghes,
>>
>>  			log_arm_hw_error(err);
>>  		} else {
>> -			void *err = acpi_hest_get_payload(gdata);
>> -
>> -			log_non_standard_event(sec_type, fru_id, fru_text,
>> -					       sec_sev, err,
>> -					       gdata->error_data_length);
>
>> +			rcu_read_lock();
>> +			list_for_each_entry_rcu(err_notify,
>> +						&ghes_error_notify_list, list) {
>> +				if (guid_equal(&err_notify->sec_type,
>> +					       sec_type)) {
>
>> +					/* The notification is called in the
>> +					 * interrupt context, thus the handler
>> +					 * functions should be take care of it.
>> +					 */
>
>I read this as "the handler will be called", which doesn't seem to be a useful
>comment.
Ok. I will correct the comment.
>
>
>> +					err_notify->handle(gdata, sev,
>> +							   err_notify->data);
>> +					is_notify = 1;
>
>					break;
>
>> +				}
>> +			}
>> +			rcu_read_unlock();
>
>> +			if (!is_notify) {
>
>if (!found) Seems more natural.
Ok. I will change to "is_notify"  to "found".

>
>
>> +				void *err = acpi_hest_get_payload(gdata);
>> +
>> +				log_non_standard_event(sec_type, fru_id,
>> +						       fru_text, sec_sev, err,
>> +						       gdata->error_data_length);
>> +			}
>
>This is tricky to read as its so bunched up. Please pull it out into a separate
>function.
>ghes_handle_non_standard_event() ?
Ok. I will add to new ghes_handle_non_standard_event() function.

>
>
>Because you skip log_non_standard_event(), rasdaemon will no longer see
>these in user-space. For any kernel consumer of these, we need to know we
>aren't breaking the user-space component.
>
>
>>  		}
>>  	}
>>  }
>> @@ -1217,6 +1308,11 @@ static int ghes_probe(struct platform_device
>> *ghes_dev)
>>
>>  	ghes_edac_register(ghes, &ghes_dev->dev);
>>
>> +	if (!refcount_read(&ghes_ref_count))
>> +		refcount_set(&ghes_ref_count, 1);
>
>What stops this from racing with itself if two ghes platform devices are probed
>at the same time?
yes. It is an issue.
>
>If the refcount needs initialising, please do it in ghes_init()....
refcount was added to register the standard error handlers to the notification
method only for the first time when the ghes device probed multiple times.
I will check is it possible to avoid using refcount by moving the above registration
of standard error handlers to the ghes_init().
>
>> +	else
>> +		refcount_inc(&ghes_ref_count);
>
>.. but I don't think this refcount is needed.
>
>
>>  	/* Handle any pending errors right away */
>>  	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
>>  	ghes_proc(ghes);
>
>> @@ -1279,6 +1376,17 @@ static int ghes_remove(struct platform_device
>> *ghes_dev)
>>
>>  	ghes_fini(ghes);
>>
>> +	if (refcount_dec_and_test(&ghes_ref_count) &&
>> +	    !list_empty(&ghes_error_notify_list)) {
>> +		mutex_lock(&ghes_error_notify_mutex);> +
>	list_for_each_entry_safe(err_notify, tmp,
>> +					 &ghes_error_notify_list, list) {
>> +			list_del_rcu(&err_notify->list);
>> +			kfree_rcu(err_notify, rcu_head);
>> +		}
>> +		mutex_unlock(&ghes_error_notify_mutex);
>> +	}
>
>... If someone unregisters, and re-registers all the GHES platform devices, the
>last one out flushes the vendor-specific error handlers away. Then we re-probe
>the devices again, but this time the vendor-specific error handlers don't work.
>
>As you have an add/remove API for drivers, its up to drivers to cleanup when
>they are removed. The comings and goings of GHES platform devices isn't
>relevant.
Ok. Got it. I will either keep the unregister for the standard error handlers only
if the standard error handlers can be part of the notification method or remove completely
if the registration can be done in the ghes_init().    
>
>
>>  	ghes_edac_unregister(ghes);
>>
>>  	kfree(ghes);
>> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h index
>> e3f1cdd..d480537 100644
>> --- a/include/acpi/ghes.h
>> +++ b/include/acpi/ghes.h
>> @@ -50,6 +50,53 @@ enum {
>>  	GHES_SEV_PANIC = 0x3,
>>  };
>>
>> +/**
>> + * error_handle - error handling function for the hw errors.
>
>Fatal errors get dealt with earlier, so drivers will never see them.
>| error handling function for non-fatal hardware errors.
Ok. I will change the comment as recoverable HW errors.
>
>
>> + * This handle function is called in the interrupt context.
>
>As this overrides ghes's logging of the error, we should mention:
>| The handler is responsible for any logging of the error.
Ok. I will add in the comment.
>
>
>> + * @gdata: acpi_hest_generic_data.
>> + * @sev: error severity of the entire error event defined in the
>> + * ACPI spec table generic error status block.
>> + * @data: handler driver's private data.
>> + *
>> + * return : none.
>> + */
>> +typedef void (*error_handle)(struct acpi_hest_generic_data *gdata, int sev,
>> +			     void *data);
>
>
>Thanks,
>
>James
Thanks,
Shiju
