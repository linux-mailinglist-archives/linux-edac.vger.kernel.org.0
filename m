Return-Path: <linux-edac+bounces-1040-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A7D8C25CB
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 15:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8E31F21D8A
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 13:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D8A12C47D;
	Fri, 10 May 2024 13:31:49 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA173127E18;
	Fri, 10 May 2024 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347909; cv=none; b=XbBiuOYDBvftRKYTEsQM7xrRtcR+zcibP8keAHltVmx5Jf/k9QSRHgXPzqrQ8rVL/KlM4u3AWZd0HyB1TlA69PsTbKIAdp7lDM98vdtutHMUQiRvnjP0YhZeoflpxJX7wiBgbL2dIsxqQCfZiHrZZOmKrFdFa8nhCchOx7X9N2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347909; c=relaxed/simple;
	bh=QDeUIilVTn4GdjQ9ikQzbhB+jiyiep3X6WCQDzncYZI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWHJSuyLO1MdCu0b3cKrfeWJwIMB0gC4PKH+Qi/AjqVPm1m7JpFC1JwTnr0lD2pFtrgs/Rv0LGkDvrdPhr49tQ0LxoMa5JKJIBvp2klOgSO1mi22SS9OQq44YG9C3W93xYOXRr4RFMSskk1eHFsfDcQBjWWw0lVB6ppJ/mbpT0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VbV7z4xFKz6K5ks;
	Fri, 10 May 2024 21:28:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C21D61400D4;
	Fri, 10 May 2024 21:31:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 10 May
 2024 14:31:42 +0100
Date: Fri, 10 May 2024 14:31:41 +0100
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
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Jean Delvare
	<jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Message-ID: <20240510143141.000042da@Huawei.com>
In-Reply-To: <D9511DC1-1566-473A-A426-111BB1F7F9F0@alien8.de>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
	<20240419164720.1765-2-shiju.jose@huawei.com>
	<20240425101542.GAZiotThrq7bOE9Ieb@fat_crate.local>
	<63fdbe26b51f4b7c859bfb30287c8673@huawei.com>
	<20240506103014.GHZjixNhhFkgkMhDg_@fat_crate.local>
	<e0ce36eb80054440ab877ccee4e606de@huawei.com>
	<20240508172002.GGZju0QvNfjB7Xm6qL@fat_crate.local>
	<4ceb38897d854cc095fca1220d49a4d2@huawei.com>
	<20240508192546.GHZjvRuvtu0XSJbkmz@fat_crate.local>
	<20240509101939.0000263a@Huawei.com>
	<D9511DC1-1566-473A-A426-111BB1F7F9F0@alien8.de>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> How hard is that "jump through hoops" thing anyway?

I'd conservatively estimate 500 lines of duplicated code from the CXL
subsystem just to handle the setup and discovery of the mailbox, plus
all the checks needed to establish the device is in a state to reply.
Also locking or module load ordering constraints because we need
to ensure mutual exclusion on that mailbox between this module and the CXL
core. So it would approximately triple the size of this driver to
check for CXL scrub support. Not to mention hotplug - which could
possibly be solved with appropriate udev rules to try loading this again
whenever a CXL memory device gets plugged in.

Alternative would be to make this ras class driver dependent on the CXL
driver stack running first. Thus if you wanted RAS2 ACPI table support, you'd
need to load a whole bunch of CXL stuff.

Add another similar driver in future and we get another few 100 lines of code
or another dependency. To me those numbers make it unsustainable.

> 
> You mean it should load so that when booting an allmodconfig kernel there are not enough modules which are loading so lemme load one more. And then I need to go and rmmod them all before I need to do localmodconfig and build a tailored kernel for the machine.
> 
> Or is there some other reason to load silly modules, use up resources for no good reason whatsoever and bloat the machine?

As Dan, Shiju and I observed (and Shiju tested to be sure we weren't
getting it wrong), normal setups including your allmodconfig
build would not even load the driver.  What are we missing?

Jonathan

