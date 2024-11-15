Return-Path: <linux-edac+bounces-2554-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E705F9CDE1A
	for <lists+linux-edac@lfdr.de>; Fri, 15 Nov 2024 13:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0D4284DD2
	for <lists+linux-edac@lfdr.de>; Fri, 15 Nov 2024 12:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171411BBBC6;
	Fri, 15 Nov 2024 12:14:24 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455271B3942;
	Fri, 15 Nov 2024 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731672864; cv=none; b=X47Nd9E+DRKf96mNuuVn31+VWfeVSfxxdO/S0+N8lbHJyhWQ4bG1hSnhzoRPtwKu+gvvO9AqTPpKnYRCYPo8bjWCcviWNfoc5RrJ1cGoL8bfXkPjjULN1+vroJNJ66VGJK3idb4fc/eFaTi6rYTEi3gDqIoTn/+xwHamVi5D/M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731672864; c=relaxed/simple;
	bh=rWmshmSMK3ztYZPMn5WUQGtD4MV6pNS+89ldeBjN4z4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vb91aaK+xSmkwCJErdHT5DLeWPfMVwMn4EUApchfjzSHCFnN2dySqiAKf6opJEuF9ncsM1j7nebpTRQ8L0gX//7PA7HSvsge17e3dMM/2ikbAERB3759PyIEOY4fEAwSHm38sOobtVmp3Y/RWn8td8oBjQ2METpUSILgDOJD+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XqbXq0CZJz6LD9k;
	Fri, 15 Nov 2024 20:14:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AF913140A08;
	Fri, 15 Nov 2024 20:14:18 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 15 Nov
 2024 13:14:17 +0100
Date: Fri, 15 Nov 2024 12:14:15 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: Shiju Jose <shiju.jose@huawei.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "leo.duran@amd.com"
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
	"Roberto Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v15 11/15] EDAC: Add memory repair control feature
Message-ID: <20241115121415.00005c76@huawei.com>
In-Reply-To: <20241114133249.GEZzX8ATNyc_Xw1L52@fat_crate.local>
References: <20241101091735.1465-1-shiju.jose@huawei.com>
	<20241101091735.1465-12-shiju.jose@huawei.com>
	<20241104061554.GOZyhmmo9melwI0c6q@fat_crate.local>
	<1ac30acc16ab42c98313c20c79988349@huawei.com>
	<20241111112819.GCZzHqUz1Sz-vcW09c@fat_crate.local>
	<7fd81b442ba3477787f5342e69adbb96@huawei.com>
	<20241114133249.GEZzX8ATNyc_Xw1L52@fat_crate.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

Hi Borislav,

I'll just jump in on one element.

> > This will work for the CXL PPR feature where the result of the query operation for resources  availability
> > return to the command, however for the CXL memory sparing features,  the result of the query resources 
> > availability command returned later in a Memory Sparing Event Record from the device. 
> > Userspace shall issue repair operation with the attributes values received on the Memory Sparing trace event.
> > Thus for the CXL memory sparing feature, query for resources availability and repair operation 
> > cannot be combined.  
> 
> What happens if the resources availability changes between the query and the
> start of the repair operation?
>
Short answer, you get an error return. 

The query is an optional step / optimization. You can just skip it.
There is no point in  querying if you are going to immediately issue the command to repair
(as that will report an error if you can't do it). 

A typical flow where it might be useful is:
1) Lots of corrected errors reported on a particular part of the memory.
2) OS decides enough is enough, that row/bank/nibble should be replaced.
3) Before doing so it checks it can actually replace it - otherwise maybe we will be disrupting a
   gigantic page or similar where the perf cost of just off lining is higher than we want.
4) After query the page is offlined etc (may or may not be necessary depending on the
   hardware design - we may be able to do it 'live').
5) 'Try' to repair. Hopefully no one raced with us and used up the remaining resources.
  Given this is typically only driven by something like RASDaemon that race should be
  a corner case only (very unlikely)
6) If repair fails can just bring the memory back - but this dance was expensive and
   we will carry on working with less than ideal memory (probably schedule some
   real maintenance to swap out the device).
7) If repair succeeds bring the memory back as now we have shiny new memory.

We could drop the query for now and bring it back later once more of the surrounding
infrastructure becomes clearer.  To me it's a useful feature, but I appreciate
this is early days and we shouldn't always try for all the bells and whistles on
day 1.


> The cat catches fire?
Dog person? :) Just a nice normal error return to indicate no resources.

Jonathan

> 


