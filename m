Return-Path: <linux-edac+bounces-2853-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA022A07916
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2025 15:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC09D3A1E54
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2025 14:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ECB21A44D;
	Thu,  9 Jan 2025 14:24:41 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7967521A438;
	Thu,  9 Jan 2025 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432681; cv=none; b=h1hzIPbffy4mqzBkraP3zH2J6h0ir2aBFjUg2bUDtbz8y1YngF68dkteasRY3piX9bjDsptA/TOmQoaAaL/vtEBG3SX/7oYubeShUEZQA5D57BkSHv5svQv5Km8Y1A8WP8SZSoqqIAt7P/H3CxMFVuC4SpbyyEON8D6T+xnv/TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432681; c=relaxed/simple;
	bh=2PSVPW2utaOGMD3nvSyNOUFyw+PtgwdElVqKGi+B0bs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrvUxjTT1UmAJ7bOBeUVSQxLwhgxh4xp+xwfnKQ6hYne8pPYoHV5QqIKxZLWbFts7BEU+NU2HVSSwXpf9QBm8kUTssHLi3p4Lb48H19ZIJmur/DL9I9/D/ELLZz1+3pW/lQT3P/GfpsVSSNJ3P41rWXHiwKtEpMsFv9ytuaVe2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YTRpD0FQlz6GFBq;
	Thu,  9 Jan 2025 22:23:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C8DC140A34;
	Thu,  9 Jan 2025 22:24:36 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 9 Jan
 2025 15:24:34 +0100
Date: Thu, 9 Jan 2025 14:24:33 +0000
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
Message-ID: <20250109142433.00004ea7@huawei.com>
In-Reply-To: <20250109123222.GBZ3_B1g3Esgu1-MPi@fat_crate.local>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250106121017.1620-5-shiju.jose@huawei.com>
	<20250109091915.GAZ3-Uk3rkuh38cQyy@fat_crate.local>
	<3b2d4275d1d24dbeacee0f192ac4d69b@huawei.com>
	<20250109123222.GBZ3_B1g3Esgu1-MPi@fat_crate.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 9 Jan 2025 13:32:22 +0100
Borislav Petkov <bp@alien8.de> wrote:

Hi Boris,

> On Thu, Jan 09, 2025 at 11:00:43AM +0000, Shiju Jose wrote:
> > The min_ and max_ attributes of the control attributes are added  for your
> > feedback on V15 to expose supported ranges of these control attributes to the user, 
> > in the following links.    
> 
> Sure, but you can make that differently:
> 
> cat /sys/bus/edac/devices/<dev-name>/mem_repairX/bank
> [x:y]
> 
> which is the allowed range.

To my thinking that would fail the test of being an intuitive interface.
To issue a repair command requires that multiple attributes be configured
before triggering the actual repair.

Think of it as setting the coordinates of the repair in a high dimensional
space.

In the extreme case of fine grained repair (Cacheline), to identify the
relevant subunit of memory (obtained from the error record that we are
basing the decision to repair on) we need to specify all of:

Channel, sub-channel, rank,  bank group, row, column and nibble mask.
For coarser granularity repair only specify a subset of these applies and
only the relevant controls are exposed to userspace.

They are broken out as specific attributes to enable each to be set before
triggering the action with a write to the repair attribute.

There are several possible alternatives:

Option 1

"A:B:C:D:E:F:G:H:I:J" opaque single write to trigger the repair where
each number is providing one of those coordinates and where a readback
let's us known what each number is.

That single attribute interface is very hard to extend in an intuitive way.

History tell us more levels will be introduced in the middle, not just
at the finest granularity, making such an interface hard to extend in
a backwards compatible way.

Another alternative of a key value list would make for a nasty sysfs
interface.

Option 2 
There are sysfs interfaces that use a selection type presentation.

Write: "C", Read: "A, B, [C], D" but that only works well for discrete sets
of options and is a pain to parse if read back is necessary.

So in conclusion, I think the proposed multiple sysfs attribute style
with them reading back the most recent value written is the least bad
solution to a complex control interface.

> 
> echo ... 
> 
> then writes in the bank.
> 
> > ... so we would propose we do not add max_ and min_ for now and see how the
> > use cases evolve.  
> 
> Yes, you should apply that same methodology to the rest of the new features
> you're adding: only add functionality for the stuff that is actually being
> used now. You can always extend it later.
> 
> Changing an already user-visible API is a whole different story and a lot lot
> harder, even impossible.
> 
> So I'd suggest you prune the EDAC patches from all the hypothetical usage and
> then send only what remains so that I can try to queue them.

Sure. In this case the addition of min/max was perhaps a wrong response to
your request for a way to those ranges rather than just rejecting a write
of something out of range as earlier version did.

We can revisit in future if range discovery becomes necessary.  Personally
I don't think it is given we are only taking these actions in response error
records that give us precisely what to write and hence are always in range.

Jonathan

> 
> Thx.
> 


