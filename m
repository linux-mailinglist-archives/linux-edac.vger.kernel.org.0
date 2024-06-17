Return-Path: <linux-edac+bounces-1300-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C689490A798
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jun 2024 09:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E952882CA
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jun 2024 07:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A7E19005A;
	Mon, 17 Jun 2024 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IR83votZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB4C18FDBC;
	Mon, 17 Jun 2024 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718610250; cv=none; b=IF41AFbxiKAvEHJuXNm4WT+o+Kjb0AxTyaTac9KcDF+U9WI2OgmNP6fOh3XwOhWp3eZHZ7jORPW7qIL02ZAvDDYXyq+Nwc428WoUfrr54XDie/4w4gZnGATCSL/cxgU8+NO8+C8m9yhgwkocBkCBvYl2B5I+wNmZPSWt+A2jZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718610250; c=relaxed/simple;
	bh=l+oou/CNKfItRttkxCF+wVH69kQkGTsxTvp6gBoNd5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coIsfzuMjLmpO0oGF4jn2C/eVMgz4Fu4Cc+hq+BHjpj0Nzj6wRrxhAScvvY63kWEzF8P+limV1bmz3FHLiH42i16Ee5q6PleIuABg4XgQLd8oJ3peIS5EncDtab0SkaeREeJ0CtsxWiUUMsr3ukHMmue4ZyopdQ6AbkrSm9B3hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IR83votZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C3F5940E0185;
	Mon, 17 Jun 2024 07:44:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gOwqiNFFBQhM; Mon, 17 Jun 2024 07:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718610240; bh=FZ6+fDmbEQkofYSo5wFximye1HQt1P1HrjYhkgcf4t0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IR83votZ39Yvsbs0pTZd+VZwbRnSqD7SqlIefEr8052MR+a5S3EOW4z7igaVsrBcg
	 B61p7OPkNOfu3SD0x0ZFW/t5TZ57aLg7vNFcTlSGBC5f5KFMjE1BhzF64dBUQsfD43
	 bIXVXttNIxE7A1TpEVM5SGcS+5069135lyiwdNXCo42ohl1dYrUo9Rj2PKfA/ivKU7
	 HFUZROWgsrwSjrtaQmwfmKFMVDQHlF2H9w/MCtQ5bxGEqDskFW+Xshiw7dDFO44XjL
	 ZGOC36OC27CpnHx6ubEshI1dosVYO54PUngwCtAaYe8B98g53srnuLW6b2pHgOfNSv
	 MmCH4zjhmkrJW6QdxthY49/me4OCmaiaK8zng/jUhMWlp4Pr11bFs7JIz+d9URELtS
	 tEZ9CjZSmvKzn93G/VrN5mbUvicd99qkM9eUdfA0h27lunBCAdgp+MZ6KLVnpDT4ay
	 MUdcy6KTHvHZbkHe0pXisuEMsajXWod00ulvomt7z0phz5XCu3W6wSfKC4bTc9F0q6
	 0wfuLw2RYgYd1J0s7XxN8N/AHh6nYW/McFLcx4KZp8XOl0iGNoCXC3dbLN6vt4W9Tf
	 HHqPbjRGlcv0POUL1d1fSXW758qo95V5i8ORJNr3mlaFgyPIJTTfyCcp/L2f1eG5Bw
	 FZT3/pz5itaKiNbb9q/qLtOQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3FD9840E01F9;
	Mon, 17 Jun 2024 07:43:52 +0000 (UTC)
Date: Mon, 17 Jun 2024 09:43:46 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] EDAC: layerscape: add missing MODULE_DESCRIPTION() macro
Message-ID: <20240617074346.GAZm_pMvJ1FeQr-Vqa@fat_crate.local>
References: <20240613-md-arm64-drivers-edac-v1-1-149a4f0f61bb@quicinc.com>
 <20240616154347.GCZm8IMxshO8YYTTjB@fat_crate.local>
 <28c653ab-af12-4857-8a32-9ea73740959a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28c653ab-af12-4857-8a32-9ea73740959a@quicinc.com>

On Sun, Jun 16, 2024 at 06:43:58PM -0700, Jeff Johnson wrote:
> My process has been, for the most part, to first fix the ones where I actually
> observe the warning, unless there is just one or two others. For drivers/edac
> there are more than a couple more that have a LICENSE but not a DESCRIPTION:

And my process is not to do excessive work of collecting silly oneliners because
some tool complains. Send me a whole patch which addresses *all* issues you've
found in drivers/edac/ or keep sending them one by one but I'll merge them all
into one. In any case, I won't do piecemeal silly oneliners.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

