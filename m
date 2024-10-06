Return-Path: <linux-edac+bounces-1966-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE74991D39
	for <lists+linux-edac@lfdr.de>; Sun,  6 Oct 2024 10:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C8ECB217C8
	for <lists+linux-edac@lfdr.de>; Sun,  6 Oct 2024 08:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AC9170A01;
	Sun,  6 Oct 2024 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ipP/kjX3"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2062616F0CA;
	Sun,  6 Oct 2024 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728203297; cv=none; b=kOv/xXoiTrm8Rctqwaq2DTn2KZkmDldurYkJCtJ8hHJ4zH3Zm217KYbm/i8IdXf9rNVsFIrPme3A+vROv22nr2aLGzgKYXNJrY92y6Z9uKg3eeQ+YjHkiLGhvzcJxI8+mMTNYO0ilJ/hpIPX/HId3hPO2d7I2bzUFHtL0AqzZ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728203297; c=relaxed/simple;
	bh=lpZs4vhLXbcbVhOdexr3qYP7xkj7h5DccHqwriq8dy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlTZRXLV/e7l2B5VzqEGoek5dWv1CbDIxs8uXTJs35akjPqsSDocAn2J5J/KlJ//U7+rGKas7kMhqklxqu/2tcmBMn3pmVjLPwgQ/efn0lDf5SqGySO5ZkZOwa3c9alk5F4x5Ubly+iG5zzf/IvwHTu1w7QA5TpqqaOrjGvMRO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ipP/kjX3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 095A840E01A5;
	Sun,  6 Oct 2024 08:28:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Jf7AsJawZqxF; Sun,  6 Oct 2024 08:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728203289; bh=XPe/p8+A/ICybqUJWGk+fxH/CznGQ9Jdh3wGEPUOivA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ipP/kjX3jk1GN9HmHu2j4CynLKSl5uKNC5FUnFoa58yVuYYU6ep9nZxS5Xb4XNIAp
	 VAoao2tIAZSpnKaL8wAkNYJO54WohQdkup+oogMAAcG7acQf25x8jmQd3f4ekjaVqn
	 XXfRMXbmCLWEfKDwoNgiNiXRh3YQLxL2mSNQ+McPYVLBcVnpvXRdD7XJ5VLsZZdPmz
	 CsSFmfwQojeXg4QRVnXbKs00VMGymqOUsv70BxWQz1GzKkHNtZLpXZWeSk0wzcUS0r
	 KO2D8pJotnCbB2KMmNS+XnoRRP5LHjIVF2zajqHtNj4BUSBMgiZD/NRVqWs5nTcDxN
	 wJbr3vqcM73ApRiSFxdAV4vb/7Rt7lHgUyWFE0oT4fQElx7NFafifR4xDsVRAR4Tbv
	 Km0TYAsEDqFKVFxC/0CPWwGo5KfIMl1E6KTIVwSQ0NB+o6bELfaTLqJN9pMR4ZxQ58
	 3djsJ6HyKj4Pmy4iV10HTlIeE3Ff3H1z1OD5ydHa4FAWiDX7ElyYKXmEq7UAZAv6jV
	 s5X3umr6t1TFIh99TolIHxctvKeRR64A8d/Ajg1Y+/G/xEfFPW4dvvArhK4E+j3Pfq
	 MjvmelCmpJ44GHgDbMdDpFxxjIaaHAxz/GMeIQAGrEIOiZ5W0wZaZpV8AOntJlzIWj
	 JrgVjVSYvLL26Jw+GRWcpEek=
Received: from nazgul.tnic (dynamic-176-003-032-216.176.3.pool.telefonica.de [176.3.32.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 93B9040E0184;
	Sun,  6 Oct 2024 08:27:59 +0000 (UTC)
Date: Sun, 6 Oct 2024 10:28:00 +0200
From: Borislav Petkov <bp@alien8.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev, York Sun <york.sun@nxp.com>
Subject: Re: [PATCH v2] EDAC: MAINTAINERS: change FSL DDR EDAC maintainer to
 Frank Li
Message-ID: <20241006082800.GBZwJKENEExy1RKXwc@fat_crate.local>
References: <20241003193348.102234-1-krzysztof.kozlowski@linaro.org>
 <20241006080810.GAZwJFauv4TWAICuQg@fat_crate.local>
 <127856ca-fb79-45f5-ad0a-8aa219bae85b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <127856ca-fb79-45f5-ad0a-8aa219bae85b@linaro.org>

On Sun, Oct 06, 2024 at 10:20:02AM +0200, Krzysztof Kozlowski wrote:
> Can you change it to R: when applying or you want v3?

Sure, will do.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

