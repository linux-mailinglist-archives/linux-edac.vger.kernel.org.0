Return-Path: <linux-edac+bounces-4040-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5C4AC8075
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 17:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49F817D704
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 15:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533F122AE6B;
	Thu, 29 May 2025 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hZbisq1R"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351C11ACEAC;
	Thu, 29 May 2025 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748533336; cv=none; b=Wa/x8Vq3aeW0x9LhHNAG+W1mjt17RvfMgIVWQyO+nA8r8F4Ln30xMEqRnhiKiAsY6Oefo/oqRH7x2oyWEQxND6YtxKEwYtCKYkHAzBwW3n6JUAHSZpyLLmSrqSkgaVMnfrabvpXjy3eDnbl4FaUe3XJ4XIlvXx6ImnMzrAjcKtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748533336; c=relaxed/simple;
	bh=NvS3iajel3uiFpERDVLOA+H1e2GfdGwuFWSBnEly3Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZ16bBlbtLO37Cn8SKnvE3OlMAJ9ZmpvJVwZrCB3pQmEJUaZKAOXTkDkukt3x+0mH/OScH0li91gRQ1ywU8Qh+3tRgn7Pc+yg3EVanPKzv6XDMAv4oCnENwy8cYYVH7HxLTDIRYmCmNtkPFji4DyYRTNOErFDUZoEfMz230HB2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hZbisq1R; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9567040E01B4;
	Thu, 29 May 2025 15:42:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eVHumS4QlpMy; Thu, 29 May 2025 15:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1748533324; bh=AFiskssTvMw0BTST5ut/KPBkxvYipqUNG82ZFuKfYZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZbisq1Rf8elH2xuvZxnzmvfA9yjubTHXr8jTguh52CvNwnMknBoeCkkmAflyioRj
	 nRi6Z+NIlpc+Y775G5lAX8dUDY77ov+CU/NFJbrqGQEl0XCcVpAR/pnxfZeP6KVNcj
	 miMnh8njo/U4gWn4BvQ62Nh8tgaU5o/m+j+THy6LhO3U9LvbNa07VhOeXImNvChS2H
	 e/WBk3CxPxmmHiFX2dDD1/yAstqK1f/6cayQwrrq2OCjQWPhGedUX1liYGmFmThGLC
	 +/jDjdnVBTjGUCthBWpz+SOh6kOR+ByzjtgE+q7NbmDQCNNu4ZMeRt8Tx6of/1zjTL
	 FasIOF1UhXNv65tM1gAJvrh612fmfFBY4tYuy5mFSmbSGdtu7u1xyu6vu6SxqkQ07v
	 bBYk3R+qg76UogGKk7mwMX2d8OUeaAz1ynDD9SMfUFL9mPwH9YY6vnfk7dx/tkxKni
	 gxEg60nXXxdb+iR2wlifXqXefWWhg94BCGqzfS/Xf2Pg4EwMJvlSnNsEXwU0t2DKQb
	 uHBSV7Z4ONXOajtE5pV4ftIVz2wZuBWmXT6dMYSqaUidvoZFmqeCjy0Kx30uu6JR67
	 PR5eQlXO4UDF8oueUG7b0evHjtPukpy10ojOljKsRw8ftLCupn7UGH7tVvItfp37d4
	 N5lL34ltGTUzVP5TcAn8+3Jg=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 040A240E01B2;
	Thu, 29 May 2025 15:41:52 +0000 (UTC)
Date: Thu, 29 May 2025 17:41:46 +0200
From: Borislav Petkov <bp@alien8.de>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: dinguyen@kernel.org, tony.luck@intel.com, james.morse@arm.com,
	mchehab@kernel.org, rric@kernel.org, tthayer@opensource.altera.com,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	stable@kernel.org
Subject: Re: [PATCH] EDAC/altera: Use correct width with writes to INTTEST
 register.
Message-ID: <20250529154146.GDaDiAOlkiHTwlgE0L@fat_crate.local>
References: <20250527145707.25458-1-matthew.gerlach@altera.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250527145707.25458-1-matthew.gerlach@altera.com>

On Tue, May 27, 2025 at 07:57:07AM -0700, Matthew Gerlach wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> On SoCFPGA platform INTTEST register only supports 16-bit write based on
> the HW design, writing 32-bit to INTTEST register triggers SError to CPU.
> Use 16-bit write for INITTEST register.

For the future, please run this text through AI so that it can massage the
formulations into proper English:

    On the SoCFPGA platform, the INTTEST register supports only 16-bit writes.
    A 32-bit write triggers an SError to the CPU so do 16-bit accesses only.

> Fixes: c7b4be8db8bc ("EDAC, altera: Add Arria10 OCRAM ECC support")
> Cc: stable@kernel.org
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
>  drivers/edac/altera_edac.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

