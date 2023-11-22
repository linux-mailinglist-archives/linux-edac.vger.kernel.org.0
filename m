Return-Path: <linux-edac+bounces-73-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 238487F4F76
	for <lists+linux-edac@lfdr.de>; Wed, 22 Nov 2023 19:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B81AEB20CBE
	for <lists+linux-edac@lfdr.de>; Wed, 22 Nov 2023 18:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3DD5D49D;
	Wed, 22 Nov 2023 18:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fP9jg+Jx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A96A101;
	Wed, 22 Nov 2023 10:25:10 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8472940E0258;
	Wed, 22 Nov 2023 18:25:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YgiYJuUjdv3l; Wed, 22 Nov 2023 18:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1700677506; bh=lqA5qVf9Mh3ghu+RQuFFADLB1EH+r3K5c+kuLOH/DB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fP9jg+JxNMXFB3FRiupIkDq9j0Re060w0g+5MobWmzPFc6kTOBt3rkemMvTtXC32U
	 tZS45HdPeONct59wSXV6x88Dkub02kcxT5vk0VXnmJMmnL06O2n/liHsWN93QzbL/g
	 YJj8pOfHvpOg1bfzl5x/WOO01q0Fz9gaGMyhWdJanveLsP8zzujClcsO+HrHBGMvBP
	 Og6OUEN0FKc2khtNltzok2vg4SaT3s2J1siJ17hJeI0WqZlrGM2g8XdjEpnnLybJmq
	 jZOx7IgWm3hf6Cl1D2bi3tmzrM7LuPyyHl7PVw3x7KJhyn/2XDkt0j60kS2EQ1NlEu
	 ZIeQI4eViSyJys3b56s+cMRgpmoHV0GXRzI6G8lqGy56k6f8EhgyfLUDPeyW7P6bEz
	 msYqhLLcDnhpUGrXpf9yxltWkbgqn8VAliHC+ft1PMTT3Z5UiE2ezeVySkb6p4K6jJ
	 hkpQmS+M8oVQh4D6N64QdPZK910hb24YvOUrxmBD+1zOZXHWdxu7R5db+6i2788v1K
	 Vi9eCp3CcxFo2qUGvKLk/wvmAo3l/XkRIb77MgoPTwpE4Fz6k+h+Hv5VNeS+R9IF0/
	 IvMb9rzyVdW/myY8ckf67k7TwJx0s51c3BZaqpIMrb85KMH8i8/LQFgy+1OP6W1Wur
	 PzfjGMdgGMwxfchDdGtAsiv0=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9691A40E0259;
	Wed, 22 Nov 2023 18:24:57 +0000 (UTC)
Date: Wed, 22 Nov 2023 19:24:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, Avadhut.Naik@amd.com,
	Smita.KoralahalliChannabasappa@amd.com,
	amd-gfx@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 02/20] x86/mce: Define mce_setup() helpers for global and
 per-CPU fields
Message-ID: <20231122182451.GHZV5Hc/49OYomyejc@fat_crate.local>
References: <20231118193248.1296798-1-yazen.ghannam@amd.com>
 <20231118193248.1296798-3-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231118193248.1296798-3-yazen.ghannam@amd.com>

On Sat, Nov 18, 2023 at 01:32:30PM -0600, Yazen Ghannam wrote:
> +void mce_setup_global(struct mce *m)

We usually call those things "common":

mce_setup_common().

> +{
> +	memset(m, 0, sizeof(struct mce));
> +
> +	m->cpuid	= cpuid_eax(1);
> +	m->cpuvendor	= boot_cpu_data.x86_vendor;
> +	m->mcgcap	= __rdmsr(MSR_IA32_MCG_CAP);
> +	/* need the internal __ version to avoid deadlocks */
> +	m->time		= __ktime_get_real_seconds();
> +}
> +
> +void mce_setup_per_cpu(struct mce *m)

And call this

	mce_setup_for_cpu(unsigned int cpu, struct mce *m);

so that it doesn't look like some per_cpu helper.

And yes, you should supply the CPU number as an argument. Because
otherwise, when you look at your next change:


+       mce_setup_global(&m);
+       m.cpu = m.extcpu = cpu;
+       mce_setup_per_cpu(&m);

This contains the "hidden" requirement that m.extcpu happens *always*
*before* the mce_setup_per_cpu() call and that is flaky and error prone.

So make that:

	mce_setup_common(&m);
	mce_setup_for_cpu(m.extcpu, &m);

and do m.cpu = m.extcpu = cpu inside the second function.

And then it JustWorks(tm) and you can't "forget" assigning m.extcpu and
there's no subtlety.

Ok?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

