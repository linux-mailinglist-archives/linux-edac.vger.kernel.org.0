Return-Path: <linux-edac+bounces-4516-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBB8B1B89D
	for <lists+linux-edac@lfdr.de>; Tue,  5 Aug 2025 18:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C467189EA7D
	for <lists+linux-edac@lfdr.de>; Tue,  5 Aug 2025 16:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74999275B0D;
	Tue,  5 Aug 2025 16:37:09 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B60417A2FC;
	Tue,  5 Aug 2025 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754411829; cv=none; b=YDDIvMxRA0jmUwnyh96Bwm18N4i9HzsR5ac90aBzeXswaiWk+FHr8z9G47iynhA8s6B6+qgf1NpKSihPtPuPuN06OVBZXxutrYovW4MXIJD5jxm2lDiHDHKLI50Gwt6HJmalWC6RBzj6CxBPfjtRzB0c8iaYUWTPIOZmB8noXno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754411829; c=relaxed/simple;
	bh=F29hzBNcyeahwC4S4pGvw5mdFA7828PNr5zkWmSZ3MI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GbMZYnEmYuRpTltM1e3UBDMIhnvNfqYT4HYtpaOOJsurgAm/HzkVQfMbMSj/V6ciywv+2vvfSIVYBwTyu6imicxKTizLUIaO5ZxxnknXZBKXw/+5ACGZ9cf8FO9Lojhv9RFY6DnCLpn5trdDfIypKUhGPfMyXwzQDEjTqa97fok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bxJtk1pj9z6D9f2;
	Wed,  6 Aug 2025 00:35:10 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 13D861402FE;
	Wed,  6 Aug 2025 00:36:56 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 5 Aug 2025 18:36:55 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 5 Aug 2025 18:36:55 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Mike Rapoport <rppt@kernel.org>
CC: "rafael@kernel.org" <rafael@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Linuxarm <linuxarm@huawei.com>, "rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [PATCH v10 1/3] mm: Add node_to_range lookup facility to
 numa_memblks
Thread-Topic: [PATCH v10 1/3] mm: Add node_to_range lookup facility to
 numa_memblks
Thread-Index: AQHcAwip/H6S43K2aESNS7qE2UciQ7RTvVYAgACIBKA=
Date: Tue, 5 Aug 2025 16:36:55 +0000
Message-ID: <bdbb50d7309741b8b282c2e8a1fc72ae@huawei.com>
References: <20250801172040.2175-1-shiju.jose@huawei.com>
 <20250801172040.2175-2-shiju.jose@huawei.com> <aJHawm1zE62x1YH9@kernel.org>
In-Reply-To: <aJHawm1zE62x1YH9@kernel.org>
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

>-----Original Message-----
>From: Mike Rapoport <rppt@kernel.org>
>Sent: 05 August 2025 11:20
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: rafael@kernel.org; bp@alien8.de; akpm@linux-foundation.org;
>dferguson@amperecomputing.com; linux-edac@vger.kernel.org; linux-
>acpi@vger.kernel.org; linux-mm@kvack.org; linux-doc@vger.kernel.org;
>tony.luck@intel.com; lenb@kernel.org; leo.duran@amd.com;
>Yazen.Ghannam@amd.com; mchehab@kernel.org; Jonathan Cameron
><jonathan.cameron@huawei.com>; Linuxarm <linuxarm@huawei.com>;
>rientjes@google.com; jiaqiyan@google.com; Jon.Grimm@amd.com;
>dave.hansen@linux.intel.com; naoya.horiguchi@nec.com;
>james.morse@arm.com; jthoughton@google.com; somasundaram.a@hpe.com;
>erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
>gthelen@google.com; wschwartz@amperecomputing.com;
>wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Roberto
>Sassu <roberto.sassu@huawei.com>; kangkang.shen@futurewei.com;
>wanghuiqiang <wanghuiqiang@huawei.com>
>Subject: Re: [PATCH v10 1/3] mm: Add node_to_range lookup facility to
>numa_memblks
>
>On Fri, Aug 01, 2025 at 06:20:27PM +0100, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Lookup facility to retrieve memory phys lowest continuous range for a
>> NUMA node is required in the numa_memblks for the ACPI RAS2 memory
>> scrub use case.
>
>If the code that needs to find the lowest contiguous range in a node runs =
before
>we discard .init you can just use
>
>	unsigned long pfn =3D node_start_pfn(nid);
>	unsigned long start_pfn, end_pfn;
>
>	memblock_search_pfn_nid(pfn, &start_pfn, &end_pfn);

Thanks Mike for your suggestion and help.
=20
With node_start_pfn(nid) and memblock_search_pfn_nid(), the 'end_pfn' retur=
n=20
different value than the actual.

