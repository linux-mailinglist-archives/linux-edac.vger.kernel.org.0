Return-Path: <linux-edac+bounces-1142-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EDF8D1612
	for <lists+linux-edac@lfdr.de>; Tue, 28 May 2024 10:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340711F24947
	for <lists+linux-edac@lfdr.de>; Tue, 28 May 2024 08:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABAB6F079;
	Tue, 28 May 2024 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fNbxkhic"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C01317E8F9;
	Tue, 28 May 2024 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716884241; cv=none; b=P/jWD2nAoQNNXIw7vK0CdvNZ/uxTsb2qFJrEqm9cto0OdA4B3HUIM0IXaSc5v/w0Wuk1wqrSn+1vYty+Fk3HTfKpj/LqUIe3Zycn8PAE4IHkNb+P1x7iJ6rM0y20uV6JhtPBC86SIHZ42NCJCEEYuOgzOXcpCLf5T0OoMR6IDcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716884241; c=relaxed/simple;
	bh=/FpOGl1eA3dzRNRusCfLJZQnMKA6mlE2Y7xycWHfcAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPjYrp8i62XePNZx7AT6QdS3sfL5D2wyNAp8PkMcgLNWIXhOg1HfDfAms9NVQssLMY7RLD/IzbRRcR1I5qNScXE8JdCBuAEDszr1sQrEgoAXAPqu2h19TzBpIADo/IJe1JUnijZNyCasSsiTed78DybHvG5G9xEcHPSNSubMPL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fNbxkhic; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7F91C40E0177;
	Tue, 28 May 2024 08:17:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6KBZL4OdRVpa; Tue, 28 May 2024 08:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716884234; bh=VL4GSIKm7KFvFd+RWq9P3+o7xeYr6S1RnKogo23la+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNbxkhicDFRmzATyOJKm3QrEpM9Z5544syNthLYtQm4Ne42t9PP7chai3uyx4x4/M
	 af0xuRVNd2ygS4n0D5zWSMrnDs4/z9dc6uoWOS7GjvjAe6jHH85i7wxrT9fFcpqkx+
	 1NMqvf7YuSWijQ1GzrcxEGA7jjd7pef5cy+0fc5Wt8uH7KKUV3rlQZWd00rr8zOoRj
	 Ybq6o1gFO77W2qgJWt6ZYe68UWjb94wtci8XpMsNeeOUjuMGeaCryoILWdib0RNbDr
	 gNr9Yz+bbi0JWUgymswNdrlfE2vyVOgQyDS3NY99Nrc56Zrf/6MbSQywG4o8Fy9Oxb
	 /WZwuinVMo6t2NR/GJFlZiW0b60gIJ8w3/YdEWz2l0ZMVLGB6kZMzCyK/vT6LXiaTT
	 AWj2pXgIFpWkfURYNE3v0pp7b8NeDP55E3vZ9mp+MpUFSNFWE8ckNLcRnk4ivSc1z8
	 eMifS4KInDDRvqxZ4ZSSk7XS7fobnAOhV4Pvh/yzzS1N0pGikyiNXVgcGrPjDaeKhT
	 zn2uF5ymdnrzdV30EoOKl7OtwaYx4mj3GujjjaJ+DLLb9s19+E43OtDA4kdGYjXk11
	 ruMfOKRAiIDa2/HyzIwW2zGD1UTgKz+c5zBm+gUER2aOkhQw/yYaGD9O/VeO88cMF3
	 c5Ps6IvmCrMsHl0Ei9bLbegM=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 22B2940E01E8;
	Tue, 28 May 2024 08:17:07 +0000 (UTC)
Date: Tue, 28 May 2024 10:16:59 +0200
From: Borislav Petkov <bp@alien8.de>
To: John Allen <john.allen@amd.com>
Cc: linux-edac@vger.kernel.org, tony.luck@intel.com, yazen.ghannam@amd.com,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	muralidhara.mk@amd.com
Subject: Re: [PATCH v4 1/4] RAS/AMD/ATL: Read DRAM hole base early
Message-ID: <20240528081659.GDZlWS-9eT0U3_cf_V@fat_crate.local>
References: <20240506154605.71814-1-john.allen@amd.com>
 <20240506154605.71814-2-john.allen@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240506154605.71814-2-john.allen@amd.com>

On Mon, May 06, 2024 at 03:46:02PM +0000, John Allen wrote:
> @@ -282,6 +298,11 @@ int get_df_system_info(void)
>  
>  	get_num_maps();
>  
> +	if (get_dram_hole_base()) {
> +		pr_warn("amd_atl: Failed to read DRAM hole base");

This thing with the printk prefix "amd_atl: ". Please do a pre-patch
which adds

#undef pr_fmt
#define pr_fmt(fmt) "amd_atl: " fmt

to ...atl/internal.h and remove all such string prefixes from the pr_*
statements in the driver.

> +		return -EINVAL;

So this basically says that the driver won't load if it can't read hole
base. But it did load before - on failure to read that reg, it would
simply fail translating.

So why is that failure so tragic? Or is it that we absolutely need hole
base in all circumstances so that loading it is pointless if not?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

