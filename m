Return-Path: <linux-edac+bounces-2632-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2479F9D82E2
	for <lists+linux-edac@lfdr.de>; Mon, 25 Nov 2024 10:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8AF3163E8E
	for <lists+linux-edac@lfdr.de>; Mon, 25 Nov 2024 09:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8DF19149E;
	Mon, 25 Nov 2024 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="FPReAO52"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E1D191F92;
	Mon, 25 Nov 2024 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528327; cv=none; b=XwVAqPEWAAV/7wEWCDeT05wP0NiGc/VUq2azTfseMyD2qGNschEkD9vWH3o/To9wU3hjAtxFYK0zdYuDfaqxQmDprJVk3kb+a3Q1Pf75UwhZjlY1FI4yHQSBguxAP2XgF4w3Ikk0kaWiU7+YLX6CXlM8d+Zk7ttQ5tXE0r66NsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528327; c=relaxed/simple;
	bh=Z815E4KFw6x29F6Ky1bHtLzzSkCGOhfmU/4Z27hrZKI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kqMSR9lCV1WKic8/EDJS2DJIh+R1R35DTeXy8avjlkrzlKOkc0o90y93hh52P17Frvr675ooKpC4Anxuab5x1LSNLAsjE7QN+V3Nno6ppsrpg9m378KnetxpRFsmIhopNE7HGBBLJ/JjBXgHvMEDg67MKCpQ7B/mWJsrrWZpq2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=FPReAO52; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1732528313;
	bh=xXQGNKC9g/gxVu2UclehtcajTzlHUR7Br/voSKreqhc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FPReAO52M8K8BxzdE6potA9MO88w945boEz40ZsO5Q56AgeXdZoYGBVRs8PYdAS45
	 5tx/j8HuHZYirKCbFL7AvrenQAlbNWj11NttW9TxgEOU+8sUbCQBK0SnOnvEyV2YV4
	 3d/gHTibFuBwZZlSjD4FWyCdScra+4NeQ5fgi9kKyQIaz5yXtte7zaL1GAV8EulKTc
	 58tMqJmDP2O1MPaqYkXRXHbTQvWDcx+MCyZKT7oxs7OaJtC5nlqmliWjDXqbPRBNNo
	 Wek/UR9WPBCqD+kkZIvoNYw2ZNYWs38hg3wYml8Gn6j3ZyWmm3+LRhWOXenm8tkcXN
	 J4MZP461zq/6A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xxgw83vlyz4xcr;
	Mon, 25 Nov 2024 20:51:52 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linux-edac@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, bp@alien8.de, tony.luck@intel.com
In-Reply-To: <20241112084134.411964-1-mpe@ellerman.id.au>
References: <20241112084134.411964-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] EDAC/powerpc: Remove PPC_MAPLE drivers
Message-Id: <173252811445.21628.11243334718451760345.b4-ty@ellerman.id.au>
Date: Mon, 25 Nov 2024 20:48:34 +1100
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 19:41:34 +1100, Michael Ellerman wrote:
> These two drivers are only buildable for the powerpc "maple" platform
> (CONFIG_PPC_MAPLE), which has now been removed, see
> commit 62f8f307c80e ("powerpc/64: Remove maple platform").
> 
> Remove the drivers.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] EDAC/powerpc: Remove PPC_MAPLE drivers
      https://git.kernel.org/powerpc/c/3c592ce7991cdf03bc7d139d790ce58c82c5903b

cheers

