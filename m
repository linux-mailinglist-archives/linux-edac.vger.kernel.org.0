Return-Path: <linux-edac+bounces-2876-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 483E4A096DA
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 17:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0884D3AA9CB
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 16:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B743D212D75;
	Fri, 10 Jan 2025 16:11:35 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B592B212B25;
	Fri, 10 Jan 2025 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525495; cv=none; b=Mtuw2ofsNRetm9SCXCFN1h3qadZHBiY9XWK82/16E51QRRKVsJf+d23h57NsOPlMjyEYv7Cm+VQMbGneldIV127XXz92k/NAiknYyhE4j8PfU0ZP8107kRocrZBKrASF5wx5LZCi+w16u0NfhssiXsDlRdz0MQy7Zg+/Yi2YIkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525495; c=relaxed/simple;
	bh=61aXJkD15lbAy5elVXi+GkQLAZWB5hVQBqNShlc6UTg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JF83TCQCbE1vbChTGOjYAxRP+IciNvBB0Q/hqdS+9NklnOZ+EAMk33wrfFqKeyngSh4jJcV1UjOL00c6QIUfsIkSvsDuZaxyEr4nq9rZWg4y5iMkMtLGMLI2iRYMHS2tPYJw6kFbjH7o8SuHxFdQ4JIYEseNroblwj8k6a5xEmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV63Z2h0sz6JB3P;
	Sat, 11 Jan 2025 00:06:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CA314140CB1;
	Sat, 11 Jan 2025 00:11:31 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 10 Jan 2025 17:11:31 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 10 Jan 2025 17:11:31 +0100
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
Subject: RE: [PATCH v2 01/14] rasdaemon: Fix for parsing error when trace
 event's format file is larger than PAGE_SIZE
Thread-Topic: [PATCH v2 01/14] rasdaemon: Fix for parsing error when trace
 event's format file is larger than PAGE_SIZE
Thread-Index: AQHbY1rwGc5G1PO4ekmde8JfW+7B37MQGrEAgAASV2A=
Date: Fri, 10 Jan 2025 16:11:31 +0000
Message-ID: <617ab243f9444508bab2ce12218007fa@huawei.com>
References: <20250110122641.1668-1-shiju.jose@huawei.com>
	<20250110122641.1668-2-shiju.jose@huawei.com>
 <20250110160244.00006635@huawei.com>
In-Reply-To: <20250110160244.00006635@huawei.com>
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

Hi Jonathan,=20

Thanks for the review.

>-----Original Message-----
>From: Jonathan Cameron <jonathan.cameron@huawei.com>
>Sent: 10 January 2025 16:03
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org;
>mchehab@kernel.org; dave.jiang@intel.com; dan.j.williams@intel.com;
>alison.schofield@intel.com; nifan.cxl@gmail.com; vishal.l.verma@intel.com;
>ira.weiny@intel.com; dave@stgolabs.net; linux-kernel@vger.kernel.org;
>Linuxarm <linuxarm@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>
>Subject: Re: [PATCH v2 01/14] rasdaemon: Fix for parsing error when trace
>event's format file is larger than PAGE_SIZE
>
>On Fri, 10 Jan 2025 12:26:27 +0000
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> When a trace event's format file is larger than PAGE_SIZE (4096) then
>> libtraceevent returns parsing failed when rasdaemon reads the fields.
>> The reason found that tep_parse_event() call in the
>> add_event_handler() internally fails in libtraceevent because of the
>> incomplete format file data read. However libtraceevent did not return
>> error in this stage, which is fixed in the following patch for libtracee=
vent.
>> https://lore.kernel.org/all/20250109102338.6128644d@gandalf.local.home
>> /
>>
>> When rasdaemon reads a trace event format file,the maximum data size
>
>space after that comma if spinning a v3.
Sure.
If no v3, then I will fix when the pull request is submitted.

Thanks,
Shiju
>
>> that can be read is limited to PAGE_SIZE by the seq_read() and
>> seq_read_iter() functions in the kernel. This results in userspace
>> receiving partial data if the format file is larger than PAGE_SIZE,
>> requiring fix in the rasdaemon to read the complete data from the
>> format file.
>>
>> Add fix for reading trace event format files larger than PAGE_SIZE in
>> add_event_handler().
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>> ---
>>  ras-events.c | 21 +++++++++++++--------
>>  1 file changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/ras-events.c b/ras-events.c index 5d8118a..6692a31 100644
>> --- a/ras-events.c
>> +++ b/ras-events.c
>> @@ -376,7 +376,7 @@ static int filter_ras_mc_event(struct ras_events
>> *ras, char *group, char *event,
>>
>>  static int get_pagesize(struct ras_events *ras, struct tep_handle
>> *pevent)  {
>> -	int fd, len, page_size =3D 4096;
>> +	int fd, len, page_size =3D 8192;
>>  	char buf[page_size];
>>
>>  	fd =3D open_trace(ras, "events/header_page", O_RDONLY); @@ -827,7
>> +827,8 @@ static int add_event_handler(struct ras_events *ras, struct
>tep_handle *pevent,
>>  			     unsigned int page_size, char *group, char *event,
>>  			     tep_event_handler_func func, char *filter_str, int id)
>{
>> -	int fd, size, rc;
>> +	int fd, rc;
>> +	int size =3D 0;
>>  	char *page, fname[MAX_PATH + 1];
>>  	struct tep_event_filter *filter =3D NULL;
>>
>> @@ -857,13 +858,17 @@ static int add_event_handler(struct ras_events *ra=
s,
>struct tep_handle *pevent,
>>  		return rc;
>>  	}
>>
>> -	size =3D read(fd, page, page_size);
>> +	do {
>> +		rc =3D read(fd, page + size, page_size);
>> +		if (rc < 0) {
>> +			log(TERM, LOG_ERR, "Can't get arch page size\n");
>> +			free(page);
>> +			close(fd);
>> +			return size;
>> +		}
>> +		size +=3D rc;
>> +	} while (rc > 0);
>>  	close(fd);
>> -	if (size < 0) {
>> -		log(TERM, LOG_ERR, "Can't get arch page size\n");
>> -		free(page);
>> -		return size;
>> -	}
>>
>>  	/* Registers the special event handlers */
>>  	rc =3D tep_register_event_handler(pevent, -1, group, event, func,
>> ras);


