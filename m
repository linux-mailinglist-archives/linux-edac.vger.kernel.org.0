Return-Path: <linux-edac+bounces-2780-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1C7A00E68
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2025 20:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D3B164865
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2025 19:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EC51FC0F7;
	Fri,  3 Jan 2025 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WuKyYhmd"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1D61A8F80;
	Fri,  3 Jan 2025 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735932421; cv=none; b=qMbS7ShixDXAy58otj35lx0QFAMJFEZKPPT9h5eqw8DcC3MU0thZqudPDEZcH5gXYPq45LtkqGJssKi+rCApNqtXV6ueCg75gjJ+RGeXwLx6VZvb/Aqoqc6xgAwU8xy1HY5N1j1R5CPaLqQXxas98LrZYTZRSN2zM95emEX9zBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735932421; c=relaxed/simple;
	bh=oIGgIQFAXIH3zJEQyZ7quXBCeVlGsl9tGWiwODfLzm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJOCI856rJfCsuj7QUxyRIpQOT8vJzAQAGovYNLbRtbkdypqVR9st61OnSPD29J+9Yz0Aeq9uUd5oXNur/mSa1DxycJ2W0eeQ8EPDBQoPMwx8Bh7NN5lIJjahBqO16t0U2K4UOlQBUa0Z2diixQvm05zAefHFsay7Tch0YrqiKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WuKyYhmd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E5B2F40E015F;
	Fri,  3 Jan 2025 19:26:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0VU4e0Rq0pAY; Fri,  3 Jan 2025 19:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1735932412; bh=X5SqtYoMG+jfkAQPJEE8Hcpq4PLdUqKKuvK3Mg4GprY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WuKyYhmd14NTA0M8eyVsq5guNkp+3pQJdMFsPccZIags7qlwDSnwPxhw7vbc1SFYo
	 yUd+oXmSKoN/J27FUxn4Ht+r8R7HcCvK42VxeuAL8xpFkizbZB1ODvpHkhuXS4hi+d
	 Qy7vkABVFkgIQ48dBfD9rksw/5bC9E7QedSEMk2FNCBGW0mV5MuSspYnIqdJLKT1vX
	 f/X1dU3uG4BjQ2kz8gJs1/JBAbiRzMDkpufWjeOBAPCcdDq5ew6otUd2LDC91hpeKn
	 L/59T5gkEtMPu38zsGo8v2VSuMv072JBBppwaV6tfe9FE37JXLABrFwrJ5F9eq2KEo
	 CYYy08VdfCXQjnOczpjAyvkqsLhpGMqMncQYlIdfIxXymtpCXUd/iGgIrPN4mwHM9l
	 s/EgEqkz/92E2WpIhL4SWq/IJBttwDTRpLmf1EKXh93oAnoWT7Lu3AfXxGQtdjOIQ0
	 AaQgjTTebe+gasthtrX4QpO2H/Y1AYh0V4LdIuUvGVWHLfihrLrsqBqMHXxHul7hMB
	 stIYR/notJ4BCWirP9nMSLrQE8Iq/jg/WNGTWQ4cgSH+6l8rIGyPqWI71cMB7b07FN
	 1ZSn/F9jO8rDPhRfkN1z9ERY0lD9/7VI/EspUScuVjE6xjvWV67sWKwg4U4OQaFI4F
	 qrJ1IYMQdeLPt4RCZ0+HzIeE=
Received: from zn.tnic (p200300Ea971F93Ba329c23ffFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93ba:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 850B040E01C5;
	Fri,  3 Jan 2025 19:26:08 +0000 (UTC)
Date: Fri, 3 Jan 2025 20:26:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
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
Subject: Re: [PATCH v17 00/18] EDAC: Scrub: introduce generic EDAC RAS
 control feature driver + CXL/ACPI-RAS2 drivers
Message-ID: <20250103192601.GHZ3g5ydu1d8oKl6HJ@fat_crate.local>
References: <20241122180416.1932-1-shiju.jose@huawei.com>
 <20250103114109.GAZ3fM1dEsyBSn9lWA@fat_crate.local>
 <20250103130213.00006abd@huawei.com>
 <c89765ef-1243-445a-bc4a-db88fb5b9377@intel.com>
 <747cb4c966604aaf84f6b9f2d54df02c@huawei.com>
 <216de8e0176441e29a656865fc31d336@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <216de8e0176441e29a656865fc31d336@huawei.com>

On Fri, Jan 03, 2025 at 07:17:13PM +0000, Shiju Jose wrote:
> Please find updated and reordered patches in
> https://github.com/shijujose4/linux/tree/edac-enhancement-ras-features_v18
> Please note that EDAC patches are the same as in v17 other than updated, the kernel version
> to 6.14 in the documentation.

If you want patches applied, you send them as mails to the mailing list. Not
some branch on github. Unless I should take the v17 stuff...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

