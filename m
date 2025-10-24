Return-Path: <linux-edac+bounces-5189-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 158E2C082D3
	for <lists+linux-edac@lfdr.de>; Fri, 24 Oct 2025 23:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17411B81923
	for <lists+linux-edac@lfdr.de>; Fri, 24 Oct 2025 21:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD30303A2A;
	Fri, 24 Oct 2025 21:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LtIHaQpY"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D762C21F6;
	Fri, 24 Oct 2025 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341273; cv=none; b=IidmoeapJDvVFOmp1sVRJJfPLr8N/j8zHeRElqf+TRhFGBaxU5KLVmTpyp5Fr8JFI/QoRKLTMk5mQ1WLIY9qmU45nS45wpmzc+rQgHIzl+xWgjUUxge6f5TTfR2IESu0wFmLJOWBSH9v550eGt6X/hp434vTUyh18O3/qQJ5fkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341273; c=relaxed/simple;
	bh=qvO5IlFA+YKOgE+yjroMrw8twCPmHsBDR5Yvn16L8iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5Uukg3tQlYmyP4nyM2Srhn1GgiO/OlEakyhGrFO13REKewB3FhpZb5IYmc5ypX+l151xuR0aktJaGxA4ZHFy3D8jbujCGp+1eJsvipo5Z8nQWw6Ktx3jKOOcmPEBKdINzUwvP9hyjxLKDJfDj2Kwbpod6nfkpt41i9zdxOydWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LtIHaQpY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B4CEC40E01FA;
	Fri, 24 Oct 2025 21:27:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yA3X27WzlXtz; Fri, 24 Oct 2025 21:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761341262; bh=jsp6zdTFa+nn9vnL9aFdvsNiE2mZKAq+9nq0RxkWjIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LtIHaQpYVgoKadF8e8WFNj+/6fFvpvO6y/FBdFYrDjIsJVkwcEunh56Cn0IHZT89h
	 PfT6gNgyfc+2MmSX7lDLwkaNocMFv0YL7MDW02PF8y4fcHlax3VwVWs4IS1qjT1hCy
	 rMxrqaMZKldWE2mQ4SOMkVfhXKUx7PZSrzEGMXOaM35tvmTkO8Ery0tIEpYiJyh1QV
	 6O0z+xUGiaIpOt15SS4jReW6YtTe5qt/mqUf24T1JySdpoLN3eZaNkfraV2RV1k/DC
	 dQ+0ZnMaFLl0zsZr6uRCfqbkUGhB0Zl+O4ln74P3jkCq8QHfMHhbLMQhlqxXg9GZki
	 NkgJ4P9UWh/+psLsoJk1wj1N/lSVhyf9PZ2vPPAY0EdjcFk68+pJi7uWL4Yw+ExqnG
	 u5sEAFQrf1vDdUScgtPN2fWMP0/AhfSrds4ymXV/EdUfTXefFpq6LrnzYIGDH5s/O6
	 mOP1x5UBzm9Zxzy0IcNFFfA/w6A6u/hYpjzLFBAgB8wsj1+trAzgs/ZPawuev6XooE
	 UR6AFV2fMqqeNm2tMBAWgog78gKsOKccfKvqNYRzOn2YkTGJN1eEJ4EPjWaYUVv2ds
	 ZEkxe4lKnH5LSOg0eu6u53oOP135jmYN0LY0Lh3I880yM0QdhbuNeJSBwGZhYEHrBp
	 7ZebCXWlZ0q5fOhQUAfuroWw=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 1DFC440E019B;
	Fri, 24 Oct 2025 21:27:30 +0000 (UTC)
Date: Fri, 24 Oct 2025 23:27:23 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Bert Karwatzki <spasswolf@web.de>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 2/8] x86/mce: Unify AMD DFR handler with MCA Polling
Message-ID: <20251024212723.GGaPvvO3l2OlUEG7Xn@fat_crate.local>
References: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
 <20251016-wip-mca-updates-v7-2-5c139a4062cb@amd.com>
 <20251024150333.GSaPuVRQYxH92zyrmO@fat_crate.local>
 <20251024203012.GA251815@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251024203012.GA251815@yaz-khff2.amd.com>

On Fri, Oct 24, 2025 at 04:30:12PM -0400, Yazen Ghannam wrote:
> Should I send another revision?

Nah, I'm not done simplifying this yet. :-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

