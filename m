Return-Path: <linux-edac+bounces-4713-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5236AB3FD6F
	for <lists+linux-edac@lfdr.de>; Tue,  2 Sep 2025 13:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9B01B23CD7
	for <lists+linux-edac@lfdr.de>; Tue,  2 Sep 2025 11:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F742F744A;
	Tue,  2 Sep 2025 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ou41VjJ1"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D66A279DA6;
	Tue,  2 Sep 2025 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811485; cv=none; b=qknGan+H5mrmmq7wgUcB+X4/WRISZna9fQJskTFpDFJ6SMXgwvboIec/z2HnUsMx3KNHAapSk9zExATFhxVjPVNcqLF8lG2HjmKu6EcRjMSBNJPFZxvt8V/NXQcRisTjd+XVKqeZtu76rz3Ou/hnKUjmWvjLXlmSPDisP+Y6GaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811485; c=relaxed/simple;
	bh=TPu07su/3VM8SEQywPtrJmzbAe46oS3S7G2DqM/0ij4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZZeTiHiUO1/bXzV0ktbbo/w1Mw8olj70Xdqi6z/6B1MBzSru4jnGoy5PwH+Cbsx7+l/mvC6VJfAw8PAJ1QhujzuU/59TMsQiY1sC/r3ik3H+MIGLxu0FR+QDkqtqwRbgdJQlx2jvMoJEeekRxqxMtGnxpC2FRTs0yIg+ig3m2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ou41VjJ1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3FC9740E01BB;
	Tue,  2 Sep 2025 11:11:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Qojvh_XrsXSa; Tue,  2 Sep 2025 11:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756811469; bh=3/V00Uv1i06CI763yI6IFspJgpQRVik3r9LvA1Qhk1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ou41VjJ1pEl2Rm4wtfZMIZYfoi5TlT5hWkur+pkn6c2KPQqGOF8qSMJdz4xzm1FG2
	 ll78ml4LmNN+3vrsTQgeaFbeWaeblCexmZYghE36aM0mtZmtdGFWcmO3xoI7uT/rEt
	 2IUpizJpMwmnb8jcNaSuNZTpyWH51PjMi9bOl4H7b9RwRXEKjjBikCiYmHlrhva1CR
	 eVGMuv2P1Gt7xteaIU/oFhBDW7FPTLwUIAxBrsEML4BRqUV1o3OfLas8IKelHwVvlc
	 GUFXBFHf49DNV4uwRRu2FImuisQ1wlij+1hja7VoUzwdmWKOG28DOkNNwEEqHD/4G/
	 /SbQqkdPJTCt0GtucHu7Y9ksO6svLs4dMX1lTnEPtGkT5BeS2hQAVNlzUKf6INV4Fc
	 927vOayqP+AHrdcsFwkUFujf76du8hXijH8bbY+PgKRJnM4APKtZ84B/CEI3ErzUyU
	 zg5+uYkjV2XwFX7DvVxhOCF/uM4+Jb0XrMvLSc+BbehpGoYDUjkoQkqNalXTq3clle
	 5r0vUTiJI67kyOsXS6tBzowDtmlO7B0/gJGNuYyjoLixslw3ucVcE46cAt8JPCEFC0
	 eTSl18U/mHd2xp9b6g8uNunOzcGO1qrXBlIbgFYsmJSuJt3a1Hs21WIH58ZUUTAimE
	 z2jGucoGtQX5XomVtWn+Mbx4=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5CE0E40E01B3;
	Tue,  2 Sep 2025 11:10:59 +0000 (UTC)
Date: Tue, 2 Sep 2025 13:10:52 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 13/20] x86/mce: Unify AMD THR handler with MCA Polling
Message-ID: <20250902111052.GDaLbQvA2A0b8Ii26k@fat_crate.local>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
 <20250825-wip-mca-updates-v5-13-865768a2eef8@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825-wip-mca-updates-v5-13-865768a2eef8@amd.com>

On Mon, Aug 25, 2025 at 05:33:10PM +0000, Yazen Ghannam wrote:
> +/*
> + * Threshold interrupt handler will service THRESHOLD_APIC_VECTOR. The interrupt
> + * goes off when error_count reaches threshold_limit.
> + */
> +static void amd_threshold_interrupt(void)
> +{
> +	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->thr_intr_banks);
>  }

So the thresholding interrupt will fire.

It'll call machine_check_poll().

That thing will do something and eventually call back into amd.c again:

                if (mce_flags.amd_threshold)
                        amd_reset_thr_limit(i);

Why the back'n'forth?

Why not:

static void amd_threshold_interrupt(void)
{
	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->thr_intr_banks);
	amd_reset_thr_limit();
}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

