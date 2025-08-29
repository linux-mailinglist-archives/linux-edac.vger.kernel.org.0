Return-Path: <linux-edac+bounces-4706-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A095B3BABB
	for <lists+linux-edac@lfdr.de>; Fri, 29 Aug 2025 14:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C49C1CC1ADC
	for <lists+linux-edac@lfdr.de>; Fri, 29 Aug 2025 12:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C82D31158E;
	Fri, 29 Aug 2025 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Qlq3eH4H"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BC82C3769;
	Fri, 29 Aug 2025 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756469026; cv=none; b=W7fWlTn27qHXQBUIVQbrjoUtA3vlRirTAP1t6w8fxikQho3OHwVFWOnW9zRJ5zGUayP5qNYtycMP/5rsU62DigONT01VA7c3BjFa80NAJQMNFw9+ymmJL9TkXJMSZq8Q+CcOPyun02N/8EkWaavzSeoZAguiT82P1FQmYe1Q+pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756469026; c=relaxed/simple;
	bh=115NZsIvYnV2ui7X29W/zJVYkk+Lpf5KB2g0omL/oIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSOK/sUgi6cKbjwlJIaQ+nKdu4VrvT0EOzh6Cb5yZCBmPFeHcfNKF63FGje0lYWuFTJLBcCkxgHobeSklxHbVhHVUmjiev8gPNtXPc5uw8h+g/wS58odN6Ao2z4+cwy10lvgfNqJJcCJzatzuMDON21BSyMbwQ1vmKdIIvBKkB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Qlq3eH4H; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DBA5E40E0177;
	Fri, 29 Aug 2025 12:03:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id l2hP3T9UqLB9; Fri, 29 Aug 2025 12:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756469016; bh=SxB2Y9n5mlykbRbC9Skan0hwwaj5XmCQ9toF0m+gFj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qlq3eH4HyEgfDAmQN5rajn1TTv/4KwpghWNYdm7cNp5Smpmw3Ig+Zr79zglRjBXsk
	 ftJ4T2cwwKMDxz9RL3byIrnVJz6aIgno9r+7do3nnHxx6lyz/Y34wr2YCR1Pcg6mBz
	 mxlrUPOuAM+O3XrhxtgWE6MimR0r7Fyjo/1bjxz65ss2Sq33VhxFXZTdEXSRu/kBVF
	 PwEiS/92dGtu8o24QBy3cq6PZdG3YKdMg99nlqx2o0+x1wUV07hswarFGsmWT6w2Fu
	 a/GiWKbxFUnB4PhlwRnFGdmyT8mC0mxpGrokWJdYrFDdgOmHkow0WW/sJ5STusRgSx
	 gVmx1NPQhwMgvy2r8q1HBsS607aPQYS9W9bHgXQ1rJliQ06tWL50o0sY6jJPpGsjDv
	 lbQapdOqfJm7dp9GgBC8Zgy24nEy+lXbBHQ8Ed7QuLWP86pSqRculdZ+vybyEAp1rl
	 AT0oqUiatRvURj9mCpVu8pj2JZDFwxXr1Xogc+A7PPfViNU0nAK427Xog0H00asTYy
	 hqullDyvLMcRFutcTGmQ1n5/Wxh8T2WoTNjhOIHnwZc/kBHB5mbFeO6Sfgm/Iu9QW2
	 +eru3PM9iUtd0TPd11iSTKVn6ozSfQ/PUBFOlTtoLIdW3D6W9yRC3x3BBdR2jSjST2
	 32l1d5ej1uiL7JyP4lwPXrow=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3569540E0185;
	Fri, 29 Aug 2025 12:03:19 +0000 (UTC)
Date: Fri, 29 Aug 2025 14:03:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, git@amd.com, ptsm@linux.microsoft.com,
	srivatsa@csail.mit.edu, shubhrajyoti.datta@gmail.com,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>
Subject: Re: [PATCH v8 2/5] cdx: Export Symbols for MCDI RPC and
 Initialization
Message-ID: <20250829120312.GKaLGXAGPy4wdtsVac@fat_crate.local>
References: <20250826052914.2066884-1-shubhrajyoti.datta@amd.com>
 <20250826052914.2066884-3-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250826052914.2066884-3-shubhrajyoti.datta@amd.com>

On Tue, Aug 26, 2025 at 10:59:11AM +0530, Shubhrajyoti Datta wrote:
> diff --git a/drivers/cdx/controller/mcdi.c b/drivers/cdx/controller/mcdi.c
> index 90bf9f7c257b..6f52d8dac907 100644
> --- a/drivers/cdx/controller/mcdi.c
> +++ b/drivers/cdx/controller/mcdi.c
> @@ -100,6 +100,19 @@ static unsigned long cdx_mcdi_rpc_timeout(struct cdx_mcdi *cdx, unsigned int cmd
>  		return cdx->mcdi_ops->mcdi_rpc_timeout(cdx, cmd);
>  }
>  
> +/**
> + * cdx_mcdi_init - Initialize MCDI (Management Controller Driver Interface) state
> + * @cdx: NIC through which to issue the command

NIC?

/**
 * struct cdx_mcdi - CDX MCDI Firmware interface, to interact
 *      with CDX controller.

Apparently there's a NIC behind this thing.

> + *
> + * This function allocates and initializes internal MCDI structures and resources

s/This function allocates/Allocate/

> + * for the CDX device, including the workqueue, locking primitives, and command
> + * tracking mechanisms. It sets the initial operating mode and prepares the device
> + * for MCDI operations.
> + *
> + * Return:
> + * * 0        - on success
> + * * -ENOMEM  - if memory allocation or workqueue creation fails
> + */
>  int cdx_mcdi_init(struct cdx_mcdi *cdx)
>  {
>  	struct cdx_mcdi_iface *mcdi;
> @@ -129,6 +142,7 @@ int cdx_mcdi_init(struct cdx_mcdi *cdx)
>  fail:
>  	return rc;
>  }
> +EXPORT_SYMBOL_GPL(cdx_mcdi_init);
>  
>  void cdx_mcdi_finish(struct cdx_mcdi *cdx)
>  {
> @@ -554,6 +568,19 @@ static void cdx_mcdi_start_or_queue(struct cdx_mcdi_iface *mcdi,
>  			cdx_mcdi_cmd_start_or_queue(mcdi, cmd);
>  }
>  
> +/**
> + * cdx_mcdi_process_cmd - Process an incoming MCDI response
> + * @cdx: NIC through which to issue the command

ditto. Also tabbing

> + * @outbuf:  Pointer to the response buffer received from the management controller
> + * @len:     Length of the response buffer in bytes
> + *
> + * This function handles a response from the management controller. It locates the

s/This function handles/Handle/

> + * corresponding command using the sequence number embedded in the header,
> + * completes the command if it is still pending, and initiates any necessary cleanup.
> + *
> + * The function assumes that the response buffer is well-formed and at least one
> + * dword in size.
> + */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

