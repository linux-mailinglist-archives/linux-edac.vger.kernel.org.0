Return-Path: <linux-edac+bounces-1615-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6269468D2
	for <lists+linux-edac@lfdr.de>; Sat,  3 Aug 2024 11:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F8FDB2124B
	for <lists+linux-edac@lfdr.de>; Sat,  3 Aug 2024 09:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D61C762E0;
	Sat,  3 Aug 2024 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MUw+reMt"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2A71C3E
	for <linux-edac@vger.kernel.org>; Sat,  3 Aug 2024 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722677275; cv=none; b=USKZwGAFirqjyxqyCD+w4JbeumCMVfKZjRXMC8hAnIsKmGWlILLQ+szjT7wq+CzLWy2Y1QIM+v8qjFA0X0bU6eHBDCw3J6IXZGd+Wa96oMyBVLp7+JIsz5467JQPl2HOXgLftnsWW6kvk2V1CX6NdDv24fjDaacMRChrg+Xkci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722677275; c=relaxed/simple;
	bh=zjAsxj6t34RQ1978NDenA+K1InVfGjrV/+V3z77Wu4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neCWhr058I9tUthackLf6WY4iUMKACK8HA4T76TG5pJFP3Tccu2F4JqkIQyAOeNnFaFmjLIMftnm/eKSYYjcD4Shzj1GdMrtID+LBhpasDvZMQyGIkyT02T7/OA3L8PrzK4JvQ8T4FrNAs8dXVOySQO4T/p0+TZeKc4vt9yWx2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MUw+reMt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D5D2840E026B;
	Sat,  3 Aug 2024 09:27:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3fiWKMq1iNDN; Sat,  3 Aug 2024 09:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722677260; bh=G7/tyxOVQIoHuLjPAXTUL3EMerWOd59x8iUDmMVwzXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUw+reMtfeRtmX6OG5ajyUTjDKeMDYUvosqdcG17I+yxfm+aHdJ28Znz7mIQpmDE6
	 JghDmBkbrVLT28CGLrRUR+3cmdLfQ9mKm/w6BWE/eVfwNBWqWJwsutUdysf8d64PVm
	 J8wbKPYsDAxCN22bZ1N+6JhNl6ttFV/YTxtAh+NA7WjBM6bRvV4sXGlcuaAQXIq1iL
	 z+bcxUccYBYv+ZJk8B1AemFrEp84z9tFnENS9m6PrALTYdJ+NSb0R2f3Gb95Md0exv
	 U2k4oZ61/fFS0lqFpy8vfkKev4MxBEg1mep2mLtu9ETn1MRTF8rwJ9AxOr922wk0zs
	 K4mon2WyQOLg4OQervObyTDTNur37PfCzonHrRmIDoUYwel7o5Beu7ybVSd7jDQ9Im
	 3R4WlgKW06ijycbyurBKRoOfrV6yx28r7n5mcUn/vAd5wML0QhyjVRuyilz7J4ibth
	 ogfVIzKGaB8C2yDOI6PGl/box7kWcgO8wdPUkEsQOpgoU40g27yY7KpMLg1hNAY2a5
	 DYy3JvWu+RZ58tQwON0u0e8d8VyiOaKJxHLp7WkVKA2EFg7t85RzFuUv8AqCpyWYMk
	 z43F/FRvyRUF2Z6KpOBWaAgYJZduyDb6bpTHRH58zJt6bt765T3/DVu5rp7lag3WIp
	 EiXM3XKAKDY7vW75HoJkGEeM=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 69A0E40E0269;
	Sat,  3 Aug 2024 09:27:34 +0000 (UTC)
Date: Sat, 3 Aug 2024 11:27:28 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: Andres Valloud <ten@smallinteger.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	linux-edac <linux-edac@vger.kernel.org>
Subject: Re: Unrecognized MSR report
Message-ID: <20240803092728.GAZq34AHbcvqs5Z0mm@fat_crate.local>
References: <f5fab0e1-a6f3-4e53-a605-0aaf6d26ee3e@smallinteger.com>
 <20240726124232.GBZqOZuM0yue1Oak-A@fat_crate.local>
 <CY8PR11MB71343FB88D7F84EAD9D189E389B32@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20240802105742.GAZqy7ptiSmi7H8VHk@fat_crate.local>
 <CY8PR11MB7134A23EAC691A383F6F555389B32@CY8PR11MB7134.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY8PR11MB7134A23EAC691A383F6F555389B32@CY8PR11MB7134.namprd11.prod.outlook.com>

On Fri, Aug 02, 2024 at 03:08:03PM +0000, Zhuo, Qiuxu wrote:
> I thought some cloud service providers running old kernels (<5.11) could 
> upgrade their rasdaemons at runtime (w/o system reboot). 

You thought. So no real use case. No, we don't anticipate use cases.

> Some pseudo-codes like below.  However, as you mentioned, poking MSR in
> userspace is not advisable.

You got it: we don't want to perpetuate the MSR poking - we want to get rid of
it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

