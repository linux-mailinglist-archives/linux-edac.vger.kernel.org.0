Return-Path: <linux-edac+bounces-4602-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7ABB2B382
	for <lists+linux-edac@lfdr.de>; Mon, 18 Aug 2025 23:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB813AA031
	for <lists+linux-edac@lfdr.de>; Mon, 18 Aug 2025 21:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59FB214A94;
	Mon, 18 Aug 2025 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MVb0U/d7"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B3C18A6DB;
	Mon, 18 Aug 2025 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755553031; cv=none; b=k7il/sRga/y6+UR4pXJSbx6i6zo4tc/9L6btDLzGOUqwLIAp93E+32rUHMxp/fMCeBJ6CJK7iRCzcEWup4KOqKyYRAyrM5Y3KdHHnjdBP6Aww90ie62o0bMadWtD/YynLttn+2vA3dbbfMbWrCf6V9Jb5eDQ/panGMnouSf7jJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755553031; c=relaxed/simple;
	bh=F/p7H+rGIe1jvJiKXdKD3uvPisdzpDiRsKGZ8Z/yroU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WORjJqh2wgswbf0HTR8fpQ9HCfsAzAP7i3skvbDTVKctAlomM65nGCZkIrmIU7pe3zuutyqL0UtNgqahMwzV0LU8rpWtWP5DYuCX1tVznJZC2GY9opc9xJOiomy/vmMJl8XeibnVPvhzgjgGxgzS4nwS2iU07rmXkJxTWztdCpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MVb0U/d7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0CB8040E023B;
	Mon, 18 Aug 2025 21:37:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 292qZh3tMt0g; Mon, 18 Aug 2025 21:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755553021; bh=VOpF6rsvxG/61Oc9IdUb+SvxGX5wEXMkX49T2aBrX+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MVb0U/d7kN1zpE5VHbyDw5mLRqryclm9sc6tky/SOFi4PKoHojJPGr5WaZVVEv7kI
	 JkXNKiGgZK72EjAK+xK8vY+2ZGw/8AlQn6sc0kUmVe/QUJ4xQhqyCCNBWBMUybwAs7
	 KWHlVQ/MBVsS2HDvxD4x8jZL+vMuGYfzTxRtxyrnCnsAqgR9ogo2DCzF/oDufqlXSr
	 nQZgdP2f9RW+kINo2gPNtg0hSBuCL8v6LMx08N+nTjUB1SSP9sw+ezoQPczB+HT2el
	 QzJhc7Fhv0a+5N0F1IuEHg3AbKcoAaeVJB7Wdps576KxLvAV/gGHPaRk176rQ2m3kE
	 yTxIpIDa8WFJwmJgF+lU5p4811cJZCej3Pya4jtgFPvhVr00JF3JsGR6rK4vU9/DC+
	 tRTipjsMArGAQ4pzzUQtUvgSPA3Y24zgTrHXizYSMBwvui+AlWFusJ12wUl78/Yy6T
	 KzRQYLk/itlpU4ptMmK3zrEeZJy0g/gir5z6MMoPg5oW29UL6mODgkli261E0svsqG
	 dfOCKhbz/Yk6cL9xE9pO+h7eZ+HE92X2zPhafyvTSRqrQCdTiu0n3OQnirEliJGuHF
	 loZp3XZQtLWWRjcWhaovcElD4NYGmnq9LWHyOogQvk23AEhnUhwB0bzJyJvhIhufRb
	 tESsIHr4DXlAO3uw56dCEDhQ=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4685140E0185;
	Mon, 18 Aug 2025 21:36:57 +0000 (UTC)
Date: Mon, 18 Aug 2025 23:36:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, yazen.ghannam@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] EDAC/mc_sysfs: Increase legacy channel support to
 16
Message-ID: <20250818213651.GIaKOc88InL4iy-SGM@fat_crate.local>
References: <20250807201843.4045761-1-avadhut.naik@amd.com>
 <20250807201843.4045761-3-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807201843.4045761-3-avadhut.naik@amd.com>

