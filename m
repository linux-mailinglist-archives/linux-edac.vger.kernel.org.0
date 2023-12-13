Return-Path: <linux-edac+bounces-231-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BAC80CE39
	for <lists+linux-edac@lfdr.de>; Mon, 11 Dec 2023 15:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 182B1B20DA5
	for <lists+linux-edac@lfdr.de>; Mon, 11 Dec 2023 14:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62221487A8;
	Mon, 11 Dec 2023 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TFgvBWqB"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CFF386D;
	Mon, 11 Dec 2023 06:21:15 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5903040E01AB;
	Mon, 11 Dec 2023 14:21:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Z2N06UjmoT9y; Mon, 11 Dec 2023 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1702304470; bh=gezEdtYhaIxe/fWsl459Ba6u1C7m+8fj9hdgHURkMxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TFgvBWqBOCSqAp+bJFiNyhAooxk12oHs3vH9E9Cg3ZmHNguLYvSVhEIRD97Hvmc8o
	 kLzfTbTOIzwHP3k2a50131kbU0dEMV/o7G8X9aK0nrfyZ8QBft/1nRoPesV4dMPVy6
	 nlF0zlmo9tUNHGIAlCNHaeO0OfWvwlPW+81hsK4M1nA4IuonRZIqSS2Vv44ZozrbXJ
	 lz+QkTJbt0+qmyQvtj5WO1UvCQjmnBSOH31GrChFmwu+PR7WnlRJBWudwK0C6cc2uu
	 gYyckDwW+XS7nXoAsnFmXl4LidAr1qoROTj0rAWKJgDM5060hNLt+W3L2EVd9bgAld
	 BrF7EgV14xqBKdUbvYJB2KVr4wXGXb/dAZ7Gdplh2yy2MvscQBSLL8NIuqI4c9cOWp
	 zJDocthdv5rjz1xnDxAJ4C8ggV1mJNAYERvej7IjX4uGVYC/MvP3o7wKFgcCsDHvA6
	 zJGs/EcX6k/9Uj2t4fYY/elzU54h6gpcOl5lykXd6BaC0UG6S/E4vzRww/9Lr24WDg
	 6feMSI1ob7sR2A6TQ7A6A6Evr/wZUuLhA4pDWC3UScayh7ASC7rwk6aJ4lCkPBq2X3
	 vAdoAd0rp/KzRVxxiZmh3ajduLm6MEkyQkyPvsYNlD2eZXJ6HZL79SAbtnGaaF552Z
	 rdtb1vSmCQLsr1nLejEqXvzU=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F69440E0140;
	Mon, 11 Dec 2023 14:21:01 +0000 (UTC)
Date: Mon, 11 Dec 2023 15:20:55 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, william.roche@oracle.com,
	muralidhara.mk@amd.com
Subject: Re: [PATCH v3 1/3] RAS: Introduce AMD Address Translation Library
Message-ID: <20231211142055.GHZXcax0W+WD5/YBgm@fat_crate.local>
References: <20231210194932.43992-1-yazen.ghannam@amd.com>
 <20231210194932.43992-2-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231210194932.43992-2-yazen.ghannam@amd.com>

On Sun, Dec 10, 2023 at 01:49:30PM -0600, Yazen Ghannam wrote:
> diff --git a/drivers/ras/amd/atl/Kconfig b/drivers/ras/amd/atl/Kconfig
> new file mode 100644
> index 000000000000..fcff387faa33
> --- /dev/null
> +++ b/drivers/ras/amd/atl/Kconfig
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# AMD Address Translation Library Kconfig
> +#
> +# Copyright (c) 2023, Advanced Micro Devices, Inc.
> +# All Rights Reserved.
> +#
> +# Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
> +
> +config AMD_ATL
> +	tristate "AMD Address Translation Library"
> +	depends on AMD_NB
> +	imply AMD_ATL_MOD
> +	select AMD_ATL_STUB
> +	default N
> +	help
> +	  This library includes support for implementation-specific
> +	  address translation procedures needed for various error
> +	  handling cases.
> +
> +	  Enable this option if using DRAM ECC on Zen-based systems
> +	  and OS-based error handling.
> +
> +config AMD_ATL_MOD
> +	tristate "AMD Address Translation Library module"
> +	depends on X86_64
> +	default N
> +	help
> +	  This option provides the module component of the AMD Address
> +	  Translation Library. It will be selected automatically if
> +	  building the library. Minimal dependencies are given to avoid
> +	  build errors for modules using the library.
> +
> +config AMD_ATL_STUB
> +	bool "AMD Address Translation Library stub"
> +	default N
> +	help
> +	  This option provides minimal built-in code to support the
> +	  AMD Address Translation Library module. It will be selected
> +	  automatically if building the library. No dependencies are given
> +	  to avoid build errors for modules using the library.

So, provided this stub thing even makes sense (I need to continue
looking first since this is a huge diff), you don't need the help text
and the bool prompt: a stub is prompt-less and is selected
automatically.

IOW:

diff --git a/drivers/ras/amd/atl/Kconfig b/drivers/ras/amd/atl/Kconfig
index fcff387faa33..348498d49b01 100644
--- a/drivers/ras/amd/atl/Kconfig
+++ b/drivers/ras/amd/atl/Kconfig
@@ -32,10 +32,4 @@ config AMD_ATL_MOD
 	  build errors for modules using the library.
 
 config AMD_ATL_STUB
-	bool "AMD Address Translation Library stub"
-	default N
-	help
-	  This option provides minimal built-in code to support the
-	  AMD Address Translation Library module. It will be selected
-	  automatically if building the library. No dependencies are given
-	  to avoid build errors for modules using the library.
+	def_bool N

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

