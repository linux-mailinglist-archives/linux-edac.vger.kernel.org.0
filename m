Return-Path: <linux-edac+bounces-4350-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DADB032A3
	for <lists+linux-edac@lfdr.de>; Sun, 13 Jul 2025 20:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7FA1899BBC
	for <lists+linux-edac@lfdr.de>; Sun, 13 Jul 2025 18:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8607A287502;
	Sun, 13 Jul 2025 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZOCdCNIG"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38C713B2A4;
	Sun, 13 Jul 2025 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752431400; cv=none; b=I6kArivmn5Q3vUwS9PR+2fVB6mBg5iZVzeCZgfGaHdUE1XZpYiSWFSsab3za6ygzqkCrw2yaQYTWdzxc5HZV/FqWXenNRJ0J3w30n/ZY8waivp+XwOSBJtXE5Qqpa2u8BJGtsoBjZq21e7TXr9T7zRX9Opb6epWlANDTeEj1IPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752431400; c=relaxed/simple;
	bh=/H41FcYLxVtO0ZWKPOCvXMuREgtLxHA7gtfyh74kkL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfzXX8KLiOF/V6lQw7fj9ZQf8x8oBTOD08m5AzsaOKdNkSPXNx7mKke0sDf6O4iRN2ezPgsmQ2nCu9kgRPGTk8d9DwgUNpQpwdY/AWTegIFkwuhWPEAAtG/EH69/+bKL4JC0eLf8zy2ttLLAA/WaKFUDXwseylVSq2NbadsjSE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZOCdCNIG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D0CE740E019D;
	Sun, 13 Jul 2025 18:29:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qfbbGh1WaMFR; Sun, 13 Jul 2025 18:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752431390; bh=QQW2piFd37q2SVJWdr1fEbUbrygpT8SHRdtBeH6fKJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZOCdCNIGz2UbfaA9XtLgczLO2znitTyc/ycye3F/YcjtOP+zFtc/F/GDTbkA5CGxu
	 FtVOoBpA7gjeso3pWRj389EtpcAxv8HPXuUl1Hlrm02haUWTA57DcB0MYJbPDCyd4k
	 d0EFjAi3QBnSDxwEVtpr9Bpxjzmi4Fy+T6s74f64rhZ9+THuBnxkTsiFn3Zks45Vtl
	 2zXfwYw8YrsYZr9KGX3RJEPXVC5zXcF4VvHXE3qmwRbAoFo+qNQxs/NlOaqWhLmxX6
	 8+HktBiAMXSNNJN7KrhaiD/T1m06RMgpFHuw5DuG7fOyup6T7SyK3UG61GWvKQhNYv
	 xhYUi+X97VcFkx3rxKFsahXL8uthqR1oekB2LNrl0xJaBHceL29iaGdM6SnTSgWdG3
	 inm7myHZMnTj/kZqvQsuzAjrd2I7shWd0nXz5KMdA2rEwW7mkK9wJgtpxVlVUnxcgH
	 14xTElzILcd1tc2S6Xk2E80qdNluf2HJ0fr8QR7oikov+pglYfjJF6RNMZJDx29b8T
	 R0T+431EDsZOGBKlhOZPpM784RV2RB3dCsCTj0eYgG1E43ZqQLRtHPKiJf9XCLu1l0
	 5wDymncSN+SqrRrpGfnmQcvOlobjPBXbz1DUW38UkoN6/lYfaNjrqb/COs7CdVwsQJ
	 81RTtifcEKul35uPkF6ekZ2o=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B275B40E00DD;
	Sun, 13 Jul 2025 18:29:39 +0000 (UTC)
Date: Sun, 13 Jul 2025 20:29:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-edac@vger.kernel.org, git@amd.com, shubhrajyoti.datta@gmail.com,
	Michal Simek <michal.simek@amd.com>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/synopsys: Clear the ECC counters at init
Message-ID: <20250713182933.GDaHP7DdAhX-8OoaP-@fat_crate.local>
References: <20250713050753.7042-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250713050753.7042-1-shubhrajyoti.datta@amd.com>

On Sun, Jul 13, 2025 at 10:37:53AM +0530, Shubhrajyoti Datta wrote:
> Clear ECC error and counter registers during initialization/ probe
> to avoid reporting stale errors that may have occurred before EDAC
> registration.
> 
> Key changes
> - Introduced a unified `get_ecc_state()` function that handles ECC state detection
>   and register clearing for both Zynq and ZynqMP platforms.
> - Removed platform-specific `get_ecc_state` function pointers from the platform
>   data structures.
> - Added a new `platform` enum field to `synps_platform_data` to identify the
>   target hardware platform.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
> Changes in v2:
> - Update the commit message
> - Add the zynq reset changes
> - remove the function pointer
> - Use a plat field instead of the quirk
> 
>  drivers/edac/synopsys_edac.c | 96 +++++++++++++++++-------------------
>  1 file changed, 45 insertions(+), 51 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

