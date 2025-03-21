Return-Path: <linux-edac+bounces-3395-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3838A6B86E
	for <lists+linux-edac@lfdr.de>; Fri, 21 Mar 2025 11:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1769B3B97D8
	for <lists+linux-edac@lfdr.de>; Fri, 21 Mar 2025 10:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E61A1F2377;
	Fri, 21 Mar 2025 10:03:15 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179DB41C72;
	Fri, 21 Mar 2025 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742551395; cv=none; b=WTWgMYH+gcpIlxUoduSEPC0CcpDWXfIOPEI9Jj6des2bpSeh2EQPPQUl/xRHdScSj925C08Pl6pKT9jyoVQ1xZpjo+WQyV/t5dfySrxqpM2br9r101sKAvsgKDxECxtbIALy+psKxMD+lJVLgii9X6S/UIRBw1EOl6Jcfp9wwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742551395; c=relaxed/simple;
	bh=mr6l2LLuKAGbHkCuYwjPvSvm/d7AOLglFWNvz7o9a+c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtnDZAeD3gsSZ0qW/kCt/vwgTZpr4iOiBmcLKQeXKzzH8EmokKukHjyd75rHlaOUUkkkoffWXTn9I3wGInObXGfzlRa65mrcEu1Twna/0VDShjoVhmUlt4+MEOlg7xgweuKYSddgOZ2lVTw7Qy9Q1Mw7fGY9mh5KkkguAuDwJNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZJyc82vtFz6K9V7;
	Fri, 21 Mar 2025 18:00:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CC66A140146;
	Fri, 21 Mar 2025 18:03:08 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Mar
 2025 11:03:07 +0100
Date: Fri, 21 Mar 2025 10:03:05 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <david@redhat.com>,
	<Vilas.Sridharan@amd.com>, <linux-edac@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 2/8] EDAC: Update documentation for the CXL memory
 patrol scrub control feature
Message-ID: <20250321100305.000018d2@huawei.com>
In-Reply-To: <20250320180450.539-3-shiju.jose@huawei.com>
References: <20250320180450.539-1-shiju.jose@huawei.com>
	<20250320180450.539-3-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 20 Mar 2025 18:04:39 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
>=20
> Update the Documentation/edac/scrub.rst to include descriptions and
> policies for CXL memory device-based and CXL region-based patrol scrub
> control.
>=20
> Note: This may require inputs from CXL memory experts regarding
> region-based scrubbing policies.

So I suggested the region interfaces in the first place.  It's all about
usecases and 'why' we might increase the scrub rate.
Ultimately the hardware is controlled in a device wide way, so we could
have made it complex userspace problem to deal with it on a perf device.
The region interfaces are there as a simplification not because they
are strictly necessary.

Anyhow, the use cases:

1) Scrubbing because a device is showing unexpectedly high errors.  That
   control needs to be at device granularity.  If one device in an interlea=
ve
   set (backing a region) is dodgy, why make them all do more work?

2) Scrubbing may apply to memory that isn't online at all yet.  Nice to know
   if we have a problem before we start using it!  Likely this is setting
   system wide defaults on boot.

3) Scrubbing at higher rate because software has decided that we want
   more reliability for particular data.  I've been calling this
   Differentiated Reliability.  That data sits in a region which
   may cover part of multiple devices. The region interfaces are about
   supporting this use case.

So now the question is what do we do if both interfaces are poked
because someone cares simultaneously about 1 and 3?

I'd suggest just laying out a set for rules on how to set the scrub rates
for any mixture of requirements, rather than making the driver work out
the optimum combination.
=20
>=20
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  Documentation/edac/scrub.rst | 47 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>=20
> diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
> index daab929cdba1..d1c02bd90090 100644
> --- a/Documentation/edac/scrub.rst
> +++ b/Documentation/edac/scrub.rst
> @@ -264,3 +264,51 @@ Sysfs files are documented in
>  `Documentation/ABI/testing/sysfs-edac-scrub`
> =20
>  `Documentation/ABI/testing/sysfs-edac-ecs`
> +
> +Examples
> +--------
> +
> +The usage takes the form shown in these examples:
> +
> +1. CXL memory device patrol scrubber
> +
> +1.1 Device based scrubbing
> +
> +CXL memory is exposed to memory management subsystem and ultimately user=
space
> +via CXL devices.
> +
> +For cases where hardware interleave controls do not directly map to regi=
ons of
> +Physical Address space, perhaps due to interleave the approach described=
 in=A0
> +1.2 Region based scrubbing section, which is specific to CXL regions sho=
uld be
> +followed.

These sentences end up a bit unwieldy. Perhaps simply a forwards reference.

When combining control via the device interfaces and region interfaces see
1.2 Region bases scrubbing.


=20
> In those cases settings on the presented interface may interact with
> +direct control via a device instance specific interface and care must be=
 taken.
> +
> +Sysfs files for scrubbing are documented in
> +`Documentation/ABI/testing/sysfs-edac-scrub`
> +
> +1.2. Region based scrubbing
> +
> +CXL memory is exposed to memory management subsystem and ultimately user=
space
> +via CXL regions. CXL Regions represent mapped memory capacity in system
> +physical address space. These can incorporate one or more parts of multi=
ple CXL
> +memory devices with traffic interleaved across them. The user may want t=
o control
> +the scrub rate via this more abstract region instead of having to figure=
 out the
> +constituent devices and program them separately. The scrub rate for each=
 device
> +covers the whole device. Thus if multiple regions use parts of that devi=
ce then
> +requests for scrubbing of other regions may result in a higher scrub rat=
e than
> +requested for this specific region.
> +
> +1. When user sets scrub rate for a memory region, the scrub rate for all=
 the CXL
> +   memory devices interleaved under that region is updated with the same=
 scrub
> +   rate.=20

Note that this may affect multiple regions.

> +
> +2. When user sets scrub rate for a memory device, only the scrub rate fo=
r that
> +   memory devices is updated though device may be part of a memory regio=
n and
> +   does not change scrub rate of other memory devices of that memory reg=
ion.
> +
> +3. Scrub rate of a CXL memory device may be set via EDAC device or regio=
n scrub
> +   interface simultaneously. Care must be taken to prevent a race condit=
ion, or
> +   only region-based setting may be allowed.

So is this saying if you want to mix and match, set region first then device
next?  Can we just lay out the rules to set up a weird mixture.  We could
add more smarts to the driver but do we care as mixing 1 and 3 above is pro=
bably
unusual?

1. Taking each region in turn from lowest desired scrub rate to highest and=
 set
   their scrub rates.  Later regions may override the scrub rate on individ=
ual
   devices (and hence potentially whole regions).

2. Take each device for which enhanced scrubbing is required (higher rate) =
and
   set those scrub rates.  This will override the scrub rates of individual=
 devices
   leaving any that are not specifically set to scrub at the maximum rate r=
equired
   for any of the regions they are involved in backing.
  =20

> +
> +Sysfs files for scrubbing are documented in
> +`Documentation/ABI/testing/sysfs-edac-scrub`


