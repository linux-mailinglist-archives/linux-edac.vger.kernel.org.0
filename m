Return-Path: <linux-edac+bounces-5411-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A94C3FF6D
	for <lists+linux-edac@lfdr.de>; Fri, 07 Nov 2025 13:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9196E3ADE1F
	for <lists+linux-edac@lfdr.de>; Fri,  7 Nov 2025 12:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024D92DECDF;
	Fri,  7 Nov 2025 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NXxpTzYi"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574E52DF131;
	Fri,  7 Nov 2025 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762519255; cv=none; b=OU31q2oITXRg/XvInGoEXH6paP3QTswLejwRIxqU4VhvggI204kTOiZlkxwsgPxxkUtszRVNRdKCq+cXHr9vrRYjKo6Eb9xDxMujj59K1e3A6jTs2AZN6K9806WOcQPKF6QR2BH3jAKQ+2SjxuNpUWHLP42/IOZmhRKVGPIwFJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762519255; c=relaxed/simple;
	bh=2650l2rHI5C8SlHe2oTnjbOtRTz9Afs5JrBw5WprZeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzKLvsRpTcxcD/T2FdKVooLkB1chjzpm+TDE87Q2UJXUu43oqmzycodJJeRN0/iX33S/6tnfQG4TwlJa59XyAzKVIoHn6XCFXlqy1rmDx9/DwNuPZGDg/Ih0PGqhNTmdCXisroRqqnJJFtfNkgQUGPl9k8RNrBBzmz6dbhAmd1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NXxpTzYi; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AC67940E019D;
	Fri,  7 Nov 2025 12:40:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fQEt509UJMqN; Fri,  7 Nov 2025 12:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762519244; bh=vtVqYuiAk49rAmyfB1QxFbItCJbOMfJZd6LlD30g0i4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NXxpTzYinLsNoMXFa+qXAZ+C5GkDisRM1iwMTATwej+trqra34kbGTkkA9vVG3zBR
	 qYgSPxQLqk4wh61i/HE2cOGQPtNzWBL/lZbgY0EHnSGadS6TtKn8A+QrW0MOr1DZ3L
	 0HBmqkavCMIoU+d/HVkJEQCZHwLIWCSjJEt7+9nfJ6hMdzpHNaBsardjaDU/Ql7eBq
	 arif9w1QO0ADglN/42AzPy+KCACkQnIVQGOwapROnc/5Mf6R1vkZwvJJivGtoXxYcT
	 OjLaz5IhjI97b/t/TrLIT5sCklPJRBw5P+xMSQVBe4ALkPKjWGryS6WlWalSaNQyIb
	 PgM+CHvgZIjtWlwdGRLATnsv/GVDmkCJKBjz1pQIrFPCXqbmAvw6xVNzBl+O6D6Kac
	 i6JKGRHKSOvvXkauH59cBPPcmttiar255+K7ZzNUbSdEDufeJ5jZFroZRM1isb1F8I
	 xvil6JF6pUdzBvn4rcPXjkj7MNHxYq7gFQC5yd/ixzmiaEIJ/EtWgDSQv/DCNOEZAC
	 WptbbEt9rG0DOyUe52EEimIul1cAO/dTo/x7ozYS7w4GKmbiaIKCxwNu5q9EtpEV3A
	 ZLUxj/R8iIZjcdpDJIvFOTVLzxpSmjLjzM1QbfpkBmyPKO+hNupXJQnk2budHrkGgU
	 d8S9hbdNa+1usIpJGJWvTBEs=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 43E3640E015B;
	Fri,  7 Nov 2025 12:40:35 +0000 (UTC)
Date: Fri, 7 Nov 2025 13:40:25 +0100
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, linux-doc@vger.kernel.org,
	gregkh@linuxfoundation.org, corbet@lwn.net, chenhuacai@kernel.org,
	mchehab+huawei@kernel.org, yazen.ghannam@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Cleanups in amd64_edac and removal of legacy EDAC
 sysfs interface
Message-ID: <20251107124025.GRaQ3ouSiYdtQemqI3@fat_crate.local>
References: <20251106015727.1987246-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106015727.1987246-1-avadhut.naik@amd.com>

On Thu, Nov 06, 2025 at 01:54:43AM +0000, Avadhut Naik wrote:
> This patchset undertakes some cleanups in the amd64_edac module and
> removes the legacy EDAC sysfs interface since it has been obsolete for
> more than a decade.
> 
> The first patch removes explicit assignment of the ctl_name string and
> instead generates it at runtime using scnprintf.
> 
> The second patch removes the NUM_CONTROLLERS macro and instead uses the
> max_mcs variable to determine the size of chipselect array.
> 
> The third patch removes the old EDAC sysfs interface.
> 
> NOTE:
> These cleanups were earlier submitted as part of the set adding EDAC
> support for AMD's newer Family 1Ah-based SOCs.[1] However, since the
> support patches were critical to enabling EDAC on newer AMD SOCs and
> since these cleanups were still under review, the set was split up.
> 
> [1]: https://lore.kernel.org/all/20250909185748.1621098-1-avadhut.naik@amd.com/
> 
> Changes in v2:
>  - Drop the patch that set zn_regs_v2 flag for all SOCs based on Family
> 1Ah and later.
>  - Change MAX_CTL_NAMELEN macro from 20 to 19.
>  - Modify commit message of the second patch per feedback received.
>  - Skip deprecation and just remove the old EDAC sysfs interface.
> 
> Links:
> v1: https://lore.kernel.org/all/20251013173632.1449366-1-avadhut.naik@amd.com/
> 
> Avadhut Naik (3):
>   EDAC/amd64: Generate ctl_name string at runtime
>   EDAC/amd64: Remove NUM_CONTROLLERS macro
>   edac: Remove the legacy EDAC sysfs interface
> 
>  Documentation/admin-guide/RAS/main.rst     | 142 +-------
>  arch/loongarch/configs/loongson3_defconfig |   1 -
>  drivers/edac/Kconfig                       |   8 -
>  drivers/edac/amd64_edac.c                  |  61 +---
>  drivers/edac/amd64_edac.h                  |   7 +-
>  drivers/edac/edac_mc_sysfs.c               | 404 ---------------------
>  6 files changed, 22 insertions(+), 601 deletions(-)

Queued, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

