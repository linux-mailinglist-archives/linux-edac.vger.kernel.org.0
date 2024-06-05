Return-Path: <linux-edac+bounces-1186-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFDE8FC843
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 11:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC33282916
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 09:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A37518FC7A;
	Wed,  5 Jun 2024 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TCh2FTyP"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65100D268;
	Wed,  5 Jun 2024 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580837; cv=none; b=e7xY4fz+73c+crzY0Urjhu4Tq25ama2H+d906TUgWHsH5Ssr9eTy0/uytD0m2IEGg1P1nJ7Erx+vyPEY+qdBXqO0IeGGbmt2IFhNtwep3LzwkJvZzJRLUehbzyz5Fun3cH4jtKciFx2VeLCugWcj3CMkEBsfGy58/ScAszN6eXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580837; c=relaxed/simple;
	bh=ulBE34BR3uS7bDhHAEt6eLLOzMIT1k2sez+8leC7G5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R262tTyZSXLGZ3aLMBPJ55oHkY8jxSpyfS6RmUqxaKZZ1RETM56T3Aq7gbRXrmTgaeCEUWv5uMjrId7yTn99oQwBLUTM66OJMj4qEHrcIU5mhO2xxlVsHLEVGjqTfAm14tlewnVwHrp8OQmbMCIQTYWBMEAg2tQNqBvqXFhT8Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TCh2FTyP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5628440E016E;
	Wed,  5 Jun 2024 09:47:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id l7M77ZkLGiLI; Wed,  5 Jun 2024 09:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717580828; bh=HG9ZhMggVLi4IgYZk4UTu1n5WmntVlynhD5JWtBGG+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TCh2FTyP/+RQ0++qDHwgkr92rqF1d5kJocKrpKomlNPzS3XZkAEIX+ahtsfac0XPP
	 BsHJvY4r8X8MMaY58a3SmACgbNEjgmDgZK0Q9JBtxwzi9yNqymMpoOipZ9k4+vJ+Hu
	 Z1XjGdrOO9YgNLDpz1fckOmHK9ZnS+qBo6xYVAy+0ADgNc2xL154zyu654jkOrPvpA
	 cjD+Ehl8lazJuA2aM/4MD2Y5XzI5pr3aDzVzJjqarYHPi1vLaLZ1ePwbLx0vBpEARB
	 yTNW6qO/vdKOhfY+wUXd++VqMYv7G+dZJBxpQJ7fc0Id4xRaxyJWU7N4C14PSDR+VQ
	 gl8TaDQnGm/Syj2IjxmVOViJSQjHzPOMCnSzI3fJjwmtXMmuXl/9G9JSFcK4ofToom
	 gRfV1ObrQVG/Hz+SkkYXmNdRrEHAiWemqpFXxfQjUAOvHCQGifIJ4Nzlez0QzO/HyB
	 WbewDeVBoCOGyADQYBCmuLzelZ99WqBcnT50CB6KzXqVX911vX5nbnmvPPqHuvegaF
	 k07DsPxg1CxH+4Aw62rLuas/+1BXKqXW6nOeAH+fG066hJe9HOPUX1eklhX0hjrsXS
	 WIOHpg4Mh6h1rll2Ln1aHWsZSqBgvbyYwIF2p+I3tul/KX4puvEPD95hlGuqZ25hhV
	 Ng81XFYZclIGWzpIXNIHfVQk=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CAA7A40E0176;
	Wed,  5 Jun 2024 09:47:01 +0000 (UTC)
Date: Wed, 5 Jun 2024 11:47:00 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 2/8] EDAC/amd64: Check return value of amd_smn_read()
Message-ID: <20240605094700.GVZmA0FK-8GcYsVdpm@fat_crate.local>
References: <20240523-fix-smn-bad-read-v3-0-aa44c622de39@amd.com>
 <20240523-fix-smn-bad-read-v3-2-aa44c622de39@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523-fix-smn-bad-read-v3-2-aa44c622de39@amd.com>

On Thu, May 23, 2024 at 01:26:53PM -0500, Yazen Ghannam wrote:
> Check the return value of amd_smn_read() before saving a value. This
> ensures invalid values aren't saved. The struct umc instance is
> initialized to 0 during memory allocation. Therefore, a bad read will
> keep the value as 0 providing the expected Read-as-Zero behavior.
> 
> Furthermore, the __must_check attribute will be added to amd_smn_read().
> Therefore, this change is required to avoid compile-time warnings.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Cc: stable@vger.kernel.org

Not really stable material. Zapped and applied.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

