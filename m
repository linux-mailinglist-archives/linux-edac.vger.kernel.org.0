Return-Path: <linux-edac+bounces-1964-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD4E991D1A
	for <lists+linux-edac@lfdr.de>; Sun,  6 Oct 2024 10:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592C01C2116B
	for <lists+linux-edac@lfdr.de>; Sun,  6 Oct 2024 08:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D05816D4E6;
	Sun,  6 Oct 2024 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jZhzZk13"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C25042A8A;
	Sun,  6 Oct 2024 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728202108; cv=none; b=BMPTIxstHDPitpHFXDpGn9lVQpAzP5EFTrIZ98Bq1E6HCN4ZtoiWnkMO+o+vpmcFg1KKJaHlkSlk12Bt7Kg7LViJE9W6my5ksKNIZ87oQ4hZOSL3J/9DGq2LLgP3IQr9PLvz772cBicGXa1cxzeyhMrd5elrGgyMamnotRX7CWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728202108; c=relaxed/simple;
	bh=GPRQwXzi/eRjdOxZt0+cwWLYzvRQMCw+M/NUYgaozno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mf0jspahCvZg9nf4I9Dhy0KC2XMx2JduY8M2Ud+GTWAIdsvWC5oK2o31PxnDr+BLN+cmIuYRq2abNQSVzuMXrYZi6oWQcCFLr0y66vpv2eOp0ERYhoNXBL3MG6/0zJMP108V8bK2biU7RBL5rI/A7pe8cp6rSG+gq98Vdep9w0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jZhzZk13; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4907840E0194;
	Sun,  6 Oct 2024 08:08:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uCLC4dFwxtTK; Sun,  6 Oct 2024 08:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728202098; bh=/LMvIf5LJREogs4JiEAh5RaRooWLJIdYyt4QrciUcE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZhzZk13s6aeV5kC1tqzxZk6X2Qy8BogSnlGgnHdX2T6hioR0pU1DI2Pw67qqebfU
	 ENApmdh4WUsJe7BzsKitt++/debsc6RL+lDVaJ0uANNYMXnWAVkmhEFAfOqjBD17J/
	 UkdizzYmNOquc2SGlUKnx6RmpXBp942GFUpZxx4G5ZxMHuhndeDBMtqEYHXsOqu/f0
	 FKTHBex/0zww005xfuX18WANCUhz3GYfsi4/I2om52IbjIKmmvwJQURSk+QdAC6CS0
	 wnIGALgdh0WjWDQ3NmiC1eB3iQ8C8C+aPjgntTJGD+HTXfR63tlGzXYLTW7RHTnWoe
	 p9AHMuOFrEH30NmqooOygkuALue2Aw0CvSg1hOUUF/Uc4kSN7ijR5fDUEGVuZfayi0
	 /jiGs0rEL1zym3HVLA9fUYeqXm2ttDtbsBTuFEwJ5K9g1Xmp9nqhponCVnv3rHtVxk
	 tAlTGS67vk5C93y9qWlSxzLm0xQbfqc6PGy1H3rXuqPOygE+HZlCe/mx1TB35OXjvP
	 fnULgwnJD4rfLixAOtxyBesfbX9E6kfU6AFlJCx1Uy/ye8KvlWjqG6UsDQX0YbAaYk
	 I7IRPEsxi7qYaYPeZNOcFEpEUd+1ryM8IlBq9eqg8kpcPQ2955XjQ0tjlUADn4c5NG
	 J337XvcDQnYvktSEN5AVhD0Y=
Received: from nazgul.tnic (dynamic-176-003-032-216.176.3.pool.telefonica.de [176.3.32.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9FBAA40E0169;
	Sun,  6 Oct 2024 08:08:08 +0000 (UTC)
Date: Sun, 6 Oct 2024 10:08:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev, York Sun <york.sun@nxp.com>
Subject: Re: [PATCH v2] EDAC: MAINTAINERS: change FSL DDR EDAC maintainer to
 Frank Li
Message-ID: <20241006080810.GAZwJFauv4TWAICuQg@fat_crate.local>
References: <20241003193348.102234-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003193348.102234-1-krzysztof.kozlowski@linaro.org>

On Thu, Oct 03, 2024 at 09:33:48PM +0200, Krzysztof Kozlowski wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 636a84ccb5f6..03474c934930 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8120,7 +8120,8 @@ S:	Maintained
>  F:	drivers/edac/e7xxx_edac.c
>  
>  EDAC-FSL_DDR
> -M:	York Sun <york.sun@nxp.com>
> +M:	Frank Li <Frank.Li@nxp.com>

Let's start by making Frank a reviewer first. I wanna see how we can
work together, how responsive he is, etc.

My experience so far is that most of those EDAC single driver
"maintainers" become silent shortly after they get added so I'd like to
avoid yet another such case.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

