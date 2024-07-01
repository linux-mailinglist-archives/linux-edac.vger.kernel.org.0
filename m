Return-Path: <linux-edac+bounces-1445-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD23591E617
	for <lists+linux-edac@lfdr.de>; Mon,  1 Jul 2024 18:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA19282823
	for <lists+linux-edac@lfdr.de>; Mon,  1 Jul 2024 16:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4508216DEC0;
	Mon,  1 Jul 2024 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GrwAMY1t"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8E016DC3A;
	Mon,  1 Jul 2024 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719853187; cv=none; b=pvi49k7lqt1gmZk9cAhf5eAVIN2owaKs5raq5sMWzFjuDcAToHGi+EAOvA8v4skaoxmA5CiSZ+AbFOfIfp9mAkFR/RrLNkip9TMdo5+TGLi1fELJb829pifJSCtjEJOqUyzojRPtsN0wiIZzoRCD5r7312MGl1E+YOoAAaVnyZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719853187; c=relaxed/simple;
	bh=qLOncLYdHHqUTVbR/vRD88gj1EJwz2NYAlt0A0GlEcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LT449qC/EJr3pwufVW2z0I9tmZG1Wh+liBvIFzlHtpJNbM7oXqwMlB6+8z41oVIiW1vI/yPwbMCUIunW0r3NKQvdQay1nznidhkTK0pa5HrUOtinhKQKgCwDOZjFKHwBFeSmAvLMAdGNLthAk3Y0d9DAg90i5JrfwXlOt4lpeOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GrwAMY1t; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C512140E021B;
	Mon,  1 Jul 2024 16:59:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nO3_FysZ_Po1; Mon,  1 Jul 2024 16:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719853179; bh=h6U1lRkSQ02qZbv9tBPVD0ljz8FvKEtI/USLEALXRpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GrwAMY1tw24nUlPeEhLbKjeKvTKm/Q2IE6nYy+oFdJdcC0oD0i66WfMRjn4WptKiK
	 sniZ99THDAU7f8zkNp2K5x9+ILIR3qBfDE7zWd/JMHP0kB74UP6H6E2L5Y9xJjG0Y9
	 oLtJPI91WNlu0M7++3GGIKY21sTADUJvn1ZM5vL18Vx2l5Nlti070sNs3kLNSiLpTg
	 3EmFsXQqyHPHtrxbJCxmk4xrVlPpYZNrPvION77m4r2DcfxJrtKVYbdWACfW/evyrO
	 OWF32irHl1rZgszFgifH3nURFLplRAJVFSVno3ioL4gkyo6KSKAFcjr9Ee6lByCSiX
	 K64RYakYTA9LjVQm54rcvy+YWao2G2Xn4yuMeqpYOiOWKNsxwlbL/rNVwhpgV0nalt
	 8uc3icZqDQF48io0+kDsiahnCbiDlsYpPH01t/bqA18UJwtvygnZxZYtYDQ45GEAtt
	 yQ0YKmToSH16ejATAcHPlXHajADwBCzKQzOZCqfcMpfTwmgB9LoXtipCIlkheLkApC
	 QHDdlAhe3vcjih/C8uHR07UDyLwlTA70xSc7sJBf9S0lKE/uX1ZqHQceuCIfO3RzjQ
	 omsH28rU54t2Q0dK2kWDLTNTGHO6w2blZY0/+/tl5l6hsniDuFngNGL5LThFKwo4qp
	 RVcLMBDk15MonisyTk7RCoOs=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 22E5E40E0192;
	Mon,  1 Jul 2024 16:59:32 +0000 (UTC)
Date: Mon, 1 Jul 2024 18:59:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: John Allen <john.allen@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, yazen.ghannam@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 2/2] RAS/AMD/ATL: Translate normalized to system
 physical addresses using PRM
Message-ID: <20240701165926.GIZoLgbknHklmJ143Z@fat_crate.local>
References: <20240506174721.72018-1-john.allen@amd.com>
 <20240506174721.72018-3-john.allen@amd.com>
 <20240628074522.GDZn5qEkTXG0EvQ4Lv@fat_crate.local>
 <ZoLYCJVfoRLJbGtW@AUS-L1-JOHALLEN.amd.com>
 <20240701163424.GHZoLakCmNflWa_Lzm@fat_crate.local>
 <ZoLct9pSnqXm4OFd@AUS-L1-JOHALLEN.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZoLct9pSnqXm4OFd@AUS-L1-JOHALLEN.amd.com>

On Mon, Jul 01, 2024 at 11:43:35AM -0500, John Allen wrote:
> This is because the spec defines different param buffer structures for
> different types of translation. We can call this just param_buffer for
> now, but would need to be renamed if/when we add use cases for the other
> translation handlers. My preference would be to sort of future-proof
> the name now, but I don't have an issue calling it param_buffer now and
> changing it later if that's what you'd prefer.

Sure:

/*
 * PRM parameter buffer - normalized to system physical address, as described
 * in the section "PRM Parameter Buffer" in the aforementioned spec.
 */
struct norm_to_spa_param_buf {
	...
} __packed;

and you'll have to mention the spec in the prm.c file, at the top.

This way readers can immediately map it to the place in the spec.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

