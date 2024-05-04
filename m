Return-Path: <linux-edac+bounces-996-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D73E78BBC7B
	for <lists+linux-edac@lfdr.de>; Sat,  4 May 2024 16:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBE81F21A43
	for <lists+linux-edac@lfdr.de>; Sat,  4 May 2024 14:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A0239FD9;
	Sat,  4 May 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Bj5jNRO9"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C8C37700;
	Sat,  4 May 2024 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714833713; cv=none; b=QwOlMQmzun7xOTlfO0/BZ1xfkFHdA5kaRY5XrGiQMIugTMyshjWtwqPIshxHjil8gEQCG4jZhqKG0StfOTxknlD14iyF5M7sz97jHOtAmBCZHLe6yxzgxzXs8FJ8dkYvyDvtEnhHDz/R5V5JQAgvtOQVdbhxFhRiIF3DuP98iU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714833713; c=relaxed/simple;
	bh=ctPH1ZslJOA60185S5JL9+K5bRbUtsnEi0rriNOsE9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZpbCuP44GTrFl3TUmFe7O5i30cHUCIo/hI9oXpoGMOcGD0EADfp6xESizer8UZ3mOk8vcbZfx1JdFcWic+zY8BDp6XEkCMDxpsFrmqoSb1Rj8eHspGDg1hTUtyEhHb3bzSw5IkfSzHk0WhlD6PiRFq00M4N5j8TSFc1zYSEU6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Bj5jNRO9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8C62440E01F6;
	Sat,  4 May 2024 14:41:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sQruP3uFrSWy; Sat,  4 May 2024 14:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714833704; bh=ZPZnSIgsZm76QrdrCmCnZAFegpDRYsEvTiDSXnLopVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bj5jNRO9sMhixKA3R9j1LWiBeFZwQwXocXgVUZGlmRYBqUFEWZbJrmOL3awznSoU4
	 uqWvpV6wKTU8oORcYq42BVtBrPLMADqdm3UGoXLmzELrvLtv+e9M9GsAf4FK/eHhmg
	 UKuFGF/Eu+BvbPV9pp+D7g56VeV9gI/FjVl1Tc80QxVJVFMNYrFc89uZD7QZLi8alD
	 Dqt9EdkXOg+l9hkHqNBemfdoZ1Go3X46HFbtclNT6JZhbyRcTXB9DXJewet3+dVFfS
	 tLEp4m1klfOmSd5sN8oswF+l+b96Ywk9AM8zCRxnWEcFzETg4cEcUIVRfJLu4uJH7O
	 YgFpVVd9eeOsXkREN5NWbupBx3qpKzlZlUJ/c+m6xbo8zc6uzzYDnOny2IsfPiGiS+
	 Qv6PUy1DtxV6sCmb64821n63xYkPCoEG5VQb2Es3/lMyRxHXmxJn34TihYLN31tzwO
	 /9V2PNQgvwyA5yITIjCIZcGRnE9+XPWsHtsDQwX8hpd2t9YFCnhwcyKiXvebhCc6gw
	 hTcOwi0LaGng8U7CVTFAN0uAIt3SsYYsJ6wslSoHPD1atfMJur0ciUcw9rc8W3hbdS
	 nuSYVhKde7Y59oMmmh9fO5/erzHBDFT42xirsmkUmPiujxF9P4IaUt8l/daKDKYmWL
	 EwM3ysZi2OqeVtmonIMWG15g=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C256040E0192;
	Sat,  4 May 2024 14:41:37 +0000 (UTC)
Date: Sat, 4 May 2024 16:41:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, Avadhut.Naik@amd.com,
	John.Allen@amd.com
Subject: Re: [PATCH v2 08/16] x86/mce/amd: Clean up
 enable_deferred_error_interrupt()
Message-ID: <20240504144136.GEZjZJIG0QdIeAie4H@fat_crate.local>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-9-yazen.ghannam@amd.com>
 <20240429131240.GOZi-cyLh2OhRrNTWM@fat_crate.local>
 <d527fccc-6c32-43bc-bfad-477e6f07e33c@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d527fccc-6c32-43bc-bfad-477e6f07e33c@amd.com>

On Mon, Apr 29, 2024 at 10:18:59AM -0400, Yazen Ghannam wrote:
> Good idea. In fact, we can treat this register as read-only, since we will
> only handle (SUCCOR && SMCA) systems. The only need to write this register
> would be on !SMCA systems.
> 
> We need to assume that the register value will be identical for all CPUs. This
> is the expectation, but I'll add a comment to highlight this.
> 
> Also, we don't need the entire register. We just need the LVT offset fields
> which are 4 bits each.

Yes, you could read out and sanity-check only the LVT offsets and make
they're the same across all cores to make sure BIOS hasn't dropped the
ball in programming them.

But see my previous mail too: I think we should leave pre-Zen as it is
and do cleanups and simplifications only for Zen and newer.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

