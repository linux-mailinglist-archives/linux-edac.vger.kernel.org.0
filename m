Return-Path: <linux-edac+bounces-1248-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12787901B24
	for <lists+linux-edac@lfdr.de>; Mon, 10 Jun 2024 08:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DE41C211B5
	for <lists+linux-edac@lfdr.de>; Mon, 10 Jun 2024 06:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CB717999;
	Mon, 10 Jun 2024 06:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CkjT4BOb"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3971755C;
	Mon, 10 Jun 2024 06:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718000624; cv=none; b=rGT77xOpQad2Y0OEmVb1hFTAZ0RhtcnETyGdy8SxLvjwL+amtU2ycdLmVMyWZP3lFRXau/iWKRiBWteQliXGLPQJEUc7l4F0w5csjmTIv6gVZRgbHc7cOxgP95GgUsVoVgiP0Ht2VzJm9mdyu/N41syL0fuLPeLUPvdHBuMZSIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718000624; c=relaxed/simple;
	bh=GXlbCBbiVnD51YX64g8phHA+2llZ/IKI82PW3shBCjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCfQEodcUEk07oiLHxMzK/SMoOtHYhUPaCH7EyucbzwClMoO0GIBKrX4FpgqUdNpvbx3SrkNNO/VT8kovPEeJcoFMo/VP6NFHf5EIeIeTVOezm9ZU+XAgV7BgbG7uyR+odoTBevlh+aDlsSEeiVG0MPtr3Zh7dEslkig/VOQ7NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CkjT4BOb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EC71B40E016E;
	Mon, 10 Jun 2024 06:23:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HAN76aojwwZb; Mon, 10 Jun 2024 06:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718000617; bh=wb6X2r0WiPjtZ16rgHx15DSQ/4Kth3JyQcEsSwfJEZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CkjT4BObA/XQAKV5VgRAx7w163jxROsAJH6uQOj+Yh9vg8yIYmQTM4sLgBXW0iH3C
	 6fA7bMUrV9H3Ibx+yEuvKtMbMIaHM60hKglDu3L1kI0jLwBlwvP0oujIrtQYvgHdpw
	 wURdOjZeSoLpd8+i0Ser7eAEOTZUUlpaaAwrYuhtLMN4fHzVtH86+nzDJXKVMovvbL
	 eSuPzD1uUAALmO8he0QfXQrQuI9vsMHriYKMurke1O088iInVi9IKbp//Mr5lUlgNF
	 jYvAk0zszIMymqTAIBq841eMRecHaPb/UoL8Hwrj9wl9M/6LU2iQr3+Gl43p54RWuv
	 lfh1c6uNHmdEmUjYPqf1ZuIr24J1ciIX8dLRrf+v1ZA8itkAPnuI6Au4s7srpblnMG
	 OM5wplGVrgAIKCRxkA/itZg3wbEnhF/7qKNIRA2rJRc+90adPkDHVC9eaNoPYXx25M
	 FPCdfqBauyV+nzCLwohQ0LgUqHSQ+oCqhcglZymJQ76aGvUJhidURqLDV4i18FLxar
	 qucaAqHLxR6zkDFKNrYFs3BCgO9+WyuArYW3eeG91Ffx3WjFFnsOtDqnJIZAnsRR++
	 dZ9gqTcKPVKB3pEt6U+uMue9oQ6bN7ZWrCvLy8iIJRJxIqGz2mRrge+BZGxo8Gs/5a
	 S4QuImr/oToKU2jiLf8RmNus=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B985040E0081;
	Mon, 10 Jun 2024 06:23:30 +0000 (UTC)
Date: Mon, 10 Jun 2024 08:23:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: John Allen <john.allen@amd.com>
Cc: linux-edac@vger.kernel.org, tony.luck@intel.com, yazen.ghannam@amd.com,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	muralidhara.mk@amd.com
Subject: Re: [PATCH v5 0/6] RAS: ATL: DF 4.5 NP2 Denormalization
Message-ID: <20240610062329.GDZmab4bmi1KDcXbSB@fat_crate.local>
References: <20240606203313.51197-1-john.allen@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240606203313.51197-1-john.allen@amd.com>

On Thu, Jun 06, 2024 at 08:33:07PM +0000, John Allen wrote:
> Implement non-power-of-two denormalization for Data Fabric 4.5 in the
> AMD address translation library.
> 
> Tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
> Base commit:
> dadc295cbd03955cc1ba55af55e23a06713d1a5f
> (origin/edac-amd-atl)
> 
> v2:
>   - Fix compilation error.
>   - Make remove_base_and_hole the inverse of add_base_and_hole.
>   - Move all map validation checks to validate_address_map at the
>     beginning of translation
> v3:
>   - Fix bug where the legacy hole was not getting removed properly.
>   - Minor rework of functions for matching the normalized address and
>     logical cs fabric id.
> v4:
>   - Merge common cases in map validation function.
>   - Fix map validation for cases that don't have explicit checks.
> v5:
>   - Add patches to add a pr_fmt prefix for the driver and share the
>     internal.h header with the FMPM driver.
>   - Don't fail to load driver if DRAM hole base can't be read.
> 
> John Allen (6):
>   RAS/AMD/ATL: Add amd_atl pr_fmt prefix
>   RAS/AMD/ATL: Read DRAM hole base early
>   RAS/AMD/ATL: Expand helpers for adding and removing base and hole
>   RAS/AMD/ATL: Validate address map when information is gathered
>   RAS/AMD/ATL: Implement DF 4.5 NP2 denormalization
>   RAS/AMD/FMPM: Use atl internal.h for INVALID_SPA
> 
>  drivers/ras/amd/atl/core.c        |  50 +--
>  drivers/ras/amd/atl/dehash.c      |  43 ---
>  drivers/ras/amd/atl/denormalize.c | 561 ++++++++++++++++++++++++++++++
>  drivers/ras/amd/atl/internal.h    |  48 +++
>  drivers/ras/amd/atl/map.c         |  97 ++++++
>  drivers/ras/amd/atl/system.c      |  21 +-
>  drivers/ras/amd/fmpm.c            |   4 +-
>  7 files changed, 755 insertions(+), 69 deletions(-)

All queued.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

