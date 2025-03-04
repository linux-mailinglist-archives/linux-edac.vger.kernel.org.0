Return-Path: <linux-edac+bounces-3266-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30E9A4EE61
	for <lists+linux-edac@lfdr.de>; Tue,  4 Mar 2025 21:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127C53A938C
	for <lists+linux-edac@lfdr.de>; Tue,  4 Mar 2025 20:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5218224C063;
	Tue,  4 Mar 2025 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cTl4B5dA"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB81C8633F;
	Tue,  4 Mar 2025 20:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120286; cv=none; b=G0/01cU3MvsLX4y0TPYa3sLS8qpp69L7Rdx62daRMlOa3Oy4DTYDeWyxZ9Z5qriuQv02bMMTaTP6EdZrwLDdBdHhHmflz0h/+ZvG89OVosfUDYP9hwyR112q9MDMn+r4F/o+dPRz2XE+/naQpGK/uyJRx0XpqmrEH2BncFW8u3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120286; c=relaxed/simple;
	bh=JKKNW+RwGoZHZtO5aV5J7jh7Za+xK7f1V74u2fYud9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ruhs+BZRlQ63PJ6MZSZGmm2cv3Hh0ZJwXjBoekXxsrGx+RkIGaOigblUjtpJYGb1sSVVIURMshFeq4YGw2ogRe5rn3DKKeDDs5u99HGKPedVXrK4MBzfBA8bWmdn877Ac0CDic+WP0OccE5D/YN6H6JcsXOnoECjfKO7GV6UD2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cTl4B5dA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5F51540E015E;
	Tue,  4 Mar 2025 20:31:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id m5qk8LclUbkO; Tue,  4 Mar 2025 20:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741120274; bh=QjUL2XTBMPOMONfEVC9hR8GGbNvASEYjnpKzPJNLH3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cTl4B5dAlChiXp50cOSMXm9Ac6TNweXDosPAU2wVWtPz2QDDVTYPemlIGIPLlObVt
	 yLm4FNKxlexqfosdFx0fKrd/rnVR6fAEMaqhTlxH+MEwTHGIQV3EQDNjihTnCOrIU2
	 b20qDDlAuWX5LBlNU6wZR5oI6k5s8BuDoEc+s/QZb5QpjJyp6J5LkOGYc30rzZkwOP
	 uTb06lw3oaMCP3oBqti2fdgHjULhGuv6KiCmXTNX+AsuCULOTt/WykpoONYGTmhatm
	 oBH9D1lgRgYMlheOJSICQBkWXDJ6ftFLRH84J56D+eRMmF0PiTHBgr3UyK7zcZsyTw
	 0GjyeKRjfUcygnqhpDPqGzzi7KcQy43n8c7k3JhBhZWAFfHqhUG2SsR+fqlB/9RHdV
	 TSFk2G8fFb0xkiFLd/vaUZ4AqZgjkX4YsOIHNztP7tyWy/0L+TiUlDpPaDunSXFUjc
	 rSZkaSgucGn2/w9iuTBiRlr2m72h9qMQK2yQXTEZZyExuuOiz+LCYUi3F/E3Q/htcj
	 PKQzHPIxzL1Dj66MqTLpQGuYRiy4S47CfcxMu9NbxQj0QAgPppWN5oZjo/FiQ+FlS3
	 7/vvQl5OtAkdnv3TbbqZ32CtJD1ZV1d5GgE58jkeCiyGUK2mfFqYIDdgvEdzAEc0j/
	 PmoVkzlatGwxwy67lghP6cHU=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F4FE40E0176;
	Tue,  4 Mar 2025 20:30:32 +0000 (UTC)
Date: Tue, 4 Mar 2025 21:30:25 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
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
Subject: Re: [PATCH linux-next 0/2] ACPI: Add support for ACPI RAS2 feature
 table
Message-ID: <20250304203025.GDZ8di4fTxb0QUo8h5@fat_crate.local>
References: <20250228122752.2062-1-shiju.jose@huawei.com>
 <20250303173538.000007cd@huawei.com>
 <20250303103529.GBZ8WF8flezRahE-1h@fat_crate.local>
 <977a011b1ede4093a8e49d9cbcf49d19@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <977a011b1ede4093a8e49d9cbcf49d19@huawei.com>

On Tue, Mar 04, 2025 at 06:19:58PM +0000, Shiju Jose wrote:
> Some of these variables, for e.g. requested_address_range are not defined 
> in this patch, but in the 'include/acpi/actbl2.h'.
> My understanding is that those changes required to upstream first via
> https://github.com/acpica/acpica ?

Are you sure?

...
 * Additional ACPI Tables (2)
 *
 * These tables are not consumed directly by the ACPICA subsystem, but are
 * included here to support device drivers and the AML disassembler.
 ...

In any case, if this goes through me, I will have to review it first as it
looks funky.

Your call guys.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

