Return-Path: <linux-edac+bounces-3254-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB20A4C3E3
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 15:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B3F47A1E50
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 14:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE8D2139B2;
	Mon,  3 Mar 2025 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="h7JjHMgD"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EF820F07D;
	Mon,  3 Mar 2025 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013568; cv=none; b=J4uSn+lPqTyv6ELGUFQM0d1hL3sygVQrtOZArB8VWakB6fVnFKy7XulW+dXTGdwrulZd+ZzUqBsTOaPZ/uK0gua0LMXwrlwpkoTZ6nwfGkJg2oAoV1570ADTkfuANav2INwgnH5lXvoQ7cN3xgGf/sRXCtxCxdKodFiW12bNJEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013568; c=relaxed/simple;
	bh=m8LqLgUKcSZmyeWPSBwRlyO6eYdEV0wMI/HPPxv5yRI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Jj0Btj0Kqx/MwDDlqyL/jPjMuKckLUyhWPd7bkgdQlO3fUcPRBNRfnoiFqRVwOJBgYCyT135P/7+oCEKobgjbJeZRmp7ho3Wdsd141T/YL1oUafWOmgoEvVTSqSIKFK7iXcE+dk6Pi3e/Wiip4qZ0V/kLaor/OhEYu+GYl4R5M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=h7JjHMgD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B400040E0214;
	Mon,  3 Mar 2025 14:52:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ONsOBIKd_0m5; Mon,  3 Mar 2025 14:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741013558; bh=3Y1lYbvSoDqOWPOG8r6c7lDbEcR6+kXVb8wrSf7bgGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=h7JjHMgD03Cyet05MwSAe2uxgzEQiEJESaeSSIfMztot3GylrZdpvfDJxywFCcQJN
	 t+B2CQ8ukEDjG3NcNMIO3Pblo06e10Ws+SgYf/jpBDF0T75WqEPhCDPAiSUplCAY68
	 sXWEixID3AZ38mz0p9HMwrXRD5UwEVuIFcRCyyM2iuzQJV7hpewWdfMAx/jcnnf3A8
	 ZxPQ7XypVqiAa5n7K49ZykA7vG4FyX07sDMzMSuNsdPAwTJc1LUQ6KAFGs9/BHjhUM
	 2BECmgDEAH4x3kPuFui38eXQOCU1uYix+7xc9Akxhbsvfzi+dr2P16v8QVxmv6Hz9Z
	 4dh+QnsIqxYNNj3NWdPyB5vVRKkgFjZ2mSoWiXtiHQLtk6LKbn4kaNsRFk1fsj3bhU
	 s02l2877iCCFFG0mUE+pdhWZqDW2VIkWhh5B6JgiGKF8rfKfoCCYexloDQkYR3BH+3
	 AEZJhKE4HZIjL4y04k2TrMcsvgoLWOZJ3tF811hcsh1IMT++/I4mFuqRSNcPLjpyrc
	 fAsRaRF7/iQsrYI9BIhoREewwVPMCjVcRzl28igc/pxPqRbPwPZKFWsdRsayeKvHHT
	 Zw7vWBlDg0eAO1kV1Lb8PLpIS/uwoNJ8pb6znu40V0lKKHtI2TwCGzPwRd3AyIHhe6
	 vAjnO2z0Kx4IMKZW0iJJLRpQ=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1756340E020E;
	Mon,  3 Mar 2025 14:52:33 +0000 (UTC)
Date: Mon, 3 Mar 2025 15:52:26 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	David Thompson <davthompson@nvidia.com>
Cc: Shravan Kumar Ramani <sramani@mellanox.com>, linux-edac@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] EDAC, mellanox: Add ECC support for BlueField DDR4
Message-ID: <20250303145226.GCZ8XCKkC0YSLHXycB@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <046bf689-9a2b-4993-b8ca-927d7d2a0cc5@stanley.mountain>

On Thu, Oct 24, 2024 at 11:20:45AM +0300, Dan Carpenter wrote:
> Hello Shravan Kumar Ramani,
> 
> Commit 82413e562ea6 ("EDAC, mellanox: Add ECC support for BlueField
> DDR4") from Jun 25, 2019 (linux-next), leads to the following Smatch
> static checker warning:
> 
> drivers/edac/bluefield_edac.c:205 bluefield_gather_report_ecc() error: uninitialized symbol 'dram_syndrom'.
> drivers/edac/bluefield_edac.c:219 bluefield_gather_report_ecc() error: uninitialized symbol 'dram_additional_info'.
> drivers/edac/bluefield_edac.c:231 bluefield_gather_report_ecc() error: uninitialized symbol 'edea0'.
> drivers/edac/bluefield_edac.c:231 bluefield_gather_report_ecc() error: uninitialized symbol 'edea1'.
> drivers/edac/bluefield_edac.c:256 bluefield_edac_check() error: uninitialized symbol 'ecc_count'.
> 
> drivers/edac/bluefield_edac.c
>     173 static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
>     174                                         int error_cnt,
>     175                                         int is_single_ecc)
>     176 {
>     177         struct bluefield_edac_priv *priv = mci->pvt_info;
>     178         u32 dram_additional_info, err_prank, edea0, edea1;
>     179         u32 ecc_latch_select, dram_syndrom, serr, derr, syndrom;
>     180         enum hw_event_mc_err_type ecc_type;
>     181         u64 ecc_dimm_addr;
>     182         int ecc_dimm, err;
>     183 
>     184         ecc_type = is_single_ecc ? HW_EVENT_ERR_CORRECTED :
>     185                                    HW_EVENT_ERR_UNCORRECTED;
>     186 
>     187         /*
>     188          * Tell the External Memory Interface to populate the relevant
>     189          * registers with information about the last ECC error occurrence.
>     190          */
>     191         ecc_latch_select = MLXBF_ECC_LATCH_SEL__START;
>     192         err = bluefield_edac_writel(priv, MLXBF_ECC_LATCH_SEL, ecc_latch_select);
>     193         if (err)
>     194                 dev_err(priv->dev, "ECC latch select write failed.\n");
>     195 
>     196         /*
>     197          * Verify that the ECC reported info in the registers is of the
>     198          * same type as the one asked to report. If not, just report the
>     199          * error without the detailed information.
>     200          */
>     201         err = bluefield_edac_readl(priv, MLXBF_SYNDROM, &dram_syndrom);
>     202         if (err)
>     203                 dev_err(priv->dev, "DRAM syndrom read failed.\n");
> 
> If bluefield_edac_readl() fails then dram_syndrom is uninitialized.
> 
>     204 
> --> 205         serr = FIELD_GET(MLXBF_SYNDROM__SERR, dram_syndrom);
>     206         derr = FIELD_GET(MLXBF_SYNDROM__DERR, dram_syndrom);
>     207         syndrom = FIELD_GET(MLXBF_SYNDROM__SYN, dram_syndrom);
> 

This looks forgotten.

I'm thinking of:

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0..061149ade8c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8222,8 +8222,7 @@ F:	Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
 F:	drivers/edac/aspeed_edac.c
 
 EDAC-BLUEFIELD
-M:	Shravan Kumar Ramani <shravankr@nvidia.com>
-S:	Supported
+S:	Orphan
 F:	drivers/edac/bluefield_edac.c
 
 EDAC-CALXEDA

but lemme Cc people who have touched this recently first.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

