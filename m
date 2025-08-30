Return-Path: <linux-edac+bounces-4708-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8B8B3CC40
	for <lists+linux-edac@lfdr.de>; Sat, 30 Aug 2025 17:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19EC3A8DD1
	for <lists+linux-edac@lfdr.de>; Sat, 30 Aug 2025 15:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC94B248881;
	Sat, 30 Aug 2025 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IoFk00pM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6076B223DFD;
	Sat, 30 Aug 2025 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756568968; cv=none; b=QMKBnCHxJQHCKI6AWcPfSBBik2hnyeSj7lkMSqZ+4XlbaSWQ7vE4JvAc1xNly0BTeuabSJhXvSKyD0Wsy/QmGwQa/xVZbUSePyUg0so0dL99DNJkcZMBGhPbv7kUbNlOATc/zitn79eX3iur/MLAmaXCEn2HamdPV3NUm/5hJGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756568968; c=relaxed/simple;
	bh=sCz6OtkOx1vc4ea/ZODZiQbBdd0ICmXd2PZBM3+12wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfiaNaXoa822yQfFtu/V3ivurq9B4Vtu5Pnxrmrz7JE0+LO5LTFzq3wGbGsYOGwTR+m9EaaWOlt1vG4v1+CXraQtSU8iYqSLePVJFzwMDVZ2D+jY7s5+bswfHAYwULmoeLAGyc0tRJH9WM7iJM/XQbzQ5lblP7y4f5OtEpou9lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IoFk00pM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4976E40E016C;
	Sat, 30 Aug 2025 15:49:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dHomIRKhcIz4; Sat, 30 Aug 2025 15:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756568958; bh=9plfLh/NHQsvvraG6diWzRD6eI4/nonopBwFheQd3Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IoFk00pMXcwfAL1NCebkf+p26Ps9bSLn7lCOaGhumPnP6ZHgWj75dOXvRQMYZquoB
	 UY99zu/wYJeK59uoI3ohIeuVuyt6EDF/WdL4LvLzuvuxmDDQCe9KpRWc/JLToCGMr+
	 g0HsP+3MGErFulj6FcIOOLBo6Tt4hAQJZHEchAfRVped/jO9mLCEs6jLk/o27ZriZM
	 sIqrShkeSKR1oNIk1O8A9Gb/QhpCYrowjkBRehT8RNfYH6ByH9KvN7Maqhu112K8+i
	 uSEBo0NWs5DHdHPNF+vSR7acGSCqhWyRbbx3H+Qx8gcXuE8cC90cIroPHFBLPD9ns5
	 WUwfghcOPOOqxkr30B+1eTa0i1GMheRh1CsTg+DJeH+LmCmiYZVCfr7/gG0d2lBRsy
	 5PcCxMzlr7b/bznTXYOlQPPbmhcuR6LvZ+FwX19esMgjgQJks+ds7ZoNVAu62RmPYH
	 qMexuKsKPnMgJUC/BEZuSoGgjoSsQUqiuI03C78IBmIQVsFKSegSUc7cQMpkWn0xdb
	 4b630GmJnFdSWn2FXrgmrnpy6eR1WtWYtf5xsimfhBG1Mza3L0XCF7ztAouuFk24zS
	 q7VVVZdSVfumBJFzeC5jK68goZ55u67ivQIMu9BfivJhgrX+U29V47ykuusMLdpG9/
	 kcGjhP2fcRRdHXT9apsokv6Q=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id DD9CE40E0140;
	Sat, 30 Aug 2025 15:49:07 +0000 (UTC)
Date: Sat, 30 Aug 2025 17:49:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
	rric@kernel.org, shiju.jose@huawei.com, jonathan.cameron@huawei.com,
	jserv@ccns.ncku.edu.tw, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: Fix wrong executable file modes for C source files
Message-ID: <20250830154902.GCaLMdbp6eeHS9_IO0@fat_crate.local>
References: <20250828191954.903125-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828191954.903125-1-visitorckw@gmail.com>

On Fri, Aug 29, 2025 at 03:19:54AM +0800, Kuan-Wei Chiu wrote:
> Three EDAC source files were mistakenly marked as executable in
> commit 1e14ea901dc8 ("EDAC: Initialize EDAC features sysfs attributes").
> 
> These are plain C source files and should not carry the executable bit.
> Correcting their modes follows the principle of least privilege and
> avoids unnecessary execute permissions in the repository.
> 
> Fixes: 1e14ea901dc8 ("EDAC: Initialize EDAC features sysfs attributes")
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  drivers/edac/ecs.c        | 0
>  drivers/edac/mem_repair.c | 0
>  drivers/edac/scrub.c      | 0
>  3 files changed, 0 insertions(+), 0 deletions(-)
>  mode change 100755 => 100644 drivers/edac/ecs.c
>  mode change 100755 => 100644 drivers/edac/mem_repair.c
>  mode change 100755 => 100644 drivers/edac/scrub.c
> 
> diff --git a/drivers/edac/ecs.c b/drivers/edac/ecs.c
> old mode 100755
> new mode 100644
> diff --git a/drivers/edac/mem_repair.c b/drivers/edac/mem_repair.c
> old mode 100755
> new mode 100644
> diff --git a/drivers/edac/scrub.c b/drivers/edac/scrub.c
> old mode 100755
> new mode 100644
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

