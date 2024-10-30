Return-Path: <linux-edac+bounces-2359-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DE39B698C
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 17:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87682281BD7
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 16:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01EB215012;
	Wed, 30 Oct 2024 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Uzd895sY"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAF62144A4;
	Wed, 30 Oct 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307024; cv=none; b=JirrXh8vIdfsY1RU2vFWUUcGXBZU+g0GR0gVhw80s7PgXJVccvsYRDWZnKjiX03jdFsEiLAyzZTtjydT2ysQn60G0iQoObEEGjFfwK3pn980lHAfvSkcGq4wcasTx6ovSb99U1XmbUKJikc6ze+qyu8u5zT8c6YwE7u4i/vl7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307024; c=relaxed/simple;
	bh=i+riZExPC4Bzx82/6vEcQbpgyzoXnl5tP4Zu38hTmx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fqq4XZelCAHoOp9jekaO4UuMPlO6p6YYz04oTFwHZ7YebOku/rkQoIGFjv6i4JzM/8QtWN+sYmfpA8YsQiYposzuy6O9sGOe7Wan1QoGXgPe2Yzm7+PenwTS5QJ6841yb1cbXFkMthzbaT6I4psuRaBopsdaIcMcB1inpqYwSBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Uzd895sY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2E01B40E0208;
	Wed, 30 Oct 2024 16:50:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TtMLYRbXGK7z; Wed, 30 Oct 2024 16:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730307016; bh=kse0K2kJU6T6AL0bA4i1n8JgYNPNQBVrO2byuZlpEfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uzd895sYaEdC8s/Qr1FnPhTtqFdXd/m6WnpULp99sf+L5wIEfrcVNRPVJ2H3qfxz3
	 nMg6dI1Z0bD2+4N+5rF7YT4BR0mP8j3OhI94bMgo2AmsNG7u6egZXX8mGvKmku1+HT
	 7yNnKN9PG4csud82Dl6MJDgzqJLwuAKgcA2+5RnDNFx/uzXtfmJQ+mJXQ4XNTgeR8+
	 bPH1M3G43T+QHRHK8QEekRi/H7V0nJyMOkT22ljQknSGj5q1wBvs+JHXU8ix0mOU4y
	 YD84CigugNXHvkHO1Xz6PrHnCKoR+QeguRcPp9MMseLPcEr0TUR6YTEFQxCmS+QTvw
	 7iZBPgZbdB//KG2RhSMorKLmvSFvmoFssf6dJaxpCFFkxPqlXP0CeXkY0a9smBmo8D
	 wuTYN/qXDpZSbYvZUS3GwPnvGU7nNTB/dMXnSsOyJHPmiVAZcSZODzxehH0/AHMRPY
	 3u0oOISMIxCR9ROMlSziRrX81CauTdqgEQYFNtFeFgQk/NP4EuX5QnfpoLavvQCNld
	 HbDs/lcOEa+DX/D7JpcRnBhjQTxcwyhHxK91hfiQY40aDSx2LprrA1+vJf0qe199LL
	 PCPe5oa2vUf28Iu4l/4Cw2JRVnD6N8uIgRJr9aoDO4IqtB/xbK/9cpdbA+fHrNBZxi
	 M9tTJoLnKuPSzKboNKijW6gg=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5057640E0191;
	Wed, 30 Oct 2024 16:50:03 +0000 (UTC)
Date: Wed, 30 Oct 2024 17:50:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Avadhut Naik <avadhut.naik@amd.com>, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	qiuxu.zhuo@intel.com, tglx@linutronix.de, mingo@redhat.com,
	rostedt@goodmis.org, mchehab@kernel.org, john.allen@amd.com
Subject: Re: [PATCH v7 5/5] EDAC/mce_amd: Add support for FRU Text in MCA
Message-ID: <20241030165002.GFZyJjuifxBLUDKyL6@fat_crate.local>
References: <20241022194158.110073-1-avadhut.naik@amd.com>
 <20241022194158.110073-6-avadhut.naik@amd.com>
 <20241030161550.GFZyJbthMO_2Wxe3bV@fat_crate.local>
 <20241030163147.GA1379143@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241030163147.GA1379143@yaz-khff2.amd.com>

On Wed, Oct 30, 2024 at 12:31:47PM -0400, Yazen Ghannam wrote:
> The entire struct mce_hw_err gets exposed through the mce tracepoint in
> patch 3 of this set.

Bah, crap. Lemme go back and take a second stab at this.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

