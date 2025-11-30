Return-Path: <linux-edac+bounces-5542-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 429E5C94F15
	for <lists+linux-edac@lfdr.de>; Sun, 30 Nov 2025 12:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3361341C5A
	for <lists+linux-edac@lfdr.de>; Sun, 30 Nov 2025 11:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7678C238D54;
	Sun, 30 Nov 2025 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Mx4kkmJ9"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C1815A864;
	Sun, 30 Nov 2025 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764501719; cv=none; b=jfkYR0QS4EvLldy+C99nmJNuyn/aOD6ea98T1xXi3Sv2OAKKudO6Ao2rSRzoqtOREhCbAFEPOzmU5m7zvY51lD0wFvZJTVWZpO9tvu2H893JruH/gt8flhMnfVhr1TuG811Zw6PENexDDCIzY9/FLbxsjzYUS8VnrpkoO0E4wb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764501719; c=relaxed/simple;
	bh=fyyvbQVM2+GhJsuliAg71XlZgr2ALAHbppa4kJDf+Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8Uw29GMp+C0NLy4EuropYZpV9967ENBlVL2tpeXH4DXuxCWDkriU904cB1YRYaAhiI6Jd7BmeUGiK3CaPSg9I7r2N6h9m5uP5UuacFpzznJu3Qh5VoXFHg2qUPGmlfliVMJo9ah0B9klNkhK/tLjSFBb86ON0m2N3joNmkHck8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Mx4kkmJ9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 46C0940E0173;
	Sun, 30 Nov 2025 11:21:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id spkQncZ7v7_A; Sun, 30 Nov 2025 11:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764501710; bh=k0b9PAOs6kjDpExSMH3yJ0+ArW1lqguDw/Bi1eJTLm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mx4kkmJ9F2ZR7HJzF/w8bs3cuK/DvexCgiwd6RAUUXIOqJRKRIIlcZGpcKrlqB+1A
	 /edVsOoVcsFIYWtaRZaQfpK93yDl0eTB4/cJjOIoKSgRQi6FCs8Gy5hVe4GCk5bzVq
	 MGS9719//ZsfQIgg83FpPe+3wPxXT2ya5r3uE9ZnfFQ3OpoVPutTGM1LOfKHhRZrvi
	 0HtkONCE1LPPjOON96csaFTwT7vrhbjYJa3jt9L0CRC0Bn+ZngKlkJu77PvhTLv4fk
	 2Mg4bnxVL2tf8jvGqN392cdQU0VX3FNxfx2uuvGsiP6q/JNNEGAKZVK68Dfh5EIpgR
	 HFGhox5Gy1LsTb2RC3F0LEBGiNRmd+csw5pfOevAigwbA2HoMtVWlHr3ZDvkdVNzy7
	 sNf/SXzEvPz5bOigVg94kTFC1JODZWuc5iC/rY6p1JT4gQwD8WrETCZLWge49WpLU0
	 hOXXBEYj/+nePzN8YNsfnX4+lYweSKid4R1u9ybyL8j/Uzx+fM2kayb386qH1FZi9u
	 sbxVKG6E/FuxSQRA5ORBNgNyxexKaaAaPgnT5yQ9Bk/HELMOA3jz/rfa0DbWdE7BzM
	 +Z4FUTmT/9/ph+tZcIpIItuNMUtiz0GFCz0DIdMcV9Mk65O2A9cSTL8cIpG3F6Lca4
	 8lnFjVOU6V5cR93IoCMeHaTU=
Received: from zn.tnic (pd953063a.dip0.t-ipconnect.de [217.83.6.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9170A40E00DE;
	Sun, 30 Nov 2025 11:21:44 +0000 (UTC)
Date: Sun, 30 Nov 2025 12:21:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: Devang Vyas <devangnayanbhai.vyas@amd.com>
Cc: yazen.ghannam@amd.com, tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ramesh Garidapuri <ramesh.garidapuri@amd.com>
Subject: Re: [PATCH v2] EDAC/amd64: Add support for family 19h, models 40h-4fh
Message-ID: <20251130112144.GAaSwoyJuNCwJiVC1W@fat_crate.local>
References: <20251130102111.1180875-1-devangnayanbhai.vyas@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251130102111.1180875-1-devangnayanbhai.vyas@amd.com>

On Sun, Nov 30, 2025 at 03:51:11PM +0530, Devang Vyas wrote:
> Enable AMD EDAC driver for AMD SoC family 19h with
> models 40h-4fh to support Ryzen 6000 CPUs/APUs
> ("Rembrandt"), which provides kernel-level
> infrastructure needed for RAS (Reliability, Availability
> and Serviceability) features.
> 
> Added changes enhance the ability to detect and
> report memory errors on systems that utilize AMD SoCs
> from the specified family. There are 4 memory controllers
> supported by Rembrandt which enables proper error reporting
> and RAS testing on specified AMD SoCs.
> 
> AMD EDAC linux driver interfaces directly with the hardware-
> error reporting mechanism present in AMD platform, otherwise
> these errors would not be surfaced through the standard Linux
> EDAC framework and RAS validation workflows would be
> incomplete.

Nope, this is reads like AI slop and too generic.

Lemme try again: we do not enable amd64_edac on client hw - only server. Why
does *this* *client* deserve an exception?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

