Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D504D67C7FF
	for <lists+linux-edac@lfdr.de>; Thu, 26 Jan 2023 11:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbjAZKEX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Thu, 26 Jan 2023 05:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbjAZKEW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 26 Jan 2023 05:04:22 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3FE6DB25;
        Thu, 26 Jan 2023 02:04:18 -0800 (PST)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P2bmT5VKLz67bVM;
        Thu, 26 Jan 2023 18:00:09 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 26 Jan 2023 10:04:16 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2375.034;
 Thu, 26 Jan 2023 10:04:16 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>
CC:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH V2 2/4] rasdaemon: Add support for the CXL poison events
Thread-Topic: [PATCH V2 2/4] rasdaemon: Add support for the CXL poison events
Thread-Index: AQHZMBUDwh/M+sNz9U2N9frzcPkO0K6vulKAgAC8TEA=
Date:   Thu, 26 Jan 2023 10:04:16 +0000
Message-ID: <8eb3a8a40cb8494381795fb0c1d1ca95@huawei.com>
References: <20230124165733.1452-1-shiju.jose@huawei.com>
 <20230124165733.1452-3-shiju.jose@huawei.com>
 <63d1ae8d41b2b_3e042294ab@iweiny-mobl.notmuch>
In-Reply-To: <63d1ae8d41b2b_3e042294ab@iweiny-mobl.notmuch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.171.35]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Ira,

Thank you for the feedback.

