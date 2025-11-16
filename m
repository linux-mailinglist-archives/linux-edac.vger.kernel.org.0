Return-Path: <linux-edac+bounces-5445-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FE9C6138B
	for <lists+linux-edac@lfdr.de>; Sun, 16 Nov 2025 12:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22EB33B7E1E
	for <lists+linux-edac@lfdr.de>; Sun, 16 Nov 2025 11:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46458231A23;
	Sun, 16 Nov 2025 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JitOWWBI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644D31A3165;
	Sun, 16 Nov 2025 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763293100; cv=none; b=hCyA00p5iBIOC72ReJBzFfFa3mt0+YrtPAsiMxcP6sCTxTfJYcq0lYXW/LEOD2fgXu6Db4q6fSO3aPMYbngUefyk8W3zo808c0ESfOadaahsU4Ks4SKRjXeJMAdx4FB8qekwYM7qLF1v5Rh06trqeHOfeKjN+/WpaA4ddZQVkw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763293100; c=relaxed/simple;
	bh=Gtq9f5i6oJItrW++XRw5R00qAFO0jggbvOVk68aFkOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7gFi8jP5yN4ZlLB6XdVzlN+QkxWNmllPmMr8ZULqijZHeuEqQNKbBuCqJaBYn1+IaFwl5NBfA2jIWuVvtSr7ESj6dmUlwN039YzFe4lWy57r7PVyyVxqUfWbPNaHCKlaw2eQTAR9UOXmkTjf0uMq/PfIJckA1cQjFMCp3OY1Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JitOWWBI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 19D6D40E016E;
	Sun, 16 Nov 2025 11:38:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 02YIxdQRRDme; Sun, 16 Nov 2025 11:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763293090; bh=yI8lRAnHO2UCOtwFd0bjPvm/WHOS+qDTKXtzuBGSyrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JitOWWBIJP1AIbqZ90Npk1AkBB26AFRezsmQIrQAiWaGeX3qiMXVjirxKDLLXOZ94
	 mtis2H07Hh61OsQxzTH27vuDKklDJbsnathbp+h+b/tVkw3SH8oA6kblguV2dWUrl0
	 za4JousvzqHbjggF1YEeustLiG6rHTYvcNT0TTjcpb4Wse4rFtCgB7gazUVXYtxfxc
	 NytNjLh5VhieitIczEHKzab1jmc/xKt7UkgpP5P+T3Z+/kkvqPcOfBGEiUYH3Cuucm
	 FUDugkYp6o7d/dJmbXWuqAcYndqj1UV+5Ksj2FiNyxu1QfuAdkcdroXq5TPMIXT35F
	 kXZFQZ4TD74FcWg6eaLvuMm8Q2Wd76lRLgsHPUz2Ht0PMUlXIaRRTrOPCFRHD0+iuu
	 VIprDbxFscNk8Fzu55zg3vWUKlsfZBlqEyMax/6Xlfw8I0NWjK5f++r01cexajSKMk
	 QJNfca8k98BoO3GV1XUYUDe3XBl3Jqx1sfE8kPNEvD+0IuOu2MFamxPm3NLdL4TSN/
	 APn6bM/o6bzG+IA+p3M+/LsVRk4XvyrdFLHkWwmC7NOHtpVFJnccZabSGDNNP8KLGT
	 1qMdb34r0fjAeaYPzTydxJZQOO1Iv91gp8r4JoJeqtCBhLOQRKu5fn7DlDcFaz34g7
	 tVvJlWqoPeWe0AygILT/Rvb0=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8081440E01A5;
	Sun, 16 Nov 2025 11:38:05 +0000 (UTC)
Date: Sun, 16 Nov 2025 12:37:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] EDAC/ghes: Replace deprecated strcpy in
 ghes_edac_report_mem_error
Message-ID: <20251116113759.GAaRm3l7yimgdxc5TD@fat_crate.local>
References: <20251114160004.230025-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251114160004.230025-2-thorsten.blum@linux.dev>

On Fri, Nov 14, 2025 at 05:00:05PM +0100, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead. No functional changes.

Please put the reason why it is deprecated here using

https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

so that the commit message is self-contained.

Then you can point to our documentation instead of some page:

> Link: https://github.com/KSPP/linux/issues/88

we don't really control and can become obsolete.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

