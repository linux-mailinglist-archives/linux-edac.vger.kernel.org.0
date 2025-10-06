Return-Path: <linux-edac+bounces-4994-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F21BBE7BE
	for <lists+linux-edac@lfdr.de>; Mon, 06 Oct 2025 17:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5A944EF276
	for <lists+linux-edac@lfdr.de>; Mon,  6 Oct 2025 15:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129EA2D73B6;
	Mon,  6 Oct 2025 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZc2CMBK"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55052D59EF;
	Mon,  6 Oct 2025 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759764340; cv=none; b=gv2osxSOnTSB+6prvc5Xp/zCM8OzyfkLCYL5ZnitncQUBBHB/39knbRrPC3igO0n9Le94KdKwZK5LYT/SlwAvXBFktM+mpvgfMwbgdRh93tTxZkf85TK+UFiQoUk2cyDeHlUDf+X+wa+5eSlaIvyQm6kuubjDeL3kvnBVKpJm8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759764340; c=relaxed/simple;
	bh=A6Y1wPP5SCrw4QxZScmaUQJS82g3EOT647s+IMarmWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDAkDoZrK8+1NipDGKzaAYIb14TvwoHw398cabytOgpTUP+SnR3ISTu20pTq63pfiZgNg1Ai4BUIcTV2gAVk96vtVJ0BgHvwoqQ/8c0r4nissmSfcb8Tp31zcPEZtfSjsdtspDZDu2yN5kds6sHCfJ5eGEGaMphphlkJb+yPnkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZc2CMBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7345CC4CEF5;
	Mon,  6 Oct 2025 15:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759764339;
	bh=A6Y1wPP5SCrw4QxZScmaUQJS82g3EOT647s+IMarmWY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VZc2CMBKC+N4CsHhoOd9DoArBEDdasSf6PF61F3CoVAmkgx2q9EIqd7EkPi/cZ+az
	 3q7w9KlC+YeP7Ho2MVKmEQT4+KrxiRpqxW8T/4NqdCQZi69xIb/JbRCJf1gZ/cVRmG
	 +RqrLiedr/kbaInZ0Jgz90mQrifTerDbnFLbGqA0NOJBgvUMxf/Cqlz+qtIFIcrtIe
	 jMr3QXUQBocL0JUYJj5ye0vyHviIkBGqPBTmvlxnS9XpbXvK4YsiSzuV6szyDv+a1q
	 XpO1t1+U5eH8ZIgjlArZZWBnvMK765uK09eF4D2tJE3fWGTyN382Iuw/WNZOfS7pnX
	 Nn11/rrKXSI4g==
Message-ID: <c9c79871-7fe0-49c0-8d90-bc467d2a641d@kernel.org>
Date: Mon, 6 Oct 2025 10:25:37 -0500
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] AMD ATL PRM Updates
To: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, Avadhut Naik <avadhut.naik@amd.com>,
 John Allen <john.allen@amd.com>
References: <20251006-wip-atl-prm-v1-0-4a62967fb2b0@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20251006-wip-atl-prm-v1-0-4a62967fb2b0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/6/2025 10:10 AM, Yazen Ghannam wrote:
> Hi all,
> 
> This set updates the AMD Address Translation Library to default to using
> PRM handlers.
> 
> Patch 1 adds a small helper function in the ACPI PRMT code.
> 
> Patch 2 adds the new ATL functionality.
> 
> Patch 3 does minor miscellaneous cleanup.
> 
> Please note there is a minor conflict with this set from Avadhut:
> https://lore.kernel.org/r/20250915212244.886668-1-avadhut.naik@amd.com
> 
> Thanks,
> Yazen
> 
> ---
> Yazen Ghannam (3):
>        ACPI: PRM: Add acpi_prm_handler_available()
>        RAS/AMD/ATL: Require PRM support for future systems
>        RAS/AMD/ATL: Return error codes from helper functions
> 
>   drivers/acpi/prmt.c            |  6 ++++++
>   drivers/ras/amd/atl/core.c     |  7 +++++--
>   drivers/ras/amd/atl/internal.h | 10 +++++++++-
>   drivers/ras/amd/atl/prm.c      | 10 ++++++++++
>   drivers/ras/amd/atl/system.c   | 19 +++++++++++--------
>   drivers/ras/amd/atl/umc.c      |  2 +-
>   include/linux/prmt.h           |  2 ++
>   7 files changed, 44 insertions(+), 12 deletions(-)
> ---
> base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
> change-id: 20251006-wip-atl-prm-c5f8b5b71211
> 

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>


