Return-Path: <linux-edac+bounces-2677-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218CE9E98DA
	for <lists+linux-edac@lfdr.de>; Mon,  9 Dec 2024 15:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C309B18882DE
	for <lists+linux-edac@lfdr.de>; Mon,  9 Dec 2024 14:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255451E9B2E;
	Mon,  9 Dec 2024 14:28:23 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FA21B042A;
	Mon,  9 Dec 2024 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754503; cv=none; b=VXyBcIq3ItRD9avgdUYJd1emwPOGurp8+jIZRP64dsd/xfvEp96rQ3R3siyvvm5+POQJe/TS9biBzPRGIfFeeCelNvd5L23Z79qF5ijbA8NMVgC2I9ba9Wn9+rmNNG0qBNm1Ub0ZCa1+BANmZqHi+6dPm6r1kxxPAd3zh0tAUfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754503; c=relaxed/simple;
	bh=cJxXhlIIJ0DTJ1Yc/e3CZ2CGOJB3TvumN3JmbMWYa8A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qI5nNsDZnIAOGjtgwxKRblZRgCC5bUtSwxVpqrd3tM/pwvEn1+rb8UZGGjHH3oUkQePUch3lbqW+iiPxC70sJKfxxxElWv898TQhAi4EGVPdcOYT/nph5g6mNNuDKejoPOZcULXNsizmtPjeDf2dXV4SF2HhN31kO8NRupSw5ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y6PHP3XSbz6GCM3;
	Mon,  9 Dec 2024 22:23:45 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id A8C831400DD;
	Mon,  9 Dec 2024 22:28:16 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 15:28:16 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 9 Dec 2024 15:28:16 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, "linux-edac@vger.kernel.org"
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
Thread-Index: AQHbPQkFb4DhmQwolUmt5xqDd6N+ZLLZxDuAgAQrVZA=
Date: Mon, 9 Dec 2024 14:28:16 +0000
Message-ID: <e72011454204462eb8ccf10eef56106c@huawei.com>
References: <20241122180416.1932-1-shiju.jose@huawei.com>
 <20241122180416.1932-6-shiju.jose@huawei.com>
 <67536f6987656_10a08329480@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <67536f6987656_10a08329480@dwillia2-xfh.jf.intel.com.notmuch>
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
>From: Dan Williams <dan.j.williams@intel.com>
>Sent: 06 December 2024 21:41
>To: Shiju Jose <shiju.jose@huawei.com>; linux-edac@vger.kernel.org; linux-
>cxl@vger.kernel.org; linux-acpi@vger.kernel.org; linux-mm@kvack.org; linux=
-
>kernel@vger.kernel.org
>Cc: bp@alien8.de; tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
>mchehab@kernel.org; dan.j.williams@intel.com; dave@stgolabs.net; Jonathan
>Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
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
><linuxarm@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
>Subject: Re: [PATCH v17 05/18] cxl: Add Get Supported Features command for
>kernel usage
>
>shiju.jose@ wrote:
>> From: Dave Jiang <dave.jiang@intel.com>
>>
>> CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h) The
>> command retrieve the list of supported device-specific features
>> (identified by UUID) and general information about each Feature.
>>
>> The driver will retrieve the feature entries in order to make checks
>> and provide information for the Get Feature and Set Feature command.
>> One of the main piece of information retrieved are the effects a Set
>> Feature command would have for a particular feature.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  drivers/cxl/core/mbox.c      | 179 +++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxlmem.h         |  44 +++++++++
>>  drivers/cxl/pci.c            |   4 +
>>  include/cxl/mailbox.h        |   4 +
>>  include/uapi/linux/cxl_mem.h |   1 +
>>  5 files changed, 232 insertions(+)
>
>Hi Shiju,
>
>So I commented yesterday on this patch that is also duplicated in Dave's s=
eries
>have a merge order ordering plan to propose.

Hi Dan,

Thanks for the suggestions.
I tested your suggestions for CXL features commands in the fwctl series, in=
 the EDAC CXL features setup,
as replied.=20
>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c index
>> 880ac1dba3cc..c5d4c7df2f99 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -67,6 +67,7 @@ static struct cxl_mem_command
>cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] =3D {
>>  	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
>>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>>  	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
>> +	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD,
>0),
>
>As I mention on the CXL FWCTL alias of this path, for kernel-internal only=
 usage
>by definition that means a CXL command id does not need to be defined.
I tried removing  these definitions for  get_supported_features, get_featur=
e and set_feature
from cxl_mem_command[] and build and worked fine for the EDAC CXL features.

For cxl_get_supported_features() to work , I removed following check.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
int cxl_get_supported_features(struct cxl_dev_state *cxlds) {
	int remain_feats, max_size, max_feats, start, rc;
[...]

	/* Get supported features is optional, need to check */
	cmd =3D cxl_mem_find_command(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
	if (!cmd)
		return -EOPNOTSUPP;
	if (!test_bit(cmd->info.id, cxl_mbox->enabled_cmds))
		return -EOPNOTSUPP;
[...]
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=20
>
>Setting that aside, the place where CXL EDAC and CXL FWCTL series can unif=
y is
>on the definition of the cxl_{get,set}_features() helpers proposed in this=
 series
>for kernel-internal submission of CXL FEATURES commands. I think Dave's se=
ries
>should ingest cxl_{get,set}_features(), go in first since it does not have=
 cross-
>subsystem entanglements, and then you can build reuse that infrastructure =
to
>finalize the CXL scrub implementation.
Agree. I will reuse merged features infrastructure for the EDAC CXL feature=
s.

>
>The missing piece in my mind to make cxl_{get,set}_features() usable with =
the
>CXL FWCTL path is likely to make it be able to support copying in / out of=
 __user
>buffers. To me that looks like updating
>cxl_internal_send_cmd() to use copy_{to,from}_sockptr() internally so that=
 it is
>independent of the kernel vs user buffer concern from CXL EDAC vs CXL FWCT=
L
>callers.
Ok.

Thanks,
Shiju

