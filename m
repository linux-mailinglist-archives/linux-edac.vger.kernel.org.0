Return-Path: <linux-edac+bounces-965-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B9E8B2610
	for <lists+linux-edac@lfdr.de>; Thu, 25 Apr 2024 18:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0B71F21260
	for <lists+linux-edac@lfdr.de>; Thu, 25 Apr 2024 16:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0AC14C58E;
	Thu, 25 Apr 2024 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XdP7Usev"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6AC14A096
	for <linux-edac@vger.kernel.org>; Thu, 25 Apr 2024 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061537; cv=none; b=EjxQZz6UHw85xVSTYbeyGoscqE6klnjEkOqgeosPI0jOlgpaGq380IPcC0myOTUfgo5cJKKus0UxG4B3NJslSh1PcFF+SNCFMgIEtsKaEu80uLnvRLYl1TyvPgOasp54EAXDjD4Brv/pP76Qt2VUa5PewnqitVvvk/qBxAVgvk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061537; c=relaxed/simple;
	bh=qMDIGKPGZlbydO65rWwW1ratdS1tNbhyI+T73tEoTLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUeD2dkMg9WmjvgYBV6OmdxG+GfsA3lxXzX7lPhBhma566wC05g5q78Mk0h43lepa1KL93xlL9RIbtyqAITJLcBO+HTh1ibwbH4PA0tLJN2m7eRpuXyQleJWTdZfg+4HscNJKSJ2YkN+FubhyIjN7NRNTfrolYrl+kzKZ9qoG4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XdP7Usev; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A13DA40E01C5;
	Thu, 25 Apr 2024 16:12:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1EXqKOuiGMIS; Thu, 25 Apr 2024 16:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714061530; bh=3K57cgGRvYfdlxAjb8iMOTnvKVbqqsDTHvFm5e9kVZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XdP7UsevomVWSboKVAxCAXqHEDRaPCTP5JM8YdnXY3tEdKPZTVyw1cPlwXRsTd6/R
	 0+vzYoY/j/cBF1eUX6JtzfyTCbNIrV+AMN0ms80gAPZLzk4ARXRBy7wij92cxowj97
	 9TcbqURAahibYn1Elb5a/2cYKWj/wQloZupX/AjrMUIDdAYCW8jBfP7yePL3ado/1r
	 U9DeimzfTiMRvsteDT9nQTSCn+hg2NxDufIIusKDxV9Fe9pxU1SWgpp/EoCS6QTxr1
	 xxo3rFruES/Ydrq1JCNHHeS7hE0BBJHMTZ70C9K5D96d0Sl+j5KKP4gZuFXGJ56EKv
	 8EWQVTeXINiLKwiNvKWsIOJLsPIFL6qvNCxxo5EI/S8kOWfTohS1frOjBHH8bkHc1r
	 rAZpS9/v6xRqOdGypCKzxTWfIxParPwiFTf7DLzHo0DRXZwSgQ6R9COr65G57m3eho
	 Juf2Uu0357M29Ouf5A7hMzRlw7yfgUrBfIEcAgX3fu9Wg6GAMH/ZEiVgDZQcKCsgIU
	 I7AASyd9ma4kbtyBE5s2zt/pnoSOj/9RRny9tiE7LwTHuSFCImrlH+/zk/3q80YlEb
	 /MhPON8wZl83vuA2YvUH5nPsKy0mTZrtKSLuZmXypqJfqsy2ktOTgjx+mN8x+reRiu
	 wfEFZ8LwmvyAff7bZtOIBRJA=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DB27640E0177;
	Thu, 25 Apr 2024 16:12:01 +0000 (UTC)
Date: Thu, 25 Apr 2024 18:11:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-edac@vger.kernel.org, git@amd.com, rric@kernel.org,
	mchehab@kernel.org, james.morse@arm.com, tony.luck@intel.com,
	sai.krishna.potthuri@amd.com
Subject: Re: [RESEND PATCH 0/3] EDAC/versal: Driver updates
Message-ID: <20240425161156.GEZiqAzEwbNP8ok8Hw@fat_crate.local>
References: <20240425121942.26378-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240425121942.26378-1-shubhrajyoti.datta@amd.com>

On Thu, Apr 25, 2024 at 05:49:39PM +0530, Shubhrajyoti Datta wrote:
> 
> Include a NULL check for the user-passed function.
> Eliminate unnecessary NOC error registration.
> Avoid sending cumulative values in the EDAC.
> 
> 
> 
> Shubhrajyoti Datta (3):
>   EDAC/versal: Do not register for the NOC errors
>   EDAC/versal: Add a NULL check for the user passed values
>   EDAC/versal: Do not send the cumulative values
> 
>  drivers/edac/versal_edac.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

