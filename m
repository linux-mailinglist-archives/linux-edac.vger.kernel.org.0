Return-Path: <linux-edac+bounces-2205-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6E09AD074
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 18:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5D01F233B2
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CCC1D0F73;
	Wed, 23 Oct 2024 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="W19lpIFu"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25D81D0DE9;
	Wed, 23 Oct 2024 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700768; cv=none; b=UoC1307rKtTBEyFga7N/OEjx312uRX8G+Bil154SwriTf8lctpjp+rPiff/MqPmQEmj+QreIkPgFyX2alrHnAOzUQePaW7TcJwTxgWCr7fmBqhG+f9oEWHvv+Ky+iw18c6wo5vsIBQTdEU0BQ8WhfFAcetYNuoJnGduFeSeuDMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700768; c=relaxed/simple;
	bh=Ar2lgOyGoBsh/6u/TKy+hMR18rggVWMi7Zf6eguVel8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxYJdkgCpVXVdokinB0DWnazL9O7yLOx4mlXVem2J7FZR+gnB2ZtFbwVOqnkmIb+kBJ7WTG5ASeSGUXmCd6KNLCgmLCV+2T3znTicRuwWaNBP7+plwD/T8XZTRwqPN/NvCkaedlIb9Nn0Ovz029gxrak2dEhe+1KZboB/YXRvmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=W19lpIFu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D903640E015F;
	Wed, 23 Oct 2024 16:16:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3knQLSADIqtL; Wed, 23 Oct 2024 16:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729700213; bh=ZbVpk0hvfbmUrgI0RQm7j5r7sUgbzT1X7sZYFMHu3WU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W19lpIFuP87d30ErCdAXO0V9Rn6i6qLqfUYpO4RRk5GxzsNsqOhxQ+xQwBya28t4R
	 OrLqbJTtWO1fexV7FatqKICpG0ipaX3nOTvP34+G8Br0prc8d5IFMdxZAZmQxqEK3/
	 Zbxz4TMQq8M2T3FskB15ySaBiPV9usbYQh0D8m+L2a/4xQ7hK2J2kvi4os0+BfXJpH
	 VH3zCNNbljgQq0cu9fbj975x7vdcO67KUTvjFNEkocvOBI4Vf8jc4krVVl5HvnSKXV
	 z4csYqEoJl2MC0kqspB8Q8d7q19lpfq9H+qBWh1HkLcsFEXu7e3+Rrp1OATrC9BXMT
	 pT7eWmucA+TubejM3+KxPfFd7RE3ho1rU2OrdiUtoQ9kFGVeHLFPF/TFuX6MzSQigL
	 +ne6pxY+ikLclA4FjHSgPPfKUg+gO9koPu1yAH932CEXFSN633PLyBXrHA9yih25Za
	 tU5v31PNj9URR0bcNUg+w9Xoq/WB4ErufIMS3oIEq7lOkJE3I2D//PUxJYwG4A940Y
	 /vGEAlZVh/wuUZFjJ4cohxNPahwaPx5zGzcuGvABKysCXmVNAbO6xsqF9Lze9XY0p0
	 N8SW/+J76pBEv+8h1NumlE0x60VJD7I3eVmX2Idr+J/jawe5JnxeGyPDx7jJZxPdAW
	 Z3cagfchrgrnaLxbiZ7azmg0=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D827040E0191;
	Wed, 23 Oct 2024 16:16:09 +0000 (UTC)
Date: Wed, 23 Oct 2024 18:16:03 +0200
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
Subject: Re: [PATCH v13 02/18] EDAC: Add scrub control feature
Message-ID: <20241023161603.GDZxkhQ65XCa-6S7RU@fat_crate.local>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
 <20241009124120.1124-3-shiju.jose@huawei.com>
 <20241022190454.GIZxf3VkmLVR-JLeUc@fat_crate.local>
 <4ee36d03a2894606a571b37f440da36f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ee36d03a2894606a571b37f440da36f@huawei.com>

On Wed, Oct 23, 2024 at 04:04:05PM +0000, Shiju Jose wrote:
> >Why do you need a separate "enable" flag?
> >
> >Why can't it be: "writing into "addr" starts the on-demand scrubbing"?
> If  'enable' attribute is removed , then there is an ordering with setting address + size.

No, there won't be. You clarify the ordering and if someone doesn't adhere to
it, you check for 0 values and return.

> Also user space can't check whether scrubbing is enabled or not.

That one is semi-valid. You can set addr to 0 when scrubbing is done but then
userspace might wanna know which address it scrubbed.

> >What are those three good for and why are they exposed?
> Scrub has an overhead when running and that may want to be reduced by
> just taking longer to do it. 
> Min and max scrub cycle duration returns the range of scrub rate
> supported by the device.

This *definitely* needs to be part of the documentation explaining the API.

> >I think fail. What is a scrub feature good for if it doesn't have ops?
> Here continue to check any other feature (for eg. ECS, memory repair or another scrub instance) listed
> by the parent device in the ras_features[].   

Why would you tolerate a semi-broken feature?

This is all open source code. People will fix it when they test their feature
which is missing ops. There's no point in allowing any of that.

Btw, do me a favor, pls, and trim your mails when you reply just like I do.
You don't want to leave text quoted to which you are not replying to.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

