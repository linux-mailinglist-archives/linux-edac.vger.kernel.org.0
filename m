Return-Path: <linux-edac+bounces-4799-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7313EB5509F
	for <lists+linux-edac@lfdr.de>; Fri, 12 Sep 2025 16:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3217C85DB
	for <lists+linux-edac@lfdr.de>; Fri, 12 Sep 2025 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B411F30FF3F;
	Fri, 12 Sep 2025 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="W250Hofs"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A802F4A;
	Fri, 12 Sep 2025 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686373; cv=none; b=dUi9nGUiuiVg0UsAE0QF0rYBi+wD5aOdKbDo+3Mb7JHw7s24Is6wbHQOCpvo2NakkIC4bYoIv/BRzQlxF+a6wgglbMnu/d0CEtfzcABfTKB4VFcyLYtUUA9uaByNrauecHWKm8xBNLLrZPSz4UC5CgpUTc4kdewkMJizo15PQnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686373; c=relaxed/simple;
	bh=T8cKU7GX1nkbL2NcsD+XuaY1d1XDFVWZOQimj/0jD0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeWexej/U3EsToHVTDkRQkahdREz/pCnN6MrchPqfiO7tIrpPmRNgSjgDvUS+0GkZJ4cZghAhOvwBZomNj3HXC5jIL78JIIflytXXFUusZcj3vixv9I2Ke4ZDP+Uh2iZCLJEDsMCEnX7o382/W1rg33TSZDAvngLZJTn6MxOSEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=W250Hofs; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D0F8B40E015C;
	Fri, 12 Sep 2025 14:12:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ctliiuI1qv13; Fri, 12 Sep 2025 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757686358; bh=tkZAXzfE56Ye+65KcJu3D+78RmJwSGKf5LKjnICPk0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W250Hofs3CAu2xKR7YwCa+iuLV0a0Hass4IjlijRdWxTDhiQQrX5MMxcjFX/Muc19
	 L1D9c9Lb04ZjcZf2KbXFQiyCtAZkXdrAvGqG3NsN38YXvViWfFhq3P0qTKJhMAoDtQ
	 6UGaVchmykQilTK2/QSbuXaV+EiXymkTV0TZvEiQmPcJ9I0YHSQejDJXCwfIbEj6Vm
	 G82J1yDYKg8aVzqOuciVXFDjtRzsZBjG214DEdiy5w4HRkaQgpbr9bqur9Dn4iIy+G
	 kUEKLKzCNYgwDfBobGKajNUoiHCg1W0aYCKRpRyJgrKkrptRO3UAkR+8VAi2i/X4dd
	 OJiTh87FPlwX5ZYud/PEw6fK/bMAFObYM9H8+6ZA0bJgAWhCCE7E2K5ZeCBch71PJ7
	 ec3fzVkjxAt1hg8ejNy+olL5CCuC7iTcNROQynBJNScdIV1SUCJWANA9rP0ZqSoeV0
	 fQ4ChX9Ohn7lYM7tj7Csy7+36rXAEKPCnTft1D/juHMPjpnN3GuSelzM6eN2ldRDPQ
	 10q3tNaz2HGvwBOzQHWUWiiR7DrqZPQL7a9bJUMlBSqtM/i2yS/ATc4iyOplB8BAiX
	 cGCC0JD2nAMdgH2VtFBFe971EdKWqTPbJYopr/QR5spgvae29gJxJ+ZXY3XQCRzdvH
	 Hd5DDtPIhAX+N27TiOyX93NY=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C653340E0140;
	Fri, 12 Sep 2025 14:12:01 +0000 (UTC)
Date: Fri, 12 Sep 2025 16:11:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Linuxarm <linuxarm@huawei.com>,
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
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>
Subject: Re: [PATCH v12 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Message-ID: <20250912141155.GAaMQqK4vS8zHd1z4_@fat_crate.local>
References: <20250902173043.1796-1-shiju.jose@huawei.com>
 <20250902173043.1796-2-shiju.jose@huawei.com>
 <20250910192707.GAaMHRCxWx37XitN3t@fat_crate.local>
 <9dd5e9d8e9b04a93bd4d882ef5d8b63e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9dd5e9d8e9b04a93bd4d882ef5d8b63e@huawei.com>

On Fri, Sep 12, 2025 at 12:04:57PM +0000, Shiju Jose wrote:
> >Why is this requirement here?
> The physical memory address range retrieved here for the NUMA domain is used in the subsequent
> patch  [PATCH v12 2/2] ras: mem: Add memory ACPI RAS2 driver,
> 1. to set Requested Address Range(INPUT) field of Table 5.87: Parameter Block Structure for PATROL_SCRUB
> when send GET_PATROL_PARAMETERS command to the firmware, to get scrub parameters, running status,
> current scrub rate etc.
> 2. for the validity check of the user requested memory address range to scrub. 

Again, why does it have to be *lowest* and *contiguous*?

Your answer doesn't explain that.

> Also intended to expose this supported memory address range to the
> userspace via EDAC scrub control interface, though it is not present now.

Why? To tie ourselves with even more user ABI?!

There better be a good reason and not a better design for what this is trying
to do.

> >What happens with the aux devices you created successfully here? Unwind?
> Please see the previous discussions on this were about allowing the successfully created
> auxiliary devices to exist.
> https://lore.kernel.org/all/20250415210504.GA854098@yaz-khff2.amd.com/

There's no discussion here. And nothing answers the question "why" this is ok
to do this way.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

