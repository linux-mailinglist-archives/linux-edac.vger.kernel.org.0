Return-Path: <linux-edac+bounces-2059-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BCA99D529
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 19:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A041C22158
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 17:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0711D1C0DD6;
	Mon, 14 Oct 2024 17:02:27 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF481BE854;
	Mon, 14 Oct 2024 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925346; cv=none; b=bvmp4GVn/LkgccGp0P3pnuog7/yuom8H9LSlyPZg0P5b/Gtuenku2Mb0NIepV0nIu1HA5FM+h08oXnIip1C+cbsBz2LbkF4sw/bYe/bFFjpXvezVdvtm8M9Tu2TBgCV5Rht9bU0cFbOtbLV3PrRJtVaB6H3Kn255OHFiS+L48TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925346; c=relaxed/simple;
	bh=vkupR3+rWlCaZao5/CLj0g4WFEKCHfS/VpFVvhggC54=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+CGWzq5V6r7WdM5om6JbknyjIyYfvWYYlAsw0ljEl9nDLJJFTiqiaF0RAG4RxiqkqNKFWXusrmhpas2ZUk9wdQWhfDMvb+LuScBvJRZXid0l+DyEXgxI8KjhVd8oblOWPykbZhOp/s+6FON+Q7HB/BLTE+iQVT+DMPiyNTMitw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XS3QR2yBmz6J6qD;
	Tue, 15 Oct 2024 01:00:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 734101404F5;
	Tue, 15 Oct 2024 01:02:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 19:02:19 +0200
Date: Mon, 14 Oct 2024 18:02:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shiju Jose <shiju.jose@huawei.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
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
Subject: Re: [PATCH v13 15/18] EDAC: Add memory repair control feature
Message-ID: <20241014180217.0000299a@Huawei.com>
In-Reply-To: <162f5e44507b46029eebb007dedef0d5@huawei.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
	<20241009124120.1124-16-shiju.jose@huawei.com>
	<20241014172312.00007034@Huawei.com>
	<162f5e44507b46029eebb007dedef0d5@huawei.com>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 14 Oct 2024 17:39:12 +0100
Shiju Jose <shiju.jose@huawei.com> wrote:

> >-----Original Message-----
> >From: Jonathan Cameron <jonathan.cameron@huawei.com>
> >Sent: 14 October 2024 17:23
> >To: Shiju Jose <shiju.jose@huawei.com>
> >Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org; linux-
> >acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
> >bp@alien8.de; tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
> >mchehab@kernel.org; dan.j.williams@intel.com; dave@stgolabs.net;
> >dave.jiang@intel.com; alison.schofield@intel.com; vishal.l.verma@intel.com;
> >ira.weiny@intel.com; david@redhat.com; Vilas.Sridharan@amd.com;
> >leo.duran@amd.com; Yazen.Ghannam@amd.com; rientjes@google.com;
> >jiaqiyan@google.com; Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
> >naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
> >somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
> >duenwen@google.com; gthelen@google.com;
> >wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
> >wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
> ><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Roberto
> >Sassu <roberto.sassu@huawei.com>; kangkang.shen@futurewei.com;
> >wanghuiqiang <wanghuiqiang@huawei.com>; Linuxarm
> ><linuxarm@huawei.com>
> >Subject: Re: [PATCH v13 15/18] EDAC: Add memory repair control feature
> >
> >On Wed, 9 Oct 2024 13:41:16 +0100
> ><shiju.jose@huawei.com> wrote:
> >  
> >> From: Shiju Jose <shiju.jose@huawei.com>
> >>
> >> Add generic EDAC memory repair control, eg. PPR(Post Package Repair),
> >> memory sparing etc, control driver in order to control memory repairs
> >> in the system. Supports sPPR(soft PPR), hPPR(hard PPR), soft/hard
> >> memory sparing, memory sparing at cacheline/row/bank/rank granularity etc.
> >> Device with memory repair features registers with EDAC device driver,
> >> which retrieves memory repair descriptor from EDAC memory repair
> >> driver and exposes the sysfs repair control attributes to userspace in
> >> /sys/bus/edac/devices/<dev-name>/mem_repairX/.
> >>
> >> The common memory repair control interface abstracts the control of an
> >> arbitrary memory repair functionality to a common set of functions.
> >> The sysfs memory repair attribute nodes would be present only if the
> >> client driver has implemented the corresponding attribute callback
> >> function and passed in ops to the EDAC device driver during registration.
> >>
> >> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>  
> [...]
> >  
> >> +
> >> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/hpa
> >> +Date:		Oct 2024
> >> +KernelVersion:	6.12
> >> +Contact:	linux-edac@vger.kernel.org
> >> +Description:
> >> +		(WO) Set HPA (Host Physical Address) for memory repair.  
> >
> >Can we not just read back what was written?  Seems like userspace might expect
> >that?  
> I am fine to add read back.
> I did not add read back  for controls because there was no such requirement from the client driver and
> also tried to reduce the number of callbacks in the initial version. 

I think we can for now at least just cache in the core code.
If we have future implementations where more validation is possible
then we can add optional callbacks at that stage.

Jonathan

> 
> Thanks,
> Shiju


