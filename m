Return-Path: <linux-edac+bounces-1277-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF8E90762B
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2024 17:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22AD71F25D95
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2024 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9F81494AF;
	Thu, 13 Jun 2024 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HHChkXMp"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7C145FE2;
	Thu, 13 Jun 2024 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291505; cv=none; b=t0IXzTYN624BO9rho2/QnIufQOPSfVk2d2X1+rJhRUrmMLYYpvSQ2MsWf4oviRbQUAP4pNFlgk/ZBFH5KIf91blb3qW3woMt0TpRGs8dkyOdeKEsJneG+B4qccmmQhRkjm2XIglYpR5S+tS6JQCTRpiBmwU2Z//baWan4FUgwpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291505; c=relaxed/simple;
	bh=LqKR8yZj3cDsTcdf1+eCB2p/t6/O4VciGgB1Da8+LSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nde+NBAkUSzPO8DYRgggrf9+3Foi9OHbSmF+JMd9HY4S1gbZkgGPQcWzNCoRsXLd/hGL4IblEjfI7DJeTRbkqk8+0TZpvwdDetQINZkY6+xuPdKthxWmhXdS8UZM3bJEPZTzNXT8QbNv5WFQEHDBs/8Y6ZCZPGfhWEksN0IqJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HHChkXMp; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 11A5640E0031;
	Thu, 13 Jun 2024 15:11:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cEw696DXvtlK; Thu, 13 Jun 2024 15:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718291498; bh=8LWiwHYisdjka6vHW8jeH1lBJFYtiOXuwceIo6IJxA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HHChkXMpi8fK2dFRdiGUd1f8FIKO9CF5uhBD1Uf42U/GbjkcdT6dEW56rNviDHojH
	 q05x2yQmsfFgnuMy/ZkumulZ0Oz5zKRrFGesYrwlTu1+rfcCdkCZ5xlb+d5sE+8yUA
	 xT1PDHAxXV4CR6mD9SOi9NAYz4l1DQ/DvcQ3N9aDO8G60LEps7csdMXGbJyvtKodoL
	 m24wUe/bSG+5a/JycFUH9kDbJEHfp+JRtggwDWt74D21gpP1/kx6yii9ynq28cdYG0
	 t3qdfiXN32rz2YFFGQRutZb5JmJfs85luGXOI5wSaVWKsEAPj9tTAftPRnPjNvAbQW
	 y8hoPCLCzegpbE9K/3csSwwg5O9XwxyxtRCxNWo8JgynhnEhBBSDnFj4CqyBFHRd7x
	 6xOfYV3a7MmA9EfQLwgk3sg9G8V+ObUHx0sLl/3JT4vs3gfRVDVHfTHHenJtq2VCRj
	 +njrg/l6yjG5tUsw32aI/lbhIXGLm7vfbYJkMjT0mPv6Z5jiFD4KdSRGzbS3gkiEUl
	 H0Sz55tngsIXwLK1RLMW1L2CGHK2qVHZcbLbNS1PufqeToWwwAnKrQ+9duYuPi2CG6
	 V1h/2j178PVeq5hEAh/5ErS+K/yCRl6oO9k8na0DF3ZxebY8J8+0loERnlNOXW5U2U
	 9XsB/LiuoCrgQm4ESQkm3LBA=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 185F640E0176;
	Thu, 13 Jun 2024 15:11:30 +0000 (UTC)
Date: Thu, 13 Jun 2024 17:11:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Thompson <davthompson@nvidia.com>
Cc: "tony.luck@intel.com" <tony.luck@intel.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>,
	Shravan Ramani <shravankr@nvidia.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] EDAC/bluefield: fix white space in
 bluefield_edac_mc_probe
Message-ID: <20240613151129.GIZmsMIc1lXDXJf65u@fat_crate.local>
References: <20240612193831.25913-1-davthompson@nvidia.com>
 <20240612193831.25913-2-davthompson@nvidia.com>
 <20240612200056.GGZmn-eO15ePolbAPo@fat_crate.local>
 <DM6PR12MB553462599AA57044F6E41DF4C7C12@DM6PR12MB5534.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR12MB553462599AA57044F6E41DF4C7C12@DM6PR12MB5534.namprd12.prod.outlook.com>

On Thu, Jun 13, 2024 at 03:06:38PM +0000, David Thompson wrote:
> I did review this section of the kernel documentation and then
> went on to create a v2 with the updated commit message.
> I apologize but I didn't notice your comment below about 
> your preference to not have this type of patch at all.  I have been
> told in the past to have separate patches for style cleanups, and

Yeah, it all depends on the maintainer. I, personally, do not encourage style
cleanups only because they interfere with git archeology and teach new
submitters not to chase real bugs but do silly patches only.

> not to bundle them with features.  But I can do as you recommend for next
> version.  I will squash the two style fixes into a patch that contains some
> new functionality for the BlueField EDAC driver.

Thanks.

Simply use checkpatch on your patches only but not on the .c files directly. 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

