Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA906779E6
	for <lists+linux-edac@lfdr.de>; Mon, 23 Jan 2023 12:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjAWLOL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Mon, 23 Jan 2023 06:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjAWLOK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 23 Jan 2023 06:14:10 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F49A256;
        Mon, 23 Jan 2023 03:14:08 -0800 (PST)
Received: from lhrpeml100001.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P0nSW3lsYz67L8m;
        Mon, 23 Jan 2023 19:10:03 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100001.china.huawei.com (7.191.160.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 23 Jan 2023 11:14:05 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2375.034;
 Mon, 23 Jan 2023 11:14:05 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [RFC PATCH 2/4] rasdaemon: Add support for the CXL poison events
Thread-Topic: [RFC PATCH 2/4] rasdaemon: Add support for the CXL poison events
Thread-Index: AQHZLCoOJbC9T/czmEWI0JFEpON+Rq6reT8AgABihDA=
Date:   Mon, 23 Jan 2023 11:14:05 +0000
Message-ID: <f0dc812ee02e4358b8c457cb2d558615@huawei.com>
References: <20230119171809.1406-1-shiju.jose@huawei.com>
 <20230119171809.1406-3-shiju.jose@huawei.com>
 <Y84WZp4K3mLzLkwh@aschofie-mobl2>
In-Reply-To: <Y84WZp4K3mLzLkwh@aschofie-mobl2>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.169.171]
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

Hi Alison,

Thanks for the feedback.

