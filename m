Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10B0698129
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2019 19:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfHURXx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Aug 2019 13:23:53 -0400
Received: from foss.arm.com ([217.140.110.172]:33894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbfHURXx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 21 Aug 2019 13:23:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C72A344;
        Wed, 21 Aug 2019 10:23:52 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C2863F718;
        Wed, 21 Aug 2019 10:23:51 -0700 (PDT)
Subject: Re: [PATCH RFC 1/4] ACPI: APEI: Add support to notify the vendor
 specific HW errors
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        tony.luck@intel.com, bp@alien8.de, baicar@os.amperecomputing.com,
        linuxarm@huawei.com, jonathan.cameron@huawei.com,
        tanxiaofei@huawei.com
References: <Shiju Jose> <20190812101149.26036-1-shiju.jose@huawei.com>
 <20190812101149.26036-2-shiju.jose@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <12a7f2f7-3a81-b0c3-fb8e-96db0cd626c5@arm.com>
Date:   Wed, 21 Aug 2019 18:23:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190812101149.26036-2-shiju.jose@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

On 12/08/2019 11:11, Shiju Jose wrote:
> Presently the vendor specific HW errors, in the non-standard format,
> are not reported to the vendor drivers for the recovery.
> 
> This patch adds support to notify the vendor specific HW errors to the
> registered kernel drivers.

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index a66e00f..374d197 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -477,6 +477,77 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
>  #endif
>  }
>  
> +struct ghes_error_notify {
> +	struct list_head list;> +	struct rcu_head	rcu_head;
> +	guid_t sec_type; /* guid of the error record */

> +	error_handle handle; /* error handler function */

ghes_error_handler_t error_handler; ?


> +	void *data; /* handler driver's private data if any */
> +};
> +
> +/* List to store the registered error handling functions */
> +static DEFINE_MUTEX(ghes_error_notify_mutex);
> +static LIST_HEAD(ghes_error_notify_list);

> +static refcount_t ghes_ref_count;

I don't think this refcount is needed.


