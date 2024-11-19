Return-Path: <linux-edac+bounces-2562-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A559D2600
	for <lists+linux-edac@lfdr.de>; Tue, 19 Nov 2024 13:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A681F226F2
	for <lists+linux-edac@lfdr.de>; Tue, 19 Nov 2024 12:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850DD1CBA1A;
	Tue, 19 Nov 2024 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HLV69bqH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767D513B780;
	Tue, 19 Nov 2024 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019874; cv=none; b=eesP1P9F0FHrH8raYBGAPmJpF86H0Sr7MI9AfUdV+W7lmHGzAXm1cYBIlAhDxb5NxUM0b22XcILT7TZlrANoPQeCySJigG/eGy8WsJ5pD119VbfEHOrKp9oDgj5GHAk+oLijUq8VCmIccxrwmZq3Jz9okzpu2VY/Z3BC6sM/OX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019874; c=relaxed/simple;
	bh=SLn98ioub+iMNwf/pV/eo5IlGgC5pW4cy3AFahRwgdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbXZzZ0mKopzz5qfcSosZp+0J8o8NQxMTi8k6pAvyrL0gX6b11euQO+ffezjGfEE+xDjyxQKE1pBTY+wxxBS5fQUVSkUsAYHDoa6XxYMPCh5A2h+pgMBzfcPb8lOF7/TPfHGWcplW/3t5kuIdgkNsn3jAar1H01RF83NYoxylW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HLV69bqH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8D91840E0263;
	Tue, 19 Nov 2024 12:37:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EeAmpnxGTl59; Tue, 19 Nov 2024 12:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732019864; bh=9msUNrWXEC3mX7pDT4bRGAge3h56G8tJeE9EQBQ1Y5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HLV69bqHTjs9bY2eVTquOscV9cgfcrIVEM2MzDalEn89hAY4Pw/y/AizBd2/hO70O
	 Vc/+rpyhRPIbYRCJxNEilPYLKGmdkR7iqT+mxumS280SHQdnktLkaNdCHu6ANvbwhO
	 CaRmnVLR8aOlNFOkt9/X9u4tpRQ0MGd87TRi1DOJBOoYedaWoB6rZWU0/gO9Gdc78h
	 kshaJuLwxbLvNxoeEqmy1MAYLm2CSJavoHxFlFINGk4PuywN/agTbCfE3bclwWJ5/z
	 uaEJ9dcfeDX+rTli7C1CF8v8DboZGHdr2f/59KqR6PhbBJAtccnG7Hywb7+CR63oVw
	 MKrYy2tcnspENaeRjnI8SqwM7ISzSAYwDTZfc1t5ue27X5NJrXfm67tLOHMxB+RJVu
	 XMK9qx3PCAPRzb6dU7kxYbCQ/4hlWUgRRKpEF/mzwCAwarC7ktttLKKNuZp55jJ71P
	 wt31ptsnCFQrwtovGvUiqUA+dZMEF0Ro6+hciHcX9VkhnXd6nq+8Y2qfaA+NT89Nbo
	 dUheNOmBThnPQTcnhZ7KlVvvfiz8whMnXqDJE46iJysJoTPWp9rsss+lFM8lx3pWVy
	 6gRFxSpZd5p/rxr1mx+YOXkEkbVg4zOO8PJ1daG76wNL3f+nvdYdZFkF9kdRqNVhaE
	 2L6q71mhMpWwTUMO9S2HXmDs=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 04C5B40E0269;
	Tue, 19 Nov 2024 12:36:58 +0000 (UTC)
Date: Tue, 19 Nov 2024 13:36:57 +0100
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
Message-ID: <20241119123657.GCZzyGaZIExvUHPLKL@fat_crate.local>
References: <20241101091735.1465-1-shiju.jose@huawei.com>
 <20241101091735.1465-12-shiju.jose@huawei.com>
 <20241104061554.GOZyhmmo9melwI0c6q@fat_crate.local>
 <1ac30acc16ab42c98313c20c79988349@huawei.com>
 <20241111112819.GCZzHqUz1Sz-vcW09c@fat_crate.local>
 <7fd81b442ba3477787f5342e69adbb96@huawei.com>
 <20241114133249.GEZzX8ATNyc_Xw1L52@fat_crate.local>
 <fa5d6bdd08104cf1a09c4960a0f9bc46@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa5d6bdd08104cf1a09c4960a0f9bc46@huawei.com>

On Fri, Nov 15, 2024 at 12:21:16PM +0000, Shiju Jose wrote:
> >Ok, and how is the user supposed to know what those mean?
> 
> Print in  string format?, may be as 'persist'/'volatile'? 

That sounds like an abuse of sysfs (Greg?) to me and even if it were possible,
you need explanation what those strings mean.

> I am  fine with adding the support for expose the ranges of these,
> but makes more sense to do it when a driver surfaces that can do it.

So how do you envision to do it otherwise? The user is supposed to guess the
ranges?

That's not a good UI IMO.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

