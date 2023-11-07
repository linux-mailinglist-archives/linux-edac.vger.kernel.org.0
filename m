Return-Path: <linux-edac+bounces-3-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A192C7E3B69
	for <lists+linux-edac@lfdr.de>; Tue,  7 Nov 2023 13:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B55B280F51
	for <lists+linux-edac@lfdr.de>; Tue,  7 Nov 2023 12:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86A42D7BE;
	Tue,  7 Nov 2023 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VWngGHjO"
X-Original-To: linux-edac@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263F2D7B3
	for <linux-edac@vger.kernel.org>; Tue,  7 Nov 2023 12:02:34 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE4410A;
	Tue,  7 Nov 2023 04:02:32 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E96D940E0191;
	Tue,  7 Nov 2023 12:02:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lE1Uhn93tP6E; Tue,  7 Nov 2023 12:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1699358547; bh=lxN1TuhcCJQeqTAeGqqpjQdztFGsAxuhyyTGBRhcVEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VWngGHjOYgMTx4sASyd1/D4oZhFMjPizYdc01Siqc8pcBxFiVQOw+prM2T7Eu47eU
	 HlsyrIc/1ammlhA+6Uf9PcDq3jf06akyB2rnbRMAwbYOHq7ryjtZGCn1ejATF6nQBn
	 4lEQ2NUKcnt0cNcmelHEx1nTn9xqjd4LKqILd0UBPtSdf0FptaepDVbKKxEFBmst1U
	 LaItEo8ryqD+0k2vlDmC7H3yDXjHOn2KDYPZBAHoyAc/u+/u4fCQrjWclXM60W6g8K
	 cUs3Gbi6h4kQst5nf0dq/n6dIRJCDxzof0a16QGgxXHcyxgJzQLgVYjaRN8+/HSyvN
	 MlM5qsZCDIoeiQE1f6OTJ9+hOhwBGpq/C55Nz3ScHC4mchSd172jnBEyDBOS6fC00D
	 tkeofrmpnBIky04Vw0LS9//VDRymUTZeYHMC+AkgmjFwb5U8rGiOHNFGyHaR4UVLoR
	 0ycu1xjRoOQhPKvRtC+GOgtkQQLcIjRh4lkURb7lD2eJmSb+7ZQ10kZrpMZTWd/fp+
	 y2RLwTQgcZM8iUoIP+JQQkgDYndFUTputGY7jjZnoI8QqzHQPaP2N2PEi0Rdz2lG82
	 2KTN6+TNPXIZTM6BFRfhbo3qUbY957M/WjP4CfXB33vLZqB7VKLdDMiANGShERuWXj
	 BgpYTeJvq4ypNYekJxOFMNVU=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A5CCC40E0176;
	Tue,  7 Nov 2023 12:02:18 +0000 (UTC)
Date: Tue, 7 Nov 2023 13:02:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: kernel test robot <lkp@intel.com>, linux-edac@vger.kernel.org,
	tony.luck@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, william.roche@oracle.com
Subject: Re: [PATCH v2 1/2] RAS: Introduce AMD Address Translation Library
Message-ID: <20231107120212.GAZUonREyEeClfT5Tf@fat_crate.local>
References: <20231005173526.42831-2-yazen.ghannam@amd.com>
 <202310162015.fuitGuiJ-lkp@intel.com>
 <935d6e08-3754-4c06-ab25-69bda3fd8ea1@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <935d6e08-3754-4c06-ab25-69bda3fd8ea1@amd.com>

On Tue, Oct 24, 2023 at 11:30:01AM -0400, Yazen Ghannam wrote:
> Any thoughts?

Yes, no one cares about 32-bit:

---
diff --git a/drivers/ras/amd/atl/Kconfig b/drivers/ras/amd/atl/Kconfig
index 88324c1978d8..6ddb9ac7ea30 100644
--- a/drivers/ras/amd/atl/Kconfig
+++ b/drivers/ras/amd/atl/Kconfig
@@ -9,7 +9,7 @@
 
 config AMD_ATL
 	tristate "AMD Address Translation Library"
-	depends on AMD_NB
+	depends on AMD_NB && X86_64
 	help
 	  This library includes support for implementation-specific
 	  address translation procedures needed for various error

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

