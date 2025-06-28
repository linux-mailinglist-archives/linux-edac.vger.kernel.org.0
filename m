Return-Path: <linux-edac+bounces-4277-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F88AEC7F9
	for <lists+linux-edac@lfdr.de>; Sat, 28 Jun 2025 16:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50C4B7A5CEC
	for <lists+linux-edac@lfdr.de>; Sat, 28 Jun 2025 14:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAC224888A;
	Sat, 28 Jun 2025 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WYuuujny"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1642A246BC4;
	Sat, 28 Jun 2025 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751122503; cv=none; b=uKHltqZM+ZJ3Tb2AX9xri1BhuFUwseezD+k87mc9SUIX2vhLDMBiiNuqaw8eqPUcsuQ1bZNALxaoAQYar5eFv3ABblmERLvsuMiYN0XrDxK18+ytfSIAoQCSMFn2DJL/lbK8f2ydGpyhuuxNGVkYDr1VWpSOOC6IYa619XbY7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751122503; c=relaxed/simple;
	bh=xPR4Lvm6sevP9jewqnEme78aoVYw1olPc/gla3sySrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bghdCdij/wfs4c0u0fW/zWwjiPbpiPz1wX8jHIaIcPECevALNa3/NhAGJnP2cIncW3l5lXZr8QvtY2cSw/C9rRBfAzf7hVoM16eihEOOr5cB5TJi+cW1mM5/dQGISM7Q5vHI/0VQWUqMg0UwxRPRy6HH0uNnyhP8l1mkcTZSPf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WYuuujny; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7374B40E0196;
	Sat, 28 Jun 2025 14:54:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vTGqOYpnSVjR; Sat, 28 Jun 2025 14:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1751122493; bh=ovmOxsomgada5Pq6LtWBEdl4bZco9EDqhj7IQZAEl38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYuuujny7oCIGJQ3kL+A+uhL4mkTIoiviFPFT9EyLgBqbAbq5RI/rYDSObzd4QEfg
	 EFkxSTAsXYH366Ux9cJZByShEILlwUhss+78vtWdJebTKQZg9s12vP0ZjIuLRKluGJ
	 1FaAEFhEb08oZwg3JSu3nAo7s/g2GvE/nag0s2Snm8OYjK8qwUZqS0AltfAKeaxLt7
	 sgNGDJu/rqEhHy9o0TP3mHaMLBxrfyo1hmIrAKRxrhh/vqgl36Ep5Zl9t+1r/T426s
	 XP6VDl+yOD141LDJ0HVmTVy4f97XUTk4aIkATEwktxkYYt435UutDoALTFHdZiO7/i
	 1eAs5R2XLrsCrs+Jc+Axy5k+gAjCaZHpn2vQLC7cZyYQ8QPfLDU0VKthspmlE0LEhY
	 waKYkiosntmlHqV4TrUKlso7LO3+Dk8jj1KodW9Vr5OtKc6zc0uadcuFpL3zRDIJ3s
	 XszeDjfVqlgrkqvd6xW6egEt1ARFkeSt1Rz1W2MGBT6eiayp34j+gTci+e9/vldede
	 lYVtXg/zQyGtFqjnKIfQFo1JuufL266tBhXePF7bOdpy5tpZcCY9X2DeA14UAXA06f
	 QJg/qIG6qNoIhxArqy+xdv/o5sYRWAf9E4og77MRU4fJp1EukVuzSZfYvVlwSxJAyf
	 p22ZdWbObeyLxYbd91poczDs=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EDFAC40E0184;
	Sat, 28 Jun 2025 14:54:39 +0000 (UTC)
Date: Sat, 28 Jun 2025 16:54:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, mchehab@kernel.org,
	dave.jiang@intel.com, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, linuxarm@huawei.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com
Subject: Re: [PATCH v2 1/1] EDAC: Fix lockdep splat caused by edac features
 code
Message-ID: <20250628145433.GEaGACKVlsfyRegTw6@fat_crate.local>
References: <20250626101344.1726-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250626101344.1726-1-shiju.jose@huawei.com>

On Thu, Jun 26, 2025 at 11:13:44AM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Fix the lockdep splat caused by missing sysfs_attr_init() calls
> for the recently added EDAC feature's sysfs attributes.
> 
> In lockdep_init_map_type(), the check for the lock-class key
> if (!static_obj(key) && !is_dynamic_key(key)) causes the splat.
> 
> Backtrace:
> RIP: 0010:lockdep_init_map_type+0x131/0x270
> Call Trace:
>  __kernfs_create_file+0x77/0xf0
> sysfs_add_file_mode_ns+0x86/0x140
> internal_create_group+0x1cc/0x4b0
> internal_create_groups+0x42/0xa0
> device_add+0x310/0x860
> ? __init_waitqueue_head+0x4a/0x60
> edac_dev_register+0x3ff/0x480
> devm_cxl_memdev_edac_register+0x509/0x640 [cxl_core]
> ? lock_acquire+0xc4/0x2d0
> ? find_held_lock+0x2b/0x80
> ? cxl_mem_probe+0x21e/0x360 [cxl_mem]
> ? cxl_mem_probe+0x21e/0x360 [cxl_mem]
> ? lockdep_hardirqs_on+0x78/0x100
> ? cxl_mem_probe+0x226/0x360 [cxl_mem]
> cxl_mem_probe+0x226/0x360 [cxl_mem]
> 
> Fixes: f90b738166fe ("EDAC: Add scrub control feature")
> Fixes: bcbd069b11b0 ("EDAC: Add a Error Check Scrub control feature")
> Fixes: 699ea5219c4b ("EDAC: Add a memory repair control feature")
> Reported-by: Dave Jiang <dave.jiang@intel.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Applied, thanks.

While you're here: please make all those attributes static like in this patch:

https://lore.kernel.org/r/20250620114135.4017183-1-arnd@kernel.org

which I've already applied - you can base stuff ontop of edac-for-next.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

