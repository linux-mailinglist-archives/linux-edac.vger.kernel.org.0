Return-Path: <linux-edac+bounces-2896-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A3DA10758
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 14:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F8E3A6C9C
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 13:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8185234D0A;
	Tue, 14 Jan 2025 13:05:45 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9F5236A91;
	Tue, 14 Jan 2025 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736859945; cv=none; b=K9KOZ1ZUnjNlPTYQEqgLOkmyU9C6mkemUy2Ig3eCir5yVgf4TMGvAAnxu//wNhT/gV9QOgCuowRUJVViZZMk/EzoDM7OgCM6N1SOU+OaVtRXVMQlngKrWjC6pbvrxLo1ZHnaj5tR2IeGy1MSTx7tSvfzj31GyZ6X4x1x49sTIK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736859945; c=relaxed/simple;
	bh=Wh1F2bF3QMCaIaMqNwCHnUDsPbe730s7f5QEYrJL3cg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvXRmeGtUjsjWZtpcdLdXV03uHXsPWVMp1LAljOv/+ftLOMXNlvtsV3q45ElscMYD1EJGd60WsAEG/7zK3G9uZ0ZkrogSYbNJ/aWmRfMuZixFkdkmFL+s1zTfZFcu4C+/Ptj+EbUtXWSgMBa7eifrz35Q2fG4sWtlnlusj9ZpWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YXTq10b9Lz6F9BN;
	Tue, 14 Jan 2025 21:04:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 10AC414022E;
	Tue, 14 Jan 2025 21:05:40 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 14 Jan
 2025 14:05:38 +0100
Date: Tue, 14 Jan 2025 13:05:37 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Shiju Jose <shiju.jose@huawei.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
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
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <20250114130537.0000375b@huawei.com>
In-Reply-To: <20250114133817.20048aa4@foz.lan>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250106121017.1620-5-shiju.jose@huawei.com>
	<20250109091915.GAZ3-Uk3rkuh38cQyy@fat_crate.local>
	<3b2d4275d1d24dbeacee0f192ac4d69b@huawei.com>
	<20250109123222.GBZ3_B1g3Esgu1-MPi@fat_crate.local>
	<20250109142433.00004ea7@huawei.com>
	<20250114133817.20048aa4@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 14 Jan 2025 13:38:31 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Thu, 9 Jan 2025 14:24:33 +0000
> Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:
> 
> > On Thu, 9 Jan 2025 13:32:22 +0100
> > Borislav Petkov <bp@alien8.de> wrote:
> > 
> > Hi Boris,
> >   
> > > On Thu, Jan 09, 2025 at 11:00:43AM +0000, Shiju Jose wrote:    
> > > > The min_ and max_ attributes of the control attributes are added  for your
> > > > feedback on V15 to expose supported ranges of these control attributes to the user, 
> > > > in the following links.        
> > > 
> > > Sure, but you can make that differently:
> > > 
> > > cat /sys/bus/edac/devices/<dev-name>/mem_repairX/bank
> > > [x:y]
> > > 
> > > which is the allowed range.    
> > 
> > To my thinking that would fail the test of being an intuitive interface.
> > To issue a repair command requires that multiple attributes be configured
> > before triggering the actual repair.
> > 
> > Think of it as setting the coordinates of the repair in a high dimensional
> > space.
> > 
> > In the extreme case of fine grained repair (Cacheline), to identify the
> > relevant subunit of memory (obtained from the error record that we are
> > basing the decision to repair on) we need to specify all of:
> > 
> > Channel, sub-channel, rank,  bank group, row, column and nibble mask.
> > For coarser granularity repair only specify a subset of these applies and
> > only the relevant controls are exposed to userspace.
> > 
> > They are broken out as specific attributes to enable each to be set before
> > triggering the action with a write to the repair attribute.
> > 
> > There are several possible alternatives:
> > 
> > Option 1
> > 
> > "A:B:C:D:E:F:G:H:I:J" opaque single write to trigger the repair where
> > each number is providing one of those coordinates and where a readback
> > let's us known what each number is.
> > 
> > That single attribute interface is very hard to extend in an intuitive way.
> > 
> > History tell us more levels will be introduced in the middle, not just
> > at the finest granularity, making such an interface hard to extend in
> > a backwards compatible way.
> > 
> > Another alternative of a key value list would make for a nasty sysfs
> > interface.
> > 
> > Option 2 
> > There are sysfs interfaces that use a selection type presentation.
> > 
> > Write: "C", Read: "A, B, [C], D" but that only works well for discrete sets
> > of options and is a pain to parse if read back is necessary.  
> 
> Writing it as:
> 
> 	a b [c] d
> 
> or even:
> 	a, b, [c], d
> 
> doesn't make it hard to be parse on userspace. Adding a comma makes
> Kernel code a little bigger, as it needs an extra check at the loop
> to check if the line is empty or not:
> 
> 	if (*tmp != '\0')
> 		*tmp += snprintf(", ")
> 
> Btwm we have an implementation like that on kernelspace/userspace for
> the RC API:
> 
> - Kernelspace:
>   https://github.com/torvalds/linux/blob/master/drivers/media/rc/rc-main.c#L1125
>   6 lines of code + a const table with names/values, if we use the same example
>   for EDAC:
> 
> 	const char *name[] = { "foo", "bar" };
> 
> 	for (i = 0; i < ARRAY_SIZE(names); i++) {
> 		if (enabled & names[i].type)
> 			tmp += sprintf(tmp, "[%s] ", names[i].name);
> 		else if (allowed & proto_names[i].type)
> 			tmp += sprintf(tmp, "%s ", names[i].name);
> 	}
> 
> 
> - Userspace:
>   https://git.linuxtv.org/v4l-utils.git/tree/utils/keytable/keytable.c#n197
>   5 lines of code + a const table, if we use the same example
>   for ras-daemon:
> 
> 		const char *name[] = { 
> 			[EDAC_FOO] = "[foo]",
> 			[EDAC_BAR] = "[bar]",
> 		};
> 
> 		for (p = strtok(arg, " ,"); p; p = strtok(NULL, " ,"))
> 			for (i = 0; i < ARRAY_SIZE(name); i++)
> 				if (!strcasecmp(p, name[i])
> 					return i;
> 		return -1;
> 
> 	(strtok handles both space and commas at the above example)
> 
> IMO, this is a lot better, as the alternative would be to have separate
> sysfs nodes to describe what values are valid for a given edac devnode.
> 
> See, userspace needs to know what values are valid for a given
> device and support for it may vary depending on the Kernel and
> device version. So, we need to have the information about what values
> are valid stored on some sysfs devnode, to allow backward compatibility.

These aren't selectors from a discrete list so the question is more
whether a syntax of
<min> value <max> 
is intuitive or not.  I'm not aware of precedence for this one.

There was another branch of the thread where Boris mentioned this as an
option. It isn't bad to deal with and an easy change to the code,
but I have an open question on what choice we make for representing
unknown min / max.  For separate files the absence of the file
indicates we don't have any information.


> 
> > 
> > So in conclusion, I think the proposed multiple sysfs attribute style
> > with them reading back the most recent value written is the least bad
> > solution to a complex control interface.
> >   
> > > 
> > > echo ... 
> > > 
> > > then writes in the bank.
> > >     
> > > > ... so we would propose we do not add max_ and min_ for now and see how the
> > > > use cases evolve.      
> > > 
> > > Yes, you should apply that same methodology to the rest of the new features
> > > you're adding: only add functionality for the stuff that is actually being
> > > used now. You can always extend it later.
> > > 
> > > Changing an already user-visible API is a whole different story and a lot lot
> > > harder, even impossible.
> > > 
> > > So I'd suggest you prune the EDAC patches from all the hypothetical usage and
> > > then send only what remains so that I can try to queue them.    
> > 
> > Sure. In this case the addition of min/max was perhaps a wrong response to
> > your request for a way to those ranges rather than just rejecting a write
> > of something out of range as earlier version did.
> > 
> > We can revisit in future if range discovery becomes necessary.  Personally
> > I don't think it is given we are only taking these actions in response error
> > records that give us precisely what to write and hence are always in range.  
> 
> For RO devnodes, there's no need for ranges, but those are likely needed for
> RW, as otherwise userspace may try to write invalid requests and/or have
> backward-compatibility issues.

Given these parameters are only meaningfully written with values coming
ultimately from error records, userspace should never consider writing
something that is out of range except during testing.

I don't mind presenting the range where known (in CXL case it is not
discoverable for most of them) but I wouldn't expect tooling to ever
read it as known correct values to write come from the error records.
Checking those values against provided limits seems an unnecessary step
given an invalid parameter that slips through will be rejected by the
hardware anyway.

Jonathan

> 
> 
> Thanks,
> Mauro


