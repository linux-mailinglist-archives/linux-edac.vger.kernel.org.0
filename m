Return-Path: <linux-edac+bounces-3092-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F48EA36665
	for <lists+linux-edac@lfdr.de>; Fri, 14 Feb 2025 20:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9F53B2579
	for <lists+linux-edac@lfdr.de>; Fri, 14 Feb 2025 19:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D041946DA;
	Fri, 14 Feb 2025 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Q1LeBU57"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFBE1C8615;
	Fri, 14 Feb 2025 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562339; cv=none; b=qrfVDVmhaZiarRn/TsvLnGvH//txVDuzQbNwetXfWVi29oRpCp4efXn0HlHNwsOc5YYLghUPDaduWJA6orCWcTTLeD3eHkD6dwYx34nfI6G7UYhWEjT0YTvoLeENWwBAs4OKcEXsUi/uDilkkVsG5fhcq/dTMU93NVk/Zlb9jBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562339; c=relaxed/simple;
	bh=RZm17bftE0tukyw0ZkF6+6r9zOThRKcBthxha9QvyYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NveDNIxLLKXxnl1dD51o0qHqHn2rmfD23X+MX4otGtJsRj06U3eS1ujwqOqjfqxaEf9VCH7pNdh47i2xpSl3XWcEsVd7BXWVSKmejDN+UxTIscpMv10bq2iRtnVtMwxcrOSjf6Mm2whSMF2aw1rtSsxJiL3YzBHvO0FdgydwLPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Q1LeBU57; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D246040E0177;
	Fri, 14 Feb 2025 19:45:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lKZg66ZpciT5; Fri, 14 Feb 2025 19:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739562321; bh=3cGuQ2sRU+0eqUm5YRCYlYqOBZM80IxVgwSxc9d08V0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1LeBU57EqNGWpNF86xMvwQCOyLuoKii8ODPv52GPjx4j5+bGYLdDnElqT8gxOc8Q
	 8i/qslY81FclOVFcssyMVlh8C92FCx0szFTiKK+LahBL16RcyalmG27Vw+r8qmJrvt
	 jsn5mSOqx05VKmLKyCT7g61JkvmhJc5SQ5ORpsER8lidXDabJWeDI1xMuNqgh3WkDW
	 Kn0jh6IlH28szD71/i75THhTXspbUvJeQMJJsGoTbZeTfJiSN98b7q02GqMwcqSthX
	 RSXZKQTb9BPYWcJv1/SsVBqzKzng1I9D8/X5w2ZTBjqSAxSADYvcBedQQ6324sD19S
	 J1o+9N6F/5qYkFO7Lmq/pMJJF0UVZOSfFLVfg5vi2UCp71+fNa8Ml/MfPhIKsZBN+V
	 JJKyItRCxw+MwCZOczGRTo+vCXQoTttQdJc6BPCesDbnxy+60czg4Q//eNargAo74G
	 6GHrU9GJxe36lDJYSnp5xF/TOut2ODHdTeD/PR856+Z/sOzf5qu6Bh/JyJXLBcGcey
	 QeUz2yQ6p+yQKo1xL3ux93WhPujxym8UP12+FfIU27yRxf2zbB9BFsupjV/sXteCGa
	 h1tWN48dGwBrc2Ebz24PA/qvxeo/LVi3MNRiZuQ5uqjfGRLmcOFTWl88Ej7EeZrUcY
	 hMN/FuLO9EoTWzFgjoxWS9hM=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8088440E016A;
	Fri, 14 Feb 2025 19:45:10 +0000 (UTC)
Date: Fri, 14 Feb 2025 20:45:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Komal Bajaj <quic_kbajaj@quicinc.com>, tony.luck@intel.com,
	james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
	andy.gross@linaro.org, vnkgutta@codeaurora.org,
	linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qcom: llcc/edac: Correct interrupt enable register
 configuration
Message-ID: <20250214194502.GAZ6-dPgSc-QEEdufv@fat_crate.local>
References: <20241119064608.12326-1-quic_kbajaj@quicinc.com>
 <20250214131840.desyshjr3dbb5lyl@thinkpad>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250214131840.desyshjr3dbb5lyl@thinkpad>

On Fri, Feb 14, 2025 at 06:48:40PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Nov 19, 2024 at 12:16:08PM +0530, Komal Bajaj wrote:
> > The previous implementation incorrectly configured the cmn_interrupt_2_enable
> > register for interrupt handling. Using cmn_interrupt_2_enable to configure Tag,
> > Data RAM ECC interrupts would lead to issues like double handling of the
> > interrupts (EL1 and EL3) as cmn_interrupt_2_enable is meant to be configured
> > for interrupts which needs to be handled by EL3.
> > 
> > EL1 LLCC EDAC driver needs to use cmn_interrupt_0_enable register to
> > configure Tag, Data RAM ECC interrupts instead of cmn_interrupt_2_enable.
> > 
> 
> Cc: stable@vger.kernel.org
> 
> > Fixes: 27450653f1db ("drivers: edac: Add EDAC driver support for QCOM SoCs")
> > Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

