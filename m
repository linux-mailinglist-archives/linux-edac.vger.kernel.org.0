Return-Path: <linux-edac+bounces-1001-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 524578BCC05
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 12:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D552F1F22C3E
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 10:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C3E1E895;
	Mon,  6 May 2024 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lKsTAn5S"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A206520E6;
	Mon,  6 May 2024 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714991466; cv=none; b=I3f3HFAfrm57AjIfKNq8pIUqddQ/BQ2N6yVMcQNruByN2ma2dFzxRLwm2jZ7dLUYdbXmYXODTG3dknN1fIZ7mb/IkOrq+W/76tWEcuduuCuSdsP5Skjbu7UqS+/5zex7rleoO0uHSlG8G3DXcRRXh72ngnzgA0iM6QInrTbG2TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714991466; c=relaxed/simple;
	bh=ReZKyuVHA0NHApnlMBhen5K4UugoVceHOVNhkkvO6yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I61x6FlickYqSRY/uetWajD3IqYoYE0aI6xxp7xnk2iCMYLuQYeKhERMqYyewenwHDqd90K4VpdQMA+yV/RVxE1e7y1/PQra7trM24dpYXaCRnaxcMQdO+P7k5aEq/JtgcEiSBP3hXSGABsqnprt4wxHKiHBRhkAweeQbfc5ntM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lKsTAn5S; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0982D40E0249;
	Mon,  6 May 2024 10:31:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id h5q6KkWXILDw; Mon,  6 May 2024 10:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714991458; bh=snaM6UDtGtGvqvIKA47vd3NtbUZwsnUs8N0zwMuvcFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lKsTAn5SKefD7WI+yRaq08YbIV+1ksjAPMz31FhFS97vvzMBXS/MUSbHPDQGOYxLI
	 LJ+2OMimc4sy7QTSfhIKBn0lNu9SFSNJ0f2bSIyn8ScGMYCWGKusTnKexdk2MMJTIt
	 Td7g2RmjqRAzSg/14n7zvDh/7WPw+Pgl6mMkHrCN/7p3nPXfN362Zj+h/bVsDdAlcz
	 ezOsWx2t9UtC9h7lgES4p4LocFcTBtdUbSxOYmI5lfA6EwRTnMGcFES98RUed0wyxu
	 Otf0mlBhKW65Xpf/mwJIS1Xl5zvq0WRGi/RAp7K/1YNp9BgwL+L5+mMle/M9rhV+uL
	 j7xDXYq40aZP7/6OQ5zvn/4MgUKsGANoDTbNGXykt44NIkBmHm1Ek5fYwAG/NU6gpx
	 LMGnd4GJhR0A2GnGOpsbNv41F7rPhN0NxKPM26Gmi5SA4e8eUqG4RA7hk+l7OiL3lc
	 Ri6RS9Qylcb+gjR2m2RCV0wQqAmzLI4x1gSQQnL8SkhEYw1/K84kQWIaOouSMlptjy
	 D5u+2PUKgvBSw7AxIDd5/wJVPsOEO4VZfWJtr0n1qSQh+6NoGe/lOOlkmfaEfEZCIF
	 KfH5qVWUPM9aBMqf1Iv0fsKrvWJVp6tdASX5j2j31OB0nQ+89XRIyz77YkEtqAKej+
	 /lR1VU/27KvCKxnUssgLwkDA=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8B77840E0187;
	Mon,  6 May 2024 10:30:15 +0000 (UTC)
Date: Mon, 6 May 2024 12:30:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
	"leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
	"erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>,
	"mike.malvestuto@intel.com" <mike.malvestuto@intel.com>,
	"gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Message-ID: <20240506103014.GHZjixNhhFkgkMhDg_@fat_crate.local>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
 <20240419164720.1765-2-shiju.jose@huawei.com>
 <20240425101542.GAZiotThrq7bOE9Ieb@fat_crate.local>
 <63fdbe26b51f4b7c859bfb30287c8673@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63fdbe26b51f4b7c859bfb30287c8673@huawei.com>

On Thu, Apr 25, 2024 at 06:11:13PM +0000, Shiju Jose wrote:
> It is expected to have multiple RAS-specific functionalities other
> than scrubbing  in long run.  Most of the classes in the kernel found
> as  /sys/class/<class-name>/<class-name>X/
> 
> If not, however /sys/class/ras/<module -name>X/<feature> is more
> suitable because there are multiple device instances such as cxl
> devices with scrub control feature.  For example,
> /sys/class/ras/cxlX/scrub

Make it as user-friendly as possible. cxlX is not as user-friendly as

/sys/class/ras/cxl/<mem_accelerator>
		  /<fancy_bla_thing>

and so on.

Yes, you can introduce a special category .../ras/cxl/ if there are
multiple cxl devices which have RAS functionality on them.

> Presently underlying hw driver does the check. I think this will
> become more complex if does in the common rate_store() if we have to
> check against either a list of possible rates or min and max rates.

Ok.

> >> +DEVICE_ATTR_RW(enable_background);
> >> +DEVICE_ATTR_RO(name);
> >> +DEVICE_ATTR_RW(rate);
> >> +DEVICE_ATTR_RO(rate_available);
> >
> >static

Forgot one.

> This is the ras instance id (X) used for scrub control feature, /sys/class/ras/rasX/scrub/

Yeah, as discussed  above.

> >> +static int __init memory_scrub_control_init(void) {
> >> +	return class_register(&scrub_class); }
> >> +subsys_initcall(memory_scrub_control_init);
> >
> >You can't just blindly register this thing without checking whether there are even
> >any hw scrubber devices on the system.
>
> I think it happens only when a dependent module as autoloaded based
> on a scrub device existing with exception of memory scrub control
> built in and who would build this in?

You think or you know?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

