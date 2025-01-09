Return-Path: <linux-edac+bounces-2854-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 391EAA07BBC
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2025 16:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C75188D790
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2025 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6DB21C9E3;
	Thu,  9 Jan 2025 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MSMASKI1"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE32B219A97;
	Thu,  9 Jan 2025 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435992; cv=none; b=LAbfDVvq/Ww2Uq8RXn23jENbil6ZZJW+8vV5p36wPwu7jQHNzZgTsKkuGsLhggEQMBtRtdWNplTyiSXg6NZtTE2Cly8baccqnytYshlGFoCQL6Oc8sI2RAjWNIgTQLRgBlV1wBMcTU5VnVNV1aES9tgSMOkC4BvOqlbGd1JBDho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435992; c=relaxed/simple;
	bh=LcD8D/O+tjtCsnATnq+o/+QJGJt2DNI3UWtiJj8dbvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0byhXs05yxBIwihulRQclSkMXviqFac+XEzaaNZOX4I7WGEyga2YIN6GgrKljKWz0u3zOYZSDtdMZwUx0VujYlO5vmZJYP5PmFPVyEUFh8IQbTpjIHfM8e64KCzE2nHSx+23TAlzraIvtpRST4TXstROBySPPbJwQZEktppDAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MSMASKI1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0CE2340E01F9;
	Thu,  9 Jan 2025 15:19:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tuK91XRnwJwF; Thu,  9 Jan 2025 15:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736435983; bh=eRtSquyKGkO5VxcHauXskkyGRsl2V7wKCAQNwjFunh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MSMASKI15NWKaVfiR4YFLTDuNJcQ7zUoJHND6KyAzhPYBIl7Nej56ZkbflXjDPccw
	 SwZBaMflm8kkIYwWRdJdSBAk6qoXnWT+tXMcbHAe4oqr3Wevx8TMQ3C5tygnDc4yCI
	 PxOPgdLj0AiZWKaJIDhkt/cLdoUrimgsahHFuu7muO+6o1e1J/vzx2BcEYtY6fa0D6
	 62JD39Ez58+GyiMMJcBMWW2yJgWmDDbHEopn6Bpb8a/UU3hObDoFf9QnShcJBLaqs5
	 3urjdMoyXTmhD8BhQKdQSJ8NXjvURv/J+Uzlk5MrSVpuGqKs8YEF7L5la7nyN6RfSD
	 7dz7xoPOHR+BsRWtHRzQKwX55Rq1iMHM1A+gUVzI9FB4qFZ9fB2fO9X3wOz903/qM4
	 VcyAAiDjiSbaTQS42DpS7hiubNZB3st7rxfgRPpsonFzXtMDqQdSpo0wNOSHMYbbya
	 ZMlGBtQzu5GX2hYEhmVNkz0rlDLV1s4/VPv+X6FpI65+D55Iwszm79L/E7n026ae3D
	 mY5uxowwdlXEZoLd7dfVW9vN9B+yX1mRQ4eKzrUe6Yd+0LSRcULioL5e6wls/n+PJW
	 3unbGU24+aG4hvQg9FZWe8LuTep+M1uuejAjE8rtUIeDwmBN69AAZ22coopsw7Ocgi
	 Nsb2+btJbJBenmpuOo3x69Wk=
Received: from zn.tnic (p200300eA971f933C329c23fffEA6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:933c:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3B79440E0288;
	Thu,  9 Jan 2025 15:19:00 +0000 (UTC)
Date: Thu, 9 Jan 2025 16:18:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
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
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <20250109151854.GCZ3_o3rf6S24qUbtB@fat_crate.local>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250106121017.1620-5-shiju.jose@huawei.com>
 <20250109091915.GAZ3-Uk3rkuh38cQyy@fat_crate.local>
 <3b2d4275d1d24dbeacee0f192ac4d69b@huawei.com>
 <20250109123222.GBZ3_B1g3Esgu1-MPi@fat_crate.local>
 <20250109142433.00004ea7@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109142433.00004ea7@huawei.com>

On Thu, Jan 09, 2025 at 02:24:33PM +0000, Jonathan Cameron wrote:
> To my thinking that would fail the test of being an intuitive interface.
> To issue a repair command requires that multiple attributes be configured
> before triggering the actual repair.
> 
> Think of it as setting the coordinates of the repair in a high dimensional
> space.

Why?

You can write every attribute in its separate file and have a "commit" or
"start" file which does that.

Or you can designate a file which starts the process. This is how I'm
injecting errors on x86:

see readme_msg here: arch/x86/kernel/cpu/mce/inject.c

More specifically:

"flags:\t Injection type to be performed. Writing to this file will trigger a\n"
"\t real machine check, an APIC interrupt or invoke the error decoder routines\n"
"\t for AMD processors.\n"

So you set everything else, and as the last step you set the injection type
*and* you also trigger it with this one write.

> Sure. In this case the addition of min/max was perhaps a wrong response to
> your request for a way to those ranges rather than just rejecting a write
> of something out of range as earlier version did.
> 
> We can revisit in future if range discovery becomes necessary.  Personally
> I don't think it is given we are only taking these actions in response error
> records that give us precisely what to write and hence are always in range.

My goal here was to make this user-friendly. Because you need some way of
knowing what valid ranges are and in order to trigger the repair, if it needs
to happen for a range.

Or, you can teach the repair logic to ignore invalid ranges and "clamp" things
to whatever makes sense.

Again, I'm looking at it from the usability perspective. I haven't actually
needed this scrub+repair functionality yet to know whether the UI makes sense.
So yeah, collecting some feedback from real-life use cases would probably give
you a lot better understanding of how that UI should be designed... perhaps
you won't ever need the ranges, whow knows.

So yes, preemptively designing stuff like that "in the dark" is kinda hard.
:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

