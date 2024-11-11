Return-Path: <linux-edac+bounces-2494-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A809C3D41
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 12:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E3C284FB7
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 11:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485EA197A81;
	Mon, 11 Nov 2024 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SuhjY9Xn"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77374189BBB;
	Mon, 11 Nov 2024 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324565; cv=none; b=h9OmmAzsFi4RtSMxthjmYk87RAigsXQb5ROmSPrAqcZbmjEIi+igJr7Cqyjs2kb/wQneo/P0RRZkyfUKrvWz8sayjtL4Hehnj6/zSIfShlO8Pu46I618e+pPHYcHrK2WmCliFOb0QL1Gvxx1gXTMrUZ6QjMLgm2MzO8ndEdQCQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324565; c=relaxed/simple;
	bh=5cgp7iaZi8tgG12DuQYS4WxE3EZhYIb7ihHP94ue5g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+nVyKDgKgIHU6Uah9clMYVcdklsES2q5Twwygg/1w6//t59ctBMj2kM3zMAqo8shOBRS01aWahSF5N7KCIjchFEIM7CZZoGzpQVNZEMbR2RRJMwK1wguLCTw0z4lI7Satj7rTZ+00gWbspWQQCw+Zv7/yskIKhZ8U2E2ePieZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SuhjY9Xn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7B3C040E01FE;
	Mon, 11 Nov 2024 11:29:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LH789wugla_b; Mon, 11 Nov 2024 11:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731324553; bh=JihSgH5EEo1zZNt1PcMAqI+W39owOYa2GO/ORFME5H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SuhjY9XnZ61YUXJC4uvZeRaxLqOrfY2JaVRfozxcZVCcQQoiMIzqFT+q9PDTupY4u
	 Hz6vFjCezBUMp1Z9ilVs57fs5c6sOSvIgddWYN9XDQQbbHztkqGCUGJnu53EOeNcgV
	 8xqOueQtp8xg415nHLXdvfrxQ0hxs+W7Rsj2K/Hha8+z9Wpqlt6/OUzOamqctNuVc6
	 JEhLX+Zm2Uc8Y98c0WDxXUTOa+N3VASdpO9X12FoJ1MKyMVs8g5ps+Bjn7R5OsEuvm
	 AzdopQYAzqqcC9Vv6zbV2pQAydaDbwevNcOHJGMg73p9bJcofd6iGewT0XED0AvR3Q
	 cqzSB/hrFEJm9E2wnLLW24/0vbwSxWAbbL1+SDPKBoNr3A47OcbR9RBX56CY2dKTbv
	 M75Mj7BP7raefAdBGWvIMkUYisRxJ3AsO2Mn5plb8jx6zaoxz3Tx1DhOfR2wKD51kq
	 FmJ+KskVIy4cHuZqfCBB7FPAQC+gcPEnKb5lhfiWjkwJR7/qjrg4Bx4kkui9Mfgz6S
	 tQhlJQofepQFryNPWV4eDH4/4QJcNt0cWG699kJQkKCK/fWqHHPYDxKe4BRbKJqddS
	 v2Z7IqzW1qI2QfQyWdntY6GwFMG/gtHUeUYkCQLXd0A4SK+bD7GxMCW1/J3dk9/p6o
	 rCqL4WPLRSj3eru4yUfxmUXk=
