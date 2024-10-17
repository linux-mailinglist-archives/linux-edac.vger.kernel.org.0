Return-Path: <linux-edac+bounces-2125-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5389A21ED
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 14:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855941F281F6
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 12:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714281DD533;
	Thu, 17 Oct 2024 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JO6VO2dA"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802B11DD0DE;
	Thu, 17 Oct 2024 12:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729167210; cv=none; b=RiLGSzWvn6/yuYuRU57Gg/dx7EbZH2zFV2zf2rMmJVfOAx4YtnIxN6Q3eXWmcOF9denbWivHTt1nQU2Nax3vf20a7zx6/q8UUxHQffw2UIQ4IJE0rb6g/NOOUQw748TJKxWqN0wWKhjebHvc8+U2irB5440+dOSlYQ2ekmihy9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729167210; c=relaxed/simple;
	bh=hrYmQE28ikXt0QdSrLrZQR2hHNKbxJRKuczFAskacHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d937FdC7lJsv6DyONZNAYuYIj13ND4cmWQgox/wzaYTr3/hH/OmmlXzPHAdF6/lLEmgfpd3edFRBPh70iDWSWbAMGyeHL5mNJrQQo0HSaW7BU6lU7LBFi5DufIlZKlnyOFFJCY9ZlSQnYG6ggDG7saiVmbBHiyQzwhZ1ijv053g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JO6VO2dA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 543E940E0284;
	Thu, 17 Oct 2024 12:13:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0HVYk0G5kQKB; Thu, 17 Oct 2024 12:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729167196; bh=MVEq3VBq6KFp5gWgam8RecRECgr9G7KmZO/u2TK2UHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JO6VO2dAGNfGx36lK4CDYqCGGc8y7/kO3Q2iHgpXrrBDmiIQI2qU2xYuLeBUtjnEU
	 7Q/Dfb4Om4DfFnPYSC95C+ZkAdTOa0qTSmKyJzoi7B/q3MAzTng1Z2qXIvuSnwqx3r
	 ylOas+FjDweK/ZjzTgNt3/5AgfD6yy7LXK+xhxH2ZPZE9w1VrMRGRfX4kWdZereF8N
	 HBNYAyHzzi5pSnPehaSM7UGUMhjo+pY+ON2/CGCRRmZ9w5Cz9I86G9O+06U9UWdzN6
	 gKZBpcQI6DPUNsN9SeVQ6heNCF+IVv4iDu1R45DlzxTnMMMSWj68JeAdWiYsFjd1Wb
	 hBkQKj38SRBWAX4xxyYXnFp6bEN0OXKa+nUkJCf3LDSFHxbfYCCACyDDqNT2N32f72
	 rM49Mf9TYsiSoOVK0vmrDIvD/ruwLwNkqoyiAKfpdy7vb1zAh5afR+LLIJqjM1sbyY
	 0CM15KnLDachrGy4DTXWb1sJHov8N28spmUUpNPVGJu7iTAtw+iPLvBSIoX7K6PoXw
	 NDxrs70kGAC3FcqiwPWM4GX+tL85Tt1egtPFmPjJMSe5P0Rs4Eo98JiwaXttk7QFeL
	 MFBXinilAlWHYtvpu02P4Nzl2ETA7bNLRn4DXJtyeOXTOwbDhQ7SZqcUshVZLQTnpW
	 Hzc6jXhKWwacfuU6uOyG1690=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B9CF40E0169;
	Thu, 17 Oct 2024 12:13:08 +0000 (UTC)
Date: Thu, 17 Oct 2024 14:12:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Thompson <davthompson@nvidia.com>
Cc: "tony.luck@intel.com" <tony.luck@intel.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	Shravan Ramani <shravankr@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 RESEND] EDAC/bluefield - fix potential integer overflow
Message-ID: <20241017121258.GCZxD_Sq1sami2prbU@fat_crate.local>
References: <20240930151056.10158-1-davthompson@nvidia.com>
 <20241016165027.GTZw_u0wpcd48VwbMA@fat_crate.local>
 <PH7PR12MB590228EA57AE7A66870E373FC7462@PH7PR12MB5902.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR12MB590228EA57AE7A66870E373FC7462@PH7PR12MB5902.namprd12.prod.outlook.com>

On Wed, Oct 16, 2024 at 05:30:49PM +0000, David Thompson wrote:
> This patch addresses an issue that was raised during a scan by Coverity
> (static code analyzer).  I don't believe we have evidence that it will be
> hit with real workloads.

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

