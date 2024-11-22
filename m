Return-Path: <linux-edac+bounces-2604-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BF39D5D3E
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 11:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1427F2826F0
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 10:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669721AB535;
	Fri, 22 Nov 2024 10:26:56 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615F171088;
	Fri, 22 Nov 2024 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732271216; cv=none; b=DjIjc0yd5SPNPX/YPHzXU+Ps207oc/dOw52RvCwbx20dBL9EjEdAp/anM3306T5q3LMIJLPwrOeuaEYOWZrgjTp4oOT8cuclNIXD98yhC2350mC0QjOuO7HjMWmQtqtHCjrOrSAMqMY+Ew1ocKARzUk7h0zuaiysWW/XGSJXIuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732271216; c=relaxed/simple;
	bh=jFgAjBjU7UFg631kYUMZP6dUopIjZKRfvoR7MtptAjI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qJl2pj4f0FrwJo1UCX09pxFr2AkON/y7QpoGr5Jdj2VTkXXhM566zzU28Vrmeep7ippcts9YyxoQKlS/xrUn/KWbHDp7aOh5R6zPWo+4wolTt3EqWi8d6ZH3C8CSOJlgkqHI8uOdiIm4q79LMGf6JtUjo7d6vbvRWsxpnaI9z68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvrqH0T8Rz6L6vr;
	Fri, 22 Nov 2024 18:26:19 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D5AA140134;
	Fri, 22 Nov 2024 18:26:44 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 11:26:44 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 22 Nov 2024 11:26:44 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [PATCH 02/13] rasdaemon: cxl: Fix mismatch in region field's name
 with kernel DRAM trace event
Thread-Topic: [PATCH 02/13] rasdaemon: cxl: Fix mismatch in region field's
 name with kernel DRAM trace event
Thread-Index: AQHbOzMC+3A32YvgUkyL0sZEY/3KELLByImAgAFS0vA=
Date: Fri, 22 Nov 2024 10:26:43 +0000
Message-ID: <cc9a33dec49f40849a02a7ee6fb685b6@huawei.com>
References: <20241120095923.1891-1-shiju.jose@huawei.com>
	<20241120095923.1891-3-shiju.jose@huawei.com>
 <20241121151259.00006803@huawei.com>
In-Reply-To: <20241121151259.00006803@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jonathan,

Thanks for reviewing.=20
>-----Original Message-----
>From: Jonathan Cameron <jonathan.cameron@huawei.com>
>Sent: 21 November 2024 15:13
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org;
>mchehab@kernel.org; dave.jiang@intel.com; dan.j.williams@intel.com;
>alison.schofield@intel.com; nifan.cxl@gmail.com; vishal.l.verma@intel.com;
>ira.weiny@intel.com; dave@stgolabs.net; linux-kernel@vger.kernel.org;
>Linuxarm <linuxarm@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>
>Subject: Re: [PATCH 02/13] rasdaemon: cxl: Fix mismatch in region field's =
name
>with kernel DRAM trace event
>
>On Wed, 20 Nov 2024 09:59:12 +0000
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Fix mismatch in 'region' field's name with kernel DRAM trace event.
>>
>> Fixes: ea224ad58b37 ("rasdaemon: CXL: Extract, log and record region
>> info from cxl_general_media and cxl_dram events")
>>
>No line break here (though this is rasdaemon so maybe kernel rules don't
>apply?)
Will fix.

>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>> ---
>>  ras-cxl-handler.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c index
>> 8733b2b..7d4fc9f 100644
>> --- a/ras-cxl-handler.c
>> +++ b/ras-cxl-handler.c
>> @@ -966,7 +966,7 @@ int ras_cxl_dram_event_handler(struct trace_seq *s,
>>  	if (trace_seq_printf(s, "hpa:0x%llx ", (unsigned long long)ev.hpa) <=
=3D 0)
>>  		return -1;
>>
>> -	ev.region =3D tep_get_field_raw(s, event, "region", record, &len, 1);
>> +	ev.region =3D tep_get_field_raw(s, event, "region_name", record, &len,
>> +1);
>>  	if (!ev.region)
>>  		return -1;
>>  	if (trace_seq_printf(s, "region:%s ", ev.region) <=3D 0)
Thanks,
Shiju

