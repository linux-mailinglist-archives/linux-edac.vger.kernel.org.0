Return-Path: <linux-edac+bounces-3450-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C6BA781CC
	for <lists+linux-edac@lfdr.de>; Tue,  1 Apr 2025 19:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B1B17A50BD
	for <lists+linux-edac@lfdr.de>; Tue,  1 Apr 2025 17:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE8220DD4B;
	Tue,  1 Apr 2025 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AyCsYvUb"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B8620DD43;
	Tue,  1 Apr 2025 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743530246; cv=none; b=HI/0pf3Tvf0z/kih8yMm/us0cYM/vq8GwYMdLk0ZVmdRtymAsxLsXYkNnoRhhB4qhtTJsX/GnJHZtt5ByT1S7B/+9Ce6HWdZ9nE0X78iqvc+7YPvI0GxATSiFHADcRvHOIvbjpM9Eksw9WLj3uaVn83s0MGXE++HGa+ORkUOwkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743530246; c=relaxed/simple;
	bh=LCjACcw6+tY/S07RA/nOfYLXIms2B0eM1V6PAIvh19M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q83rqmoT0ta3lRsgGVcMa8PIcKIIggSVFFwC4IJtqC75J7siTxwVbOXwba0pAqMWgPZXsBYay7DrwRE50B9aKY4YDtRWouaw3xyuunDFjUACaUiDKxnEvSqtS87A90WQD/XcBORCuIFjkpwYA4ZuvjIIzhtc/vWi6EPMebg/YP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AyCsYvUb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 14D3440E0213;
	Tue,  1 Apr 2025 17:57:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id th5gcVbGkRNZ; Tue,  1 Apr 2025 17:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1743530233; bh=gkKeg3su0Dx6Uk8aXOsIoX1NcV6NiHpERc0JpoX01Sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AyCsYvUbO56xu1mwxO9zoke2Fc5H4cVruH+aRf9bWGvbaxSSNGhlaGmMmdnIuNPZq
	 VIJz8wCrlbt1EFDmWuntgn6U9pByP3g/SMZEuq64RkwSFg7X7KTr2w6T2M6E2IgOEQ
	 kh9WTQzD8nkXusX2pntBPOGJerpDOVtx3GJ9lXHVp0aoJXpjAmOEkiYD2k9JFoT50E
	 xIf1791MFW22FtHrQCrWNHGTsG7hFIvz8S4aUwC/VidEkvIaKhFMzJnhkptU7V0du1
	 PMgbQr6CnP60ssxW5TuiHPbIkV1M3AbIflXL1JYWvZsRtQja7X8aczwijTD2gYbYVh
	 QBQiJBngZ6CHSwnMcHEFTMigvZYUL4FnRQ9q+vik9ssNBk31B0TFijHFRK5jQ0xS59
	 tlh4qQdqERZIGUNnHJTU6wuAwEoi3TPNJg22HMW5LCkjVCtVIKC2JBOy1Or42MkRF9
	 jYh0rtzAL6QNfs5apXAGfOO5Pqsv0XSnM4nW0orV4RbizS7qLdd4h0Dq0JTlJyByjG
	 JL/11RPPAMQf5o59rwddaADh4L0VObW0LORsfSz1M4bCIQ/U4Kq+VUS+GPkNEeaKSJ
	 9HyWZzqmhluIGvkIoDACkfHL7RMoB3HW97Ydn/aZN5b9ErhHTWweLZw449SpipJPig
	 qxTbP2dWdgOpep10UHmBSmOA=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B1E1C40E0219;
	Tue,  1 Apr 2025 17:57:05 +0000 (UTC)
Date: Tue, 1 Apr 2025 19:56:59 +0200
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-doc@vger.kernel.org,
	tony.luck@intel.com, mchehab@kernel.org, sfr@canb.auug.org.au,
	jonathan.cameron@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 1/1] EDAC: docs: Fix warning document isn't included in
 any toctree
Message-ID: <20250401175659.GLZ-wo654tv2JdhcaT@fat_crate.local>
References: <20250401115823.573-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250401115823.573-1-shiju.jose@huawei.com>

On Tue, Apr 01, 2025 at 12:58:23PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Fix the build (htmldocs) warning: "Documentation/edac/index.rst: WARNING:
> document isn't included in any toctree".
> 
> Fixes: db99ea5f2c03 ("EDAC: Add support for EDAC device features control")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20250228185102.15842f8b@canb.auug.org.au/
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  Documentation/subsystem-apis.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
> index b52ad5b969d4..ff4fe8c936c8 100644
> --- a/Documentation/subsystem-apis.rst
> +++ b/Documentation/subsystem-apis.rst
> @@ -71,6 +71,7 @@ Other subsystems
>  
>     accounting/index
>     cpu-freq/index
> +   edac/index
>     fpga/index
>     i2c/index
>     iio/index
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

