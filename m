Return-Path: <linux-edac+bounces-1866-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7744978282
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2024 16:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02C31C21FE8
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2024 14:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11D7B67D;
	Fri, 13 Sep 2024 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iUT1lUGu"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4821EFBF0;
	Fri, 13 Sep 2024 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726237647; cv=none; b=jyWNaxFyvfTTRs3KQG1COE8s27I4I0Q5VUjkJ3rW3o8X66ZXLpxkp5gxTvLMG83zbvQAJ3R0auNT5BB5aFDTi6OnhRFm/73hnZuIdNj5PTr6/p5chdpeDg4Opm4pTcIn7Fzvs3Mrm5AfsjOhuw9Xexy9yynawJ0LrUUzC28Jk+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726237647; c=relaxed/simple;
	bh=6YJng5POzD1gvRsE/jSitVUa26RSJ5LRyxym99UVP1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMEkOEXKdCKfDJiOIwLIf7oEsczfnB76lfz257nER8oVPZenKB+49uIkEFJcKUDQu4wnJLGNgJ66NXE79Pb/UbpCYS5fnZiC5G2gieaxacXHMkwffAHCAhxSWys2onQOiVU6XtZzP8NJphDs2KRt6issz3UkOGdiwOGdu3ul/pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iUT1lUGu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E487440E0288;
	Fri, 13 Sep 2024 14:27:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AZfXSgy-gsTi; Fri, 13 Sep 2024 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1726237637; bh=C1xCLu7HR+yDL1dkU0s9zDI2p/3nBVzqyUkWE85QHhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUT1lUGu0Q2AGf7/O/DSvF40ULajh/Qd6QDGDc49FKoEhQhovja3OBUVl1Pi2GO30
	 QsZtU2248VNppWcuGUxktxsZcujtLZORazymMzKtvEofOw6VD8uuYsOQByRr9C4LgY
	 X9II2AVLbbudYiAuxn4Ne2GDDs586O3wxpvVIdOvXOAPQjDdVC0v1EytP3AZjbwOMx
	 y2vlzybN4KmbR4ZpKHmJCeV7DJcoR/eK/KWMiMeQBJVUF+AeqtA1tgXyy4KuhxY3CG
	 qpIbl9LTDdFC/ftk0tZA5WOjIICqhbOnVDVvrNhHO1fBnwy+UPEqMJfudG5uRbjPb4
	 xRoUAEHojK1PzR93utF3utlw0gE8sGSOaLW7qMZ5iarW1MDS5RM48t6Vxej40/rRes
	 dCteka/vS6uPk2tVfHyyxTNpF1r8kcQ789DFYsO+EvP+00Q94dF2+CwWJf6KgIwntK
	 TGOtJa3ShQihD2WgjQjckGcCm3Hv4i4IN6EBuuRjr8WiPqaibMEMcGuAyAJL6hKvrW
	 tPVzjKwFIlJmmpz+ElJGLeIUmdEC+A2lK2KQMogCwhOQ/JLjlBTkNOU4oU5GUumAWi
	 oOcgYwcEEDR5szpkNlkz3gqpv4uLN1o1/xJL3GgZeNJJwEmDZSe1puqu17SPfrQ1Z1
	 gAbxvdpdIKKkbRKEl6OUNkro=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ADB4F40E0198;
	Fri, 13 Sep 2024 14:27:04 +0000 (UTC)
Date: Fri, 13 Sep 2024 16:27:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: Re: [PATCH v1 1/3] x86/mce: Add centaur vendor to support Zhaoxin MCA
Message-ID: <20240913142703.GIZuRLt1-nDZrOsIlE@fat_crate.local>
References: <20240909104349.3349-1-TonyWWang-oc@zhaoxin.com>
 <20240909104349.3349-2-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240909104349.3349-2-TonyWWang-oc@zhaoxin.com>

On Mon, Sep 09, 2024 at 06:43:47PM +0800, Tony W Wang-oc wrote:
> @@ -1970,6 +1974,18 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
>  		}
>  	}
>  
> +	if (c->x86_vendor == X86_VENDOR_CENTAUR) {
> +		/*
> +		 * All newer Centaur CPUs support MCE broadcasting. Enable
> +		 * synchronization with a one second timeout.
> +		 */
> +		if ((c->x86 == 6 && c->x86_model == 0xf && c->x86_stepping >= 0xe) ||
> +		     c->x86 > 6) {
> +			if (cfg->monarch_timeout < 0)
> +				cfg->monarch_timeout = USEC_PER_SEC;
> +		}
> +	}

So if centaur == zhaoxin, why aren't you moving this hunk to
mce_zhaoxin_feature_init() instead?


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