On Thu, Aug 07, 2025 at 08:14:54PM +0000, Avadhut Naik wrote:
> Newer AMD systems can support up to 16 channels per EDAC "mc" device.
> These are detected by the EDAC module running on the device, and the
> current EDAC interface is appropriately enumerated.
> 
> The legacy EDAC sysfs interface however, provides device attributes for
> channels 0 through 11 only. Consequently, the last four channels, 12
> through 15, will not be enumerated and will not be visible through the
> legacy sysfs interface.
> 
> Add additional device attributes to ensure that all 16 channels, if
> present, are enumerated by and visible through the legacy EDAC sysfs
> interface.
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
>  drivers/edac/edac_mc_sysfs.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
> index 0f338adf7d93..8689631f1905 100644
> --- a/drivers/edac/edac_mc_sysfs.c
> +++ b/drivers/edac/edac_mc_sysfs.c
> @@ -305,6 +305,14 @@ DEVICE_CHANNEL(ch10_dimm_label, S_IRUGO | S_IWUSR,
>  	channel_dimm_label_show, channel_dimm_label_store, 10);
>  DEVICE_CHANNEL(ch11_dimm_label, S_IRUGO | S_IWUSR,
>  	channel_dimm_label_show, channel_dimm_label_store, 11);
> +DEVICE_CHANNEL(ch12_dimm_label, S_IRUGO | S_IWUSR,
> +	channel_dimm_label_show, channel_dimm_label_store, 12);
> +DEVICE_CHANNEL(ch13_dimm_label, S_IRUGO | S_IWUSR,
> +	channel_dimm_label_show, channel_dimm_label_store, 13);
> +DEVICE_CHANNEL(ch14_dimm_label, S_IRUGO | S_IWUSR,
> +	channel_dimm_label_show, channel_dimm_label_store, 14);
> +DEVICE_CHANNEL(ch15_dimm_label, S_IRUGO | S_IWUSR,
> +	channel_dimm_label_show, channel_dimm_label_store, 15);
>  
>  /* Total possible dynamic DIMM Label attribute file table */
>  static struct attribute *dynamic_csrow_dimm_attr[] = {
> @@ -320,6 +328,10 @@ static struct attribute *dynamic_csrow_dimm_attr[] = {
>  	&dev_attr_legacy_ch9_dimm_label.attr.attr,
>  	&dev_attr_legacy_ch10_dimm_label.attr.attr,
>  	&dev_attr_legacy_ch11_dimm_label.attr.attr,
> +	&dev_attr_legacy_ch12_dimm_label.attr.attr,
> +	&dev_attr_legacy_ch13_dimm_label.attr.attr,
> +	&dev_attr_legacy_ch14_dimm_label.attr.attr,
> +	&dev_attr_legacy_ch15_dimm_label.attr.attr,
>  	NULL
>  };
>  
> @@ -348,6 +360,14 @@ DEVICE_CHANNEL(ch10_ce_count, S_IRUGO,
>  		   channel_ce_count_show, NULL, 10);
>  DEVICE_CHANNEL(ch11_ce_count, S_IRUGO,
>  		   channel_ce_count_show, NULL, 11);
> +DEVICE_CHANNEL(ch12_ce_count, S_IRUGO,
> +		   channel_ce_count_show, NULL, 12);
> +DEVICE_CHANNEL(ch13_ce_count, S_IRUGO,
> +		   channel_ce_count_show, NULL, 13);
> +DEVICE_CHANNEL(ch14_ce_count, S_IRUGO,
> +		   channel_ce_count_show, NULL, 14);
> +DEVICE_CHANNEL(ch15_ce_count, S_IRUGO,
> +		   channel_ce_count_show, NULL, 15);
>  
>  /* Total possible dynamic ce_count attribute file table */
>  static struct attribute *dynamic_csrow_ce_count_attr[] = {
> @@ -363,6 +383,10 @@ static struct attribute *dynamic_csrow_ce_count_attr[] = {
>  	&dev_attr_legacy_ch9_ce_count.attr.attr,
>  	&dev_attr_legacy_ch10_ce_count.attr.attr,
>  	&dev_attr_legacy_ch11_ce_count.attr.attr,
> +	&dev_attr_legacy_ch12_ce_count.attr.attr,
> +	&dev_attr_legacy_ch13_ce_count.attr.attr,
> +	&dev_attr_legacy_ch14_ce_count.attr.attr,
> +	&dev_attr_legacy_ch15_ce_count.attr.attr,
>  	NULL
>  };

This is also slowly getting out of hand. All those should be allocated
and initialized dynamically based on a number of MCs but not keep adding them
here ad absurdum.

Because if we were doing them dynamically, we'd never ever miss any new
channels when the hw grows...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

