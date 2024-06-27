Return-Path: <linux-edac+bounces-1394-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359FA91A0CC
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 09:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2658282C4E
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 07:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049396CDAB;
	Thu, 27 Jun 2024 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MPHJENRH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A134B33987;
	Thu, 27 Jun 2024 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719474663; cv=none; b=V0urLu54w/u1Sh48vlCXeLp1letzykme8HsB34mndZ8z8EhdH3StIowPBvl4HZo+83rM1xr6zuVSyCXqmDueZb1cuDyYL7jYelms117mnK2Bn9KMVN/XTaVWVMVxZFaNpjXmpZNm5P9w91NpKmfhp2sjMAEVhn5aQsV98oGCUjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719474663; c=relaxed/simple;
	bh=7zGoCZ6FKEQqdYymcsGGBHM106RVqtWPdVI72vsRi1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8Fz1dk4YT0gmsq5ZJ9XDOTWeN6cOTJdrL26hGLuflONwyh65zvPsGTwj80bBDtR7n4KQfCiq1WGLw70hm+cMSYFpyeN2ulpNg9GUZEs6O0Br4nT4TU0xf4pocBrpyOlW86GlxvOJwzbPeS6d3qy/deEedBhFD8B3XRfaCyWVJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MPHJENRH reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7CA0540E0218;
	Thu, 27 Jun 2024 07:50:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SGuIrKFlLPNL; Thu, 27 Jun 2024 07:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719474655; bh=aLoddrSRjlxs7+z/3BRtEWZSpcrVkpWAVVnm+H1+Luk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MPHJENRHwn+Bbe7bd6KzV/aVSxqxwb0VZ+l7XGRaFWMDSBXhGr3BJzSMMo0Cz37Bh
	 g6/caTA0AvoMUgINWH/angxY8/NlVwoUsB82Xhh2+tJymCeTw1v2MPiNxfapaHz8ln
	 zQLn2rHopluNjDXs/N0Hx+PLIeFuvl0NxUXZotJF0apTxyHXcpS37vQXg4GVX9MFZC
	 dOXAMwk+daNr9/9KvcEvtHKgHE5h4NhYQPQ0t/dW6/05HRrgnrBj/n7D7tDKBZ2Lcs
	 O2093KhyrBdezP4l0TVxrTyPaFmBLbc7N0Tt76c4C3kIEP0L29PmYJ8WEdtkJ2bpix
	 CzXmA+NT3ipYK7F4X6ZwQKmDi9WVpU/DXAYKV60x3B2eZUnqBReyDeHcPtCLRQb02s
	 azpxodPUNhf78qOoIoG5M6VsEAoiweybboe7mUxLf1NxKL4gI1EBWVCdfO+B5yWfaF
	 PtDnbB/gSte6aFpbomn7ERr/zn8U16tZ8TaPaEHH2cVk7qtN4Yuvd5PEQ2KysPfNPF
	 /HckQfjSxGFsvkjUteqX3jDnneKdPbP1UpkDcPYVgAZCgkDmvDDjfJ0bQRNOAUerO1
	 weTI/jrtpRJ0C4OEsQWqx9KYhYTOkiIpOv3SaT4y1Et4IfCXM7aywQxtuyUbj9Bcud
	 gItQA9WdzW3WpiVqOzqgb0v8=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1292240E0187;
	Thu, 27 Jun 2024 07:50:39 +0000 (UTC)
Date: Thu, 27 Jun 2024 09:50:34 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Daniel Ferguson <danielf@os.amperecomputing.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Len Brown <lenb@kernel.org>, Shengwei Luo <luoshengwei@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] RAS: ACPI: APEI: add conditional compilation to ARM
 error report functions
Message-ID: <20240627075034.GBZn0Zyj_3n8XnKOQm@fat_crate.local>
References: <cover.1719471257.git.mchehab+huawei@kernel.org>
 <95baa46a5e1c88f08e328dbbfbbd01602e092234.1719471257.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95baa46a5e1c88f08e328dbbfbbd01602e092234.1719471257.git.mchehab+huawei@kernel.org>
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 09:01:08AM +0200, Mauro Carvalho Chehab wrote:
> @@ -570,7 +571,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_he=
st_generic_data *gdata,
>  				    error_type);
>  		p +=3D err_info->length;
>  	}
> -
> +#endif
>  	return queued;

The previous version I saw, had it right. "queued" was outside the ifdeff=
ery:

drivers/acpi/apei/ghes.c: In function =E2=80=98ghes_handle_arm_hw_error=E2=
=80=99:
drivers/acpi/apei/ghes.c:575:16: error: =E2=80=98queued=E2=80=99 undeclar=
ed (first use in this function)
  575 |         return queued;
      |                ^~~~~~
drivers/acpi/apei/ghes.c:575:16: note: each undeclared identifier is repo=
rted only once for each function it appears in
drivers/acpi/apei/ghes.c:576:1: error: control reaches end of non-void fu=
nction [-Werror=3Dreturn-type]
  576 | }
      | ^
cc1: some warnings being treated as errors
make[5]: *** [scripts/Makefile.build:244: drivers/acpi/apei/ghes.o] Error=
 1
make[4]: *** [scripts/Makefile.build:485: drivers/acpi/apei] Error 2
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/acpi] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/mnt/kernel/kernel/2nd/linux/Makefile:1934: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

