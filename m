Return-Path: <linux-edac+bounces-3938-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E19B3ABB825
	for <lists+linux-edac@lfdr.de>; Mon, 19 May 2025 11:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4ED18910BE
	for <lists+linux-edac@lfdr.de>; Mon, 19 May 2025 09:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F2926D4C5;
	Mon, 19 May 2025 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KzEnOhtS"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622F3226D1D;
	Mon, 19 May 2025 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645485; cv=none; b=aJp59Z8Yt4LYWD0cxw+YG0j6PfhqzazJ05uYnIVfvQ4cIO8hYeBaoQJxJR6817J1zSKyEVylSJ4oXcTYoa9nKoZwZ5x9cmzrrje7DxqcrKVtw6jM10dWo6ZHSB0z5DHrOPzlHYjOS1JSahIz/BlgfFhFC57PdINuojecAqA34uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645485; c=relaxed/simple;
	bh=5wSfd8iVGQRXhXY5iUwyBOYl/S5k745NZ69NsV4xJxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rxt7KS3joojnPJ4Vr4D3jGFoeOSly94LQidskKImvCU1H7/SZ6BQEAnqJ73a4cxycyqPbE2MWIPZX8Bws81Z+mahcIuRMTiIRnA3zV8xIxGSRZQRPPbbN6Yager2vTFPSdNRBhYeB1/UmO55xv+Iy71HIAGIPbrOu+0xWA3bOWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KzEnOhtS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7AB3040E0238;
	Mon, 19 May 2025 09:04:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Hkju7R45Z25h; Mon, 19 May 2025 09:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747645477; bh=QCJTUXLOBmRGJZAYdNXk9FNir1HXdrpoMGsuigXKN7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KzEnOhtSEbzy4G6BhBh6fp9JLZIEjzxXJQH+0SZQ9QA1SL1AtnS19zhapU3dLmkeG
	 os1xYVSJm+P2Rtc79poPx5AvT4T5BYuRKac86K1ID9Aun9xitmoE3kCPnxM/Z/4erI
	 b8caNgDhfcFbnrbaQXWhu80xcHzHYxqD2gjcVojcKFWvbXyMG10+Y1V/NfAY2NBQWz
	 IWf4Me70vVFnIjoSPHo9769KQKqh2iMs9uSDtqWktdl+qsPd3XOEZu/zrV+RTXaNY8
	 nuPK7mRUFCOtvszSyZEPIG/AtEdju+5WS0oOzir2QgbFK06KQV+DYva7s7qIG/bnQV
	 Y5k5Cjf5ydyxJq28KOjmXjb3JJoXUiUrdEAYkAsOSyTPAEhbZmmFIOJ4Ex/QcpXjKT
	 mVTDRwpH+BSNYggyX5xv0TF+dURkg9dQYr3IzbXl7BMHlDoimx/Ns5IR//EGNbRTtn
	 vk2zavQY6IKC2eOefkSTT8vE5zi8bgRfxXDz7EnDMiwAOG8UdaYFFY2f3KRGV8Ufna
	 dKTU0WBSxEkPJeLjXAIbTA6gLR8+P9rigdkfcY3bx4UCpycAY6dh4ZrO8DOg42sTVR
	 PcxRGRRIR/Sb0o8jKP7eDwAyhBMaBFdM6rtGUpv3Fhja3pnKBOMJgej7bT2RFaprC6
	 qQgMpCUfZoEgdInty9TJK1pk=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 57C6440E0173;
	Mon, 19 May 2025 09:04:22 +0000 (UTC)
Date: Mon, 19 May 2025 11:04:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc: Tony Luck <tony.luck@intel.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
	Marc Zyngier <maz@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] EDAC: Add EDAC driver for Cortex A72
Message-ID: <20250519090421.GHaCr0FWKaH1v1b5lV@fat_crate.local>
References: <1747353973-4749-1-git-send-email-vijayb@linux.microsoft.com>
 <1747353973-4749-4-git-send-email-vijayb@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1747353973-4749-4-git-send-email-vijayb@linux.microsoft.com>

On Thu, May 15, 2025 at 05:06:13PM -0700, Vijay Balakrishna wrote:
> The driver is designed to support error detection and reporting for Cortex A72
> cores, specifically within their L1 and L2 cache systems.
> 
> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3563492e4eba..1fa51e39e266 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8430,6 +8430,13 @@ F:	Documentation/driver-api/edac.rst
>  F:	drivers/edac/
>  F:	include/linux/edac.h
>  
> +EDAC-A72
> +M:	Vijay Balakrishna <vijayb@linux.microsoft.com>
> +M:	Tyler Hicks <code@tyhicks.com>
> +L:	linux-edac@vger.kernel.org
> +S:	Supported
> +F:	drivers/edac/edac_a72.c
> +
>  EDAC-DMC520
>  M:	Lei Wang <lewan@microsoft.com>
>  L:	linux-edac@vger.kernel.org
> -- 

You can merge this one with patch 1.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

