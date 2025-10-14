Return-Path: <linux-edac+bounces-5048-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C621BDADAE
	for <lists+linux-edac@lfdr.de>; Tue, 14 Oct 2025 19:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BEBD5807DE
	for <lists+linux-edac@lfdr.de>; Tue, 14 Oct 2025 17:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB27307492;
	Tue, 14 Oct 2025 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WQEy0Trj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C436304BD5;
	Tue, 14 Oct 2025 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464380; cv=none; b=aOyhD4cMzLPQkSLWFCcJCGz+61skC/Wrdglg4Hl/JIruaDEEpznm3w3j1mjQKCT5wxkbOruZbBYuRkPfn2Tf20TzQmyyy5WNunRuL3uM6pc71NkwWqoJB4N8JCn7qgNwfTtaxe6pMz3NR3mdDOo4jw+VGv9/RRWeDrulcjdagyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464380; c=relaxed/simple;
	bh=kexxsKahBXX+ujeGmTQYh71gVLh57G05sz5dgwnzyQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRNkoVPVXJJbpowAkRsY5YiVZx69dCFAPMhDQaYf8UHAP2iqmL7hWgmEP3Jrq3yjwxJfRghVZnxabf9FPk0uZW7y7l69EEVhpaPhldPqIgeT0umZgvNfFwOLaALyX3TnIK5gDGpvJmXX4MRqdXiDRuVVVzMHVLE6F0UzeY+bVGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WQEy0Trj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1910840E019F;
	Tue, 14 Oct 2025 17:52:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id E5nrVJtG0MVW; Tue, 14 Oct 2025 17:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760464370; bh=gV4lE5UFn6VJqMxc+EX/6N78lShVXPpvo+ef/MYPIf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQEy0TrjnoI3BZhHgQXUUnUlRWArLgEiogBtLs36J73jLN8i+mCZIikW4Yw+1W9SG
	 7GTcokMB9G3dvJinVdI5BvPxehC2ZUjH0a4TDV8ud7yJpBCN96gq/HuJF1M2dgg+HQ
	 sFm3fEN1ATnE7L+lG5Naqm6hokqo5wDe3FuB8KRUKY6KnW3iBPKway55xp7DOiSi/b
	 eoVEU+7ECbB1QwTn2k4N3wP3Jkddzehq8s4btsTTVsRpGKeA1X8l2w4VEMebg4Bjsp
	 aXtNQ95a5+bZAaodqoGDeRdPirES0SqZsKavgINNY/OyJdNYBWLtynaqOOv9H/sNEM
	 MrYThWOVvvV+YM6ABUI2lmz1/vxsEaTTavjDPyTuPngEnc9JpT4w6+7O7jPXU9mr59
	 aj7F55Wc5uDcT0ysXOJcbe/VZZxQJqVvJQmRhjEcYxnvsr4ukWhqynBk4pU43j9IqX
	 KaNLLZeiN8p80keJWBGWb7QV3eKZo7IpdcCc9J8PcnsBrlTQwGRvY8hLT6kpPu5L+3
	 3X8QFbC+mC+5TXbnNjCll+8l3xKWIglp/WLvvbzlR2AE18H+HhW0yUsjzfAFggp3EG
	 8+BtciHvzid5cnIdzumajiygVMVOWN2eX1xp03DKwspXZWAc9zonvK5RitACmFKzWd
	 QNILU1t9yI46YztcLSAeq7eY=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 729DF40E016D;
	Tue, 14 Oct 2025 17:52:44 +0000 (UTC)
Date: Tue, 14 Oct 2025 19:52:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
	john.allen@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Incorporate DRAM address in EDAC messages
Message-ID: <20251014175238.GIaO6N5sWpG7EReE5P@fat_crate.local>
References: <20251013193726.2221539-1-avadhut.naik@amd.com>
 <20251013220019.GFaO12cwSvbedQwGr6@fat_crate.local>
 <20251014135206.GA361227@yaz-khff2.amd.com>
 <e78b6556-24c0-469b-81d5-98380aee1f6b@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e78b6556-24c0-469b-81d5-98380aee1f6b@amd.com>

On Tue, Oct 14, 2025 at 12:13:36PM -0500, Naik, Avadhut wrote:
> > The "DRAM address" helps memory vendors analyze failures. System
> > builders want to collect this data and pass it along to the memory
> > vendors.

How real is such a use case? It sounds to me like wishful thinking and that no
one is going to use it in the end and we'll end up warming up the universe
with electrons needlessly...

> > The DRAM address is not contained in architectural data like
> > MCA info, and getting the address from MCA requires using additional
> > system-specific hardware info. It's much more reliable to get the DRAM
> > address from the system with the error rather than try to post-process
> > it later.

Ok, a bit better.

Now, why isn't that address part of the tracepoint so that system builders can
consume structured data instead of parsing scnprintf()-ed strings and trying
to guess what's there?

Also, some of the fields of TRACE_EVENT(mce_record already contain the fields
this set is adding - CS or so, for example. So there's redundancy already.

> If yes, will add this information to commit messages and resend.

When that happens, remove all text gunk which talks about what a patch does
- that should be visible from the diff.

And this is not the first time I'm saying this: folks, please stop explaining
the code.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