Found similar function get_pfn_range_for_nid(nid, &start_pfn, &end_pfn), se=
ems more
suitable as it takes 'nid' directly and both 'start_pfn' and 'end_pfn 'retu=
rn correct values.=20

Thanks,
Shiju

>
>> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  include/linux/numa.h         | 10 ++++++++++
>>  include/linux/numa_memblks.h |  2 ++
>>  mm/numa.c                    | 10 ++++++++++
>>  mm/numa_memblks.c            | 23 +++++++++++++++++++++++
>>  4 files changed, 45 insertions(+)
>>
>> diff --git a/include/linux/numa.h b/include/linux/numa.h index
>> e6baaf6051bc..d41e583a902d 100644
>> --- a/include/linux/numa.h
>> +++ b/include/linux/numa.h
>> @@ -41,6 +41,10 @@ int memory_add_physaddr_to_nid(u64 start);  int
>> phys_to_target_node(u64 start);  #endif
>>
>> +#ifndef node_to_phys_lowest_continuous_range
>> +int node_to_phys_lowest_continuous_range(int nid, u64 *start, u64
>> +*end); #endif
>> +
>>  int numa_fill_memblks(u64 start, u64 end);
>>
>>  #else /* !CONFIG_NUMA */
>> @@ -63,6 +67,12 @@ static inline int phys_to_target_node(u64 start)
>>  	return 0;
>>  }
>>
>> +static inline int node_to_phys_lowest_continuous_range(int nid, u64 *st=
art,
>> +						       u64 *end)
>> +{
>> +	return 0;
>> +}
>> +
>>  static inline void alloc_offline_node_data(int nid) {}  #endif
>>
>> diff --git a/include/linux/numa_memblks.h
>> b/include/linux/numa_memblks.h index 991076cba7c5..ccc53029de8b 100644
>> --- a/include/linux/numa_memblks.h
>> +++ b/include/linux/numa_memblks.h
>> @@ -55,6 +55,8 @@ extern int phys_to_target_node(u64 start);  #define
>> phys_to_target_node phys_to_target_node  extern int
>> memory_add_physaddr_to_nid(u64 start);  #define
>> memory_add_physaddr_to_nid memory_add_physaddr_to_nid
>> +extern int node_to_phys_lowest_continuous_range(int nid, u64 *start,
>> +u64 *end); #define node_to_phys_lowest_continuous_range
>> +node_to_phys_lowest_continuous_range
>>  #endif /* CONFIG_NUMA_KEEP_MEMINFO */
>>
>>  #endif /* CONFIG_NUMA_MEMBLKS */
>> diff --git a/mm/numa.c b/mm/numa.c
>> index 7d5e06fe5bd4..0affb56ef4f2 100644
>> --- a/mm/numa.c
>> +++ b/mm/numa.c
>> @@ -59,3 +59,13 @@ int phys_to_target_node(u64 start)  }
>> EXPORT_SYMBOL_GPL(phys_to_target_node);
>>  #endif
>> +
>> +#ifndef node_to_phys_lowest_continuous_range
>> +int node_to_phys_lowest_continuous_range(int nid, u64 *start, u64
>> +*end) {
>> +	pr_info_once("Unknown target phys addr range for node=3D%d\n", nid);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(node_to_phys_lowest_continuous_range);
>> +#endif
>> diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c index
>> 541a99c4071a..9cbaa38cb92d 100644
>> --- a/mm/numa_memblks.c
>> +++ b/mm/numa_memblks.c
>> @@ -590,4 +590,27 @@ int memory_add_physaddr_to_nid(u64 start)  }
>> EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
>>
>> +static int nid_to_meminfo(struct numa_meminfo *mi, int nid, u64
>> +*start, u64 *end) {
>> +	int i;
>> +
>> +	if (!numa_valid_node(nid))
>> +		return -EINVAL;
>> +
>> +	for (i =3D 0; i < mi->nr_blks; i++) {
>> +		if (mi->blk[i].nid =3D=3D nid) {
>> +			*start =3D mi->blk[i].start;
>> +			*end =3D mi->blk[i].end;
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return -ENODEV;
>> +}
>> +
>> +int node_to_phys_lowest_continuous_range(int nid, u64 *start, u64
>> +*end) {
>> +	return nid_to_meminfo(&numa_meminfo, nid, start, end); }
>> +EXPORT_SYMBOL_GPL(node_to_phys_lowest_continuous_range);
>>  #endif /* CONFIG_NUMA_KEEP_MEMINFO */
>> --
>> 2.43.0
>>
>
>--
>Sincerely yours,
>Mike.


