Return-Path: <linux-edac+bounces-1729-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CCD95CC4B
	for <lists+linux-edac@lfdr.de>; Fri, 23 Aug 2024 14:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3BD81C233CA
	for <lists+linux-edac@lfdr.de>; Fri, 23 Aug 2024 12:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A09518452B;
	Fri, 23 Aug 2024 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dVXSfg5B"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37CF14B95F;
	Fri, 23 Aug 2024 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724415927; cv=none; b=I11TBNGDZhh/UJgpoZDsvVqhqXI/jR6E4f4jWhHZWa7s3lGZe+zn6lG+VkP7Q8kdx9Ladoxq3IRLU4AcAXo5ymHqhfGyZhZvHHD+t/mIOBcL3ytCteCy6ot90Abi0ydLMVt7HD1vGMTl9HIJsO89iNTCui4WoG50sQEzgPYBDyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724415927; c=relaxed/simple;
	bh=XFTWX1pLHBO3yIEceFWVjik1x5+gnZCCIJKXfr2+hg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbckAXAzMr17ltnCJO3m928LKyNIu8TIUPfK7VvITHusmjtfiyVwqyHhT5p2kJ1Yx1fKfYmOcb6uHnhoLX1ObADabFAyHm9QbEU05T+fOw30pLtLStoHWCuO7bCSf3MLHhaVtwWxTMWMmOaPDQ+xf5KhYi81Pbm+ISsDDvWCSmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dVXSfg5B; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 107BE40E0184;
	Fri, 23 Aug 2024 12:25:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3qJXJgsvUomD; Fri, 23 Aug 2024 12:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1724415908; bh=E4zWIpk6FvgD5mnWHXs0S3A5EiMqdeJuHJBPRfHRdbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVXSfg5Bpj8ji9O4e8fRQb6cArQSER5WXdLpHAYTDzX2O8Y8Lh5a4GJuM35xevU6j
	 65P7ylNsTTA6Zo132ea3h58UEoAcGRDlbdFky3/lGZ9dkH+wbf4WOy4TqzcaiDxPM4
	 zvx5s4dX6Wk3qCJKMAUvVF6Wd4fkQixDFz7V4xXH4IPWEyQPS0bORF/JqjQ2sr4YIc
	 TMvNFq20MNgT50lG/K3GxwLosKFZSnqCCqjbeyiRqPrOcBqjFy5qtzCIHbhT9MBLrr
	 W7YqqGMvUJmhRu6U9qyrg+P7jrUz5OH3d40IwU5OxeQCEEAvdeqMSN7FpwzM05J5si
	 54t91IsG/t2xW3nN7Un4paqomgC3ft94XqOGBo++9Yn05/DHX144Vf6fhQa6XKUqYt
	 U1y1WHABFY2dzxRUnLKBpEoNZWwLWshY/fkV2/y6C1XWPOZ3QDuTNJgo8BZOMRzSmr
	 4pzi7A0U5uc1ZJfpomRvIFqJWQRDnjtBPWZmiFsysNJNg3E0M4JWVu3u3GKqH8FBEH
	 5dWu0pbQOK81uUUwga3+d6Ap5eHk5eFIQ+PQq3dxzxaOAqP+77Fm7BxpKW7RqhRg66
	 8zpg2QP94GwZ8RtoBnJy8XrJKJ7OIiNWe4D5QdjjyDC4/9DHB98tOGpHv5czV45O3W
	 BvFk8JX9GarUf1VyVPwmkzWM=
Received: from nazgul.tnic (unknown [IPv6:2a02:3038:208:7949:9e4e:36ff:fe9e:77ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EBD9040E01A8;
	Fri, 23 Aug 2024 12:25:01 +0000 (UTC)
Date: Fri, 23 Aug 2024 14:25:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yang Ruibin <11162571@vivo.com>
Cc: Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v3] drivers:ras:Use IS_ERR() to check
 debugfs_create_dir() return value
Message-ID: <20240823122557.GAZsh_1fb3lYpQ3zj1@fat_crate.local>
References: <20240823120147.3950878-1-11162571@vivo.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823120147.3950878-1-11162571@vivo.com>

On Fri, Aug 23, 2024 at 08:01:47PM +0800, Yang Ruibin wrote:
> The debugfs_create_dir() function returns error pointers.It
> never returns NULL. So use IS_ERR() to check its return value.
> 
> Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")

Nope, can't be that one:

$ git show 011d82611172:fs/debugfs/inode.c
...
struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
{
        struct dentry *dentry = start_creating(name, parent);
        struct inode *inode;

        if (IS_ERR(dentry))
                return NULL;
		       ^^^^


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