>-----Original Message-----
>From: Ira Weiny <ira.weiny@intel.com>
>Sent: 25 January 2023 22:35
>To: Shiju Jose <shiju.jose@huawei.com>; linux-edac@vger.kernel.org; linux-
>cxl@vger.kernel.org; mchehab@kernel.org
>Cc: Jonathan Cameron <jonathan.cameron@huawei.com>; Linuxarm
><linuxarm@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
>Subject: Re: [PATCH V2 2/4] rasdaemon: Add support for the CXL poison
>events
>
>shiju.jose@ wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add support to log and record the CXL poison events.
>>
>> The corresponding Kernel patches here:
>> https://lore.kernel.org/linux-cxl/de11785ff05844299b40b100f8e0f56c7eef
>> 7f08.1674070170.git.alison.schofield@intel.com/
>>
>> Presently RFC draft version for logging, could be extended for the
>> policy based recovery action for the frequent poison events depending
>> on the above kernel patches.
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>[snip]
>
>> +
>> +int ras_cxl_poison_event_handler(struct trace_seq *s,
>> +				 struct tep_record *record,
>> +				 struct tep_event *event, void *context) {
>> +	int len;
>> +	unsigned long long val;
>> +	struct ras_events *ras = context;
>> +	time_t now;
>> +	struct tm *tm;
>> +	struct ras_cxl_poison_event ev;
>> +
>> +	now = record->ts/user_hz + ras->uptime_diff;
>> +	tm = localtime(&now);
>> +	if (tm)
>> +		strftime(ev.timestamp, sizeof(ev.timestamp),
>> +			 "%Y-%m-%d %H:%M:%S %z", tm);
>> +	else
>> +		strncpy(ev.timestamp, "1970-01-01 00:00:00 +0000",
>sizeof(ev.timestamp));
>> +	trace_seq_printf(s, "%s ", ev.timestamp);
>> +
>> +	ev.memdev = tep_get_field_raw(s, event, "memdev",
>> +				      record, &len, 1);
>> +	if (!ev.memdev)
>> +		return -1;
>> +	trace_seq_printf(s, "memdev:%s ", ev.memdev);
>> +
>> +	ev.pcidev = tep_get_field_raw(s, event, "pcidev",
>> +				      record, &len, 1);
>> +	if (!ev.pcidev)
>> +		return -1;
>> +	trace_seq_printf(s, "pcidev:%s ", ev.pcidev);
>> +
>> +	ev.region = tep_get_field_raw(s, event, "region",
>> +				      record, &len, 1);
>> +	if (!ev.region)
>> +		return -1;
>> +	trace_seq_printf(s, "region:%s ", ev.region);
>> +
>> +	ev.uuid = tep_get_field_raw(s, event, "uuid",
>> +				    record, &len, 1);
>> +	if (!ev.uuid)
>> +		return -1;
>> +	trace_seq_printf(s, "region_uuid:%s ", ev.uuid);
>> +
>> +	if (tep_get_field_val(s, event, "hpa", record, &val, 1) < 0)
>> +		return -1;
>> +	ev.hpa = val;
>> +	trace_seq_printf(s, "poison list: hpa:0x%llx ", (unsigned long
>> +long)ev.hpa);
>> +
>> +	if (tep_get_field_val(s, event, "dpa", record, &val, 1) < 0)
>> +		return -1;
>> +	ev.dpa = val;
>> +	trace_seq_printf(s, "dpa:0x%llx ", (unsigned long long)ev.dpa);
>> +
>> +	if (tep_get_field_val(s, event, "length", record, &val, 1) < 0)
>> +		return -1;
>> +	ev.length = val;
>> +	trace_seq_printf(s, "length:%d ", ev.length);
>> +
>> +	if (tep_get_field_val(s,  event, "source", record, &val, 1) < 0)
>> +		return -1;
>> +
>> +	switch (val) {
>> +	case CXL_POISON_SOURCE_UNKNOWN:
>> +		ev.source = "Unknown";
>> +		break;
>> +	case CXL_POISON_SOURCE_EXTERNAL:
>> +		ev.source = "External";
>> +		break;
>> +	case CXL_POISON_SOURCE_INTERNAL:
>> +		ev.source = "Internal";
>> +		break;
>> +	case CXL_POISON_SOURCE_INJECTED:
>> +		ev.source = "Injected";
>> +		break;
>> +	case CXL_POISON_SOURCE_VENDOR:
>> +		ev.source = "Vendor";
>> +		break;
>> +	default:
>> +		ev.source = "Invalid";
>> +	}
>> +	trace_seq_printf(s, "source:%s ", ev.source);
>> +
>> +	if (tep_get_field_val(s,  event, "flags", record, &val, 1) < 0)
>> +		return -1;
>> +	ev.flags = val;
>> +	trace_seq_printf(s, "flags:%d ", ev.flags);
>> +
>> +	if (ev.flags & CXL_POISON_FLAG_OVERFLOW) {
>> +		if (tep_get_field_val(s,  event, "overflow_t", record, &val, 1) <
>0)
>> +			return -1;
>> +		if (val) {
>> +			/* CXL Specification 3.0
>> +			 * Overflow timestamp - The number of unsigned
>nanoseconds
>> +			 * that have elapsed since midnight, 01-Jan-1970 UTC
>> +			 */
>> +			time_t ovf_ts_secs = val / 1000000000ULL;
>> +
>> +			tm = localtime(&ovf_ts_secs);
>> +			if (tm) {
>> +				strftime(ev.overflow_ts,
>sizeof(ev.overflow_ts),
>> +					 "%Y-%m-%d %H:%M:%S %z", tm);
>> +			}
>> +		}
>> +		if (!val || !tm)
>> +			strncpy(ev.overflow_ts, "1970-01-01 00:00:00 +0000",
>> +				sizeof(ev.overflow_ts));
>> +	} else
>> +		strncpy(ev.overflow_ts, "1970-01-01 00:00:00 +0000",
>sizeof(ev.overflow_ts));
>> +	trace_seq_printf(s, "overflow timestamp:%s ", ev.overflow_ts);
>> +	trace_seq_printf(s, "\n");
>> +
>> +	/* Insert data into the SGBD */
>> +#ifdef HAVE_SQLITE3
>> +	ras_store_cxl_poison_event(ras, &ev); #endif
>
>I know nothing about the rasdaemon build system but it seems like this needs
>a ifdef HAVE_CXL around it?
>
>[snip]

This file ras-cxl-handler.c included in the build only if configure with --enable-cxl. 
With --enable-cxl  build scripts define HAVE_CXL.

>
>> --- a/ras-record.c
>> +++ b/ras-record.c
>> @@ -559,6 +559,67 @@ int ras_store_mf_event(struct ras_events *ras,
>> struct ras_mf_event *ev)  }  #endif
>>
>> +#ifdef HAVE_CXL
>> +/*
>> + * Table and functions to handle cxl:cxl_poison  */ static const
>> +struct db_fields cxl_poison_event_fields[] = {
>> +	{ .name = "id",                   .type = "INTEGER PRIMARY KEY" },
>> +	{ .name = "timestamp",            .type = "TEXT" },
>> +	{ .name = "memdev",               .type = "TEXT" },
>> +	{ .name = "pcidev",               .type = "TEXT" },
>> +	{ .name = "region",               .type = "TEXT" },
>> +	{ .name = "region_uuid",          .type = "TEXT" },
>> +	{ .name = "hpa",                  .type = "INTEGER" },
>> +	{ .name = "dpa",                  .type = "INTEGER" },
>> +	{ .name = "length",               .type = "INTEGER" },
>> +	{ .name = "source",               .type = "TEXT" },
>> +	{ .name = "flags",                .type = "INTEGER" },
>> +	{ .name = "overflow_ts",          .type = "TEXT" },
>> +};
>> +
>> +static const struct db_table_descriptor cxl_poison_event_tab = {
>> +	.name = "cxl_poison_event",
>> +	.fields = cxl_poison_event_fields,
>> +	.num_fields = ARRAY_SIZE(cxl_poison_event_fields),
>> +};
>> +
>> +int ras_store_cxl_poison_event(struct ras_events *ras, struct
>> +ras_cxl_poison_event *ev)
>
>Because I believe this is not defined if (!HAVE_CXL and HAVE_SQLITE3)
>
>[snip]
>
>>
>>  #ifdef HAVE_SQLITE3
>>
>> @@ -155,6 +170,9 @@ struct sqlite3_priv {  #ifdef HAVE_MEMORY_FAILURE
>>  	sqlite3_stmt	*stmt_mf_event;
>>  #endif
>> +#ifdef HAVE_CXL
>> +	sqlite3_stmt	*stmt_cxl_poison_event;
>> +#endif
>>  };
>>
>>  struct db_fields {
>> @@ -182,6 +200,7 @@ int ras_store_arm_record(struct ras_events *ras,
>> struct ras_arm_event *ev);  int ras_store_devlink_event(struct
>> ras_events *ras, struct devlink_event *ev);  int
>> ras_store_diskerror_event(struct ras_events *ras, struct
>> diskerror_event *ev);  int ras_store_mf_event(struct ras_events *ras,
>> struct ras_mf_event *ev);
>> +int ras_store_cxl_poison_event(struct ras_events *ras, struct
>> +ras_cxl_poison_event *ev);
>>
>>  #else
>>  static inline int ras_mc_event_opendb(unsigned cpu, struct ras_events
>> *ras) { return 0; }; @@ -195,6 +214,7 @@ static inline int
>> ras_store_arm_record(struct ras_events *ras, struct ras_arm_ev  static
>> inline int ras_store_devlink_event(struct ras_events *ras, struct
>> devlink_event *ev) { return 0; };  static inline int
>> ras_store_diskerror_event(struct ras_events *ras, struct
>> diskerror_event *ev) { return 0; };  static inline int
>> ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev) {
>> return 0; };
>> +static inline int ras_store_cxl_poison_event(struct ras_events *ras,
>> +struct ras_cxl_poison_event *ev) { return 0; };
>
>But I could be missing something.
>
>Ira
>
>[snip]

Thanks,
Shiju
