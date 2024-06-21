Return-Path: <linux-edac+bounces-1336-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0096F912BFD
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2024 18:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319B81C214CB
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2024 16:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B83160865;
	Fri, 21 Jun 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TkTSgJpZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8855DDDC4;
	Fri, 21 Jun 2024 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989129; cv=none; b=stOGKYPnqE1QMJ7ackWm0RkZqYF7ylSPC0ZoHUGjLZ9eOLdzHNHjFu+RQZfG3FycsjTrRfF1sIkF9l7JMgbx+R9uFcBFUuPCD5dvN0koVZx3+8TS4JZ0gHCOOxwsQ9klf90/WW3iQ+hHw7mYpDNHCkE8rIGGU06CGV4akoL8o7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989129; c=relaxed/simple;
	bh=BelYWAGbMn4jpSekV3NProDOBKu/yC+Hvmtq4elyLnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpiUZ0sOUgOVBDeyIT1DS+hFCsjw+gX5f86j72dHQpFkHYwNS8pnof3r3/wtpxE51vTAkWMy2wBVIupx69Hsronc3aSbq+cVRTOkGALMGy98fmV1z6deVWt8uhdZRJKDtODwUUfr0UgRdJ+UQekUlIR7qWhZZRivAHfwsdfLj2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TkTSgJpZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 465E940E01F9;
	Fri, 21 Jun 2024 16:58:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TM-OOgscWArZ; Fri, 21 Jun 2024 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718989122; bh=XpompesGEa9CpbxVGr5wphiZrAV9WGI7UwouSa3Si0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TkTSgJpZQTP6pKW9IlD4oIyo4R1nADDX+IScZd1+FhZ03+q2Td3Hiz0Cv1NPIDGwt
	 ONY4rZBy3hRdklza5yUwOwpAAhLGViU6BotKskrGYkcvEfIIiGWV0SMpn6FlolzNqe
	 A/VlX0nCfWhHZL8o5s50sG1/aobpkBJKB/k2rK1d/YplmCdQ2/M+WYnZ2NrtvGY69U
	 yzKABfZ+8CoUB3RUY/WHbTIp6QpB8zBcVbzpYsLTHkmLgW85FnqxyY6yZkuwe1vFHl
	 EFSHmghg/h0snZu1Yeqzr+/gwFzDrO++eUiVoqbJaY3QSbkXQsVQZNerONcE5S7Jpc
	 aQ9ZbSCR06yveceRP//B07yjuxUzgXD74CFw+ViZ0rl5MOQCuQX0Q8lehPoPCwv6Y+
	 8PIEMG19n3fNU+objFgbtcE5WIdgTa2djdA5irBn1Al4fC5kM8OVF8cAb5endqAdoO
	 jFftGpbH3XwRNs2fAqKn0cBm/l/fkykXte7zleEsWreOsXsoHpDDgc+/r5g91N2mWo
	 Q7BPugQrT7hDuTEFYZwtyROGqByWVvTHdamMHU9LfrwKrLJUW0EE5g6p25Pu+8qePa
	 FWr0NMkPSnEbOo3xeIIbIfFcsQ0hJooTvFtuyHbo6i0MMb+pJr3Tq8+dLJRbN29ldF
	 gWJFLLWIeshRzzASQKuTTPkE=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 00DA440E01A5;
	Fri, 21 Jun 2024 16:58:23 +0000 (UTC)
Date: Fri, 21 Jun 2024 18:58:23 +0200
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: x86@kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	rafael@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	rostedt@goodmis.org, lenb@kernel.org, mchehab@kernel.org,
	james.morse@arm.com, airlied@gmail.com, yazen.ghannam@amd.com,
	john.allen@amd.com, avadnaik@amd.com
Subject: Re: [PATCH 0/4] MCE wrapper and support for new SMCA syndrome MSRs
Message-ID: <20240621165823.GJZnWxLxd9BVhQDBUU@fat_crate.local>
References: <20240530211620.1829453-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240530211620.1829453-1-avadhut.naik@amd.com>

On Thu, May 30, 2024 at 04:16:16PM -0500, Avadhut Naik wrote:
>  arch/x86/include/asm/mce.h              |  20 ++-
>  arch/x86/kernel/cpu/mce/apei.c          | 111 ++++++++++----
>  arch/x86/kernel/cpu/mce/core.c          | 191 ++++++++++++++----------
>  arch/x86/kernel/cpu/mce/dev-mcelog.c    |   2 +-
>  arch/x86/kernel/cpu/mce/genpool.c       |  20 +--
>  arch/x86/kernel/cpu/mce/inject.c        |   4 +-
>  arch/x86/kernel/cpu/mce/internal.h      |   4 +-
>  drivers/acpi/acpi_extlog.c              |   2 +-
>  drivers/acpi/nfit/mce.c                 |   2 +-
>  drivers/edac/i7core_edac.c              |   2 +-
>  drivers/edac/igen6_edac.c               |   2 +-
>  drivers/edac/mce_amd.c                  |  27 +++-
>  drivers/edac/pnd2_edac.c                |   2 +-
>  drivers/edac/sb_edac.c                  |   2 +-
>  drivers/edac/skx_common.c               |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   2 +-
>  drivers/ras/amd/fmpm.c                  |   2 +-
>  drivers/ras/cec.c                       |   2 +-
>  include/trace/events/mce.h              |  51 ++++---
>  19 files changed, 286 insertions(+), 164 deletions(-)

This doesn't apply anymore - please redo this ontop of the latest tip/master.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