Received: from zn.tnic (p200300ea973a31c3329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:973a:31c3:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C093040E015F;
	Mon, 11 Nov 2024 11:28:26 +0000 (UTC)
Date: Mon, 11 Nov 2024 12:28:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
	"leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
	"erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>,
	"gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v15 11/15] EDAC: Add memory repair control feature
Message-ID: <20241111112819.GCZzHqUz1Sz-vcW09c@fat_crate.local>
References: <20241101091735.1465-1-shiju.jose@huawei.com>
 <20241101091735.1465-12-shiju.jose@huawei.com>
 <20241104061554.GOZyhmmo9melwI0c6q@fat_crate.local>
 <1ac30acc16ab42c98313c20c79988349@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ac30acc16ab42c98313c20c79988349@huawei.com>

On Mon, Nov 04, 2024 at 01:05:31PM +0000, Shiju Jose wrote:
> More detailed explanation of PPR and memory sparing and use cases was added
> in Documentation/edac/memory_repair.rst, which is part of the last common
> patch ("EDAC: Add documentation for RAS feature control") added for
> documentation of various RAS features supported in this series. Was not sure
> the file to be part of this patch or not.

If the commit message doesn't contain a justification for a patch's existence,
why do you even bother sending it?

IOW, no redirections pls - just state here what the use case is in short. You
can always go nuts into details in the docs.

> persist_mode used to readback the value of persist_mode presently set.  For
> eg.  1 - soft memory sparing for a sparing instance, though the CXL memory
> device supports both soft and hard sparing, which is configurable.
> persist_mode_avail used to return the temporary and permanent repair
> capability of the device.  

Wait, sysfs does a one value per file thing. What does persist_mode_avail
give?

Surely you can't dump a list of all available modes...

From that doc:

root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/persist_mode_avail
0

Does that mean only sPPR is available?

If only one mode is available, why am I even querying things? There's no other
option.

Catch my drift?

> Also I will update here with more details which was given in the last part
> of this document about DPA.  Some memory devices (For eg. a CXL memory
> device) may expect the Device Physical Address(DPA) for a repair operation
> instead of Host Physical Address(HPA), because it may not have an active
> mapping in the main host address physical address map.  'dpa_support'
> attribute used to return this info to the user.  

All this stuff needs to be documented properly and especially how one is
supposed to use this interface. Not have people go read CXL specs just to be
able to even try to use this. I'd like to see clear steps in the docs what to
do and what they mean.

> The nibble mask actually for CXL memory PPR and memory sparing operations,
> which is reported by the device in DRAM Event Record and to the userspace in the
> CXL DRAM trace event.
> Please see the details from the spec.

This is *exactly* what I mean!

If I have to see the spec in order to use an interface, than that's a major
fail.

> I was not sure add or not these CXL specific details in this EDAC document.

So that document should contain enough info on how to use the interface. You
can always put links to the spec giving people further reading but some
initial how-do-I-use-this-damn-thing example should be there so that people
can find their way around this.

> The visibility of these control attributes to the user  in sysfs is decided
> by the is_visible() callback in the EDAC, which in turn depends on a memory
> device support or not the control of a repair attribute. 

That still doesn't answer my question: what are valid values I can put in all
those?

Try as many as I can until one sticks?

This is not a good interface.

And since sysfs does one-value-per-file, dumping ranges here is kinda wrong.

> This attribute used request to determine availability of resources for a repair operation
> (For eg. memory PPR and sparing operation) for a given address and memory attributes set.
> The device may return result for this request in different ways.
> For example, in CXL device request query resource command for a,  
> 1. PPR operation returns resource availability as a return code of the command. 
> 2. memory sparing operation, the device will report the resource availability by producing a
> Memory Sparing Event Record and  memory sparing trace event to the userspace.
> 
> May be 'dry-run' better name instead of query?

Maybe this should not exist at all: my simple thinking would say that
determining whether resources are available should be part of the actual
repair operation. If none are there, it should return "no resources
available". If there are, it should simply use them and do the repair.

Exposing this as an explicit step sounds silly.

> >Yeh, this needs to be part of the interface and not hidden in some obscure doc.
> Adding this info in Documentation/edac/memory_repair.rst is sufficient? 

Yap, for example. You can always concentrate the whole documentation there and
point to it from everywhere else.

> The details of the repairing control was added in
> Documentation/edac/memory_repair.rst, which is part of the common
> patch ("EDAC: Add documentation for RAS feature control").

Ok, point to it pls in this doc so that people can find it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

