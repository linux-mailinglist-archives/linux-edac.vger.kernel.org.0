Return-Path: <linux-edac+bounces-2926-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BBCA12E42
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 23:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6F73A68E4
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 22:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3928D1DC9A5;
	Wed, 15 Jan 2025 22:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="H6ZO5+1c"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA94B1DC99C;
	Wed, 15 Jan 2025 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736980057; cv=none; b=W2aZUHBQMbgzlBcSgbGxhs1i1hlSg++K09IQoV2VhmtT1Fdy0+kgog0XzlCxGV5Xbuq8lOzosU+nQiVUZbmK5P5rQU5/uJGu7dio4gB3IqTOk7DBC/rzv1QCLexrlIiLnSsOZepjXbTcdMf4x9BNysmFxZS9BpoWMPKRWyD7YnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736980057; c=relaxed/simple;
	bh=L6v3ltkFxCKX/HYK5XpNob3hJTjyKUlopNZSEjK9jNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLWvJT/zSqmw0b6SLJquQkWpVxZcaruqhd+Yn+DGWwXvb2cwPZgARDLTedg7CXVbdS1ijykLYj3ej9WtQgVebQVuu8eDE6XrXdweIiMhWPxXRNK8dbhU4NuXmTDKr44WEwibazoSFeE+guyZSo6q7gvDcQsV+rmuZ4qlVxZ1ZWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=H6ZO5+1c; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7EE5940E0269;
	Wed, 15 Jan 2025 22:27:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cdTVkAjB66QY; Wed, 15 Jan 2025 22:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736980041; bh=RT9Ae+k3g5ewDq5EuYzjdb2YU/NgkPnTTN+cUDaL0PQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6ZO5+1cTiAApFj1mE8Z/BaiL4rxS3C+90tNlLMFAaxxUhuAZOe5g2imOANwsroVv
	 IS46JTrtzR5VFRw7jgR33DyZjsxqZOxYfTiWFQvw/okc+JVSA78D/Z/3OeBSNrob2P
	 jALXxbRTD4dO1kJNWf53D/VZbJiWJqKqkx89FVq7XdwskSSkT2gm+jiRi/7qX2dj4d
	 vQkvcceQ8n59Sf/6cXrUNa/UU0gNX1OSW+hUn5ud1yGRD5q0ueljRGd4fVqPEdpy6W
	 wvns3bJsUjbSa//NcLr+12ltDuDO1peuu6fmuqJJEFmZLfwyxbm4WkWvq53hWcjPAY
	 P8ojeZesTlnSCyPWGC/7EngvPL6bi8T/dymCdhY4F4duFAvbqw5Uv5J22xqrEL9EBa
	 NExWm5pC1QpBP8iwj0Z1bn1IOHVYA3uMCqyhOF7YOqWHDEf7lG+Uvr5dQvXNkHGU0i
	 O0yeL+qvc1eRPX4hKLqFubFVeQGiITmIoVv4CIPVNFqCBnFOCEwMBiRISci+YErCbx
	 e47cgHXI5+9htgNuZC7MKZ+/ybtpYWZIycRiifL1yzMjZYTBSuHCtTeg90fqslsCiK
	 MDy7FbB6m+165et/kmL0adS8B+WbzQfTtjUSXPrjeTmiQL5q8/onIuwsRXcN9PVwTx
	 /FWG55rwdxv28fesf91t6vho=
Received: from zn.tnic (p200300ea971F93c3329C23FffEA6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93c3:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D52640E021D;
	Wed, 15 Jan 2025 22:27:09 +0000 (UTC)
Date: Wed, 15 Jan 2025 23:27:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-edac@vger.kernel.org, git@amd.com
Subject: Re: [PATCH v5 1/5] cdx: export the symbols
Message-ID: <20250115222702.GCZ4g2NhPjxGq0OmeC@fat_crate.local>
References: <20250106053358.21664-1-shubhrajyoti.datta@amd.com>
 <20250106053358.21664-2-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250106053358.21664-2-shubhrajyoti.datta@amd.com>

On Mon, Jan 06, 2025 at 11:03:54AM +0530, Shubhrajyoti Datta wrote:
> export the symbols for modules.

Which modules are going to use those? Why?

Why is this patch in this set?

This commit message is largely inadequate. Your other commit messages too.

Yeah, the goal is for our commit messages to be as clear to humans as
possible, even for people who do not have intimate knowledge of the matter.

And, more importantly, when we start doing git archeology months, years from
now, it should be perfectly clear why a commit was done.

So please try to explain the issue in a clear and detailed way.

People and you yourself will be thankful for it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

