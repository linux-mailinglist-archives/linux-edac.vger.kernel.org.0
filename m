Return-Path: <linux-edac+bounces-3569-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CD9A9119B
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 04:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0A53BCF90
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 02:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A510C1CDA2D;
	Thu, 17 Apr 2025 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CmyCZ4Ud"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C94B13D62B;
	Thu, 17 Apr 2025 02:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744856342; cv=none; b=FqgJPVxfm3MKGBXVt+Hjez03KrrhEoNQE9orpNkX8L2K+3DblW8t5y+OcqPhh9ZEl2+NnBGeKdxpyy5G9KJAJzdvj4quagHtzkPkBInooQWWGRlS6/WsDqdoq3/bVkcIEFkuqHRARj0FB2fV/GnMtCxxI4UpMCJ9nffU+LwIpAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744856342; c=relaxed/simple;
	bh=N8SLzJR7nW9RDMwDoUW4WomJlT9Uxg4JRizsEjPy9r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCf6tqTgK+bNxdY0ty7X5wP6x02Tu2Xdtapx6eNVARocizeYlYNB1Kev6X6AEgru8TWZGCqpUG1lZeNj4BLNXz2z2XPYZ4Xfih+LUejvqTLiYCkM6De388oUzc3lvOmR5E66+wLPC3mowkX6E25LxPT4oZGJy324RkVK65qg6ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CmyCZ4Ud; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8872640E0214;
	Thu, 17 Apr 2025 02:18:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gWEaAW_msJ3x; Thu, 17 Apr 2025 02:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744856330; bh=zkT8BeQRsWX/rTknRQU0hkcqA6bAbWWbl7w+UYVMquA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CmyCZ4UdfSOKjgbnwj6HmqjTeaySgLB8mzAh6Dqh2b0GIMY8PbFUXKIgPWzDOHID9
	 Pye4sAt6DOfD1d5yEZdZGE+3PCAZLAzVPLB5xu+Slps3QDOmqCASRSipjDy0uN8Q4P
	 uYjKbTsIRDBDpafNcYLovhheT8q2l7zV925TMb3BZigopXs08qUzRiWy8Ew+uYOgX+
	 Ch89rBTOuvwBtGnuF4oScXU9+zHNds4heYsjoBaDsodoxcW72s2pmuUFowsjJTsRUL
	 rW6rX19sDCgAjGN81Ew37a3LLr1ihVExiuoyuZlsr+ncTiVAsVL0OR4ZTNeurLwPFF
	 WtEG4ichRH8EWPHJCU6L/OHTPyokKM2Ls8igqr8yn2knvoVupg4cRlXK4lZ4pqMSX3
	 gwiL6LRL2CHKYXjwPAqU9ZWnrAHQqJe/+bvntE9h1SJewC0EpeMbYWP4q1fKP1Xd1x
	 j6uVvT2PiQxUT+plz2zoxL1kiQVBV4dV3j6yNOoLpG72AnXuP3hsCyh3sppVnsv1/V
	 kBCfkQRHmMHfdh+PO9GuszDdM4cIDTfuxFu4BvS7h90GUPrn1tu7xjMtD0OtCHTZfc
	 oH3LYXrtrMN6vmOkU7f1t2YvY6pNfTaXtfMivXr79XovG3jp7NN4agYHhEhw5t0FtP
	 j2rZ34psUAne+FyQdnxk3d1k=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5CEE640E0196;
	Thu, 17 Apr 2025 02:18:43 +0000 (UTC)
Date: Thu, 17 Apr 2025 04:18:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 07/17] x86/mce: Define BSP-only init
Message-ID: <20250417021835.GNaABk-wGduDVt_q41@fat_crate.local>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-7-8ffd9eb4aa56@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415-wip-mca-updates-v3-7-8ffd9eb4aa56@amd.com>

On Tue, Apr 15, 2025 at 02:55:02PM +0000, Yazen Ghannam wrote:
> +/* Called only on the boot CPU. */
> +void cpu_mca_init(struct cpuinfo_x86 *c)

I guess mca_bsp_init() or mca_init() or so. Probably former as the name makes
it perfectly clear and obviates the need for the comment above.

Because there's also mcheck_cpu_init() which is per-CPU and that's confusion
waiting to happen.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

