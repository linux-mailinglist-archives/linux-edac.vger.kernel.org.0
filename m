Return-Path: <linux-edac+bounces-3878-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB38FAB1D66
	for <lists+linux-edac@lfdr.de>; Fri,  9 May 2025 21:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E437B9139
	for <lists+linux-edac@lfdr.de>; Fri,  9 May 2025 19:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1305625DCED;
	Fri,  9 May 2025 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CGHBQHWe"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099025DB17;
	Fri,  9 May 2025 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746819465; cv=none; b=ki58WrVTVVhanzKQAcr9MMBr1X52QPx0r+j26WT+NQXNPAL7xelNIHId7wK+CQYMetA+OnqrZHggnz5F+v2FQcBK0PzTQSuqiIItRi9bfywuzeMVDJtuYzHwN5cs0gI/aSrVQcyCUQlk4jBJBYS8R5ztRX/+nOs2NtJgCnj9hag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746819465; c=relaxed/simple;
	bh=8ZVz+sM2e38LEUbul09GjJfrj5dzyu8vCUAhuzz5CWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRLtdJ1rHXFkqpei6eRy42nNpM6FeX/e/Kq3Us/YVcwJJcoWUQ7PIohe6jMNrj7uZlELAppKz+bn5URc1yiO1nt4y/TjNC+v5L/64vfMVPEm5/BxQAcpWnl249Ad+OuNRIMhujybtgI9+e1J3YO3+WSy6H2j4wcPTb3IoyLKVs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CGHBQHWe; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 562C940E023E;
	Fri,  9 May 2025 19:37:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1dJBXWql5nCj; Fri,  9 May 2025 19:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746819455; bh=KZxuyNV+T/kC6I+JBt8h1fqec+RQznGYJxv2+6xlmsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGHBQHWeU+grgUNGE19DOAdePgmdRhszVJUUO6w66pAkS/7NPngyEfaj7SvLSSRva
	 cD5n7eVSVZ7h+h46SLWnGUfCaickXT48zxlik/5NEyUVhOzIhCbB19gJGucfln/Vzf
	 Inr7FX2Y6JMg9rC/gFWqYL3uNlkM2Zkm7tSO9S04VZwebpazADz2+t4TiBKm+XC3l3
	 PA2EjIjNVCbB2jkKHeKhqFUBhjKXrOEGDn6M/EdSbZMZ+6sp91AQRkmivnwlNY1JJI
	 G+XgMYt1sWXcm5b2I2KIgak64p8yc88ffaKuQ0Ao5XIDv698o1sWNH2LWius7Rrj4+
	 NNmUVajFmqBBtYVxlXbBpiyHE/kr+JZ7om32W+6yEpIZvyRiERDvCtvrEkTudzp4fR
	 RaBVwpFd4ihgpDpVNH/vS0rVe0J8aYGT0nWgtae1K1GBUD8evjXZElS/oFFqGMIYRa
	 OYPU3lJyWCYloRZtAeNCzb9Cbcb+vFTEd4NRUb0DhE7sM4j7qupLlUhxzBP54++kZY
	 oyhA+aemGWarEbkQNgaS7OAa5hgedgJeBrK6m5gbbphZVFEn1MLe1HhykN+aO+8pOU
	 ECpprSlFAsty8PZ0+qD5J5ACJH3I7LEOEtrt1uFcPCg2UnMUrUXxyhOIAbpvkxjlAW
	 89x7Q7ohM5zzVbsQGEpD1Y5o=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E151E40E015E;
	Fri,  9 May 2025 19:37:27 +0000 (UTC)
Date: Fri, 9 May 2025 21:37:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 15/17] x86/mce/amd: Support SMCA Corrected Error
 Interrupt
Message-ID: <20250509193721.GRaB5ZccvAs9ST_3IM@fat_crate.local>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-15-8ffd9eb4aa56@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415-wip-mca-updates-v3-15-8ffd9eb4aa56@amd.com>

On Tue, Apr 15, 2025 at 02:55:10PM +0000, Yazen Ghannam wrote:
> @@ -306,6 +306,11 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
>  			high |= BIT(5);
>  		}

Yeah, the above statements explain in comments what they do so that we don't
have to define the bits but use them straight "naked" with the BIT macro.
I think you'd need to put something along the lines of that text...

> Check for the feature bit in the MCA_CONFIG register and confirm that
> the MCA thresholding interrupt handler is already enabled. If successful,
> set the feature enable bit in the MCA_CONFIG register to indicate to the
> Platform that the OS is ready for the interrupt.

... here.

<---

> +		if ((low & BIT(10)) && data->thr_intr_en) {
> +			__set_bit(bank, data->thr_intr_banks);
> +			high |= BIT(8);
> +		}
> +
>  		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
>  
>  		wrmsr(smca_config, low, high);
> 
> -- 
> 2.49.0
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

