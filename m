Return-Path: <linux-edac+bounces-5462-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D99DCC6A8FC
	for <lists+linux-edac@lfdr.de>; Tue, 18 Nov 2025 17:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E21D32C8EB
	for <lists+linux-edac@lfdr.de>; Tue, 18 Nov 2025 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D578236B057;
	Tue, 18 Nov 2025 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ks/owcME"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7262A2F28E2;
	Tue, 18 Nov 2025 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482625; cv=none; b=aRe2ptTIjo7HTGUKakER1jbeHtOXuKN0oqe1GuFGLIqCiSz4ly0n74VsHBb/BSUp6qHk8Br/fLZvavkf+wI0Ms7VoxnGwDZB8BPGUik3BHIX5fiwzRtHY6uze1smn5DSLvZKVzyLENYbar+m9ZVoAqx9TZ+ntKmP2em460KToEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482625; c=relaxed/simple;
	bh=Z0U18mld+J/RApwpXP01yE6+BGlW4voTcVzC/FYTJuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1ezxdtFRrqrRTP3zfRp2uKQm50KoDj3hQob/aNhkTlnxUhSP8DlnwsLfNxVPOPFTBPZf1XhWiuMvDCe0WDpEbpXupqo/P0OG4qJyw5ijEHNJHIhTl1aP3h4vpgc1aEuvQ8DgwV3uZNHETjV5oy2ztMFhUzk+u//Vmj8qxhTOPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ks/owcME; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 60BC040E016D;
	Tue, 18 Nov 2025 16:17:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7aJSL3hnBU4z; Tue, 18 Nov 2025 16:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763482615; bh=qdFZXdZoHpwZrzQ8lHFU3h3dtOtSi5MPGIfvQr+LAnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ks/owcMEtt/VxE3hfK0k9kaCXS0xpiTomITp4/mZTAsmiTxBGKEHMP21bjmcbJtcq
	 o5n9rHyZ0Xz3YZ3dY1XBch82TiBnDDlYsL+q5LRoaL0HQAe9RvfMOhyG/VSe9oTIxk
	 aEUQEBfJ8i/FnBNTnCYgfmHo9DOzmq/pSOxbNCGIdop/GwAhPVmtUjupNc0Z1jIK81
	 iDLatZ/tnEPtL0EOD66ovqE9ID0TtmmUK+qapfOizBQw4MX+gHJModI/ubFdmh/tLW
	 HSDqntMW2J2B+MDtAhsJBA5u/mzsl7CQuXSmxvBumznJOimX2cAqBi/G5B3u4fD68s
	 fgll4jM5henN1mkZE4fcbgKsWXCq/k8bAZrLEofprzMvVCE8dUxHq2g2/VxBF1kdhh
	 6aCYUxeiOG1dhfjvTaaUVgPg7EnCnRzgNbaMaUYZ4RVZzT4eQ2Kh5ZIyAr4llAbZ6D
	 ieHOGFXU2GlNkW/ugzzqdbhzZwYr2rYpkIsEbCgW59MqhCJnITGCrvkVZdhWJlykZr
	 zjmyrJ3ACEO/95tNuTbviiCsqkL6S2cqYoPlDvO3KtzCBvkxCjlO47bXOTDmKii0FL
	 DaYbatVAUph4czaZ/d/GBeaGgMJF72PK38/dXClGsAmGiHCI1of84Wx4B8FrIr8tYD
	 qFnfXazWoXsEfvR7D6X7jb/Y=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 6CE7A40E01CD;
	Tue, 18 Nov 2025 16:16:50 +0000 (UTC)
Date: Tue, 18 Nov 2025 17:16:43 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/ghes: Replace deprecated strcpy in
 ghes_edac_report_mem_error
Message-ID: <20251118161643.GFaRyb67ATwXpfHmKb@fat_crate.local>
References: <20251118135621.101148-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251118135621.101148-2-thorsten.blum@linux.dev>

On Tue, Nov 18, 2025 at 02:56:22PM +0100, Thorsten Blum wrote:
> strcpy() has been deprecated [1] because it performs no bounds checking
> on the destination buffer, which can lead to buffer overflows. Use the
> safer strscpy() instead.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Update patch description (Boris)
> - Link to v1: https://lore.kernel.org/lkml/20251031114607.133523-1-thorsten.blum@linux.dev/
> ---
>  drivers/edac/ghes_edac.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

