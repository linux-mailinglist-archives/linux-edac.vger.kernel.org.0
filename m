Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537DF69B17F
	for <lists+linux-edac@lfdr.de>; Fri, 17 Feb 2023 17:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjBQQ7D (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Feb 2023 11:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjBQQ7B (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 17 Feb 2023 11:59:01 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9756D7AF;
        Fri, 17 Feb 2023 08:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676653135; x=1708189135;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zu0UDu+Z7S5ym/WxORDDc0xxVh88zZZYZ5QO7u0O1Gc=;
  b=aNZxyyT7fd4sLjSVY0yFeXH5M4FnBLjIOvvIBmTLWpWilpgYyhzSly2b
   3J2Z+rO3phkivZHsqTdekodYtVRrmIrdtxYUKewY/FSoXt1qSyWZM6oUd
   nLAVxzDu3rZ9bVFY659x0iHDcKTVAf+gUeYo3+uEWqUa8bm1wCFJWxJMV
   zRA8WicRhCJ7LFSDEFy9YGmQ4Rc6ab0AsUtfTjip9lpHG+sabFEFGXLr3
   gkRM4xIOW/FFq9sIRQ9R3l/YnjEHPvyMqLBBSyXGzgHTj/MLhROjQM046
   GTLrHUbOJLwOdgUZmlOe+MHUaIRQ79g1YIO/UvOqwvlfxtXhn/xBxN+bf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="418253157"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="418253157"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 08:58:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="620441725"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="620441725"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.187.252]) ([10.213.187.252])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 08:58:54 -0800
Message-ID: <49f3555a-c763-5609-0b3c-a8d796930c00@intel.com>
Date:   Fri, 17 Feb 2023 09:58:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH V4 3/4] rasdaemon: Add support for the CXL AER
 uncorrectable errors
Content-Language: en-US
To:     shiju.jose@huawei.com, mchehab@kernel.org,
        linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     jonathan.cameron@huawei.com, linuxarm@huawei.com
References: <20230214112143.798-1-shiju.jose@huawei.com>
 <20230214112143.798-4-shiju.jose@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230214112143.798-4-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 2/14/23 4:21 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support to log and record the CXL AER uncorrectable errors.