> +/**
> + * ghes_error_notify_register - register an error handling function
> + * for the hw errors.
> + * @sec_type: sec_type of the corresponding CPER to be notified.
> + * @handle: pointer to the error handling function.
> + * @data: handler driver's private data.
> + *
> + * return 0 : SUCCESS, non-zero : FAIL
> + */
> +int ghes_error_notify_register(guid_t sec_type, error_handle handle, void *data)
> +{
> +	struct ghes_error_notify *err_notify;
> +
> +	mutex_lock(&ghes_error_notify_mutex);
> +	err_notify = kzalloc(sizeof(*err_notify), GFP_KERNEL);
> +	if (!err_notify)
> +		return -ENOMEM;

Leaving the mutex locked.
You may as well allocate the memory before taking the lock.


> +
> +	err_notify->handle = handle;
> +	guid_copy(&err_notify->sec_type, &sec_type);
> +	err_notify->data = data;
> +	list_add_rcu(&err_notify->list, &ghes_error_notify_list);
> +	mutex_unlock(&ghes_error_notify_mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ghes_error_notify_register);

Could we leave exporting this to modules until there is a user?


> +/**
> + * ghes_error_notify_unregister - unregister an error handling function.
> + * @sec_type: sec_type of the corresponding CPER.
> + * @handle: pointer to the error handling function.
> + *
> + * return none.
> + */
> +void ghes_error_notify_unregister(guid_t sec_type, error_handle handle)

Why do we need the handle(r) a second time? Surely there can only be one callback for a
given guid.


> +{
> +	struct ghes_error_notify *err_notify;
> +	bool found = 0;
> +
> +	mutex_lock(&ghes_error_notify_mutex);
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(err_notify, &ghes_error_notify_list, list) {
> +		if (guid_equal(&err_notify->sec_type, &sec_type) &&
> +		    err_notify->handle == handle) {
> +			list_del_rcu(&err_notify->list);
> +			found = 1;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();

> +	synchronize_rcu();

Is this for the kfree()? Please keep them together so its obvious what its for.
Putting it outside the mutex will also save any contended waiter some time.


> +	mutex_unlock(&ghes_error_notify_mutex);
> +	if (found)
> +		kfree(err_notify);
> +}
> +EXPORT_SYMBOL_GPL(ghes_error_notify_unregister);
> +

>  static void ghes_do_proc(struct ghes *ghes,
>  			 const struct acpi_hest_generic_status *estatus)
>  {> @@ -512,11 +585,29 @@ static void ghes_do_proc(struct ghes *ghes,
>  
>  			log_arm_hw_error(err);
>  		} else {
> -			void *err = acpi_hest_get_payload(gdata);
> -
> -			log_non_standard_event(sec_type, fru_id, fru_text,
> -					       sec_sev, err,
> -					       gdata->error_data_length);

> +			rcu_read_lock();
> +			list_for_each_entry_rcu(err_notify,
> +						&ghes_error_notify_list, list) {
> +				if (guid_equal(&err_notify->sec_type,
> +					       sec_type)) {

> +					/* The notification is called in the
> +					 * interrupt context, thus the handler
> +					 * functions should be take care of it.
> +					 */

I read this as "the handler will be called", which doesn't seem to be a useful comment.


> +					err_notify->handle(gdata, sev,
> +							   err_notify->data);
> +					is_notify = 1;

					break;

> +				}
> +			}
> +			rcu_read_unlock();

> +			if (!is_notify) {

if (!found) Seems more natural.


> +				void *err = acpi_hest_get_payload(gdata);
> +
> +				log_non_standard_event(sec_type, fru_id,
> +						       fru_text, sec_sev, err,
> +						       gdata->error_data_length);
> +			}

This is tricky to read as its so bunched up. Please pull it out into a separate function.
ghes_handle_non_standard_event() ?


Because you skip log_non_standard_event(), rasdaemon will no longer see these in
user-space. For any kernel consumer of these, we need to know we aren't breaking the
user-space component.


>  		}
>  	}
>  }
> @@ -1217,6 +1308,11 @@ static int ghes_probe(struct platform_device *ghes_dev)
>  
>  	ghes_edac_register(ghes, &ghes_dev->dev);
>  
> +	if (!refcount_read(&ghes_ref_count))
> +		refcount_set(&ghes_ref_count, 1);

What stops this from racing with itself if two ghes platform devices are probed at the
same time?

If the refcount needs initialising, please do it in ghes_init()....

> +	else
> +		refcount_inc(&ghes_ref_count);

.. but I don't think this refcount is needed.


>  	/* Handle any pending errors right away */
>  	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
>  	ghes_proc(ghes);

> @@ -1279,6 +1376,17 @@ static int ghes_remove(struct platform_device *ghes_dev)
>  
>  	ghes_fini(ghes);
>  
> +	if (refcount_dec_and_test(&ghes_ref_count) &&
> +	    !list_empty(&ghes_error_notify_list)) {
> +		mutex_lock(&ghes_error_notify_mutex);> +		list_for_each_entry_safe(err_notify, tmp,
> +					 &ghes_error_notify_list, list) {
> +			list_del_rcu(&err_notify->list);
> +			kfree_rcu(err_notify, rcu_head);
> +		}
> +		mutex_unlock(&ghes_error_notify_mutex);
> +	}

... If someone unregisters, and re-registers all the GHES platform devices, the last one
out flushes the vendor-specific error handlers away. Then we re-probe the devices again,
but this time the vendor-specific error handlers don't work.

As you have an add/remove API for drivers, its up to drivers to cleanup when they are
removed. The comings and goings of GHES platform devices isn't relevant.


>  	ghes_edac_unregister(ghes);
>  
>  	kfree(ghes);
> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> index e3f1cdd..d480537 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -50,6 +50,53 @@ enum {
>  	GHES_SEV_PANIC = 0x3,
>  };
>  
> +/**
> + * error_handle - error handling function for the hw errors.

Fatal errors get dealt with earlier, so drivers will never see them.
| error handling function for non-fatal hardware errors.


> + * This handle function is called in the interrupt context.

As this overrides ghes's logging of the error, we should mention:
| The handler is responsible for any logging of the error.


> + * @gdata: acpi_hest_generic_data.
> + * @sev: error severity of the entire error event defined in the
> + * ACPI spec table generic error status block.
> + * @data: handler driver's private data.
> + *
> + * return : none.
> + */
> +typedef void (*error_handle)(struct acpi_hest_generic_data *gdata, int sev,
> +			     void *data);


Thanks,

James
