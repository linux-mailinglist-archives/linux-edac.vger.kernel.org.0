Return-Path: <linux-edac+bounces-1023-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141FD8C0D6A
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2024 11:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E1B282D27
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2024 09:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D5014A60D;
	Thu,  9 May 2024 09:19:54 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C25814A4D6;
	Thu,  9 May 2024 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715246394; cv=none; b=ZiIs56Xx9c1+r/Me5bdfRydF2n/TiZ4dZm0ullirXDF7IOZQGuyXBatneD2sQPipxr2LcRrBFh+dSFXpNkCJIOi0/9N2/NOvKXshl53HCH3q5MD5aQI3IpZlJkJcNhcdeC6rFwc8xbU6yQdn5SrlNIcireJkcO4TZctSs8BUXv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715246394; c=relaxed/simple;
	bh=Wo1mgBAo3XVnCRSmoN/72bpcQl9w/zUeaNEQRe5EHhQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MlZiEorBIuBHuqborz2PmkpDhumRB7eopGaR6ALgDZjIoqJe8mi6ImMlF7FVf8nFpw57L392GaD/8wTRywWSm5EEWO0X31arA+/lmkA7l8wSKe0GI8MQJrB5j2ZVjH0kWKANTwl/yO9bKyZT4ijO4DdM/kN09QCPouVjDWZmKOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VZmbq6JsKz6J9rQ;
	Thu,  9 May 2024 17:16:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CF873140C98;
	Thu,  9 May 2024 17:19:41 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 9 May
 2024 10:19:40 +0100
Date: Thu, 9 May 2024 10:19:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: Shiju Jose <shiju.jose@huawei.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "leo.duran@amd.com"
	<leo.duran@amd.com>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck
	<linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Message-ID: <20240509101939.0000263a@Huawei.com>
In-Reply-To: <20240508192546.GHZjvRuvtu0XSJbkmz@fat_crate.local>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
	<20240419164720.1765-2-shiju.jose@huawei.com>
	<20240425101542.GAZiotThrq7bOE9Ieb@fat_crate.local>
	<63fdbe26b51f4b7c859bfb30287c8673@huawei.com>
	<20240506103014.GHZjixNhhFkgkMhDg_@fat_crate.local>
	<e0ce36eb80054440ab877ccee4e606de@huawei.com>
	<20240508172002.GGZju0QvNfjB7Xm6qL@fat_crate.local>
	<4ceb38897d854cc095fca1220d49a4d2@huawei.com>
	<20240508192546.GHZjvRuvtu0XSJbkmz@fat_crate.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 8 May 2024 21:25:46 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Wed, May 08, 2024 at 05:44:03PM +0000, Shiju Jose wrote:
> > I mean scrub subsystem module is not loaded and initialzed until
> > a dependent  device module is loaded and a device does not get
> > registered with the scrub subsystem on a machine which doesn't have
> > the corresponding scrub features.  
> 
> Stop this rambling blabla please. This should *not* happen:
> 
> # insmod ./memory_scrub.ko
> # echo $?
> 0
> # lsmod
> Module                  Size  Used by
> memory_scrub           12288  0
> 
> This is on a silly guest which has none of those dependent devices crap.
> 
> Your scrub module should load only on a machine which has the hardware
> - not just for fun and on anything.

Fundamental question seems to be:  Why should it not load?
Shiju and I think it should, you think it shouldn't.
Note this is only if someone deliberately ignores all the infrastructure
intended to make sure only relevant modules probe and modprobe / insmod
by hand.

+CC some driver core folk and a few other subsystem maintainers who
 have subsystems doing the same as this one.

Summary I think is:
Borislav is asking for this new scrub subsystem core module to not
successfully probe and call class_register() if it is manually
inserted and there is no hardware on the particular system.
It's a standard class type situation with core driver providing
consistent ABI and /sys/class/ras/ with drivers hanging off various
buses (currently ACPI and CXL) registering with that class.

Many subsystem core drivers will probe and create subsystem specific
sysfs directories on on systems that don't have any hardware needing
drivers from that subsystem (if someone manually inserts them rather
than relying on automatic module dependency handling.)
I don't see why this class driver should be different and have to jump
through hoops to satisfy this requirement.

A quick look for callers of class_register() in their init functions
found plenty of precedence.  Many of the cases that don't do this are
single use - i.e. class that only ever has one driver. There are even
more if we take sysfs buses into account. (edac and IIO for example) 

A few examples of same handling of class registration.
- input - that registers a lot more on class init, but sysfs class
          registration is in there.
- hwmon - other than some quirk setup same as the scrub driver.


Other than embedded systems with a custom build and kernel developers,
who actually probes modules manually?  Mostly people rely on modalias
of the client drivers and them pulling in their dependencies.
Modules are pretty pointless if you probe all the ones you've built
whether or not the hardware is present.

It would of course be easy to do the class_register() on first driver
use but I'm not seeing a lot of precedence + the scrub class module would
still insmod successfully. I think preventing load would be messy and
complex at best.

Jonathan


