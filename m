Return-Path: <linux-edac+bounces-3398-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BF1A6D865
	for <lists+linux-edac@lfdr.de>; Mon, 24 Mar 2025 11:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406EC169B99
	for <lists+linux-edac@lfdr.de>; Mon, 24 Mar 2025 10:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDB125DCE5;
	Mon, 24 Mar 2025 10:37:20 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488FA433A8;
	Mon, 24 Mar 2025 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742812640; cv=none; b=RCpgbL+1GHNczGTOOKaBwnzeBb6TVL9VIuMLIzPOw1nJFOVavva+x1cj01DCpHwnXYkhi549tkd1uIFpMp0Ysx7FEZhpKT5yyCw9ERp3vxMB4LktGHACmT9Z7ywJXFpHTqqVoIZTdWO1fTjYTpDqC2UuZORcPhEkgBMt/NmttTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742812640; c=relaxed/simple;
	bh=LnUAMeG9pWRqCjGh/oaX9QtJIz5JX5VGvxwU+xEdGF0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XW4FPhUkKj1qZ17ekzecHyiEah98RL/6eNKfB74lPxiQt5f72coIzH2tzrmTnS4eYPKkl1bxoI2uUpM26GpOJnxrkRF0+onEs1MfTmtV7ZyorRIMVqAdpY7kWcsGGGXg1LWWYKN/q4oi+2qHJWYhZ2DibwPBgxQPzq4ze6Uznyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZLqHK4jGKz6L540;
	Mon, 24 Mar 2025 18:37:01 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 94EAB14050C;
	Mon, 24 Mar 2025 18:37:08 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Mar 2025 11:37:08 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 24 Mar 2025 11:37:08 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "leo.duran@amd.com"
	<leo.duran@amd.com>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>, "erdemaktas@google.com"
	<erdemaktas@google.com>, "pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>, "gthelen@google.com"
	<gthelen@google.com>, "wschwartz@amperecomputing.com"
	<wschwartz@amperecomputing.com>, "dferguson@amperecomputing.com"
	<dferguson@amperecomputing.com>, "wbs@os.amperecomputing.com"
	<wbs@os.amperecomputing.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v2 2/8] EDAC: Update documentation for the CXL memory
 patrol scrub control feature
Thread-Topic: [PATCH v2 2/8] EDAC: Update documentation for the CXL memory
 patrol scrub control feature
Thread-Index: AQHbmcKs9aOZDT4yoEmIHT6+0TZ4QbN9TJeAgATOjJA=
Date: Mon, 24 Mar 2025 10:37:08 +0000
Message-ID: <f9fa8335c52444398e1736854c887fb7@huawei.com>
References: <20250320180450.539-1-shiju.jose@huawei.com>
	<20250320180450.539-3-shiju.jose@huawei.com>
 <20250321100305.000018d2@huawei.com>
