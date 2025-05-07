Return-Path: <linux-edac+bounces-3850-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE72DAADB5B
	for <lists+linux-edac@lfdr.de>; Wed,  7 May 2025 11:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAA65212AC
	for <lists+linux-edac@lfdr.de>; Wed,  7 May 2025 09:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB2C17A2E3;
	Wed,  7 May 2025 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="d3ar2c/T"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFB01F5F6;
	Wed,  7 May 2025 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746609664; cv=none; b=KUPFkCVBqj8Xbtxkr/2stg1BamviOCJQ5EISi8hAFra4MV88l5m1MGDULUKaUs+2RnrqQ4ni4fVocnpMcPcSRDa/hLkl/7qUpX3MdsYy4DUj/CiPr0CIB+XsLtBNSB0dX57VYRFgpLoKH75YdVJdMv0CSFNDHMaiJN6hvV3cOeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746609664; c=relaxed/simple;
	bh=GgQoyAjaOq7NcB3FzAB+J1S62la0v6VUahEFLUNpw+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pU+VlXZsF/UH4/Ch4h+tIyL7NkXT8uS6xrWLc1GvQwF7+ldLTSBxVlVxMpsvPHyr/f5w66AZMlGFDzegalKktkSa3qIZwPr5Jvd4y2o+RgqZ90/g3HJBpRmj9NYO79v+FfjlNh/gmUohIvU6TlY06aZ2M07klm95C39OM0rEwRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=d3ar2c/T; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EF9AF40E01ED;
	Wed,  7 May 2025 09:21:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id R7aXOelr91QN; Wed,  7 May 2025 09:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746609655; bh=AK6ckjogsHlVrMYShLhyH/OG65/4K2ay6m++h/7A8MQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3ar2c/T1sJPP3RXJDtoPeVeXrjtGcyAWjNrs5rzBy0RaIFvnrh3JzwKIgQLvivMF
	 FBgw1v0NK2C0q7ep6iVf19/hr6Vv2969pKHNwhUK8ZsNPRgUokX3FrKeblZJ4v1Mew
	 iBL162a8SsarGuRaYFfbAmGd1csPaAOLc8v1Mo6xtIHJ8KwtR1nYHf1TLsqF/7BfZ9
	 hDVFIv9c59pgcpDowNK6qQytJeYOG5GXYTuY2bEL+x43u9WCyoVNqfAFakiYVrbx7O
	 Bxl5h7r/mdsUet4tFZU+kXzhNYLxw51z+o620GO2i9jk7WiVw5u/OPb997miHlKEwD
	 sDO/hbHwuSQuCrja/imHPMr2p4kmUn3/oRlkbqq5UzNQHX7TM7vm7kXwYyQS/es3yZ
	 narO609+QShCtPW2sic2D3qovkcd5/OCjQBR+sWa6xRjQm5w1LyAkFVeWzQcPmszQQ
	 rLRzBq8n9jwgf473bPu6TCBIhfEfRK9etI4WlwHQwqYU+rqH7fpmaRJF5Khj1RR4q/
	 Y4oVPzzOOgqosDeA6MM3+6B5HPFL9ofRtPxfMTOuiGxoeceyHkRHPcLm3eOq0atqPN
	 gr0Mesq3zCknmCRXr8jFUe2j9CMBCIfLWwO6PoBwYIPPeN6bkkleaPFuI6lBH+pMyM
	 t7kMlpDzAtZbkKW/eShYr1ZI=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D7F740E0238;
	Wed,  7 May 2025 09:20:48 +0000 (UTC)
Date: Wed, 7 May 2025 11:20:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 13/17] x86/mce: Unify AMD DFR handler with MCA Polling
Message-ID: <20250507092042.GLaBsl6pczL50Qdr3e@fat_crate.local>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-13-8ffd9eb4aa56@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415-wip-mca-updates-v3-13-8ffd9eb4aa56@amd.com>

On Tue, Apr 15, 2025 at 02:55:08PM +0000, Yazen Ghannam wrote:
> +static bool smca_should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
> +{
> +	struct mce *m = &err->m;
> +
> +	/*
> +	 * If this is a deferred error found in MCA_STATUS, then clear
> +	 * the redundant data from the MCA_DESTAT register.
> +	 */
> +	if (m->status & MCI_STATUS_VAL) {
> +		if (m->status & MCI_STATUS_DEFERRED)
> +			mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
> +
> +		return true;
> +	}
> +
> +	/*
> +	 * If the MCA_DESTAT register has valid data, then use
> +	 * it as the status register.
> +	 */
> +	m->status = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank));
> +

Superfluous newline.

> +	if (!(m->status & MCI_STATUS_VAL))
> +		return false;
> +
> +	/*
> +	 * Gather all relevant data now and log the record before clearing
> +	 * the deferred status register. This avoids needing to go back to
> +	 * the polling function for these actions.
> +	 */
> +	mce_read_aux(err, m->bank);
> +
> +	if (m->status & MCI_STATUS_ADDRV)
> +		m->addr = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DEADDR(m->bank));
> +
> +	smca_extract_err_addr(m);
> +	m->severity = mce_severity(m, NULL, NULL, false);
> +
> +	if (flags & MCP_QUEUE_LOG)
> +		mce_gen_pool_add(err);
> +	else
> +		mce_log(err);

Except you have a function which is called "should log" which also does the
logging.

And you have that same logging being done in machine_check_poll().

This code needs more designing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