> 
> The corresponding Kernel patches are here:
> https://lore.kernel.org/linux-cxl/166974401763.1608150.5424589924034481387.stgit@djiang5-desk3.ch.intel.com/T/#t
> https://lore.kernel.org/linux-cxl/63e5ed38d77d9_138fbc2947a@iweiny-mobl.notmuch/T/#t
> 
> It was found that the header log data to be converted to the
> big-endian format to correctly store in the SQLite database likely
> because the SQLite database seems uses the big-endian storage.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   ras-cxl-handler.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++
>   ras-cxl-handler.h |   5 ++
>   ras-events.c      |   9 +++
>   ras-events.h      |   1 +
>   ras-record.c      |  67 +++++++++++++++++++++
>   ras-record.h      |  17 ++++++
>   ras-report.c      |  71 +++++++++++++++++++++++
>   ras-report.h      |   2 +
>   8 files changed, 317 insertions(+)
> 
> diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
> index b6175bf..3bcefd6 100644
> --- a/ras-cxl-handler.c
> +++ b/ras-cxl-handler.c
> @@ -21,6 +21,7 @@
>   #include "ras-record.h"
>   #include "ras-logger.h"
>   #include "ras-report.h"
> +#include <endian.h>
>   
>   /* Poison List: Payload out flags */
>   #define CXL_POISON_FLAG_MORE            BIT(0)
> @@ -176,3 +177,147 @@ int ras_cxl_poison_event_handler(struct trace_seq *s,
>   
>   	return 0;
>   }
> +
> +/* CXL AER Errors */
> +
> +#define CXL_AER_UE_CACHE_DATA_PARITY	BIT(0)
> +#define CXL_AER_UE_CACHE_ADDR_PARITY	BIT(1)
> +#define CXL_AER_UE_CACHE_BE_PARITY	BIT(2)
> +#define CXL_AER_UE_CACHE_DATA_ECC	BIT(3)
> +#define CXL_AER_UE_MEM_DATA_PARITY	BIT(4)
> +#define CXL_AER_UE_MEM_ADDR_PARITY	BIT(5)
> +#define CXL_AER_UE_MEM_BE_PARITY	BIT(6)
> +#define CXL_AER_UE_MEM_DATA_ECC		BIT(7)
> +#define CXL_AER_UE_REINIT_THRESH	BIT(8)
> +#define CXL_AER_UE_RSVD_ENCODE		BIT(9)
> +#define CXL_AER_UE_POISON		BIT(10)
> +#define CXL_AER_UE_RECV_OVERFLOW	BIT(11)
> +#define CXL_AER_UE_INTERNAL_ERR		BIT(14)
> +#define CXL_AER_UE_IDE_TX_ERR		BIT(15)
> +#define CXL_AER_UE_IDE_RX_ERR		BIT(16)
> +
> +struct cxl_error_list {
> +	uint32_t bit;
> +	const char *error;
> +};
> +
> +static const struct cxl_error_list cxl_aer_ue[] = {
> +	{ .bit = CXL_AER_UE_CACHE_DATA_PARITY, .error = "Cache Data Parity Error" },
> +	{ .bit = CXL_AER_UE_CACHE_ADDR_PARITY, .error = "Cache Address Parity Error" },
> +	{ .bit = CXL_AER_UE_CACHE_BE_PARITY, .error = "Cache Byte Enable Parity Error" },
> +	{ .bit = CXL_AER_UE_CACHE_DATA_ECC, .error = "Cache Data ECC Error" },
> +	{ .bit = CXL_AER_UE_MEM_DATA_PARITY, .error = "Memory Data Parity Error" },
> +	{ .bit = CXL_AER_UE_MEM_ADDR_PARITY, .error = "Memory Address Parity Error" },
> +	{ .bit = CXL_AER_UE_MEM_BE_PARITY, .error = "Memory Byte Enable Parity Error" },
> +	{ .bit = CXL_AER_UE_MEM_DATA_ECC, .error = "Memory Data ECC Error" },
> +	{ .bit = CXL_AER_UE_REINIT_THRESH, .error = "REINIT Threshold Hit" },
> +	{ .bit = CXL_AER_UE_RSVD_ENCODE, .error = "Received Unrecognized Encoding" },
> +	{ .bit = CXL_AER_UE_POISON, .error = "Received Poison From Peer" },
> +	{ .bit = CXL_AER_UE_RECV_OVERFLOW, .error = "Receiver Overflow" },
> +	{ .bit = CXL_AER_UE_INTERNAL_ERR, .error = "Component Specific Error" },
> +	{ .bit = CXL_AER_UE_IDE_TX_ERR, .error = "IDE Tx Error" },
> +	{ .bit = CXL_AER_UE_IDE_RX_ERR, .error = "IDE Rx Error" },
> +};
> +
> +static int decode_cxl_error_status(struct trace_seq *s, uint32_t status,
> +				   const struct cxl_error_list *cxl_error_list,
> +				   uint8_t num_elems)
> +{
> +	int i;
> +
> +	for (i = 0; i < num_elems; i++) {
> +		if (status & cxl_error_list[i].bit)
> +			if (trace_seq_printf(s, "\'%s\' ", cxl_error_list[i].error) <= 0)
> +				return -1;
> +	}
> +	return 0;
> +}
> +
> +int ras_cxl_aer_ue_event_handler(struct trace_seq *s,
> +				 struct tep_record *record,
> +				 struct tep_event *event, void *context)
> +{
> +	int len, i;
> +	unsigned long long val;
> +	time_t now;
> +	struct tm *tm;
> +	struct ras_events *ras = context;
> +	struct ras_cxl_aer_ue_event ev;
> +
> +	memset(&ev, 0, sizeof(ev));
> +	now = record->ts / user_hz + ras->uptime_diff;
> +	tm = localtime(&now);
> +	if (tm)
> +		strftime(ev.timestamp, sizeof(ev.timestamp),
> +			 "%Y-%m-%d %H:%M:%S %z", tm);
> +	else
> +		strncpy(ev.timestamp, "1970-01-01 00:00:00 +0000", sizeof(ev.timestamp));
> +	if (trace_seq_printf(s, "%s ", ev.timestamp) <= 0)
> +		return -1;
> +
> +	ev.memdev = tep_get_field_raw(s, event, "memdev",
> +				      record, &len, 1);
> +	if (!ev.memdev)
> +		return -1;
> +	if (trace_seq_printf(s, "memdev:%s ", ev.memdev) <= 0)
> +		return -1;
> +
> +	ev.host = tep_get_field_raw(s, event, "host",
> +				    record, &len, 1);
> +	if (!ev.host)
> +		return -1;
> +	if (trace_seq_printf(s, "host:%s ", ev.host) <= 0)
> +		return -1;
> +
> +	if (tep_get_field_val(s, event, "status", record, &val, 1) < 0)
> +		return -1;
> +	ev.error_status = val;
> +
> +	if (trace_seq_printf(s, "error status:") <= 0)
> +		return -1;
> +	if (decode_cxl_error_status(s, ev.error_status,
> +				    cxl_aer_ue, ARRAY_SIZE(cxl_aer_ue)) < 0)
> +		return -1;
> +
> +	if (tep_get_field_val(s,  event, "first_error", record, &val, 1) < 0)
> +		return -1;
> +	ev.first_error = val;
> +
> +	if (trace_seq_printf(s, "first error:") <= 0)
> +		return -1;
> +	if (decode_cxl_error_status(s, ev.first_error,
> +				    cxl_aer_ue, ARRAY_SIZE(cxl_aer_ue)) < 0)
> +		return -1;
> +
> +	ev.header_log = tep_get_field_raw(s, event, "header_log",
> +					  record, &len, 1);
> +	if (!ev.header_log)
> +		return -1;
> +	if (trace_seq_printf(s, "header log:\n") <= 0)
> +		return -1;
> +	for (i = 0; i < CXL_HEADERLOG_SIZE_U32; i++) {
> +		if (trace_seq_printf(s, "%08x ", ev.header_log[i]) <= 0)
> +			break;
> +		if ((i > 0) && ((i % 20) == 0))
> +			if (trace_seq_printf(s, "\n") <= 0)
> +				break;
> +		/* Convert header log data to the big-endian format because
> +		 * the SQLite database seems uses the big-endian storage.
> +		 */
> +		ev.header_log[i] = htobe32(ev.header_log[i]);
> +	}
> +	if (i < CXL_HEADERLOG_SIZE_U32)
> +		return -1;
> +
> +	/* Insert data into the SGBD */
> +#ifdef HAVE_SQLITE3
> +	ras_store_cxl_aer_ue_event(ras, &ev);
> +#endif
> +
> +#ifdef HAVE_ABRT_REPORT
> +	/* Report event to ABRT */
> +	ras_report_cxl_aer_ue_event(ras, &ev);
> +#endif
> +
> +	return 0;
> +}
> diff --git a/ras-cxl-handler.h b/ras-cxl-handler.h
> index 84d5cc6..18b3120 100644
> --- a/ras-cxl-handler.h
> +++ b/ras-cxl-handler.h
> @@ -21,4 +21,9 @@
>   int ras_cxl_poison_event_handler(struct trace_seq *s,
>   				 struct tep_record *record,
>   				 struct tep_event *event, void *context);
> +
> +int ras_cxl_aer_ue_event_handler(struct trace_seq *s,
> +				 struct tep_record *record,
> +				 struct tep_event *event, void *context);
> +
>   #endif
> diff --git a/ras-events.c b/ras-events.c
> index 6555125..ead792b 100644
> --- a/ras-events.c
> +++ b/ras-events.c
> @@ -246,6 +246,7 @@ int toggle_ras_mc_event(int enable)
>   
>   #ifdef HAVE_CXL
>   	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_poison", enable);
> +	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_aer_uncorrectable_error", enable);
>   #endif
>   
>   free_ras:
> @@ -964,6 +965,14 @@ int handle_ras_events(int record_events)
>   	else
>   		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
>   		    "cxl", "cxl_poison");
> +
> +	rc = add_event_handler(ras, pevent, page_size, "cxl", "cxl_aer_uncorrectable_error",
> +			       ras_cxl_aer_ue_event_handler, NULL, CXL_AER_UE_EVENT);
> +	if (!rc)
> +		num_events++;
> +	else
> +		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
> +		    "cxl", "cxl_aer_uncorrectable_error");
>   #endif
>   
>   	if (!num_events) {
> diff --git a/ras-events.h b/ras-events.h
> index fc51070..65f9d9a 100644
> --- a/ras-events.h
> +++ b/ras-events.h
> @@ -40,6 +40,7 @@ enum {
>   	DISKERROR_EVENT,
>   	MF_EVENT,
>   	CXL_POISON_EVENT,
> +	CXL_AER_UE_EVENT,
>   	NR_EVENTS
>   };
>   
> diff --git a/ras-record.c b/ras-record.c
> index 9db5d93..bd297ad 100644
> --- a/ras-record.c
> +++ b/ras-record.c
> @@ -620,6 +620,56 @@ int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_eve
>   
>   	return rc;
>   }
> +
> +/*
> + * Table and functions to handle cxl:cxl_aer_uncorrectable_error
> + */
> +static const struct db_fields cxl_aer_ue_event_fields[] = {
> +	{ .name = "id",                   .type = "INTEGER PRIMARY KEY" },
> +	{ .name = "timestamp",            .type = "TEXT" },
> +	{ .name = "memdev",               .type = "TEXT" },
> +	{ .name = "host",                 .type = "TEXT" },
> +	{ .name = "error_status",         .type = "INTEGER" },
> +	{ .name = "first_error",          .type = "INTEGER" },
> +	{ .name = "header_log",           .type = "BLOB" },
> +};
> +
> +static const struct db_table_descriptor cxl_aer_ue_event_tab = {
> +	.name = "cxl_aer_ue_event",
> +	.fields = cxl_aer_ue_event_fields,
> +	.num_fields = ARRAY_SIZE(cxl_aer_ue_event_fields),
> +};
> +
> +int ras_store_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev)
> +{
> +	int rc;
> +	struct sqlite3_priv *priv = ras->db_priv;
> +
> +	if (!priv || !priv->stmt_cxl_aer_ue_event)
> +		return 0;
> +	log(TERM, LOG_INFO, "cxl_aer_ue_event store: %p\n", priv->stmt_cxl_aer_ue_event);
> +
> +	sqlite3_bind_text(priv->stmt_cxl_aer_ue_event, 1, ev->timestamp, -1, NULL);
> +	sqlite3_bind_text(priv->stmt_cxl_aer_ue_event, 2, ev->memdev, -1, NULL);
> +	sqlite3_bind_text(priv->stmt_cxl_aer_ue_event, 3, ev->host, -1, NULL);
> +	sqlite3_bind_int(priv->stmt_cxl_aer_ue_event, 4, ev->error_status);
> +	sqlite3_bind_int(priv->stmt_cxl_aer_ue_event, 5, ev->first_error);
> +	sqlite3_bind_blob(priv->stmt_cxl_aer_ue_event, 6, ev->header_log, CXL_HEADERLOG_SIZE, NULL);
> +
> +	rc = sqlite3_step(priv->stmt_cxl_aer_ue_event);
> +	if (rc != SQLITE_OK && rc != SQLITE_DONE)
> +		log(TERM, LOG_ERR,
> +		    "Failed to do cxl_aer_ue_event step on sqlite: error = %d\n", rc);
> +	rc = sqlite3_reset(priv->stmt_cxl_aer_ue_event);
> +	if (rc != SQLITE_OK && rc != SQLITE_DONE)
> +		log(TERM, LOG_ERR,
> +		    "Failed reset cxl_aer_ue_event on sqlite: error = %d\n",
> +		    rc);
> +	log(TERM, LOG_INFO, "register inserted at db\n");
> +
> +	return rc;
> +}
> +
>   #endif
>   
>   /*
> @@ -967,6 +1017,15 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
>   		if (rc != SQLITE_OK)
>   			goto error;
>   	}
> +
> +	rc = ras_mc_create_table(priv, &cxl_aer_ue_event_tab);
> +	if (rc == SQLITE_OK) {
> +		rc = ras_mc_prepare_stmt(priv, &priv->stmt_cxl_aer_ue_event,
> +					 &cxl_aer_ue_event_tab);
> +		if (rc != SQLITE_OK)
> +			goto error;
> +	}
> +
>   #endif
>   
>   	ras->db_priv = priv;
> @@ -1089,6 +1148,14 @@ int ras_mc_event_closedb(unsigned int cpu, struct ras_events *ras)
>   			    "cpu %u: Failed to finalize cxl_poison_event sqlite: error = %d\n",
>   			    cpu, rc);
>   	}
> +
> +	if (priv->stmt_cxl_aer_ue_event) {
> +		rc = sqlite3_finalize(priv->stmt_cxl_aer_ue_event);
> +		if (rc != SQLITE_OK)
> +			log(TERM, LOG_ERR,
> +			    "cpu %u: Failed to finalize cxl_aer_ue_event sqlite: error = %d\n",
> +			    cpu, rc);
> +	}
>   #endif
>   
>   	rc = sqlite3_close_v2(db);
> diff --git a/ras-record.h b/ras-record.h
> index 9ede444..e2dcd19 100644
> --- a/ras-record.h
> +++ b/ras-record.h
> @@ -129,6 +129,19 @@ struct ras_cxl_poison_event {
>   	char overflow_ts[64];
>   };
>   
> +#define SZ_512                          0x200
> +#define CXL_HEADERLOG_SIZE              SZ_512
> +#define CXL_HEADERLOG_SIZE_U32          (SZ_512 / sizeof(uint32_t))
> +
> +struct ras_cxl_aer_ue_event {
> +	char timestamp[64];
> +	const char *memdev;
> +	const char *host;
> +	uint32_t error_status;
> +	uint32_t first_error;
> +	uint32_t *header_log;
> +};
> +
>   struct ras_mc_event;
>   struct ras_aer_event;
>   struct ras_extlog_event;
> @@ -139,6 +152,7 @@ struct devlink_event;
>   struct diskerror_event;
>   struct ras_mf_event;
>   struct ras_cxl_poison_event;
> +struct ras_cxl_aer_ue_event;
>   
>   #ifdef HAVE_SQLITE3
>   
> @@ -173,6 +187,7 @@ struct sqlite3_priv {
>   #endif
>   #ifdef HAVE_CXL
>   	sqlite3_stmt	*stmt_cxl_poison_event;
> +	sqlite3_stmt	*stmt_cxl_aer_ue_event;
>   #endif
>   };
>   
> @@ -202,6 +217,7 @@ int ras_store_devlink_event(struct ras_events *ras, struct devlink_event *ev);
>   int ras_store_diskerror_event(struct ras_events *ras, struct diskerror_event *ev);
>   int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev);
>   int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev);
> +int ras_store_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev);
>   
>   #else
>   static inline int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras) { return 0; };
> @@ -216,6 +232,7 @@ static inline int ras_store_devlink_event(struct ras_events *ras, struct devlink
>   static inline int ras_store_diskerror_event(struct ras_events *ras, struct diskerror_event *ev) { return 0; };
>   static inline int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev) { return 0; };
>   static inline int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev) { return 0; };
> +static inline int ras_store_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev) { return 0; };
>   
>   #endif
>   
> diff --git a/ras-report.c b/ras-report.c
> index b1b7614..b3cc7dc 100644
> --- a/ras-report.c
> +++ b/ras-report.c
> @@ -369,6 +369,30 @@ static int set_cxl_poison_event_backtrace(char *buf, struct ras_cxl_poison_event
>   	return 0;
>   }
>   
> +static int set_cxl_aer_ue_event_backtrace(char *buf, struct ras_cxl_aer_ue_event *ev)
> +{
> +	char bt_buf[MAX_BACKTRACE_SIZE];
> +
> +	if (!buf || !ev)
> +		return -1;
> +
> +	sprintf(bt_buf, "BACKTRACE="	\
> +						"timestamp=%s\n"	\
> +						"memdev=%s\n"		\
> +						"host=%s\n"		\
> +						"error_status=%u\n"	\
> +						"first_error=%u\n"	\
> +						ev->timestamp,		\
> +						ev->memdev,		\
> +						ev->host,		\
> +						ev->error_status,	\
> +						ev->first_error);
> +
> +	strcat(buf, bt_buf);
> +
> +	return 0;
> +}
> +
>   static int commit_report_backtrace(int sockfd, int type, void *ev){
>   	char buf[MAX_BACKTRACE_SIZE];
>   	char *pbuf = buf;
> @@ -409,6 +433,9 @@ static int commit_report_backtrace(int sockfd, int type, void *ev){
>   	case CXL_POISON_EVENT:
>   		rc = set_cxl_poison_event_backtrace(buf, (struct ras_cxl_poison_event *)ev);
>   		break;
> +	case CXL_AER_UE_EVENT:
> +		rc = set_cxl_aer_ue_event_backtrace(buf, (struct ras_cxl_aer_ue_event *)ev);
> +		break;
>   	default:
>   		return -1;
>   	}
> @@ -861,3 +888,47 @@ cxl_poison_fail:
>   	else
>   		return -1;
>   }
> +
> +int ras_report_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev)
> +{
> +	char buf[MAX_MESSAGE_SIZE];
> +	int sockfd = 0;
> +	int done = 0;
> +	int rc = -1;
> +
> +	memset(buf, 0, sizeof(buf));
> +
> +	sockfd = setup_report_socket();
> +	if (sockfd < 0)
> +		return -1;
> +
> +	rc = commit_report_basic(sockfd);
> +	if (rc < 0)
> +		goto cxl_aer_ue_fail;
> +
> +	rc = commit_report_backtrace(sockfd, CXL_AER_UE_EVENT, ev);
> +	if (rc < 0)
> +		goto cxl_aer_ue_fail;
> +
> +	sprintf(buf, "ANALYZER=%s", "rasdaemon-cxl-aer-uncorrectable-error");
> +	rc = write(sockfd, buf, strlen(buf) + 1);
> +	if (rc < strlen(buf) + 1)
> +		goto cxl_aer_ue_fail;
> +
> +	sprintf(buf, "REASON=%s", "CXL AER uncorrectable error");
> +	rc = write(sockfd, buf, strlen(buf) + 1);
> +	if (rc < strlen(buf) + 1)
> +		goto cxl_aer_ue_fail;
> +
> +	done = 1;
> +
> +cxl_aer_ue_fail:
> +
> +	if (sockfd >= 0)
> +		close(sockfd);
> +
> +	if (done)
> +		return 0;
> +	else
> +		return -1;
> +}
> diff --git a/ras-report.h b/ras-report.h
> index d1591ce..dfe89d1 100644
> --- a/ras-report.h
> +++ b/ras-report.h
> @@ -40,6 +40,7 @@ int ras_report_devlink_event(struct ras_events *ras, struct devlink_event *ev);
>   int ras_report_diskerror_event(struct ras_events *ras, struct diskerror_event *ev);
>   int ras_report_mf_event(struct ras_events *ras, struct ras_mf_event *ev);
>   int ras_report_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev);
> +int ras_report_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev);
>   
>   #else
>   
> @@ -52,6 +53,7 @@ static inline int ras_report_devlink_event(struct ras_events *ras, struct devlin
>   static inline int ras_report_diskerror_event(struct ras_events *ras, struct diskerror_event *ev) { return 0; };
>   static inline int ras_report_mf_event(struct ras_events *ras, struct ras_mf_event *ev) { return 0; };
>   static inline int ras_report_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev) { return 0; };
> +static inline int ras_report_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev) { return 0; };
>   
>   #endif
>   
