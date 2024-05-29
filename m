Return-Path: <linux-edac+bounces-1152-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 321EA8D3D65
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2024 19:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67081F241FF
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2024 17:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0351A0B1F;
	Wed, 29 May 2024 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cvUbEcTc"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CC0139588;
	Wed, 29 May 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717003711; cv=none; b=LcwQfGXDoY66keY0/GIK9duegmZd+ddxKJybwuX81bxRkfJ/HgJbh+p0Jf9oi36CP4gBT6lF8PR/mT8q+wP2bx0wBtUVv3v4YgXB3IzAzm/A8k+hHiqEfUBqMEdXJPQbwwvZCosH5kiIvg8yubX3/S9V0/6ZAt48h7aCupv5rdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717003711; c=relaxed/simple;
	bh=Xn62FQDeOcI22U6T4wmavHVUs2A0kMDlDLzP9wDTp2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jcy4Ka6Eg4RtUYQy9qGZ/u42r2iQy3w5ajCuG4BJH6dp4ry+36dR/vMMrKh8yIHAmDKQBwSXjek/UInkwnZS0TgWbeiunHDTWtTzQLHoX8x4MY/XiJFnbKbqjCv7XhbE06oWxyW1/WGsKfbPQ6WooC8JIvFOGJ/lz1ATN9/J5sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cvUbEcTc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 59CFC40E01A3;
	Wed, 29 May 2024 17:28:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bvCqK1uN6QJI; Wed, 29 May 2024 17:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717003703; bh=BIRj5m4B+ie6j8SZ7c+wDdfEFA6xrylwa2yz22hR+Zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cvUbEcTcF8sMBAxiqQQExdbRoqr9ePK2KcvOy7ZdR9ejB3VHU/9vokUdj1fZY+sTn
	 o3lcCb6h5RupYxqf+h/l4iUTTuWhaLs3sXi95qY2PCm3MYI3Wzdh5eBXWhVhvq3OLP
	 SlWV5x+J9nXnWqSMhr8HT/pwuWSKVBydoVwbtqCYyp2kazEYxjVxaQ0rcW3EQpuHGL
	 oOlvcT/eZKKZpSH4mS5zkLtP+wwiXmON3eEfboG4cPO63GEKHHG/dNW7pVyNM/r9bz
	 t8Zywp+ePT+XjpY+Q/wS9Dlp9c3R5zO6aBSNCk3dmJFzqWVoQqrlp9zuEwgH8FbGJL
	 +Q+CvQeBbOSsKO6ocsdhWqIHUWjOyHhrMDzlQAhZsIK+bR0RzxApMVsBO/k5RS8gap
	 1w6CnR2f6bTRb9118L6YxfW0Fnjv4JT8YLk6q+D8WM5Rlc+T2bdbBWkkNlrSDLOyqq
	 yd6iVtX4qxLHjkwE14Yw4G3x0ay1FEauvgYSV6KEz+2P6RBOykoXS4pR9tEzATI8ai
	 m8u6Me3OF5xQNlm/b451wiwuybxehEJgZK/K4QOqRlkCFaf83bPsMB9KwR3P2dT4Dl
	 NLf1UEfBni5I2LCmRpmu2ZE4y2SuWFbWnQkq3ZSJuqNg3GJhm+j4srjCRjHHVD+4Jc
	 QyO12lioUzZxZy6HRqxDpqf0=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1268E40E0192;
	Wed, 29 May 2024 17:28:16 +0000 (UTC)
Date: Wed, 29 May 2024 19:28:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH 3/3] x86/mce: Use mce_prep_record() helpers for
 apei_smca_report_x86_error()
Message-ID: <20240529172809.GJZldlqSr5km0frQ_o@fat_crate.local>
References: <20240521125434.1555845-1-yazen.ghannam@amd.com>
 <20240521125434.1555845-4-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240521125434.1555845-4-yazen.ghannam@amd.com>

On Tue, May 21, 2024 at 07:54:34AM -0500, Yazen Ghannam wrote:
> Current AMD systems can report MCA errors using the ACPI Boot Error
> Record Table (BERT). The BERT entries for MCA errors will be an x86
> Common Platform Error Record (CPER) with an MSR register context that
> matches the MCAX/SMCA register space.
> 
> However, the BERT will not necessarily be processed on the CPU that
> reported the MCA errors. Therefore, the correct CPU number needs to be
> determined and the information saved in struct mce.
> 
> The CPU number is determined by searching all possible CPUs for a Local
> APIC ID matching the value in the x86 CPER.

You're explaining the code again. :)

>  	for_each_possible_cpu(cpu) {
> -		if (cpu_data(cpu).topo.initial_apicid == lapic_id) {
> -			m.extcpu = cpu;
> -			m.socketid = cpu_data(m.extcpu).topo.pkg_id;
> +		if (cpu_data(cpu).topo.initial_apicid == lapic_id)
>  			break;
> -		}
>  	}
>  
> -	m.apicid = lapic_id;
> +	if (!cpu_possible(cpu))
> +		return -EINVAL;

What's that test for? You just iterated over the possible CPUs using
"cpu" as the iterator there...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

