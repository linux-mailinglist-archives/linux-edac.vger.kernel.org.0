Return-Path: <linux-edac+bounces-2785-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16D1A0140B
	for <lists+linux-edac@lfdr.de>; Sat,  4 Jan 2025 12:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E971638A6
	for <lists+linux-edac@lfdr.de>; Sat,  4 Jan 2025 11:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E80181334;
	Sat,  4 Jan 2025 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HUNn6B4R"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCC518E764;
	Sat,  4 Jan 2025 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735988930; cv=none; b=Zq+kssCYPKSnVTF6mdeOoSaSqJ+scTWqARxz94qJe7yRT0D43MheQJO3PL2zEbHfhBYp/tIAJ5vBuJ60aqjzDdylkOeP9QSipmttO2+oDWzNUVHlfBxMnraHvkCcfxL8x5yvAYDr9mOU6G/uhdPovPr/BkxANObFewBZ2mN7Q1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735988930; c=relaxed/simple;
	bh=P/++0UQCmWtnPtMlv5wNKphS7F3EP1mZwGPD7yJ4IuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FT1NZqTWol6/HZKvTRwGIM7+Xsf4rKwgKybf+e6AGg2R/7LbakUEP8/kF72X6vChwlEyFKJdqumsK10w7GP8w/jL5ZFb9zK3kLXKq9r/aNXD1R4Mizqz5WqRtCfSgPke/yQK1XNJpAbJt4P3g5fcvam7BQv0ZiD6CKNuNrBNYAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HUNn6B4R; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E0E9E40E01F9;
	Sat,  4 Jan 2025 11:08:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9vnLpCZbZ5Jy; Sat,  4 Jan 2025 11:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1735988921; bh=J+Ab7g1zio68FWHTYFYT2d2ps8epNs/JQ2irmEL0XX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HUNn6B4R8jh2qMTYijGamDf5KCm2MH0ST3OT45nUMD/ElNKWMQlYcHanK5s3zdpE7
	 zVstmaSNjBmmDpJwUzgdXVdoKzcU+9NaFcbiiKkTslu/D+idP9TX+JvdLHN5uVvCCZ
	 3mteDwZDm1T57jcTDc6bvOCSn9Gt9dR/qtTFFo2QV3QKNCijNn7ryKkxZgu1vmoGzl
	 6hJf8o1oap+ohQb97Ki/Ram8RmMbNW5iLJNOSOV7Xz/oAYJTsv/FoHhlw0RMIEga+x
	 1Fy/6e2J6RsTO4Pc/QXoZ5w+Im861i/1PPqRHRliKubcu19xv8vntcZP+/Y6vT2T/a
	 LVmUs2NAOuSxy6D/rUwt0QgwznvK4zCORE6LsHYsU1lUBVRBgUTivAbhwQ5Q6jggmy
	 KXhq+j47vvOYTZs427p6mJmqcnt7efJLgblfco8wFEGGowb0X/Se6H54A1AIiBm3fJ
	 oycLbCDi4UQkt6eLIdnpXlPLq2XvuoCsIAG9ZqKBfumFSQUAI2HI2uAK1nOoGSbT5U
	 bHINaLs9oNKTPpZjOOy7VSV3lTsQXJlMb3zqcWZJIn7Yh9a/da3Nb5hOPLIULdhJH4
	 HjseGXOO80RlhP/jEACurJC6EKpmXi6oBq2kbGbqqYW+Xv1r+OUhHYk85co6M2eiXA
	 qKDu98p8VXVMSojXWAmIMI90=
Received: from zn.tnic (p200300Ea971f93b8329c23FFfEA6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93b8:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2AF8840E0169;
	Sat,  4 Jan 2025 11:08:27 +0000 (UTC)
Date: Sat, 4 Jan 2025 12:08:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Zhao Qunqin <zhaoqunqin@loongson.cn>
Cc: chenhuacai@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@xen0n.name,
	tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
	rric@kernel.org, loongarch@lists.linux.dev, xry111@xry111.site,
	Markus.Elfring@web.de, Jonathan.Cameron@huawei.com,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH V11] EDAC: Add EDAC driver for loongson memory controller
Message-ID: <20250104110819.GCZ3kWo7mxP2fU9_s3@fat_crate.local>
References: <20241219124846.1876-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241219124846.1876-1-zhaoqunqin@loongson.cn>

On Thu, Dec 19, 2024 at 08:48:46PM +0800, Zhao Qunqin wrote:
> Add ECC support for Loongson SoC DDR controller. This
> driver reports single bit errors (CE) only.
> 
> Only ACPI firmware is supported.
> 
> Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> ---

...

>  MAINTAINERS                  |   6 ++
>  arch/loongarch/Kconfig       |   1 +
>  drivers/edac/Kconfig         |   8 ++
>  drivers/edac/Makefile        |   1 +
>  drivers/edac/loongson_edac.c | 150 +++++++++++++++++++++++++++++++++++
>  5 files changed, 166 insertions(+)
>  create mode 100644 drivers/edac/loongson_edac.c

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