In-Reply-To: <20250321100305.000018d2@huawei.com>
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
>From: Jonathan Cameron <jonathan.cameron@huawei.com>
>Sent: 21 March 2025 10:03
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-cxl@vger.kernel.org; dan.j.williams@intel.com; dave@stgolabs.net=
;
>dave.jiang@intel.com; alison.schofield@intel.com; vishal.l.verma@intel.com=
;
>ira.weiny@intel.com; david@redhat.com; Vilas.Sridharan@amd.com; linux-
>edac@vger.kernel.org; linux-acpi@vger.kernel.org; linux-mm@kvack.org; linu=
x-
>kernel@vger.kernel.org; bp@alien8.de; tony.luck@intel.com; rafael@kernel.o=
rg;
>lenb@kernel.org; mchehab@kernel.org; leo.duran@amd.com;
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
>Subject: Re: [PATCH v2 2/8] EDAC: Update documentation for the CXL memory
>patrol scrub control feature
>
>On Thu, 20 Mar 2025 18:04:39 +0000
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Update the Documentation/edac/scrub.rst to include descriptions and
>> policies for CXL memory device-based and CXL region-based patrol scrub
>> control.
>>
>> Note: This may require inputs from CXL memory experts regarding
>> region-based scrubbing policies.
>
>So I suggested the region interfaces in the first place.  It's all about u=
secases and
>'why' we might increase the scrub rate.
>Ultimately the hardware is controlled in a device wide way, so we could ha=
ve
>made it complex userspace problem to deal with it on a perf device.
>The region interfaces are there as a simplification not because they are s=
trictly
>necessary.
>
>Anyhow, the use cases:
>
>1) Scrubbing because a device is showing unexpectedly high errors.  That
>   control needs to be at device granularity.  If one device in an interle=
ave
>   set (backing a region) is dodgy, why make them all do more work?
>
>2) Scrubbing may apply to memory that isn't online at all yet.  Nice to kn=
ow
>   if we have a problem before we start using it!  Likely this is setting
>   system wide defaults on boot.
>
>3) Scrubbing at higher rate because software has decided that we want
>   more reliability for particular data.  I've been calling this
>   Differentiated Reliability.  That data sits in a region which
>   may cover part of multiple devices. The region interfaces are about
>   supporting this use case.
>
>So now the question is what do we do if both interfaces are poked because
>someone cares simultaneously about 1 and 3?
>
>I'd suggest just laying out a set for rules on how to set the scrub rates =
for any
>mixture of requirements, rather than making the driver work out the optimu=
m
>combination.
>
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  Documentation/edac/scrub.rst | 47
>> ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 47 insertions(+)
>>
>> diff --git a/Documentation/edac/scrub.rst
>> b/Documentation/edac/scrub.rst index daab929cdba1..d1c02bd90090 100644
>> --- a/Documentation/edac/scrub.rst
>> +++ b/Documentation/edac/scrub.rst
>> @@ -264,3 +264,51 @@ Sysfs files are documented in
>> `Documentation/ABI/testing/sysfs-edac-scrub`
>>
>>  `Documentation/ABI/testing/sysfs-edac-ecs`
>> +
>> +Examples
>> +--------
>> +
>> +The usage takes the form shown in these examples:
>> +
>> +1. CXL memory device patrol scrubber
>> +
>> +1.1 Device based scrubbing
>> +
>> +CXL memory is exposed to memory management subsystem and ultimately
>> +userspace via CXL devices.
>> +
>> +For cases where hardware interleave controls do not directly map to
>> +regions of Physical Address space, perhaps due to interleave the
>> +approach described in
>> +1.2 Region based scrubbing section, which is specific to CXL regions
>> +should be followed.
>
>These sentences end up a bit unwieldy. Perhaps simply a forwards reference=
.
>
>When combining control via the device interfaces and region interfaces see
>1.2 Region bases scrubbing.
>
>
>
>> In those cases settings on the presented interface may interact with
>> +direct control via a device instance specific interface and care must b=
e taken.
>> +
>> +Sysfs files for scrubbing are documented in
>> +`Documentation/ABI/testing/sysfs-edac-scrub`
>> +
>> +1.2. Region based scrubbing
>> +
>> +CXL memory is exposed to memory management subsystem and ultimately
>> +userspace via CXL regions. CXL Regions represent mapped memory
>> +capacity in system physical address space. These can incorporate one
>> +or more parts of multiple CXL memory devices with traffic interleaved
>> +across them. The user may want to control the scrub rate via this
>> +more abstract region instead of having to figure out the constituent
>> +devices and program them separately. The scrub rate for each device
>> +covers the whole device. Thus if multiple regions use parts of that
>> +device then requests for scrubbing of other regions may result in a hig=
her
>scrub rate than requested for this specific region.
>> +
>> +1. When user sets scrub rate for a memory region, the scrub rate for al=
l the
>CXL
>> +   memory devices interleaved under that region is updated with the sam=
e
>scrub
>> +   rate.
>
>Note that this may affect multiple regions.
>
>> +
>> +2. When user sets scrub rate for a memory device, only the scrub rate f=
or
>that
>> +   memory devices is updated though device may be part of a memory regi=
on
>and
>> +   does not change scrub rate of other memory devices of that memory
>region.
>> +
>> +3. Scrub rate of a CXL memory device may be set via EDAC device or regi=
on
>scrub
>> +   interface simultaneously. Care must be taken to prevent a race condi=
tion,
>or
>> +   only region-based setting may be allowed.
>
>So is this saying if you want to mix and match, set region first then devi=
ce next?
>Can we just lay out the rules to set up a weird mixture.  We could add mor=
e
>smarts to the driver but do we care as mixing 1 and 3 above is probably
>unusual?
>
>1. Taking each region in turn from lowest desired scrub rate to highest an=
d set
>   their scrub rates.  Later regions may override the scrub rate on indivi=
dual
>   devices (and hence potentially whole regions).
>
>2. Take each device for which enhanced scrubbing is required (higher rate)=
 and
>   set those scrub rates.  This will override the scrub rates of individua=
l devices
>   leaving any that are not specifically set to scrub at the maximum rate =
required
>   for any of the regions they are involved in backing.

Thanks. Will incorporate these info and rules in the next version.
>
>
>> +
>> +Sysfs files for scrubbing are documented in
>> +`Documentation/ABI/testing/sysfs-edac-scrub`

Shiju


