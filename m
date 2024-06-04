Return-Path: <linux-edac+bounces-1180-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7F78FB7E5
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2024 17:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A541C23C69
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2024 15:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D177714658E;
	Tue,  4 Jun 2024 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="I4u3nj8o"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEFD1805E;
	Tue,  4 Jun 2024 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516019; cv=none; b=uLa2pDSYkdA8MEuhR80CS8/ok72bru/qp8bJeDPPnm8UxucbLZsUP1fGgLVAR2KV0x7/JdWJFRvC2p3R46MDaxYMdJzkxDzfWiR084OqFUYQAo5L+ZHSCHPu5AqXEEGLWBNRbjyaj77cRU0K3a+3lpEu95WqY8E6kmtwA4STy3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516019; c=relaxed/simple;
	bh=3y21GVy1PCs2rJDaNksZMoF4iSOznqb1GnfkOIT0JAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mafliDWQd+KK0t4YvkaIy68wvCra8dgAT5X5KxzseId+hstuz3R48o/XFkG9wjCwgjJ2jrC3FzGTJnMRqiIDnBvHknWIB+XoUmjKQWGkD3rXKR6tJ/rZrMU3mYaEgtxjP5BF+kqoooKQ1DZb04OnZu8y1ed/Qnx8En42Eo8v0ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=I4u3nj8o; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9F04F40E0081;
	Tue,  4 Jun 2024 15:46:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3Ip0nACutg9K; Tue,  4 Jun 2024 15:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717516009; bh=/y9pB9+Khtr5d7gHqCNS4aSeYKsHx0WD9O7wNqsC+1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I4u3nj8oK2mRzDIAPgr6dzv5+0DlZ02Ng0q1GiRllRU4ha06xEuH0i4DSjJP/wP8b
	 veMxKynKNNnrGM7RzHSvUOI7Z+l89bFI1n9FlXoCTpf7Qmkqvwt0fvqMkUw1AqBW82
	 yWOyCxqRKSzXUUVDzM52PEdOU3Y1JjDV73YbBulALQhf8rSpzBBYZcaXYTiRIc/1qE
	 l5y9pRCgYqkaJv7b4RkiWh36NeRgC6lZTBTjj4ouKoezLSXWoVx+Nq5aYF3tNDdT8I
	 6eRuD69p5efTiZ7bSchH9pogWOLK190DKbGxjGKqw5zxC3Mq6L+6t6TxdTMDjwUIXN
	 DLtS6IP8Z+42cG61sHfMfB70xXx/0Gv55a6rzVbBjCQo8uLcIPCdTGIoUmN8ZIKqTb
	 XzeS8VLYtwV77sGaviCAu9VWwy5fUtxdCoWOmf7Evg6LEerJAkzyPyTpK+7vl5OFxU
	 1fuIqDpSkJEqE9hFyLbiN8unqzE3NPz56nssSXIxSQrwgpwVjHfoIzyOrbU2rhkze3
	 I+Wp/sPLZJgjRzmDJOrjJMN10N1GY69HLDjCmATb19134DXIIZx4rw53iw5HY/0lSc
	 qyk5eWK9dKuVTbVvD1cc+n6VAfcTCbvvLVpsF89AQ2Ir03cuaZJ2/heN7irTwkgNid
	 QOcUMtWPZLordgiJIOIC1tGM=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 42E8440E016E;
	Tue,  4 Jun 2024 15:46:42 +0000 (UTC)
Date: Tue, 4 Jun 2024 17:46:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH 8/9] x86/mce/amd: Enable interrupt vectors once per-CPU
 on SMCA systems
Message-ID: <20240604154635.GTZl8222q7WAEVSJKH@fat_crate.local>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
 <20240523155641.2805411-9-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523155641.2805411-9-yazen.ghannam@amd.com>

On Thu, May 23, 2024 at 10:56:40AM -0500, Yazen Ghannam wrote:
>  static bool thresholding_irq_en;
>  static DEFINE_PER_CPU_READ_MOSTLY(mce_banks_t, mce_thr_intr_banks);
>  static DEFINE_PER_CPU_READ_MOSTLY(mce_banks_t, mce_dfr_intr_banks);
> +static DEFINE_PER_CPU_READ_MOSTLY(bool, smca_thr_intr_enabled);
> +static DEFINE_PER_CPU_READ_MOSTLY(bool, smca_dfr_intr_enabled);

So before you add those, we already have:

static DEFINE_PER_CPU_READ_MOSTLY(struct smca_bank[MAX_NR_BANKS], smca_banks);
static DEFINE_PER_CPU_READ_MOSTLY(u8[N_SMCA_BANK_TYPES], smca_bank_counts);
static DEFINE_PER_CPU(struct threshold_bank **, threshold_banks);
static DEFINE_PER_CPU(u64, bank_map);
static DEFINE_PER_CPU(u64, smca_misc_banks_map);

Please think of a proper struct which collects all that info in the
smallest possible format and unify everything.

It is a mess currently.

> +/*
> + * Enable the APIC LVT interrupt vectors once per-CPU. This should be done before hardware is
> + * ready to send interrupts.
> + *
> + * Individual error sources are enabled later during per-bank init.
> + */
> +static void smca_enable_interrupt_vectors(struct cpuinfo_x86 *c)
> +{
> +	u8 thr_offset, dfr_offset;
> +	u64 mca_intr_cfg;
> +
> +	if (!mce_flags.smca || !mce_flags.succor)
> +		return;
> +
> +	if (c == &boot_cpu_data) {
> +		mce_threshold_vector		= amd_threshold_interrupt;
> +		deferred_error_int_vector	= amd_deferred_error_interrupt;
> +	}

Nah, this should be done differently: you define a function
cpu_mca_init() which you call from early_identify_cpu(). In it, you do
the proper checks and assign those two vectors above. That in
a pre-patch.

Then, the rest becomes per-CPU code which you simply run in
mce_amd_feature_init(), dilligently, one thing after the other.

And then you don't need smca_{dfr,thr}_intr_enabled anymore because you
know that after having run setup_APIC_eilvt().

IOW, mce_amd_feature_init() does *all* per-CPU MCA init on AMD and it is
all concentrated in one place and not spread around.

I think this should be a much better cleanup.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

