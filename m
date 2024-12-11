Return-Path: <linux-edac+bounces-2691-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 437329ED433
	for <lists+linux-edac@lfdr.de>; Wed, 11 Dec 2024 18:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6839B161CFF
	for <lists+linux-edac@lfdr.de>; Wed, 11 Dec 2024 17:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650BF200B9C;
	Wed, 11 Dec 2024 17:58:45 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3761D6DA4;
	Wed, 11 Dec 2024 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939925; cv=none; b=RD2jG5B+OeoeyBcIA0j6oDxAdzH4Q0kuiGeZlbLtXwDd/id06pCmv/vpGaMETvTjW6amVaUU0XCfeUmHbre8y/2z8Yv4dBOcX8fGAAaSz4OqhdbC3G+rdE3ULB/xgufBhs7wPHATUiSxAaYTRrmtUEfLhCoPOI4HEZVjVtdkc0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939925; c=relaxed/simple;
	bh=cGUL1g5soNzNs/G21jrfWDbCv/UQ7rxtUG3ID63/8RI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b/imKcGwB2szwSeHSDiGkEUJTkjnk6Zm1p9ZZPtsUkWjfT1rWQ7M3JqHTm9W7gtNj8F4T7QEQpL8bnNb44hGX+cEAN2mX+PZFJuSJNmcdpkOJ8UdblS1GVS62DjTQEn0IbKcd8D+H56qNlpjRuMIuMTZB76snNmno9BtB7yV+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y7jtd4XGNz6D8bR;
	Thu, 12 Dec 2024 01:55:21 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 87E06140442;
	Thu, 12 Dec 2024 01:58:38 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 18:58:38 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 11 Dec 2024 18:58:38 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Shiju Jose <shiju.jose@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "dave@stgolabs.net" <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v17 05/18] cxl: Add Get Supported Features command for
 kernel usage
Thread-Topic: [PATCH v17 05/18] cxl: Add Get Supported Features command for
 kernel usage
Thread-Index: AQHbPQkFb4DhmQwolUmt5xqDd6N+ZLLZxDuAgAQrVZCAA3+90A==
Date: Wed, 11 Dec 2024 17:58:37 +0000
Message-ID: <6e9c128e888c4cacb04b5dd53b1d1b79@huawei.com>
References: <20241122180416.1932-1-shiju.jose@huawei.com>
	<20241122180416.1932-6-shiju.jose@huawei.com>
	<67536f6987656_10a08329480@dwillia2-xfh.jf.intel.com.notmuch>
 <e72011454204462eb8ccf10eef56106c@huawei.com>
In-Reply-To: <e72011454204462eb8ccf10eef56106c@huawei.com>
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
>From: Shiju Jose <shiju.jose@huawei.com>
>Sent: 09 December 2024 14:28
>To: Dan Williams <dan.j.williams@intel.com>; linux-edac@vger.kernel.org;
>linux-cxl@vger.kernel.org; linux-acpi@vger.kernel.org; linux-mm@kvack.org;
>linux-kernel@vger.kernel.org
>Cc: bp@alien8.de; tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
>mchehab@kernel.org; dave@stgolabs.net; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
>Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
>Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
>naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
>somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
>duenwen@google.com; gthelen@google.com;
>wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Roberto
>Sassu <roberto.sassu@huawei.com>; kangkang.shen@futurewei.com;
>wanghuiqiang <wanghuiqiang@huawei.com>; Linuxarm
><linuxarm@huawei.com>
>Subject: RE: [PATCH v17 05/18] cxl: Add Get Supported Features command for
>kernel usage
>
>>-----Original Message-----
>>From: Dan Williams <dan.j.williams@intel.com>
>>Sent: 06 December 2024 21:41
>>To: Shiju Jose <shiju.jose@huawei.com>; linux-edac@vger.kernel.org;
>>linux- cxl@vger.kernel.org; linux-acpi@vger.kernel.org;
>>linux-mm@kvack.org; linux- kernel@vger.kernel.org
>>Cc: bp@alien8.de; tony.luck@intel.com; rafael@kernel.org;
>>lenb@kernel.org; mchehab@kernel.org; dan.j.williams@intel.com;
>>dave@stgolabs.net; Jonathan Cameron <jonathan.cameron@huawei.com>;
>>dave.jiang@intel.com; alison.schofield@intel.com;
>>vishal.l.verma@intel.com; ira.weiny@intel.com; david@redhat.com;
>>Vilas.Sridharan@amd.com; leo.duran@amd.com; Yazen.Ghannam@amd.com;
>>rientjes@google.com; jiaqiyan@google.com; Jon.Grimm@amd.com;
>>dave.hansen@linux.intel.com; naoya.horiguchi@nec.com;
>>james.morse@arm.com; jthoughton@google.com;
>somasundaram.a@hpe.com;
>>erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
>>gthelen@google.com; wschwartz@amperecomputing.com;
>>dferguson@amperecomputing.com; wbs@os.amperecomputing.com;
>>nifan.cxl@gmail.com; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
>><prime.zeng@hisilicon.com>; Roberto Sassu <roberto.sassu@huawei.com>;
>>kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
>>Linuxarm <linuxarm@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
>>Subject: Re: [PATCH v17 05/18] cxl: Add Get Supported Features command
>>for kernel usage
>>
>>shiju.jose@ wrote:
>>> From: Dave Jiang <dave.jiang@intel.com>
>>>
>>> CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h) The
>>> command retrieve the list of supported device-specific features
>>> (identified by UUID) and general information about each Feature.
>>>
>>> The driver will retrieve the feature entries in order to make checks
>>> and provide information for the Get Feature and Set Feature command.
>>> One of the main piece of information retrieved are the effects a Set
>>> Feature command would have for a particular feature.
>>>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>> Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
>>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>>> ---
>>>  drivers/cxl/core/mbox.c      | 179 +++++++++++++++++++++++++++++++++++
>>>  drivers/cxl/cxlmem.h         |  44 +++++++++
>>>  drivers/cxl/pci.c            |   4 +
>>>  include/cxl/mailbox.h        |   4 +
>>>  include/uapi/linux/cxl_mem.h |   1 +
>>>  5 files changed, 232 insertions(+)
>>
>>Hi Shiju,
>>
>>So I commented yesterday on this patch that is also duplicated in
>>Dave's series have a merge order ordering plan to propose.
>
>Hi Dan,
>
>Thanks for the suggestions.
>I tested your suggestions for CXL features commands in the fwctl series, i=
n the
>EDAC CXL features setup, as replied.

Please find updated patches for your suggestions are shared here.
https://github.com/shijujose4/linux/tree/edac-enhancement-ras-features_for_=
v18

However next version (v18) of EDAC series will send after receiving feedbac=
ks from Borislav=20
on v17 EDAC patches.

>>
>>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c index
[...]
>

Thanks,
Shiju

