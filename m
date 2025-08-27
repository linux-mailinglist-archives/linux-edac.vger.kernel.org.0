Return-Path: <linux-edac+bounces-4697-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 951F7B37DFD
	for <lists+linux-edac@lfdr.de>; Wed, 27 Aug 2025 10:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E671BA43CF
	for <lists+linux-edac@lfdr.de>; Wed, 27 Aug 2025 08:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D774033CE9F;
	Wed, 27 Aug 2025 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Du9Wx1fj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD12F33A00E;
	Wed, 27 Aug 2025 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756284054; cv=none; b=btq262pOjSIkyFz4FWdmm7qXAXKz77oARGgK8ayw2TSoVEvTFMOI3FzuYajw0N/1DAp3ddS5buGW8e9xTuc6skZjO/nazDqrjWYt4rMVw8qNmobNTxYT9Ks4YYTlohETnhQP4xo0D+oQXXEeLnd4y/9eEpTberwzVm27MBInjjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756284054; c=relaxed/simple;
	bh=ZmHBWK5BuQNJ31LUGpY4RJ3Mq7uS2nqP8QqNP4OwfuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJ/U7UfSuIgBhzBfKDhSp6kAw2WhPeGQ/A+JN3nHeZJ+i+KSSgqAUw/aRr0JhQXclZZ2c5nSPIq2GKZTPkFc4Er58lL+1NFUpmWEpjGIT4eRk9vnnbnEKjZSo/68raEuAEXl97e8sNS3EiGzH80Zeaq0qw0HVJvcaQ4sKqkOvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Du9Wx1fj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 55AF540E00DA;
	Wed, 27 Aug 2025 08:40:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uTmocuXlYplB; Wed, 27 Aug 2025 08:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756284046; bh=BCWF0C0SKwfKYfZP1aAsMkpWwiMtI1Y8p6BoA/+fiug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Du9Wx1fjBCOil6REbvzTOnu3Z6pIg5wTVUBsZdg7KR4Zq+m3UTP+H274k0HVAG7wE
	 /Kz7/wRN0uvN0KcTOD5hYPG/Gdj0rt4vWJg9Rx1K8SKpI0wJB+6/AGGhbVSznh32yl
	 7N9MS7X+8S4IZ3AtQOxfhavsmXJ5WQ8aUow9iwg0yqFm4kKvnCoHDq1l8ctEVuY2at
	 0NPFTZy4p08smEQrFXaYZiSIIv9SqXkMDna2OEjz8UpTGFtJpLyR1qorIAnJqjAdxX
	 iERgwN0s+4ZECUN3foQ2KVy6u89DSasdiXYkDuWtvZVmvr0OPQ2+teRA4es0upsIG4
	 V5O1BMl2lv3OtjKm/Za8rleo9CqdsqK3VSeBSeRrYcAlNp52z2gWeVObFZwDqoXBWW
	 +egUjNlnknTXlvlH4qFiNFFj1TWdRzFrepIBoeZT+YUDIpgeE8mzzx7a+CKL9Umfrf
	 zjsUSvwurmBnCB+TmIK9MEY4xfqSWdr2NdKNNCcHJDAEJCoILxvu3clTXh8HaBZokL
	 Uioua3mTJ3MiW4yKYYkDGXm8rfvYkFKS4napA8xeWjsi6KFZFUzVBV9FPjteSezyBd
	 aDT09a2/39d28sVrlQMePmaDwtYv18B0WC9NtDYNU0hpBCl5zpBKpp1yxvsZGE2JI8
	 uVfg/6p+DBo514dDUe8/9i+Q=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 016D340E019C;
	Wed, 27 Aug 2025 08:40:28 +0000 (UTC)
Date: Wed, 27 Aug 2025 10:40:28 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, git@amd.com, ptsm@linux.microsoft.com,
	srivatsa@csail.mit.edu, shubhrajyoti.datta@gmail.com,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>
Subject: Re: [PATCH v8 1/5] cdx: add the headers to include/linux
Message-ID: <20250827084028.GGaK7EfGLBLeQ-WteX@fat_crate.local>
References: <20250826052914.2066884-1-shubhrajyoti.datta@amd.com>
 <20250826052914.2066884-2-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250826052914.2066884-2-shubhrajyoti.datta@amd.com>

On Tue, Aug 26, 2025 at 10:59:10AM +0530, Shubhrajyoti Datta wrote:
> Subject: Re: [PATCH v8 1/5] cdx: add the headers to include/linux

Make that title more specific:

"cdx: Split mcdi.h and reorganize headers"

or so.

> Move `bitfield.h` from the CDX controller directory to
> `include/linux/cdx` to make them accessible to other drivers.
> 
> As part of this refactoring, `mcdi.h` has been split into two headers:
> - `mcdi.h`: retains interface-level declarations
> - `mcdid.h`: contains internal definitions and macros
> 
> This is in preparation for VersalNET EDAC
> driver that relies on it.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
> Changes in v8:
> - Split `mcdi.h` into `mcdi.h` and `mcdid.h`
> - Removed common code from CDX headers
> - Used refactored versions from shared location
> 
> Changes in v7:
> - add a minimal header instead moving them
> 
> Changes in v6:
>  - Patch added
> 
>  drivers/cdx/controller/cdx_controller.c       |  2 +-
>  drivers/cdx/controller/cdx_rpmsg.c            |  2 +-
>  drivers/cdx/controller/mcdi.c                 |  5 +-
>  drivers/cdx/controller/mcdi_functions.c       |  1 -
>  drivers/cdx/controller/mcdi_functions.h       |  3 +-
>  drivers/cdx/controller/mcdid.h                | 65 +++++++++++++++++++
>  .../linux/cdx}/bitfield.h                     |  0
>  .../controller => include/linux/cdx}/mcdi.h   | 52 +--------------
>  8 files changed, 73 insertions(+), 57 deletions(-)
>  create mode 100644 drivers/cdx/controller/mcdid.h
>  rename {drivers/cdx/controller => include/linux/cdx}/bitfield.h (100%)
>  rename {drivers/cdx/controller => include/linux/cdx}/mcdi.h (74%)

I'd need an Ack from these gents:

Nipun Gupta <nipun.gupta@amd.com> (maintainer:AMD CDX BUS DRIVER)
Nikhil Agarwal <nikhil.agarwal@amd.com> (maintainer:AMD CDX BUS DRIVER,commit_signer:4/6=67%)

if this is going to go through the EDAC tree.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