>-----Original Message-----
>From: Alison Schofield <alison.schofield@intel.com>
>Sent: 23 January 2023 05:09
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org;
>mchehab@kernel.org; Jonathan Cameron
><jonathan.cameron@huawei.com>; Linuxarm <linuxarm@huawei.com>
>Subject: Re: [RFC PATCH 2/4] rasdaemon: Add support for the CXL poison
>events
>
>On Thu, Jan 19, 2023 at 05:18:07PM +0000, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add support to log and record the CXL poison events.
>>
>> The corresponding Kernel patches here:
>> https://lore.kernel.org/lkml/cover.1668115235.git.alison.schofield@int
>> el.com/
>>
>> Presently RFC draft version for logging, could be extended for the
>> policy based recovery action for the frequent poison events depending
>> on the above kernel patches.
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  Makefile.am       |   8 ++-
>>  configure.ac      |  11 ++++
>>  ras-cxl-handler.c | 162
>> ++++++++++++++++++++++++++++++++++++++++++++++
>>  ras-cxl-handler.h |  24 +++++++
>>  ras-events.c      |  15 +++++
>>  ras-events.h      |   1 +
>>  ras-record.c      |  81 +++++++++++++++++++++++
>>  ras-record.h      |  20 ++++++
>>  ras-report.c      |  83 ++++++++++++++++++++++++
>>  ras-report.h      |   2 +
>>  10 files changed, 406 insertions(+), 1 deletion(-)  create mode
>> 100644 ras-cxl-handler.c  create mode 100644 ras-cxl-handler.h
>>
>> diff --git a/Makefile.am b/Makefile.am index a322b9a..4216370 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -69,13 +69,19 @@ endif
>>  if WITH_AMP_NS_DECODE
>>     rasdaemon_SOURCES += non-standard-ampere.c  endif
>> +
>> +if WITH_CXL
>> +   rasdaemon_SOURCES += ras-cxl-handler.c endif
>> +
>>  rasdaemon_LDADD = -lpthread $(SQLITE3_LIBS) libtrace/libtrace.a
>>
>>  include_HEADERS = config.h  ras-events.h  ras-logger.h  ras-mc-handler.h \
>>  		  ras-aer-handler.h ras-mce-handler.h ras-record.h bitfield.h
>ras-report.h \
>>  		  ras-extlog-handler.h ras-arm-handler.h ras-non-standard-
>handler.h \
>>  		  ras-devlink-handler.h ras-diskerror-handler.h rbtree.h ras-
>page-isolation.h \
>> -		  non-standard-hisilicon.h non-standard-ampere.h ras-
>memory-failure-handler.h
>> +		  non-standard-hisilicon.h non-standard-ampere.h ras-
>memory-failure-handler.h \
>> +		  ras-cxl-handler.h
>>
>>  # This rule can't be called with more than one Makefile job (like
>> make -j8)  # I can't figure out a way to fix that diff --git
>> a/configure.ac b/configure.ac index a77991f..c18a67d 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -161,6 +161,16 @@ AS_IF([test "x$enable_amp_ns_decode" = "xyes"
>||
>> test "x$enable_all" == "xyes"],
>AM_CONDITIONAL([WITH_AMP_NS_DECODE],
>> [test x$enable_amp_ns_decode = xyes || test x$enable_all == xyes])
>> AM_COND_IF([WITH_AMP_NS_DECODE], [USE_AMP_NS_DECODE="yes"],
>> [USE_AMP_NS_DECODE="no"])
>>
>> +AC_ARG_ENABLE([cxl],
>> +    AS_HELP_STRING([--enable-cxl], [enable CXL events (currently
>> +experimental)]))
>> +
>> +AS_IF([test "x$enable_cxl" = "xyes" || test "x$enable_all" ==
>> +"xyes"], [
>> +  AC_DEFINE(HAVE_CXL,1,"have CXL events collect")
>> +  AC_SUBST([WITH_CXL])
>> +])
>> +AM_CONDITIONAL([WITH_CXL], [test x$enable_cxl = xyes || test
>> +x$enable_all == xyes]) AM_COND_IF([WITH_CXL], [USE_CXL="yes"],
>> +[USE_CXL="no"])
>> +
>>  test "$sysconfdir" = '${prefix}/etc' && sysconfdir=/etc
>>
>>  CFLAGS="$CFLAGS -Wall -Wmissing-prototypes -Wstrict-prototypes"
>> @@ -201,4 +211,5 @@ compile time options summary
>>      Memory Failure      : $USE_MEMORY_FAILURE
>>      Memory CE PFA       : $USE_MEMORY_CE_PFA
>>      AMP RAS errors      : $USE_AMP_NS_DECODE
>> +    CXL events          : $USE_CXL
>>  EOF
>> diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c new file mode
>> 100644 index 0000000..11531ef
>> --- /dev/null
>> +++ b/ras-cxl-handler.c
>> @@ -0,0 +1,162 @@
>> +/*
>> + * Copyright (c) Huawei Technologies Co., Ltd. 2023. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> +modify
>> + * it under the terms of the GNU General Public License as published
>> +by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +#include "libtrace/kbuffer.h"
>> +#include "ras-cxl-handler.h"
>> +#include "ras-record.h"
>> +#include "ras-logger.h"
>> +#include "ras-report.h"
>> +
>> +/* Poison List: Payload out flags */
>> +#define CXL_POISON_FLAG_MORE            BIT(0)
>> +#define CXL_POISON_FLAG_OVERFLOW        BIT(1)
>> +#define CXL_POISON_FLAG_SCANNING        BIT(2)
>> +
>> +/* CXL poison - source types */
>> +enum cxl_poison_source {
>> +	CXL_POISON_SOURCE_UNKNOWN = 0,
>> +	CXL_POISON_SOURCE_EXTERNAL = 1,
>> +	CXL_POISON_SOURCE_INTERNAL = 2,
>> +	CXL_POISON_SOURCE_INJECTED = 3,
>> +	CXL_POISON_SOURCE_VENDOR = 7,
>> +};
>> +
>> +int ras_cxl_poison_event_handler(struct trace_seq *s,
>> +				 struct pevent_record *record,
>> +				 struct event_format *event, void *context) {
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
>> +	ev.memdev = pevent_get_field_raw(s, event, "memdev",
>> +					   record, &len, 1);
>> +	if (!ev.memdev)
>> +		return -1;
>> +	trace_seq_printf(s, "memdev:%s ", ev.memdev);
>> +
>> +	ev.pcidev = pevent_get_field_raw(s, event, "pcidev",
>> +					   record, &len, 1);
>> +	if (!ev.pcidev)
>> +		return -1;
>> +	trace_seq_printf(s, "pcidev:%s ", ev.pcidev);
>> +
>> +	ev.region = pevent_get_field_raw(s, event, "region",
>> +					   record, &len, 1);
>> +	if (!ev.region)
>> +		return -1;
>> +	trace_seq_printf(s, "region:%s ", ev.region);
>
>Hi Shiju,
>
>Does the above work OK when the region name is assigned a NULL string?
>That's what happens in the trace code (__assign_str(region, "");) when region
>is NULL.
>
I checked. It work ok with NULL string in the region name because pevent_get_field_raw()
returns the pointer to the data field.  
   
>Not sure if this is different since you last tested w posted poison set. Latest
>are here:
>
>https://lore.kernel.org/linux-
>cxl/de11785ff05844299b40b100f8e0f56c7eef7f08.1674070170.git.alison.schofie
>ld@intel.com/

I tested today with the v5 patch set, it worked ok.
 
>
>Alison
>
>> +
>> +	ev.uuid = pevent_get_field_raw(s, event, "uuid",
...
>>
>> --
>> 2.25.1
>>
Thanks,
Shiju
