Return-Path: <linux-edac+bounces-1641-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6DE94DBF1
	for <lists+linux-edac@lfdr.de>; Sat, 10 Aug 2024 11:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD131F21D09
	for <lists+linux-edac@lfdr.de>; Sat, 10 Aug 2024 09:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4276314C586;
	Sat, 10 Aug 2024 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="C7uXh3oI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE43F4436E
	for <linux-edac@vger.kernel.org>; Sat, 10 Aug 2024 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723281864; cv=none; b=C29cl6rUSjTvJk/0OkyIxQaPvT0szsnKOEIRqx/O8P/r3/G7RlsetN0ihYQLF0Cslk3ACT2rrEcK5ngV9nBXCBrvdeidBoPwiZwVKRUMewV+UsdZ0phOKKQ0gUZmUBL4brGBn/mbMsd57vpBDOx/cyUPkayo3CIXNqH3Yt1X5LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723281864; c=relaxed/simple;
	bh=p6ynztmWrHoZOLhfJB0gK7RD0fUlEd+yfWBccP+pa5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odOebZXm/my8v3s5sxkL0YQOlBIHrQ1NzSVuthtbtwCIhfwdwgpdc+BZUWj2/30Qj3DvEjnqExgYp53dwKG/j9ekeEbzT8/KygCJO9JAdV+Ao0gRsNvoHmlLC4QL+0nQNdEi9y/XJ3soAcZd05Knd6wCkE2PrVvnSJ2srI+Ujug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=C7uXh3oI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5670740E0269;
	Sat, 10 Aug 2024 09:24:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IXuQ6i0a39BC; Sat, 10 Aug 2024 09:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1723281855; bh=i0Ti64cL59inM0Kf6cJNjZxHhxdNSwj2+mzo6QRAot0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C7uXh3oIyU4A6mV+xLzLvptbwZe8mmgK/QEApVAWKkHgonkF+AlwaEvLKIn6yP8U/
	 jw4JK6dLCGLdW3Ge91/bX0Y2PnNsQL0BE/+ezHGnWkMZVNBPoNJaRzIcwcvJCmGEm4
	 P/IcO50x5+1aACTqaoV20fZIEzKcEx9dDEL148LwOPTsy58DPzhBxtQS9JXm0GY+m+
	 JKxbrY6QOA6pTk6qdoJJEa/c2bd7N7+6Z8D17hC3oNSrU0fVo4tvf7dwfQBSXwxrfw
	 qXkVh4eEqFIYhUWSBTqGdCcSooo1zwFsmP457UP/Jj7rHsODLD2bHSL16XNodf4eBj
	 rxDRqUqeFRta1IZ7gy15mcnQNvUmumikiQlby5nTk6UWXe8+ttesp2Q9soPzfGfhYP
	 ea5xdlzMipxDGBzlcJXvKNzWzRJc0bLIhbhJKhihlLEbNCZworVR96GwkUNACOCwCF
	 M8HnCWTxFObVkkOVf8fyu6lkB9VG7zeOtcqITuL3ozsiPcmpJ5GXQbufIVxqvucK4y
	 SHB0V9Mlyz2NcXPAmUaRnnmEDliRAfN508dT7NnN/vXNoxuYjjiIs7M/wGfDD9yvt0
	 fYcNiXAWH0qJUjz5qrfU0qPfFFLGzkQ3rw8Zm8v3xJr0wYecxD/ZFBpV3VUdCEw+AO
	 GwL7+n+jYoX8oFkchgnk1qzA=
Received: from nazgul.tnic (unknown [87.120.165.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 14C3040E0263;
	Sat, 10 Aug 2024 09:24:09 +0000 (UTC)
Date: Sat, 10 Aug 2024 11:25:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Eric Biederman <ebiederm@xmission.com>,
	"x86@kernel.org" <x86@kernel.org>, Tony <tony.luck@intel.com>
Subject: Re: [RESEND][PATCH 1/3] x86: Add task_struct flag to force SIGBUS on
 MCE
Message-ID: <20240810092454.GAZrcx5kZ8mNkpa-io@fat_crate.local>
References: <6273D749-9CEC-45E4-8C56-FA3A1DBE1137@alien8.de>
 <SA1PR11MB69926BFE8EFDA7B3C3D84560E7B82@SA1PR11MB6992.namprd11.prod.outlook.com>
 <CAOq732KXwsKdht55E-Z18choiAYn6dMpXc-TD15B7MOUH1fpxQ@mail.gmail.com>
 <20240808145331.GAZrTb60FX_I3p0Ukx@fat_crate.local>
 <CAOq732JV+zcCqgqTbAtVdE+7jYuen2ioG+F+3i5yaBd7Aj8ANA@mail.gmail.com>
 <20240809083229.GAZrXUHfjgVcHSZPsb@fat_crate.local>
 <SA1PR11MB69927AE28B46583DCB5C97DEE7BA2@SA1PR11MB6992.namprd11.prod.outlook.com>
 <CAOq732KnHFo3VaRH9V-x0k5m=h1jyNrdtKj4quG8Yaq7wPQjKg@mail.gmail.com>
 <20240810032134.GAZrbcvpn_cYzFdEwB@fat_crate.local>
 <CAOq732Ly1r06VedTa2EMb8o_L0+QMgJaVCHdEJFXVs5z7OVRBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOq732Ly1r06VedTa2EMb8o_L0+QMgJaVCHdEJFXVs5z7OVRBg@mail.gmail.com>

So,

to sum up the thread here:

1. Arguably, tasks which have encountered a memory error should get sent
   a SIGBUS.

2. if a valid use case appears, the proper fix should be not to sprinkle
   special-handling code in random syscalls in a whack-a-mole fashion
   but to note somewhere in the task struct that the task has
   encountered a memory error and then *override* the signal it gets
   sent to it with a SIGBUS one.

   I.e., this should be a generic solution, if anything.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

